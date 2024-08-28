
-- Declaration for trucks and trailers inventory situations;
USE [TWS Business];
DECLARE @situationParked varchar(max) = 'Parked in the yard';
DECLARE @situationInTransit varchar(max) = 'In Transit';

INSERT INTO Statuses([Name], [Description])
VALUES('Enable','Currently Active in this Solution.'), ('Disable', 'A deleted status. Stored for historical propurses . A disable record has limited features and visibility settings.');

INSERT INTO Maintenances(Anual, Trimestral, [Status])
VALUES('2025-08-08', '2024-08-08', 1),('2025-02-02', '2024-9-09', 1),('2025-10-10', '2024-10-10', 1);

INSERT INTO Manufacturers(Model, Brand, [Year])
VALUES('Volvo','AX200','2024'),('Scania','R-Series','2018'),('MAN','TGX','2020');

INSERT INTO Insurances([Policy], Expiration, Country, [Status])
VALUES('TestingPolicy1-12331','2024-10-10','MEX', 1),('TestingPolicy2-32331','2024-09-09','USA', 1),('TestingPolicy3-53242','2024-11-11','MEX', 1);

INSERT INTO Situations([Name],[Description])
VALUES(@situationParked, 'This unit is parked in some section in the yard.'), (@situationInTransit, 'Work in Transit'), ('Out of service', 'Maintenance Required ');

INSERT INTO SCT([Type], Number, [Configuration], [Status])
VALUES('Type06','SCTtesting1-1232111513111', 'confTest01', 1),('Type09','SCTtesting2-2232111513111', 'confTest02', 1),('Type12','SCTtesting3-3232111513111', 'confTest03', 1);

INSERT INTO USDOT(MC, SCAC, [Status])
VALUES('MCtest1','SCA1', 1),('MCtest1','SCA1', 1),('MCtest1','SCA1', 1);

INSERT INTO approaches(Enterprise, Personal, Alternative, Email, [Status])
VALUES('526631220311','112345678911', 'Alternative contact 1', 'mail@default1.com', 1),('5266312203422','112345678912', 'Alternative contact 2', 'mail@default3.com', 1),('5266312203433','112345678913', 'Alternative contact 3', 'mail@default3.com', 1);

INSERT INTO Addresses(Street, AltStreet, City, ZIP, Country, Colonia)
VALUES('First street', 'First alt street', 'Tijuana', 'ZIP11', 'MEX', 'Colonia 1'), ('Second street', 'Second alt street', 'San diego' ,'ZIP22', 'USA', 'Colonia 2'), ('Third street', 'Third alt street', 'Ensenada', 'ZIP33', 'MEX', 'Colonia 3');

INSERT INTO Carriers([Name], Approach, [Address], USDOT, SCT, [Status])
VALUES('TWSA', 1, 1, 1, 1, 1), ('TWS2', 2, 2, 2, 2, 1),('TWS3', 3, 3, 3, 3, 1);

INSERT INTO Locations([Status], [Name], [Address])
VALUES(1, 'TWSA HQ', 1),(1, 'LA Yard', 2), (1, 'Tijuana Yard #2', 1);

INSERT INTO Axes([Name], [Description], Quantity)
VALUES('Single axle', 'Single axle. For small trailers boxes', 1), ('Tandem axle', 'Multiple axle positioned near each other,  ', 2),  ('Triple axle', 'Triple Axle. axis are positiones at equal distances each other through the trailer', 3);

INSERT INTO Trailer_Classes([Name], [Description], Axis)
VALUES('Dry van', 'Full closed trailer, ideal for dry load.', 1),('Reefer', 'Refrigerated closed trailer', 2),('Flatbed', 'Open flat platform. ideal for big vehicules or materials transport.', 1);

INSERT INTO Trailers_Commons([Status],Class, Carrier, Situation, [Location], Economic)
VALUES (1,1,1,1,1, 'Economic 1'), (1,2,2,2,2, 'Economic 2'), (1,3,3,3,3, 'Economic 3');
 
INSERT INTO Trailers_Externals([Status], Common)
VALUES (1, 1), (1, 2), (1, 3);

INSERT INTO Trailers([Status], Common, Manufacturer, Maintenance)
VALUES (1,1,1,1), (1,2,2,2), (1,3,3,3);

INSERT INTO Identifications([Status], [Name], FatherLastname, MotherLastName, Birthday)
VALUES(1, 'ARTURO', 'RAMIREZ', 'MANCILLAS', SYSDATETIME()), (1, 'CARLOS JAVIER', 'SANCHEZ', 'GUZMAN', SYSDATETIME()), (1, 'URIAS', 'ARMENTA', 'CESAR', null);

