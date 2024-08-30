/****** Generate Tables ******/
create database [TWS Business];

use [TWS Business]
DROP TABLE PlatesTrucksH;
DROP TABLE Plates_H;
DROP TABLE Trucks_H;
DROP TABLE Carriers_H;
DROP TABLE USDOT_H;
DROP TABLE Approaches_H;
DROP TABLE Maintenances_H;
DROP TABLE Insurances_H;
DROP TABLE SCT_H;
DROP TABLE Trailers_Inventories;
DROP TABLE Trucks_Inventories;
DROP TABLE Yard_Logs;
DROP TABLE Sections;
DROP TABLE Load_Types;
DROP TABLE Plates;
DROP TABLE Trailers;
DROP TABLE Trailers_Externals;
DROP TABLE Trailers_Commons;
DROP TABLE Trailer_Classes;
DROP TABLE Axes;
DROP TABLE Trucks;
DROP TABLE Trucks_Externals;
DROP TABLE Trucks_Commons;
DROP TABLE Drivers;
DROP TABLE Drivers_Externals;
DROP TABLE Drivers_Commons;
DROP TABLE Employees;
DROP TABLE Identifications;
DROP TABLE Carriers;
DROP TABLE Locations;
DROP TABLE Addresses;
DROP TABLE Approaches;
DROP TABLE USDOT;
DROP TABLE SCT;
DROP TABLE Maintenances;
DROP TABLE Manufacturers;
DROP TABLE Insurances;
DROP TABLE Situations;
DROP TABLE Statuses;

create table Statuses(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Name] nvarchar (25) UNIQUE NOT NULL,
[Description] nvarchar (150)
);

create table Maintenances(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
Anual date NOT NULL,
Trimestral date NOT NULL,

constraint FK_Maintenances_Statuses foreign key([Status]) references Statuses(id)
);

create table Manufacturers(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
Model varchar(30) NOT NULL,
Brand varchar(15) NOT NULL,
[Year] date NOT NULL
);

create table Insurances(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
[Policy] varchar(20) NOT NULL,
Expiration date NOT NULL,
Country varchar(3) NOT NULL,

constraint FK_Insurances_Statuses foreign key([Status]) references Statuses(id)

);

create table Situations(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Name] nvarchar (25) UNIQUE NOT NULL,
[Description] nvarchar (100)
);

create table SCT(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
[Type] varchar(6) NOT NULL,
Number varchar(25) NOT NULL,
[Configuration] varchar(10) NOT NULL,

constraint FK_SCT_Statuses foreign key([Status]) references Statuses(id)

);

Create table Approaches(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
Email varchar(30) not null,
Enterprise varchar(14),
Personal varchar(13),
Alternative varchar(30),

constraint FK_Approaches_Statuses foreign key([Status]) references Statuses(id)

);

Create table Addresses(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
Country varchar(3) not null,
[State] varchar(4),
Street varchar(100),
AltStreet varchar(100),
City varchar(30),
ZIP varchar(5),
Colonia varchar(30),

);

create table USDOT(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
MC varchar(7),
SCAC varchar(4)

constraint FK_USDOT_Statuses foreign key([Status]) references Statuses(id),

);

create table Carriers(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
[Name] Varchar(20) not null,
Approach int not null,
[Address] int not null,
USDOT int,
SCT int,

constraint FK_Carriers_Statuses foreign key([Status]) references Statuses(id),
constraint FK_Carriers_Approaches foreign key(Approach) references approaches(id),
constraint FK_Carriers_Addresses foreign key([Address]) references Addresses(id),
constraint FK_Carriers_USDOT foreign key(USDOT) references USDOT(id),
constraint FK_Carriers_SCT foreign key(SCT) references SCT(id),

);

create table Locations(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int NOT NULL,
[Name] varchar(30) UNIQUE NOT NULL,
[Address] int NOT NULL,

constraint FK_Locations_Addresses foreign key([Address]) references Addresses(id),
constraint FK_Locations_Statuses foreign key([Status]) references Statuses(id)

);

create table Axes(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Name] varchar(30) NOT NULL,
Quantity int NOT NULL,
[Description] varchar(100)
);

create table Trailer_Classes(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Name] varchar(30) NOT NULL,
Axis int NOT NULL,
[Description] varchar(100),

