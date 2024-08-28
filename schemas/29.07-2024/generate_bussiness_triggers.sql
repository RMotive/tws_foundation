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
	DECLARE @Query NVARCHAR(max) = 'SELECT ' + @commonID + ' = common FROM ' + @vehiculeTableName + ' Where id = ' + @vehiculeID;
	EXEC sp_executesql @Query;

	DECLARE @updateQuery NVARCHAR(max) = 'Update ' + @commonTableName + ' SET ' + 'Situation = ' + @situationID  + ' Where id = ' + @commonID;
	EXEC sp_executesql @updateQuery ;
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

	DECLARE @commonID INT;
	DECLARE @Query NVARCHAR(max) = 'SELECT ' + @commonID + ' = common FROM ' + @vehiculeTableName + ' Where id = ' + @vehiculeID;
	EXEC sp_executesql @Query;

	--SELECT @truckCommonID = common From Trucks where id = @truckID;
	-- Check if the common table has a diferent value to modify in location column;
	--IF EXISTS(
		--SELECT 1 FROM Trucks_Commons where id = @truckCommonID AND (
		--([Location] <> @locationID)
		--OR ([Location] IS NULL AND @locationID IS NOT NULL)
		--OR ([Location] IS NOT NULL AND @locationID IS NULL)
		--)
	DECLARE @ConditionalQuery NVARCHAR(max);
	DECLARE @exist INT;

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
			DECLARE @updateToNullQuery NVARCHAR(max) = 'UPDATE ' + @commonTableName + ' SET [location] = null where id = ' + @commonID;
			EXEC sp_executesql @updateToNullQuery;
			

			--UPDATE Trucks_Commons 
			--SET [location] = @locationID Where id = @truckComsmonID;
		END 
		ELSE BEGIN
			--UPDATE Trucks_Commons 
			--SET [location] = null Where id = @truckCommonID;
			DECLARE @updateQuery NVARCHAR(max) = 'UPDATE ' + @commonTableName + ' SET [location] = ' + @locationID + ' where id = ' + @commonID;
			EXEC sp_executesql @updateQuery ;
			
		END
	END
END;
GO

CREATE PROCEDURE Set_SectionOcupancy
	@sectionID INT,
	@added Bit
	AS BEGIN
	-- Validate if values are added or not
	DECLARE @trucksTable Varchar(6) = 'Trucks';
	DECLARE @trucksExternalTable Varchar(16) = 'Trucks_Externals';
	
	
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
AS BEGIN
	DECLARE @entryBit BIT;
	DECLARE @truckID INT;
	DECLARE @truckExternalKey INT;
	DECLARE @newSectionID INT;

	SELECT @entryBit = i.Entry, @truckID = i.Truck, @truckExternalKey = i.TruckExternal, @newSectionID = i.Section FROM inserted i;
	
	IF @entryBit = 1
	BEGIN
		-- Insert new record into inventories if @entryBit is true;
		INSERT INTO Trucks_Inventories(EntryDate, truck, truckExternal, section)
		SELECT SYSDATETIME(), i.Truck, i.TruckExternal, i.Section FROM inserted i;
	END
	ELSE BEGIN
		-- Remove old record from inventories if @entryBit is false and revert changes;
		DELETE FROM Trucks_Inventories where truckExternal = @truckExternalKey OR truck = @truckID;
		EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 0; -- IF a previous record not exist, then subtract -1 to its section.
		IF (@truckID IS NOT NULL)
		BEGIN
			EXEC Set_Location @sectionID = null, @vehiculeID = @truckID, @vehiculeTableName = 'Trucks',  @commonTableName = 'Trucks_Commons';
			EXEC Set_Situation @vehiculeID = @truckID, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
		END ELSE BEGIN
			EXEC Set_Location @sectionID = null, @vehiculeID = @truckExternalKey, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
			EXEC Set_Situation @vehiculeID = @truckID, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
		END
		

	END
	
END;
GO

CREATE TRIGGER TruckInventories_Management
ON Trucks_Inventories
AFTER INSERT
AS BEGIN

	BEGIN TRANSACTION;

	DECLARE @newTruck INT;
	DECLARE @newExternalTruck INT;
	DECLARE @newID INT;
	DECLARE @newSectionID INT;
	DECLARE @oldSectionID INT;

	DECLARE insert_cursor CURSOR FOR
    SELECT Truck, truckExternal, id, section FROM inserted;

	OPEN insert_cursor;
	FETCH NEXT FROM insert_cursor INTO @newTruck, @newExternalTruck, @newID, @newSectionID;

	WHILE @@FETCH_STATUS = 0
    BEGIN
		BEGIN TRY
			-- Check if new truck is already stored in the inventory;
			IF EXISTS (
				SELECT 1
				FROM Trucks_Inventories
				WHERE (truck = @newTruck OR truckExternal = @newExternalTruck) AND Id <> @newID
			) 
			BEGIN

			-- Get old section id;
            SELECT @oldSectionID = section
            FROM Trucks_Inventories
            WHERE (truck = @newTruck OR truckExternal = @newExternalTruck) AND Id <> @newID;

			-- Remove old duplicated record based on foreign keys.
			DELETE FROM Trucks_Inventories WHERE (truck = @newTruck OR truckExternal = @newExternalTruck) AND Id <> @NewId;
			
			-- Check if the section ID has changed;
			-- Note: Not is necesary to update the section column, as the insert transaction itself does this.
                IF @oldSectionID <> @newSectionID
                BEGIN
                    -- subtract -1 to old section ocupancy AND sum + 1 to new section;
					EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 1;
					EXEC Set_SectionOcupancy @sectionID = @oldSectionID, @added = 0;

					-- Set location and Situation
					-- Validate regular truck or external truck;
					IF (@newTruck IS NOT NULL)
					BEGIN
						EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks',  @commonTableName = 'Trucks_Commons';
						EXEC Set_Situation @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
					END ELSE BEGIN
						EXEC Set_Location @sectionID = null, @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
						EXEC Set_Situation @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
					END
					-- VALIDATE FOR EXTERNAL TRUCKS
					--DECLARE @truckCommonID INT;
					--SELECT @truckCommonID = common From Trucks where id = @newTruck;

                END --ELSE DO NOTHING
				--UPDATE TRUCK LOCATION

			END
			ELSE BEGIN
				-- IF a previous record not exist, then sum +1 to its section.
				EXEC Set_SectionOcupancy @sectionID = @newSectionID, @added = 1;
				-- Set location and Situation
				-- Validate regular truck or external truck;
				IF (@newTruck IS NOT NULL)
				BEGIN
					EXEC Set_Location @sectionID = @newSectionID, @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks',  @commonTableName = 'Trucks_Commons';
					EXEC Set_Situation @vehiculeID = @newTruck, @vehiculeTableName = 'Trucks', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
				END ELSE BEGIN
					EXEC Set_Location @sectionID = null, @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals',  @commonTableName = 'Trucks_Commons';
					EXEC Set_Situation @vehiculeID = @newExternalTruck, @vehiculeTableName = 'Trucks_Externals', @commonTableName = 'Trucks_Commons', @situationName = 'In Transit';
				END
			END

			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION;

			DECLARE @ErrorMessage NVARCHAR(4000);
			DECLARE @ErrorSeverity INT;
			DECLARE @ErrorState INT;

			-- Store error message;
			SET @ErrorMessage = ERROR_MESSAGE();
			SET @ErrorSeverity = ERROR_SEVERITY();
			SET @ErrorState = ERROR_STATE();

			-- Display error message;
			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);

		END CATCH;
		FETCH NEXT FROM insert_cursor INTO @newTruck, @newExternalTruck, @newID, @newSectionID;
	END;

	CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;
GO