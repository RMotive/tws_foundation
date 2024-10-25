USE [TWS Business];

-- Check if tables already exist.
IF OBJECT_ID(N'dbo.Trailers_Inventories', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailers_Inventories;  
GO
IF OBJECT_ID(N'dbo.Trucks_Inventories', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trucks_Inventories;  
GO
IF OBJECT_ID(N'dbo.Plates', N'U') IS NOT NULL  
   DELETE FROM [dbo].Plates;  
GO
IF OBJECT_ID(N'dbo.Yard_Logs', N'U') IS NOT NULL  
   DELETE FROM [dbo].Yard_Logs;  
GO
IF OBJECT_ID(N'dbo.Trailers', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailers;  
GO
IF OBJECT_ID(N'dbo.Trailers_Externals', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailers_Externals;  
GO
IF OBJECT_ID(N'dbo.Trailers_Commons', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailers_Commons;  
GO
IF OBJECT_ID(N'dbo.Trucks', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trucks;  
GO
IF OBJECT_ID(N'dbo.Vehicules_Models', N'U') IS NOT NULL  
   DELETE FROM [dbo].Vehicules_Models;  
GO
IF OBJECT_ID(N'dbo.Manufacturers', N'U') IS NOT NULL  
   DELETE FROM [dbo].Manufacturers;  
GO
IF OBJECT_ID(N'dbo.Trailers_Types', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailers_Types;  
GO
IF OBJECT_ID(N'dbo.Trailer_Classes', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailer_Classes;  
GO

-- Removing axis table and adding size property in a new table
IF OBJECT_ID('FK_Trailers_Axes', 'F') IS NOT NULL
BEGIN
	ALTER TABLE Trailer_Classes
	DROP CONSTRAINT FK_Trailers_Axes;
END

-- Drop Axis Column 
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Trailer_Classes') 
           AND name = 'Axis')
BEGIN
    ALTER TABLE Trailer_Classes
    DROP COLUMN Axis;
END

-- Removing table.
IF OBJECT_ID('dbo.Axes', 'U') IS NOT NULL
BEGIN
    DROP TABLE [dbo].Axes;
END

    --> Normalizing Manufacturer Table
IF OBJECT_ID('dbo.Vehicules_Models', 'U') IS NULL
BEGIN
	CREATE TABLE Vehicules_Models(
		id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
		[Status] int NOT NULL,
		[Timestamp] datetime NOT NULL,
		[Name] varchar(32) NOT NULL,
		[Year] Date NOT NULL,
		Manufacturer int NOT NULL,

		constraint FK_VehiculesModels_Manufacturers foreign key(Manufacturer) references Manufacturers(id),
		constraint FK_VehiculesModels_Statuses foreign key([Status]) references Statuses(id)
	);
END

--> Changing properties in Manufacturers table
-- Drop [Year] Column in [Manufacturers]
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Manufacturers') 
           AND name = 'Year')
BEGIN
    ALTER TABLE Manufacturers
    DROP COLUMN [Year];
END

-- Drop [Brand] Column in [Manufacturers]
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Manufacturers') 
           AND name = 'Brand')
BEGIN
    ALTER TABLE Manufacturers
    DROP COLUMN Brand;
END

-- Drop [Model] Column in [Manufacturers]
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Manufacturers') 
           AND name = 'Model')
BEGIN
    ALTER TABLE Manufacturers
    DROP COLUMN Model;
END

-- Adding [Name] column in [Manufacturers]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Manufacturers') 
               AND name = 'Name')
BEGIN
	ALTER TABLE Manufacturers
	ADD [Name] varchar(32) NOT NULL;
END

-- Adding [Description] column in [Manufacturers]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Manufacturers') 
               AND name = 'Description')
BEGIN
	ALTER TABLE Manufacturers
	ADD [Description] varchar(100);
END

-- Normalizing trailer classes
IF OBJECT_ID('dbo.Trailers_Types', 'U') IS NULL
BEGIN
	CREATE TABLE Trailers_Types(
		id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
		[Status] int NOT NULL,
		[Timestamp] datetime NOT NULL,
		Size Varchar(16) NOT NULL,
		TrailerClass int NOT NULL,

		constraint FK_TrailersTypes_Statuses foreign key([Status]) references Statuses(id),
		constraint FK_TrailersTypes_TrailerClasses foreign key(TrailerClass) References Trailer_Classes(id)
	);
END


--Removing previous class constraint
IF OBJECT_ID('FK_TrailersCommons_TrailersClass', 'F') IS NOT NULL
BEGIN
	ALTER TABLE Trailers_Commons
	DROP Constraint FK_TrailersCommons_TrailersClass;
END

-- Drop [Class] Column 
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Trailers_Commons') 
           AND name = 'Class')
BEGIN
    ALTER TABLE Trailers_Commons
    DROP COLUMN Class;
END

-- Adding [Type] column in [Trailers_Commons]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Trailers_Commons') 
               AND name = 'Type')
