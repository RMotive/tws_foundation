USE [TWS Business];

--> Create Waypoints table.
IF OBJECT_ID('dbo.Waypoints', 'U') IS NULL
BEGIN
CREATE TABLE Waypoints(
	id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
	[Status] int NOT NULL,
	[Timestamp] datetime NOT NULL,
	Longitude Decimal(10, 6) NOT NULL,
	Latitude Decimal(10, 6) NOT NULL,
	Altitude Decimal(10, 6),
);
END

-- Adding [Waypoint] column in [Locations]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Locations') 
               AND name = 'Waypoint')
BEGIN
	ALTER TABLE Locations
	ADD Waypoint INT;
END

--Adding new constraints
-- Adding [Waypoint] FK in [Locations]
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
               WHERE name = 'FK_Locations_Waypoints' 
               AND parent_object_id = OBJECT_ID('dbo.Locations'))
BEGIN
	ALTER TABLE Locations
	ADD constraint FK_Locations_Waypoints foreign key(Waypoint) references Waypoints(id);
END