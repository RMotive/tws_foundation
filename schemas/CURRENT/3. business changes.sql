USE [TWS Business];

DELETE FROM Trailers_Inventories;
DELETE FROM Trucks_Inventories;
DELETE FROM Plates;
DELETE FROM Yard_Logs;
DELETE FROM Trailers;
DELETE FROM Trailers_Externals;
DELETE FROM Trailers_Commons;
DELETE FROM Trucks;

-- Check if table already exist.
IF OBJECT_ID(N'dbo.Vehicules_Models', N'U') IS NOT NULL  
   DELETE FROM [dbo].Vehicules_Models;  
GO

DELETE FROM Manufacturers;

IF OBJECT_ID(N'dbo.Trailers_Types', N'U') IS NOT NULL  
   DELETE FROM [dbo].Trailers_Types;  
GO
DELETE FROM Trailer_Classes;

-- Removing axis table and adding size property in a new table
ALTER TABLE Trailer_Classes
DROP CONSTRAINT FK_Trailers_Axes;

ALTER TABLE Trailer_Classes
DROP COLUMN Axis;

-- Removing table.
DROP TABLE Axes;

--> Normalizing Manufacturer Table
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

--> Changing properties in Manufacturers table

ALTER TABLE Manufacturers
DROP COLUMN [Year];

ALTER TABLE Manufacturers
DROP COLUMN Brand;

ALTER TABLE Manufacturers
DROP COLUMN Model;

ALTER TABLE Manufacturers
ADD [Name] varchar(32) NOT NULL;

ALTER TABLE Manufacturers
ADD [Description] varchar(100);

-- Normalizing trailer classes
CREATE TABLE Trailers_Types(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int NOT NULL,
[Timestamp] datetime NOT NULL,
Size Varchar(16) NOT NULL,
TrailerClass int NOT NULL,

constraint FK_TrailersTypes_Statuses foreign key([Status]) references Statuses(id),
constraint FK_TrailersTypes_TrailerClasses foreign key(TrailerClass) References Trailer_Classes(id)
);

--Removing previous class constraint
ALTER TABLE Trailers_Commons
DROP Constraint FK_TrailersCommons_TrailersClass;

ALTER TABLE Trailers_Commons
DROP Column Class;

ALTER TABLE Trailers_Commons
ADD [Type] int;

--Adding new class constraint
ALTER TABLE Trailers_Commons
ADD constraint FK_TrailerCommons_TrailersTypes foreign key([Type]) references Trailers_Types(id);

-- Moving SCT relationship to Trucks & trailers; Setting non-required properties:
ALTER TABLE Carriers
DROP Constraint FK_Carriers_SCT;

ALTER TABLE Carriers
DROP COLUMN SCT;

--> Trailers
ALTER TABLE Trailers
ADD SCT int;

ALTER TABLE Trailers
ADD Constraint FK_Trailers_SCT foreign key(SCT) references SCT(id);

ALTER TABLE Trailers
DROP Constraint FK_Trailers_Manufacturers;

ALTER TABLE Trailers
DROP COLUMN Manufacturer;

ALTER TABLE Trailers
ADD Model int;

ALTER TABLE Trailers
ADD Constraint FK_Trailers_VehiculesModels foreign key(Model) references Vehicules_Models(id);

--> Trucks
ALTER TABLE Trucks
ADD SCT int;

ALTER TABLE Trucks
ADD Constraint FK_Trucks_SCT foreign key(SCT) references SCT(id);

ALTER TABLE Trucks
DROP Constraint FK_Trucks_Manufacturers;

ALTER TABLE Trucks
DROP COLUMN Manufacturer;

ALTER TABLE Trucks
ADD Model int NOT NULL;

ALTER TABLE Trucks
ADD Constraint FK_Trucks_VehiculesModels foreign key(Model) references Vehicules_Models(id);

ALTER TABLE Trucks
ALTER COLUMN Motor varchar(16);

--> Setting to nulleable non required values
ALTER TABLE Trailers_Externals
ALTER COLUMN MxPlate varchar(12);

ALTER TABLE Trucks_Externals
ALTER COLUMN MxPlate varchar(12);

--> Plates
ALTER TABLE Plates
ALTER COLUMN Expiration Date;

ALTER TABLE Plates
ALTER COLUMN [State] varchar(4);

--> Drivers
ALTER TABLE Drivers
ALTER COLUMN DriverType varchar(16);

ALTER TABLE Drivers
ALTER COLUMN LicenseExpiration Date;

ALTER TABLE Drivers
ALTER COLUMN DrugalcRegistrationDate Date;

ALTER TABLE Drivers
ALTER COLUMN PullnoticeRegistrationDate Date;

--> Approaches
ALTER TABLE Approaches
	ALTER Column Email varchar(64) NOT NULL;

--> Yardlog
ALTER TABLE Yard_Logs
	ALTER Column Seal varchar(64);

ALTER TABLE Yard_Logs
	ADD SealAlt varchar(64);

--> Employees

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