BEGIN
	ALTER TABLE Trailers_Commons
	ADD [Type] int;
END


--Adding new constraints
-- Adding [Type] FK in [Trailers_Commons]
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
               WHERE name = 'FK_TrailerCommons_TrailersTypes' 
               AND parent_object_id = OBJECT_ID('dbo.Trailers_Commons'))
BEGIN
	ALTER TABLE Trailers_Commons
	ADD constraint FK_TrailerCommons_TrailersTypes foreign key([Type]) references Trailers_Types(id);
END

-- Moving SCT relationship to Trucks & trailers; Setting non-required properties:
IF OBJECT_ID('FK_Carriers_SCT', 'F') IS NOT NULL
BEGIN
	ALTER TABLE Carriers
	DROP Constraint FK_Carriers_SCT;
END

-- Drop [SCT] Column 
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Carriers') 
           AND name = 'SCT')
BEGIN
    ALTER TABLE Carriers
    DROP COLUMN SCT;
END

--> Trailers
-- Adding [SCT] column in [Trailers]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Trailers') 
               AND name = 'SCT')
BEGIN
	ALTER TABLE Trailers
	ADD SCT int;
END

-- Adding [SCT] FK in [Trailers]
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
               WHERE name = 'FK_Trailers_SCT' 
               AND parent_object_id = OBJECT_ID('dbo.Trailers'))
BEGIN
	ALTER TABLE Trailers
	ADD Constraint FK_Trailers_SCT foreign key(SCT) references SCT(id);
END

-- Drop FK  in [Trailers]
IF OBJECT_ID('FK_Trailers_Manufacturers', 'F') IS NOT NULL
BEGIN
	ALTER TABLE Trailers
	DROP Constraint FK_Trailers_Manufacturers;
END

-- Drop [Manufacturer] Column 
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Trailers') 
           AND name = 'Manufacturer')
BEGIN
    ALTER TABLE Trailers
    DROP COLUMN Manufacturer;
END
-- Adding [Model] column in [Trailers]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Trailers') 
               AND name = 'Model')
BEGIN
	ALTER TABLE Trailers
	ADD Model int;
END

-- Adding [Model] FK in [Trailers]
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
               WHERE name = 'FK_Trailers_VehiculesModels' 
               AND parent_object_id = OBJECT_ID('dbo.Trailers'))
BEGIN
	ALTER TABLE Trailers
	ADD Constraint FK_Trailers_VehiculesModels foreign key(Model) references Vehicules_Models(id);
END

--> Trucks
-- Adding [SCT] column in [Trucks]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Trucks') 
               AND name = 'SCT')
BEGIN
	ALTER TABLE Trucks
	ADD SCT int;
END

-- Adding [SCT] FK in [Trucks]
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
               WHERE name = 'FK_Trucks_SCT' 
               AND parent_object_id = OBJECT_ID('dbo.Trucks'))