constraint FK_Trailers_Axes foreign key(Axis) references Axes(id),

);
Create table  Trailers_Commons(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int NOT NULL,
Economic Varchar(16) NOT NULL,
Class int NOT NULL,
Carrier int NOT NULL,
Situation int NOT NULL,
[Location] int,

constraint FK_TrailersCommons_TrailersClass foreign key(Class) references Trailer_Classes(id),
constraint FK_TrailersCommons_Carriers foreign key(Carrier) references Carriers(id),
constraint FK_TrailersCommons_Situations foreign key(Situation) references Situations(id),
constraint FK_TrailersCommons_Locations foreign key([Location]) references Locations(id),
constraint FK_TrailersCommons_Statuses foreign key([Status]) references Statuses(id),

);

Create table Trailers_Externals(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int NOT NULL,
Common int NOT NULL,
MxPlate varchar(12) NOT NULL,
UsaPlate varchar(12),
constraint FK_TrailersExternals_TrailersCommons foreign key(Common) references Trailers_Commons(id),
constraint FK_TrailersExternals_Statuses foreign key([Status]) references Statuses(id),

);

create table Trailers(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int NOT NULL,
Common int NOT NULL,
Manufacturer int NOT NULL,
Maintenance int,

constraint FK_Trailers_Manufacturers foreign key(Manufacturer) references Manufacturers(id),
constraint FK_Trailers_Maintenances foreign key(Maintenance) references Maintenances(id),
constraint FK_Trailers_TrailersCommons foreign key(Common) references Trailers_Commons(id),
constraint FK_Trailers_Statuses foreign key([Status]) references Statuses(id),

);
Create table Identifications(
id int IDENTITY(1,1) PRIMARY KEY,
[Status] int NOT NULL,
[Name] varchar(32) NOT NULL,
FatherLastname varchar(32) NOT NULL,
MotherLastName varchar(32) NOT NULL,
Birthday date,

constraint FK_Identifications_Statuses foreign key([Status]) references Statuses(id),

);

create table Employees(
id int IDENTITY(1,1) PRIMARY KEY,
[Status] int NOT NULL,
Identification int NOT NULL,
[Address] int NOT NULL,
Approach int NOT NULL,
CURP varchar(18) UNIQUE NOT NULL,
AntecedentesNoPenaleseExp date NOT NULL,
RFC varchar(12) UNIQUE NOT NULL,
NSS varchar(11) UNIQUE NOT NULL,
IMSSRegistrationDate date NOT NULL,
HiringDate date,
TerminationDate date,

 constraint FK_Employees_Statuses foreign key([Status]) references Statuses(id),
 constraint FK_Employees_Identifications foreign key(Identification) references Identifications(id),
 constraint FK_Employees_Addresses foreign key([Address]) references Addresses(id),
 constraint FK_Employees_Approaches foreign key(Approach) references Approaches(id),
);

create table Drivers_Commons(
id int IDENTITY(1,1) PRIMARY KEY,
[Status] int NOT NULL,
Situation int,
License varchar(12) UNIQUE NOT NULL,

constraint FK_DriversCommons_Situations foreign key(Situation) references Situations(id),
constraint FK_DriversCommons_Statuses foreign key([Status]) references Statuses(id),

);

create table Drivers_Externals(
id int IDENTITY(1,1) PRIMARY KEY,
[Status] int NOT NULL,
Common int NOT NULL,
Identification int NOT NULL

constraint FK_DriversExternals_Statuses foreign key([Status]) references Statuses(id),
constraint FK_DriversExternals_DriversCommons foreign key(Common) references Drivers_Commons(id),
constraint FK_DriversExternal_Identifications foreign key(Identification) references Identifications(id),
);

create table Drivers(
id int IDENTITY(1,1) PRIMARY KEY,
[Status] int NOT NULL,
Employee int NOT  NULL,
Common int NOT NULL,
DriverType varchar(12) NOT NULL,
LicenseExpiration date NOT NULL,
DrugalcRegistrationDate date NOT NULL,
PullnoticeRegistrationDate date NOT NULL,
TWIC varchar(12),
TWICExpiration date,
VISA varchar(12),
VISAExpiration date,
[FAST] varchar(14),
FASTExpiration date,
ANAM varchar(24),
ANAMExpiration date,

constraint FK_Drivers_Statuses foreign key([Status]) references Statuses(id),
constraint FK_Drivers_DriversCommons foreign key(Common) references Drivers_Commons(id),
constraint FK_Drivers_Employees foreign key(Employee) references Employees(id),

);

