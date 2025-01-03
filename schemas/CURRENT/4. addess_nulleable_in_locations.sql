USE [TWS Business];

-- Changing [Address] in Locations to nulleable.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Locations' AND COLUMN_NAME = 'Address')
BEGIN
    ALTER TABLE Locations
	ALTER COLUMN [Address] INT;
END