BEGIN
	ALTER TABLE Trucks
	ADD Constraint FK_Trucks_SCT foreign key(SCT) references SCT(id);
END


IF OBJECT_ID('FK_Trucks_Manufacturers', 'F') IS NOT NULL
BEGIN
	ALTER TABLE Trucks
	DROP Constraint FK_Trucks_Manufacturers;
END

-- Drop [Manufacturer] Column 
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Trucks') 
           AND name = 'Manufacturer')
BEGIN
    ALTER TABLE Trucks
    DROP COLUMN Manufacturer;
END

-- Adding [Model] column in [Trucks]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Trucks') 
               AND name = 'Model')
BEGIN
	ALTER TABLE Trucks
	ADD Model int NOT NULL;
END

-- Adding [Model] FK in [Trucks]
IF NOT EXISTS (SELECT * FROM sys.foreign_keys 
               WHERE name = 'FK_Trucks_VehiculesModels' 
               AND parent_object_id = OBJECT_ID('dbo.Trucks'))
BEGIN
	ALTER TABLE Trucks
	ADD Constraint FK_Trucks_VehiculesModels foreign key(Model) references Vehicules_Models(id);
END


IF OBJECT_ID('dbo.Trucks', 'U') IS NOT NULL
BEGIN
    ALTER TABLE Trucks
	ALTER COLUMN Motor varchar(16);
END

--> Setting to nulleable non required values
IF OBJECT_ID('dbo.Trailers_Externals', 'U') IS NOT NULL
BEGIN
    ALTER TABLE Trailers_Externals
	ALTER COLUMN MxPlate varchar(12);
END

IF OBJECT_ID('dbo.Trucks_Externals', 'U') IS NOT NULL
BEGIN
	ALTER TABLE Trucks_Externals
	ALTER COLUMN MxPlate varchar(12);
END


--> Plates
IF OBJECT_ID('dbo.Plates', 'U') IS NOT NULL
BEGIN
	ALTER TABLE Plates
	ALTER COLUMN Expiration Date;

	ALTER TABLE Plates
	ALTER COLUMN [State] varchar(4);
END

--> Drivers
IF OBJECT_ID('dbo.Drivers', 'U') IS NOT NULL
BEGIN
	ALTER TABLE Drivers
	ALTER COLUMN DriverType varchar(16);

	ALTER TABLE Drivers
	ALTER COLUMN LicenseExpiration Date;

	ALTER TABLE Drivers
	ALTER COLUMN DrugalcRegistrationDate Date;

	ALTER TABLE Drivers
	ALTER COLUMN PullnoticeRegistrationDate Date;
END

--> Approaches
IF OBJECT_ID('dbo.Approaches', 'U') IS NOT NULL
BEGIN
	ALTER TABLE Approaches
	ALTER Column Email varchar(64) NOT NULL;
END

--> Yardlog
IF OBJECT_ID('dbo.Yard_Logs', 'U') IS NOT NULL
BEGIN
	ALTER TABLE Yard_Logs
	ALTER Column Seal varchar(64);
END

-- Adding [SealAlt] column in [Yard_Logs]
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE object_id = OBJECT_ID('dbo.Yard_Logs') 
               AND name = 'SealAlt')
BEGIN
	ALTER TABLE Yard_Logs
	ADD SealAlt varchar(64);
END


--> Employees
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
BEGIN
	ALTER TABLE Employees
	ALTER COLUMN IMSSRegistrationDate Date;

	ALTER TABLE Employees
	ALTER COLUMN NSS varchar(11);

	ALTER TABLE Employees
	ALTER COLUMN RFC varchar(12);

	ALTER TABLE Employees
	ALTER COLUMN AntecedentesNoPenaleseExp date;

	ALTER TABLE Employees
	ALTER COLUMN CURP varchar(18);

	ALTER TABLE Employees
	ALTER COLUMN Approach int;

	ALTER TABLE Employees
	ALTER COLUMN [Address] int;
END