create table Trucks_Commons(
 id int IDENTITY(1,1) PRIMARY KEY,
 [Status] int NOT NULL,
 VIN varchar(17) UNIQUE NOT NULL,
 Economic varchar(16) NOT NULL,
 Carrier int NOT NULL,
 Situation int,
 [Location] int,

 constraint FK_TrucksCommons_Situations foreign key(Situation) references Situations(id),
 constraint FK_TrucksCommons_Carriers foreign key(Carrier) references Carriers(id),
 constraint FK_TrucksCommons_Locations foreign key([Location]) references Locations(id),
 constraint FK_TrucksCommons_Statuses foreign key([Status]) references Statuses(id),

);


create table Trucks_Externals(
 id int IDENTITY(1,1) PRIMARY KEY,
 [Status] int NOT NULL,
 Common int NOT NULL,
 MxPlate varchar(12) NOT NULL,
 UsaPlate varchar(12),

 constraint FK_TrucksExternals_TrucksCommons foreign key(Common) references Trucks_Commons(id),
);

create table Trucks(
 id int IDENTITY(1,1) PRIMARY KEY,
 [Status] int NOT NULL,
 Common int NOT NULL,
 Manufacturer int NOT NULL,
 Motor varchar(16) UNIQUE NOT NULL,
 Maintenance int,
 Insurance int,

 constraint FK_Trucks_TrucksCommons foreign key(Common) references Trucks_Commons(id),
 constraint FK_Trucks_Manufacturers foreign key(Manufacturer) references Manufacturers(id),
 constraint FK_Trucks_Maintenances foreign key(Maintenance) references Maintenances(id),
 constraint FK_Trucks_Insurances foreign key(Insurance) references Insurances(id),
 constraint FK_Trucks_Statuses foreign key([Status]) references Statuses(id),

);
create table Plates(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int NOT NULL,
Identifier varchar(12) NOT NULL,
[State] varchar(4) NOT NULL,
Country varchar(3) NOT NULL,
Expiration date NOT NULL,
Truck int,
Trailer int,

 constraint FK_Plates_Trucks foreign key(Truck) references Trucks(id),
 constraint FK_Plates_Trailers foreign key(Trailer) references Trailers(id),
 constraint FK_Plates_Statuses foreign key([Status]) references Statuses(id),

);


create table Load_Types(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Name] varchar(32) UNIQUE NOT NULL,
[Description] varchar(100)
);

create table Sections(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Status] int not null,
Yard int NOT NULL,
[Name] varchar(32) NOT NULL,
Capacity int NOT NULL,
Ocupancy int NOT NULL,

constraint FK_Sections_Statuses foreign key([Status]) references Statuses(id),
constraint FK_Sections_Locations foreign key(Yard) references Locations(id),
);

create table Yard_Logs(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
[Entry] bit NOT NULL,
[Timestamp] datetime2,
Truck int,
TruckExternal int,
Trailer int,
TrailerExternal int,
LoadType int NOT NULL,
Guard int NOT NULL,
Gname varchar(100) NOT NULL,
Section int NOT NULL,
Seal varchar(64) NOT NULL,
FromTo varchar(100) NOT NULL,
Damage bit NOT NULL,
TTPicture varchar(MAX) NOT NULL,
DmgEvidence varchar(MAX),
Driver int,
DriverExternal int,

constraint FK_YardLogs_Drivers foreign key(Driver) references Drivers(id),
constraint FK_YardLogs_DriversExternals foreign key(DriverExternal) references Drivers_Externals(id),
constraint FK_YardLogs_Truck foreign key(Truck) references Trucks(id),
constraint FK_YardLogs_TruckExternals foreign key(TruckExternal) references Trucks_Externals(id),

constraint FK_YardLogs_Trailer foreign key(Trailer) references Trailers(id),
constraint FK_YardLogs_TrailerExternals foreign key(TrailerExternal) references Trailers_Externals(id),
constraint FK_YardLogs_LoadType foreign key(LoadType) references Load_Types(id),
constraint FK_YardLogs_Sections foreign key(Section) references Sections(id),

);

create table Trucks_Inventories(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
EntryDate datetime2 NOT NULL,
section int NOT NULL,
truck int,
truckExternal int,

constraint FK_TrucksInventory_TrucksExternal foreign key(truckExternal) references Trucks_Externals(id),
constraint FK_TrucksInventory_Trucks foreign key(Truck) references Trucks(id),

constraint FK_TrucksInventory_Sections foreign key(Section) references Sections(id),
);

create table Trailers_Inventories(
id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
EntryDate datetime2 NOT NULL,
section int NOT NULL,
trailer int,
trailerExternal int,

constraint FK_TrailerInventory_TrucksExternal foreign key(trailerExternal) references Trailers_Externals(id),
constraint FK_TrailerInventory_Trucks foreign key(trailer) references Trailers(id),
constraint FK_TrailersInventory_Sections foreign key(Section) references Sections(id),
);

