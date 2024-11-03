USE [TWS Business];

-- Alter [Section] Column in [Yard_Logs]
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.Yard_Logs') 
           AND name = 'Section')
BEGIN
    ALTER TABLE Yard_Logs
    ALTER COLUMN Section int;
END