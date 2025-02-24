USE [TWS Security];

BEGIN TRY
BEGIN TRANSACTION
	INSERT INTO Actions([Name], [Description], [Timestamp], [Enabled])
	VALUES
	('Passkey_Read', 'Action of read the accounts passkey', SYSDATETIME(), 1),
	('Passkey_Update', 'Action of update the accounts passkey', SYSDATETIME(), 1),
	('Passkey_Grant', 'Action of grant passkeys accounts permits', SYSDATETIME(), 1);

	INSERT INTO Features([Name], [Description], [Timestamp], [Enabled])
	VALUES ('Accounts', 'Suit of actions related to accounts records', SYSDATETIME(), 1),
	('Permits', 'Suit of actions related to permits records', SYSDATETIME(), 1),
	('Profiles', 'Suit of actions related to profiles records', SYSDATETIME(), 1);
	
	DECLARE @read INT = (select id from Actions where Name = 'View');
	DECLARE @create INT = (select id from Actions where Name = 'Create');
	DECLARE @update INT = (select id from Actions where Name = 'Update');
	DECLARE @delete INT = (select id from Actions where Name = 'Delete');
	DECLARE @passRead INT = (select id from Actions where Name = 'Passkey_Read');
	DECLARE @passUpdate INT = (select id from Actions where Name = 'Passkey_Update');
	DECLARE @passGrant INT = (select id from Actions where Name = 'Passkey_Grant');
	DECLARE @solution INT = ( select id from Solutions where Sign = 'TWSMA' );

	-- Check that the foreign keys are correct in your SQL database instance.
	-- solution = TWSMA (TWS administration).
	INSERT INTO Permits(Solution, Feature, [Action], Reference, [Timestamp], [Enabled])
	VALUES

	(@solution, (select id from Features where Name = 'Drivers'), @delete, 'TWSFDV04', SYSDATETIME(), 1), -- drivers/delete permit;

	(@solution, (select id from Features where Name = 'DriversExternals'), @delete, 'TWSFDE04', SYSDATETIME(), 1), -- driversExternal/delete permit;

	(@solution, (select id from Features where Name = 'Locations'), @delete, 'TWSFL004', SYSDATETIME(), 1), -- locations/delete permit;

	(@solution, (select id from Features where Name = 'Sections'), @delete, 'TWSFS004', SYSDATETIME(), 1), -- sections/delete permit;

	(@solution, (select id from Features where Name = 'Trailers'), @delete, 'TWSFT004', SYSDATETIME(), 1), -- trailers/delete permit;

	(@solution, (select id from Features where Name = 'TrailersExternals'), @delete, 'TWSFTE04', SYSDATETIME(), 1), -- trailerExternal/delete permit;

	(@solution, (select id from Features where Name = 'Trucks'), @delete, 'TWSFTK04', SYSDATETIME(), 1), -- trucks/delete permit;

	(@solution, (select id from Features where Name = 'TrucksExternals'), @delete, 'TWSFTX04', SYSDATETIME(), 1), -- trucksExternal/delete permit;
	
	(@solution, (select id from Features where Name = 'Accounts'), @read, 'TWSFAC01', SYSDATETIME(), 1), -- accounts/read permit;
	(@solution, (select id from Features where Name = 'Accounts'), @create, 'TWSFAC02', SYSDATETIME(), 1), -- accounts/create permit;
	(@solution, (select id from Features where Name = 'Accounts'), @update, 'TWSFAC03', SYSDATETIME(), 1), -- accounts/update permit;
	(@solution, (select id from Features where Name = 'Accounts'), @passRead, 'TWSFAC05', SYSDATETIME(), 1), -- accounts/pass read permit;
	(@solution, (select id from Features where Name = 'Accounts'), @passUpdate, 'TWSFAC06', SYSDATETIME(), 1), -- accounts/pass updt permit;
	(@solution, (select id from Features where Name = 'Accounts'), @passGrant, 'TWSFAC07', SYSDATETIME(), 1), -- accounts/pass grant permit;

	(@solution, (select id from Features where Name = 'Permits'), @read, 'TWSFPM01', SYSDATETIME(), 1), -- permits/read permit;
	
	(@solution, (select id from Features where Name = 'Profiles'), @read, 'TWSFPF01', SYSDATETIME(), 1);-- profiles/read permit;

COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT ERROR_MESSAGE()
END CATCH





