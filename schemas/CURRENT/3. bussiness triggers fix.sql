use [TWS Business]

DROP TRIGGER TrailerInventories_Management;
DROP TRIGGER TruckInventories_Management;
DROP TRIGGER YardLogs_InsertInto_TrucksInventories;
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
				-- Check if the truck is already stored in the inventory;
				IF EXISTS (
					SELECT 1
					FROM Trucks_Inventories
					WHERE (truck = @truckID OR truckExternal = @truckExternalKey)
				) 
				BEGIN
					DECLARE @inventorySection INT;

					SELECT @inventorySection = Trucks_Inventories.section 
						FROM Trucks_Inventories WHERE (truck = @truckID OR truckExternal = @truckExternalKey)

					DELETE FROM Trucks_Inventories 
					WHERE truckExternal = @truckExternalKey 
					   OR truck = @truckID;

					EXEC Set_SectionOcupancy @sectionID = @inventorySection, @added = 0;
				END

				IF(@trailerID IS NOT NULL OR @trailerExternalID IS NOT NULL)
				BEGIN
					DELETE FROM Trailers_Inventories 
					WHERE trailerExternal = @trailerExternalID 
						OR trailer = @trailerID;
				END

				IF (@truckID IS NOT NULL)
				BEGIN
					EXEC Set_Location @sectionID = NULL, @vehiculeID = @truckID, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons';
					EXEC Set_Situation @vehiculeID = @truckID, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
				END 
				ELSE IF (@truckExternalKey IS NOT NULL)
				BEGIN
					EXEC Set_Location @sectionID = NULL, @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons';
					EXEC Set_Situation @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
				END
				IF(@trailerID IS NOT NULL)
				BEGIN
					EXEC Set_Location @sectionID = NULL, @vehiculeID = @trailerID, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons';
					EXEC Set_Situation @vehiculeID = @trailerID, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
				END 
				ELSE IF(@trailerExternalID IS NOT NULL) 
				BEGIN
					EXEC Set_Location @sectionID = NULL, @vehiculeID = @trailerExternalID, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons';
					EXEC Set_Situation @vehiculeID = @trailerExternalID, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons', @situationName = 'In Transit';
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
                        EXEC Set_Situation @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'Parked in the yard';
                    END
                    ELSE
                    BEGIN
                        EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
                        EXEC Set_Situation @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'Parked in the yard';
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
                    EXEC Set_Situation @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'Parked in the yard';
                END
                ELSE
                BEGIN
                    EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
                    EXEC Set_Situation @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'Parked in the yard';
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
                    IF (@newTrailer IS NOT NULL)
                    BEGIN
                        EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers',  @commonTableName = 'Trailers_Commons';
                        EXEC Set_Situation @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons', @situationName = 'Parked in the yard';
                    END
                    ELSE
                    BEGIN
                        EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals',  @commonTableName = 'Trailers_Commons';
                        EXEC Set_Situation @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons', @situationName = 'Parked in the yard';
                    END
                END
            END
            ELSE
            BEGIN
                -- Set location and situation;
                IF (@newTrailer IS NOT NULL)
                BEGIN
                    EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers',  @commonTableName = 'Trailers_Commons';
                    EXEC Set_Situation @vehiculeID = @newTrailer, @vehiculeTableName = 'Trailers', @commonTableName = 'Trailers_Commons', @situationName = 'Parked in the yard';
                END
                ELSE
                BEGIN
                    EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals',  @commonTableName = 'Trailers_Commons';
                    EXEC Set_Situation @vehiculeID = @newExternalTrailer, @vehiculeTableName = 'Trailers_Externals', @commonTableName = 'Trailers_Commons', @situationName = 'Parked in the yard';
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