-- Execute this queries to populate tables from the previous table deletions.
USE [TWS Business]

--> Stores the last id's inserted in tables
DECLARE @ID1 INT, @ID2 INT, @ID3 INT, @TID1 INT, @TID2 INT, @TID3 INT;

--> Manufacturers
INSERT INTO Manufacturers([Name], [Description], [Timestamp])
VALUES('Volvo','volvo Trucks and trailers', GETDATE()),('Scania','scania Trucks and trailers', GETDATE()),('Ford','ford Trucks and trailers', GETDATE());

--> Models
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Manufacturers
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Vehicules_Models([Name], [Year], Manufacturer, [Timestamp], [Status])
VALUES('volvo model 1', '2009', @ID1, GETDATE(), 1),('Scania model 2', '2010', @ID2, GETDATE(), 1),('Ford model 3', '2011', @ID3, GETDATE(), 1);

--> Trucks
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Vehicules_Models
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Trucks(Common, Model, Motor, VIN, Maintenance, Insurance, [Status], Carrier)
VALUES(1,@ID1,'Motortestnumber1', 'VINtest1-13324231',1,1,1,1),(2,@ID2,'Motortestnumber2','VINtest2-63324231',2,2,1,2),(3,@ID3,'Motortestnumber3', 'VINtest3-93324231',3,3,1,3);


--> Trailer_Classes
INSERT INTO Trailer_Classes([Name], [Description], [Timestamp])
VALUES('Dry van', 'Full closed trailer, ideal for dry load.', GETDATE()),('Reefer', 'Refrigerated closed trailer', GETDATE()),('Flatbed', 'Open flat platform. ideal for big vehicules or materials transport.', GETDATE());

--> Trailers_Types
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Trailer_Classes
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Trailers_Types(Size, TrailerClass, [Timestamp], [Status])
VALUES('48TF', @ID1, GETDATE(), 1),('50FT', @ID2, GETDATE(), 1), ('52FT', @ID3, GETDATE(), 1); 

--> Trailers_Commons
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Trailers_Types
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Trailers_Commons([Status], [Type], Situation, [Location], Economic, [Timestamp])
VALUES (1,@ID1,1,1, 'Economic 1', GETDATE()), (1,@ID2,2,2, 'Economic 2', GETDATE()), (1,@ID3,3,3, 'Economic 3', GETDATE());

--> Trailers_Externals
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Trailers_Commons
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Trailers_Externals([Status], Common, MxPlate, UsaPlate, Carrier, [Timestamp])
VALUES (1, @ID1, 'MXexternal1', 'USAexternal1', 'Trailer Carrier 1', GETDATE()), (1, @ID2, 'MXexternal2', 'USAexternal3', 'Trailer Carrier 2', GETDATE()), (1, @ID3,'MXexternal3', null, 'Trailer Carrier 3', GETDATE());

--> Trailers
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Trailers_Commons
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Vehicules_Models
)

SELECT 
    @TID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @TID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @TID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Trailers([Status], Common, Model, Maintenance, Carrier, [Timestamp])
VALUES (1,@ID1,@TID1,1,1, GETDATE()), (1,@ID2,@TID2,2,2, GETDATE()), (1,@ID3,@TID3,3,3, GETDATE());

--> Yardlogs
WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Trailers
)

SELECT 
    @ID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @ID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @ID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

WITH LastValues AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY id DESC) AS RowNum
    FROM Trucks
)

SELECT 
    @TID1 = MAX(CASE WHEN RowNum = 1 THEN id END),
    @TID2 = MAX(CASE WHEN RowNum = 2 THEN id END),
    @TID3 = MAX(CASE WHEN RowNum = 3 THEN id END)
FROM LastValues;

INSERT INTO Yard_Logs([Entry], Truck, TruckExternal, Trailer, TrailerExternal, LoadType, Guard, Gname, Section, FromTo, Damage, TTPicture, DmgEvidence, Driver, DriverExternal, Seal, [Timestamp])
VALUES(0, @TID1, null, @ID1, null, 1, 1,'Guard 1', 2, 'Coca Cola el Florido', 0, 'Truck and trailer picture 1', null, null, 1, '12133413', GETDATE()), (1, @TID2, null, @ID2, null, 2, 2,'Guard 2', 2, 'Coca Cola el Florido 2', 1, 'Truck and trailer picture 1', 'Damage picture 1', 2, null, '2321412', GETDATE()), (1, @TID3, null, @ID3, null, 3, 3,'Guard 3', 3, 'Coca Cola el Florido 3', 0, 'Truck and trailer picture 1', null, 2, null, '32183712', GETDATE());

--> Plates
INSERT INTO Plates(Identifier,[State],Country,Expiration, Truck, Trailer, [Status], [Timestamp])
VALUES
('SADC2423E132','CA','USA','2024-07-01',@TID1,null,1, GETDATE()),('TMEX2323EST2','BC','MEX','2024-09-02',@TID2, null,1, GETDATE()), ('TXH214E3ESC1','TX','USA','2024-11-03',@TID3, null, 1, GETDATE()),
('SADC2423E132','CA2','USA','2024-07-01',@TID1, null, 1, GETDATE()),('TMEX2323EST2','BC2','MEX','2024-09-02',@TID2,null, 1, GETDATE()), ('TXH214E3ESC1','TX2','USA','2024-11-03',@TID3, null, 1, GETDATE()),

-- Trailer plates MXN/USA--
('TRAILER23E13','CAT','USA','2024-07-01',null, @ID1, 1, GETDATE()),('TRAILERTMEX2','BC2','USA','2024-09-02', null, @ID2, 1, GETDATE()), ('TRAILERTXH24','TX2','USA','2024-11-03', null, @ID3, 1, GETDATE()),
('TRAILER23E11','CAT','MEX','2024-07-01',null, @ID1, 1, GETDATE()),('TRAILERTMEX2','BC2','MEX','2024-09-02', null, @ID2, 1, GETDATE()), ('TRAILERTXH21','TX2','MEX','2024-11-03', null, @ID3, 1, GETDATE());
