use [TWS Business];

--- Adding foreign key from Guard to Employees table ---

alter table Yard_Logs
	alter column Guard bigint not null;

alter table Yard_Logs
	add constraint 

--- Altering names and removing unsued columns ---

IF EXISTS (
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = 'Yard_Logs' 
	AND COLUMN_NAME = 'Gname'
)
BEGIN
	alter table Yard_Logs
		drop column Gname;
END

IF EXISTS (
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = 'Yard_Logs' 
	AND COLUMN_NAME = 'Damage'
)
BEGIN
	EXEC('ALTER TABLE Yard_Logs drop column Damage');
END

IF EXISTS (
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = 'Yard_Logs' 
	AND COLUMN_NAME = 'TTPicture'
)
BEGIN
	EXEC sp_rename 'Yard_Logs.TTPicture', 'Evidence', 'COLUMN';

	alter table Yard_Logs
		add EvidenceTMP varbinary(max);

	update Yard_Logs 
		set EvidenceTMP = CONVERT(varbinary(max), Evidence);
	alter table Yard_Logs drop column Evidence;
	EXEC sp_rename 'Yard_Logs.EvidenceTMP', 'Evidence', 'COLUMN';
	ALTER TABLE Yard_Logs
	ALTER COLUMN Evidence VARBINARY(MAX) NOT NULL;
END

--- Adding DriverCommon ---

BEGIN TRY 
	IF NOT EXISTS (
		SELECT * 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'Yard_Logs' 
		AND COLUMN_NAME = 'DriverCommon'
	)
	BEGIN
		EXEC('ALTER TABLE Yard_Logs ADD DriverCommon BIGINT');
	END

	UPDATE Yard_Logs
	SET DriverCommon = (SELECT Common FROM Drivers d WHERE d.Id = Yard_Logs.Driver)
	WHERE Driver IS NOT NULL;

	UPDATE Yard_Logs
	SET DriverCommon = (SELECT Common FROM Drivers_Externals de WHERE de.Id = Yard_Logs.DriverExternal)
	WHERE Driver IS NULL AND DriverExternal IS NOT NULL;

	alter table Yard_Logs
		alter column DriverCommon bigint not null;

	alter table Yard_Logs
		add constraint FK_Yard_Logs_Drivers_Commons foreign key (DriverCommon) references Drivers_Commons(Id);

	alter table Yard_Logs drop constraint FK_Yard_Logs_Drivers;
	alter table Yard_Logs
		drop column Driver;

	alter table Yard_Logs drop constraint FK_Yard_Logs_Drivers_Externals;
	alter table Yard_Logs
		drop column DriverExternal;
END TRY
BEGIN CATCH
	PRINT 'An error occurred: ' + ERROR_MESSAGE();
	return;
END CATCH

--- Adding TruckCommon ---

BEGIN TRY 
	IF NOT EXISTS (
		SELECT * 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'Yard_Logs' 
		AND COLUMN_NAME = 'TruckCommon'
	)
	BEGIN
		EXEC('ALTER TABLE Yard_Logs ADD TruckCommon BIGINT');
	END

	UPDATE Yard_Logs
	SET TruckCommon = (SELECT Common FROM Trucks t WHERE t.Id = Yard_Logs.Truck)
	WHERE Truck IS NOT NULL;

	UPDATE Yard_Logs
	SET TruckCommon = (SELECT Common FROM Trucks_Externals te WHERE te.Id = Yard_Logs.TruckExternal)
	WHERE Truck IS NULL AND TruckExternal IS NOT NULL;

	alter table Yard_Logs
		alter column TruckCommon bigint not null;

	alter table Yard_Logs
		add constraint FK_Yard_Logs_Trucks_Commons foreign key (TruckCommon) references Trucks_Commons(Id);

	alter table Yard_Logs drop constraint FK_Yard_Logs_Trucks;
	alter table Yard_Logs
		drop column Truck;

	alter table Yard_Logs drop constraint FK_Yard_Logs_Trucks_Externals;
	alter table Yard_Logs
		drop column TruckExternal;
END TRY
BEGIN CATCH
	PRINT 'An error occurred: ' + ERROR_MESSAGE();
	return;
END CATCH

--- Adding TrailerCommon ---

BEGIN TRY 
	IF NOT EXISTS (
		SELECT * 
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'Yard_Logs' 
		AND COLUMN_NAME = 'TrailerCommon'
	)
	BEGIN
		EXEC('ALTER TABLE Yard_Logs ADD TrailerCommon BIGINT');
	END


	UPDATE Yard_Logs
	SET TrailerCommon = (SELECT Common FROM Trailers t WHERE t.Id = Yard_Logs.Trailer)
	WHERE Trailer IS NOT NULL;

	UPDATE Yard_Logs
	SET TrailerCommon = (SELECT Common FROM Trailers_Externals te WHERE te.Id = Yard_Logs.TrailerExternal)
	WHERE Trailer IS NULL AND TrailerExternal IS NOT NULL;

	alter table Yard_Logs
		add constraint FK_Yard_Logs_Trailers_Commons foreign key (TrailerCommon) references Trailers_Commons(Id);

	alter table Yard_Logs drop constraint FK_Yard_Logs_Trailers;
	alter table Yard_Logs
		drop column Trailers;

	alter table Yard_Logs drop constraint FK_Yard_Logs_Trailers_Externals;
	alter table Yard_Logs
		drop column TrailerExternal;
END TRY
BEGIN CATCH
	PRINT 'An error occurred: ' + ERROR_MESSAGE();
	return;
END CATCH


