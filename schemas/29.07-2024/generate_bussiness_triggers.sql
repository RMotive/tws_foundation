USE [TWS Business]
DROP PROCEDURE Set_Situation;
DROP PROCEDURE Set_Location;
DROP PROCEDURE Set_SectionOcupancy;

GO
CREATE PROCEDURE Set_Situation
	@vehiculeID INT,
	@vehiculeTableName varchar(max),
	@commonTableName varchar(max),
	@situationName varchar(max)
AS BEGIN
	DECLARE @situationID INT; 
	DECLARE @commonID INT;
	SELECT @situationID = id FROM Situations where [Name] = @SituationName;
	
	DECLARE @Query NVARCHAR(max);
	SET @Query = N'SELECT @commonID = common 
		FROM ' + QUOTENAME(@vehiculeTableName) + ' 
		WHERE id = @vehiculeID';

    EXEC sp_executesql @Query, 
		N'@vehiculeID INT, @commonID INT OUTPUT', 
		@vehiculeID = @vehiculeID, 
		@commonID = @commonID OUTPUT;

	
	DECLARE @updateQuery NVARCHAR(max);
	SET @updateQuery = N'UPDATE ' + QUOTENAME(@commonTableName) + ' 
		SET Situation = @situationID 
		WHERE id = @commonID';

    EXEC sp_executesql @updateQuery, 
		N'@situationID INT, @commonID INT', 
		@situationID = @situationID, 
		@commonID = @commonID;
END;
GO
CREATE PROCEDURE Set_Location
	@sectionID INT,
	--@truckID INT,
	@vehiculeID INT,
	@vehiculeTableName varchar(max),
	@commonTableName varchar(max)
AS BEGIN
	DECLARE @locationID INT;
	DECLARE @truckCommonID INT;
	SELECT @locationID = Yard From Sections where id = @sectionID;
	DECLARE @Query NVARCHAR(MAX);
    DECLARE @ConditionalQuery NVARCHAR(MAX);
    DECLARE @updateQuery NVARCHAR(MAX);
	DECLARE @commonID INT;
	
	 SET @Query = N'SELECT @commonID = common 
                   FROM ' + QUOTENAME(@vehiculeTableName) + ' 
                   WHERE id = @vehiculeID';

    EXEC sp_executesql @Query, 
                       N'@vehiculeID INT, @commonID INT OUTPUT', 
                       @vehiculeID = @vehiculeID, 
                       @commonID = @commonID OUTPUT;

	DECLARE @exist INT = 1;

	SET @ConditionalQuery = N'SELECT @exist = 1 FROM ' + @commonTableName + ' WHERE id = @commonID AND (
		([Location] <> @locationID)
		OR ([Location] IS NULL AND @locationID IS NOT NULL)
		OR ([Location] IS NOT NULL AND @locationID IS NULL)
	)';

	EXEC sp_executesql @ConditionalQuery, 
        N'@commonID INT, @locationID INT, @exist INT OUTPUT', 
        @commonID = @commonID, 
        @locationID = @locationID, 
        @exist = @exist OUTPUT;

IF (@exist IS NULL) SET @exist = 0;

	IF (@exist = 1)
	BEGIN
		IF (@sectionID = null)
		BEGIN 
		
			SET @updateQuery = N'UPDATE ' + QUOTENAME(@commonTableName) + ' 
				SET [Location] = NULL 
				WHERE id = @commonID';

            EXEC sp_executesql @updateQuery, 
				N'@commonID INT', 
				@commonID = @commonID;

		END 
		ELSE BEGIN
	
			SET @updateQuery = N'UPDATE ' + QUOTENAME(@commonTableName) + ' 
				SET [Location] = @locationID 
				WHERE id = @commonID';

            EXEC sp_executesql @updateQuery, 
				N'@commonID INT, @locationID INT', 
				@commonID = @commonID, 
				@locationID = @locationID;
			
		END
	END
END;
GO

CREATE PROCEDURE Set_SectionOcupancy
	@sectionID INT,
	@added Bit
	AS BEGIN
	-- Check id add or substract value;
	IF @added = 1
	BEGIN
		UPDATE Sections 
		SET Ocupancy = Ocupancy + 1 WHERE id = @sectionID;
	END
	ELSE BEGIN
		UPDATE Sections 
		SET Ocupancy = Ocupancy - 1 WHERE id = @sectionID;
	END
END;
GO

CREATE TRIGGER tgr_YardLogs_Insert
ON Yard_Logs
AFTER INSERT
AS BEGIN
	UPDATE Yard_Logs
    SET Timestamp = GETDATE()
    FROM inserted i	
    WHERE Yard_Logs.Id = i.Id;
END;
GO