INSERT INTO Employees([Status], Identification, CURP, AntecedentesNoPenaleseExp, [Address], Approach, RFC, NSS, IMSSRegistrationDate, HiringDate, TerminationDate)
VALUES(1, 1, 'RAMA830213HBCMNR03', SYSDATETIME(), 1, 1, 'RFC TEST1111', 'NSS test 11', SYSDATETIME(), SYSDATETIME(), SYSDATETIME()), (1, 2, 'SAGC771004HBCNZR07', SYSDATETIME(), 2, 2, 'RFC TEST2222', 'NSS test 22', SYSDATETIME(), SYSDATETIME(), SYSDATETIME()), (1, 3, 'UIAC770225HSLRRS06', SYSDATETIME(), 3, 3, 'RFC TEST3333', 'NSS test 33', SYSDATETIME(), SYSDATETIME(), SYSDATETIME());

INSERT INTO Drivers_Commons([Status], License, Situation)
VALUES(1, 'BCN0212895', 1), (1, 'BCN207292', 2), (1, 'BCN0215006', 3);

INSERT INTO Drivers_Externals([Status], Common, Identification)
VALUES(1, 1, 1),(1, 2, 2),(1, 3, 3);

INSERT INTO Drivers([Status], Employee, DriverType, Common, LicenseExpiration, TWIC,TWICExpiration, VISA, VISAExpiration, [FAST], FASTExpiration, ANAM, ANAMExpiration, DrugalcRegistrationDate, PullnoticeRegistrationDate)
VALUES(1, 1, 'Binational', 1, SYSDATETIME(), '28250230', SYSDATETIME(), 'TJT005336269', SYSDATETIME(), '411000013467', SYSDATETIME(), 'SATGN2017091940000001885', SYSDATETIME(), SYSDATETIME(), SYSDATETIME()), (1, 2, 'Mexican', 2, SYSDATETIME(), '28237819', SYSDATETIME(), 'TJT005044433', SYSDATETIME(), '41100103485400', SYSDATETIME(), 'SATGN2018060440000020884', SYSDATETIME(), SYSDATETIME(), SYSDATETIME()), (1, 3, 'Mexican', 3, SYSDATETIME(), '28247760', SYSDATETIME(), 'MEX041410210', SYSDATETIME(), '41100220935700', SYSDATETIME(), 'SATGN2022032740000116226', SYSDATETIME(), SYSDATETIME(), SYSDATETIME());

INSERT INTO Trucks_Commons([Status], VIN, Economic, Carrier, Situation)
VALUES (1, 'VINtest1-13324231',  'Economic 1', 1, 1), (1, 'VINtest2-63324231', 'Economic 2', 2, 2), (1, 'VINtest3-93324231', 'Economic 3', 2, 2);

INSERT INTO Trucks_Externals([Status], Common)
VALUES (1,1),(1,2),(1,3);

INSERT INTO Trucks(Common, Manufacturer, Motor, Maintenance, Insurance, [Status])
VALUES(1,1,'Motortestnumber1',1,1,1),(2,2,'Motortestnumber2',2,2,1),(3,3,'Motortestnumber3',3,3,1);

INSERT INTO Plates(Identifier,[State],Country,Expiration, Truck, Trailer, [Status])
VALUES
('SADC2423E132','CA','USA','2024-07-01',1,null,1),('TMEX2323EST2','BC','MEX','2024-09-02',2, null,1), ('TXH214E3ESC1','TX','USA','2024-11-03',3, null, 1),
('SADC2423E132','CA2','USA','2024-07-01',1, null, 1),('TMEX2323EST2','BC2','MEX','2024-09-02',2,null, 1), ('TXH214E3ESC1','TX2','USA','2024-11-03',3, null, 1),

-- Trailer plates MXN/USA--
('TRAILER23E13','CAT','USA','2024-07-01',null, 1, 1),('TRAILERTMEX2','BC2','USA','2024-09-02', null, 2, 1), ('TRAILERTXH24','TX2','USA','2024-11-03', null, 3, 1),
('TRAILER23E11','CAT','MEX','2024-07-01',null, 1, 1),('TRAILERTMEX2','BC2','MEX','2024-09-02', null, 2, 1), ('TRAILERTXH21','TX2','MEX','2024-11-03', null, 3, 1);

INSERT INTO Load_Types([Name], [Description])
VALUES('Loaded', 'DESCRIPTION 1'), ('Empty', 'DESCRIPTION 2'), ('Botado', 'DESCRIPTION 3');

INSERT INTO Sections([Name], Capacity, Ocupancy, [Status], Yard)
VALUES('A', 20, 0, 1, 1), ('B', 10, 0, 1, 2), ('C', 25, 0, 1, 3);

INSERT INTO Yard_Logs([Entry], Truck, TruckExternal, Trailer, TrailerExternal, LoadType, Guard, Gname, Section, FromTo, Damage, TTPicture, DmgEvidence, Driver, DriverExternal)
VALUES(1, 1, null, 1, null, 1, 1,'Guard 1', 2, 'Coca Cola el Florido', 0, 'Truck and trailer picture 1', null, 1, null), (1, 2, null, 2, null, 2, 2,'Guard 2', 2, 'Coca Cola el Florido 2', 1, 'Truck and trailer picture 1', 'Damage picture 1', 2, null), (1, 3, null, 3, null, 3, 3,'Guard 3', 3, 'Coca Cola el Florido 3', 0, 'Truck and trailer picture 1', null, 2, null);