-- Historical Tables --
 create table Insurances_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

 Entity int not null,
 [Policy] varchar(20) NOT NULL,
 Expiration date NOT NULL,
 Country varchar(3) NOT NULL,

 constraint FK_InsurancesH_Insurances foreign key(Entity) references Insurances(id),
 constraint FK_InsurancesH_Statuses foreign key([Status]) references Statuses(id)

 );
 create table Maintenances_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

 Entity int not null,
 Anual date NOT NULL,
 Trimestral date NOT NULL,

 constraint FK_MaintenancesH_Maintenances foreign key(Entity) references Maintenances(id),
 constraint FK_MaintenancesH_Statuses foreign key([Status]) references Statuses(id)

 );
 create table Plates_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

  Entity int not null,
 Identifier varchar(12) NOT NULL,
[State] varchar(4) NOT NULL,
Country varchar(3) NOT NULL,
Expiration date NOT NULL,
Truck int NOT NULL,

 constraint FK_PlatesH_Trucks foreign key(Truck) references Trucks(id),
 constraint FK_PlatesH_Plates foreign key(Entity) references Plates(id),
 constraint FK_PlatesH_Statuses foreign key([Status]) references Statuses(id)
 );
 create table SCT_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

  Entity int not null,
 [Type] varchar(6) NOT NULL,
 Number varchar(25) NOT NULL,
 [Configuration] varchar(10) NOT NULL

 constraint FK_SCTH_SCT foreign key(Entity) references SCT(id),
 constraint FK_SCTH_Statuses foreign key([Status]) references Statuses(id)
 );

 create table USDOT_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

 Entity int not null,
 MC varchar(7),
 SCAC varchar(4)

 constraint FK_USDOTH_USDOT foreign key(Entity) references USDOT(id),
 constraint FK_USDOTH_Statuses foreign key([Status]) references Statuses(id),

 );

 Create table Approaches_H(
  id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
  [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

 Entity int not null,
 Enterprise varchar(13),
Personal varchar(13),
Alternative varchar(30),
Email varchar(30) not null,

 constraint FK_ApproachesH_Approaches foreign key(Entity) references approaches(id),
 constraint FK_ApproachesH_Statuses foreign key([Status]) references Statuses(id)
 );

 create table Carriers_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

 Entity int not null,
 [Name] Varchar(20) not null,
 ApproachH int,
 [Address] int not null,
 USDOTH int,
 SCTH int,
 constraint FK_CarrierH_Carrier foreign key(Entity) references Carriers(id),
 constraint FK_CarrierH_Statuses foreign key([Status]) references Statuses(id),
 constraint FK_CarrierH_ApproachesH foreign key(ApproachH) references Approaches_H(id),
 constraint FK_CarrierH_Address foreign key([Address]) references Addresses(id),
 constraint FK_CarrierH_USDOTH foreign key(USDOTH) references USDOT_H(id),
 constraint FK_CarrierH_SCTH foreign key(SCTH) references SCT_H(id),
 );

 create table Trucks_H(
 id int IDENTITY (1,1) PRIMARY KEY NOT NULL,
 [Sequence] int not null DEFAULT 1,
 Timemark datetime2 not null,
 [Status] int not null,

 Entity int not null,
 VIN varchar(17) NOT NULL,
 Motor varchar(16),
 Economic Varchar(16) NOT NULL,
 Manufacturer int NOT NULL,
 Situation int,
 MaintenanceH int,
 InsuranceH int,
 CarrierH int,
 constraint FK_TrucksH_Manufacturers foreign key(Manufacturer) references Manufacturers(id),
 constraint FK_TrucksH_Situations foreign key(Situation) references Situations(id),
  constraint FK_TrucksH_MaintenancesH foreign key(MaintenanceH) references Maintenances_H(id),
 constraint FK_TrucksH_InsurancesH foreign key(InsuranceH) references Insurances_H(id),
  constraint FK_TrucksH_CarriersH foreign key(CarrierH) references Carriers_H(id),

 constraint FK_TruckH_Trucks foreign key(Entity) references Trucks(id),
 constraint FK_TrucksH_Statuses foreign key([Status]) references Statuses(id)

 );

 create table PlatesTrucksH(
  Plateid int not null,
  Truckhid int not null,

  constraint FK_PlatesTrucksH_Plates foreign key(Plateid) references Plates_H(id),
  constraint FK_PlatesTrucksH_TrucksH foreign key (Truckhid) references Trucks_H(id)
 );