CREATE TRIGGER YardLogs_InsertInto_TrucksInventories
ON Yard_Logs
AFTER INSERT
AS 
BEGIN
    BEGIN TRANSACTION;

    DECLARE @entryBit BIT;
    DECLARE @truckID INT;
    DECLARE @truckExternalKey INT;
	DECLARE @trailerID INT;
	DECLARE @trailerExternalID INT;
    DECLARE @newSectionID INT;

    DECLARE insert_yard_cursor CURSOR FOR
    SELECT i.[Entry], i.Truck, i.TruckExternal, i.Trailer, i.TrailerExternal,i.Section
    FROM inserted i;

    OPEN insert_yard_cursor;
    FETCH NEXT FROM insert_yard_cursor INTO @entryBit, @truckID, @truckExternalKey, @trailerID, @trailerExternalID, @newSectionID;

	IF(@truckID IS NULL AND @truckExternalKey IS NULL)
	BEGIN;
		THROW 50000, 'No Truck or external truck pointer.', 1
	END;

    BEGIN TRY
        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @entryBit = 1
            BEGIN
                -- Insert new record into inventories if @entryBit is true;
                INSERT INTO Trucks_Inventories(EntryDate, truck, truckExternal, section)
                VALUES (SYSDATETIME(), @truckID, @truckExternalKey, @newSectionID);

				IF(@trailerID IS NOT NULL OR @trailerExternalID IS NOT NULL)
				BEGIN
					INSERT INTO Trailers_Inventories(EntryDate, trailer, trailerExternal, section)
					VALUES (SYSDATETIME(), @trailerID, @trailerExternalID, @newSectionID);
				END
            END
            ELSE 
            BEGIN
                -- Remove old record from inventories if @entryBit is false and revert changes;
				-- VERIFY BOTH CASES EXTERNAL AND INTERNAL ********************
                DELETE FROM Trucks_Inventories 
                WHERE truckExternal = @truckExternalKey 
                   OR truck = @truckID;

				IF(@trailerID IS NOT NULL OR @trailerExternalID IS NOT NULL)
				BEGIN
					DELETE FROM Trailers_Inventories 
					WHERE trailerExternal = @trailerExternalID 
					   OR trailer = @trailerID;
				END

                EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 0;

                IF (@truckID IS NOT NULL)
                BEGIN
                    EXEC Set_Location @sectionID = NULL, @vehiculeID = @truckID, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons';
                    EXEC Set_Situation @vehiculeID = @truckID, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'Parked in the yard';
                END 
                ELSE IF (@truckExternalKey IS NOT NULL)
                BEGIN
                    EXEC Set_Location @sectionID = NULL, @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons';
                    EXEC Set_Situation @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
                END
				IF(@trailerID IS NOT NULL)
				BEGIN
					EXEC Set_Location @sectionID = NULL, @vehiculeID = @truckID, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons';
                    EXEC Set_Situation @vehiculeID = @truckID, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons', @situationName = 'Parked in the yard';
				END 
				ELSE IF(@trailerExternalID IS NOT NULL) 
				BEGIN
					EXEC Set_Location @sectionID = NULL, @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons';
                    EXEC Set_Situation @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
				END
            END

            FETCH NEXT FROM insert_yard_cursor INTO @entryBit, @truckID, @truckExternalKey, @trailerID, @trailerExternalID, @newSectionID;
        END;

        -- Commit transaction if all operations succeed;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback transaction if any error occurs;
        ROLLBACK TRANSACTION;

        -- Handle the error;
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorSeverity = ERROR_SEVERITY();
        SET @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;

    CLOSE insert_yard_cursor;
    DEALLOCATE insert_yard_cursor;
END;
GO

CREATE TRIGGER TruckInventories_Management
ON Trucks_Inventories
AFTER INSERT
AS
BEGIN
    DECLARE @newTruck INT;
    DECLARE @newExternalTruck INT;
    DECLARE @newID INT;
    DECLARE @newSectionID INT;
    DECLARE @oldSectionID INT;

    DECLARE insert_cursor CURSOR FOR
    SELECT Truck, truckExternal, id, section
    FROM inserted;

    OPEN insert_cursor;
    FETCH NEXT FROM insert_cursor INTO @newTruck, @newExternalTruck, @newID, @newSectionID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Check if the new truck is already stored in the inventory;
            IF EXISTS (
                SELECT 1
                FROM Trucks_Inventories
                WHERE (truck = @newTruck OR truckExternal = @newExternalTruck) AND Id <> @newID
            ) 
            BEGIN
                -- Get old section ID;
                SELECT @oldSectionID = section
                FROM Trucks_Inventories
                WHERE (truck = @newTruck OR truckExternal = @newExternalTruck) AND Id <> @newID;

                -- Remove old duplicated record based on foreign keys;
                DELETE FROM Trucks_Inventories
                WHERE (truck = @newTruck OR truckExternal = @newExternalTruck) AND Id <> @newID;
				

                -- Check if the section ID has changed;
                IF (@oldSectionID <> @newSectionID)
                BEGIN
                    --  add +1 to new section;
                    EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 1;
					-- Subtract -1 to old section occupancy;
					EXEC Set_SectionOcupancy @sectionID = @oldSectionID, @added = 0;
                    -- Set location and situation;
                    IF (@newTruck IS NOT NULL)
                    BEGIN
                        EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks',  @commonTableName = 'Trucks_Commons';
                        EXEC Set_Situation @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
                    END
                    ELSE
                    BEGIN
                        EXEC Set_Location @sectionID = NULL, @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
                        EXEC Set_Situation @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
                    END
                END
            END
            ELSE
            BEGIN
                -- If no previous record exists, then add +1 to its section.
                EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 1;

                -- Set location and situation;
                IF (@newTruck IS NOT NULL)
                BEGIN
                    EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks',  @commonTableName = 'Trucks_Commons';
                    EXEC Set_Situation @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
                END
                ELSE
                BEGIN
                    EXEC Set_Location @sectionID = NULL, @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
                    EXEC Set_Situation @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
                END
            END

            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END

            DECLARE @ErrorMessage NVARCHAR(4000);
            DECLARE @ErrorSeverity INT;
            DECLARE @ErrorState INT;

            -- Store error information
            SET @ErrorMessage = ERROR_MESSAGE();
            SET @ErrorSeverity = ERROR_SEVERITY();
            SET @ErrorState = ERROR_STATE();

            -- Rethrow the error to ensure it is logged
            RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        END CATCH;

        FETCH NEXT FROM insert_cursor INTO @newTruck, @newExternalTruck, @newID, @newSectionID;
    END;

    CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;
GO

CREATE TRIGGER TrailerInventories_Management
ON Trailers_Inventories
AFTER INSERT
AS
BEGIN
    DECLARE @newTrailer INT;
    DECLARE @newExternalTrailer INT;
    DECLARE @newID INT;
    DECLARE @newSectionID INT;
    DECLARE @oldSectionID INT;

    DECLARE insert_trailerInventory_cursor CURSOR FOR
    SELECT trailer, trailerExternal, id, section
    FROM inserted;

    OPEN insert_trailerInventory_cursor;
    FETCH NEXT FROM insert_trailerInventory_cursor INTO @newTrailer, @newExternalTrailer, @newID, @newSectionID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Check if the new truck is already stored in the inventory;
            IF EXISTS (
                SELECT 1
                FROM Trailers_Inventories
                WHERE (trailer = @newTrailer OR trailerExternal = @newExternalTrailer) AND Id <> @newID
            ) 
            BEGIN
                -- Get old section ID;
                SELECT @oldSectionID = section
                FROM Trailers_Inventories
                WHERE (trailer = @newTrailer OR trailerExternal = @newExternalTrailer) AND Id <> @newID;

                -- Remove old duplicated record based on foreign keys;
                DELETE FROM Trailers_Inventories
                WHERE (trailer = @newTrailer OR trailerExternal = @newExternalTrailer) AND Id <> @newID;
				

                -- Check if the section ID has changed;
                IF (@oldSectionID <> @newSectionID)
                BEGIN
                    --  add +1 to new section;
                    EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 1;
					-- Subtract -1 to old section occupancy;
					EXEC Set_SectionOcupancy @sectionID = @oldSectionID, @added = 0;
                    -- Set location and situation;
                    IF (@newTrailer IS NOT NULL)
                    BEGIN
                        EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers',  @commonTableName = 'Trailers_Commons';
                        EXEC Set_Situation @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
                    END
                    ELSE
                    BEGIN
                        EXEC Set_Location @sectionID = NULL, @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals',  @commonTableName = 'Trailers_Commons';
                        EXEC Set_Situation @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
                    END
                END
            END
            ELSE
            BEGIN
                -- If no previous record exists, then add +1 to its section.
                --EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 1;

                -- Set location and situation;
                IF (@newTrailer IS NOT NULL)
                BEGIN
                    EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers',  @commonTableName = 'Trailers_Commons';
                    EXEC Set_Situation @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
                END
                ELSE
                BEGIN
                    EXEC Set_Location @sectionID = NULL, @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals',  @commonTableName = 'Trailers_Commons';
                    EXEC Set_Situation @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
                END
            END

            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END

            DECLARE @ErrorMessage NVARCHAR(4000);
            DECLARE @ErrorSeverity INT;
            DECLARE @ErrorState INT;

            -- Store error information
            SET @ErrorMessage = ERROR_MESSAGE();
            SET @ErrorSeverity = ERROR_SEVERITY();
            SET @ErrorState = ERROR_STATE();

            -- Rethrow the error to ensure it is logged
            RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        END CATCH;

        FETCH NEXT FROM insert_trailerInventory_cursor INTO  @newTrailer, @newExternalTrailer, @newID, @newSectionID;
    END;

    CLOSE insert_trailerInventory_cursor;
    DEALLOCATE insert_trailerInventory_cursor;
END;
GO
