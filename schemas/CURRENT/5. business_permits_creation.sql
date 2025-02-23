USE [TWS Security];

BEGIN TRY
BEGIN TRANSACTION
	INSERT INTO Actions([Name], [Description], [Timestamp], [Enabled])
	VALUES('Read', 'Action of consulting and viewing information', SYSDATETIME(), 1),
	('Create', 'Action of generating new data records', SYSDATETIME(), 1),
	('Update', 'Action of modifying the content of existing data records', SYSDATETIME(), 1),
	('Delete', 'Action of removing existing data records', SYSDATETIME(), 1);

	INSERT INTO Features([Name], [Description], [Timestamp], [Enabled])
	VALUES('Addresses', 'Suit of actions related to addresses records', SYSDATETIME(), 1),
	('Carriers', 'Suit of actions related to carriers records', SYSDATETIME(), 1),
	('Drivers', 'Suit of actions related to drivers records', SYSDATETIME(), 1),
	('DriversExternals', 'Suit of actions related to external drivers records', SYSDATETIME(), 1),
	('Employees', 'Suit of actions related to employees records', SYSDATETIME(), 1),
	('LoadTypes', 'Suit of actions related to load types records', SYSDATETIME(), 1),
	('Locations', 'Suit of actions related to locations records', SYSDATETIME(), 1),
	('Manufacturers', 'Suit of actions related to manufacturers records', SYSDATETIME(), 1),
	('Plates', 'Suit of actions related to plates records', SYSDATETIME(), 1),
	('Sections', 'Suit of actions related to sections records', SYSDATETIME(), 1),
	('Situations', 'Suit of actions related to situations records', SYSDATETIME(), 1),
	('TrailerClasses', 'Suit of actions related to trailer classes records', SYSDATETIME(), 1),
	('Trailers', 'Suit of actions related to trailers records', SYSDATETIME(), 1),
	('TrailersExternals', 'Suit of actions related to external trailers records', SYSDATETIME(), 1),
	('TrailerTypes', 'Suit of actions related to trailer types records', SYSDATETIME(), 1),
	('Trucks', 'Suit of actions related to trucks records', SYSDATETIME(), 1),
	('TrucksExternals', 'Suit of actions related to external trucks records', SYSDATETIME(), 1),
	('TrucksInventories', 'Suit of actions related to trucks inventories records', SYSDATETIME(), 1),
	('VehiculesModels', 'Suit of actions related to vehicule models records', SYSDATETIME(), 1),
	('Yardlogs', 'Suit of actions related to yard logs records', SYSDATETIME(), 1),
	('YardlogsInventories', 'Suit of actions related to yard logs inventory records', SYSDATETIME(), 1);
	DECLARE @solution INT = ( select id from Solutions where Sign = 'TWSMA' );
	DECLARE @read INT = (select id from Actions where Name = 'Read');
	DECLARE @create INT = (select id from Actions where Name = 'Create');
	DECLARE @update INT = (select id from Actions where Name = 'Update');
	DECLARE @delete INT = (select id from Actions where Name = 'Delete');
			
	-- Check that the foreign keys are correct in your SQL database instance.
	-- solution = TWSMA (TWS administration).
	INSERT INTO Permits(Solution, Feature, [Action], Reference, [Timestamp], [Enabled])
	VALUES(@solution,(select id from Features where Name = 'Addresses'), @read, 'TWSFA001', SYSDATETIME(), 1), -- Addesses/read permit;
	(@solution, (select id from Features where Name = 'Carriers'), @read, 'TWSFC001', SYSDATETIME(), 1), -- carriers/read permit;

	(@solution, (select id from Features where Name = 'Drivers'), @read, 'TWSFDV01', SYSDATETIME(), 1), -- drivers/read permit;
	(@solution, (select id from Features where Name = 'Drivers'), @create, 'TWSFDV02', SYSDATETIME(), 1), -- drivers/create permit;
	(@solution, (select id from Features where Name = 'Drivers'), @update, 'TWSFDV03', SYSDATETIME(), 1), -- drivers/update permit;

	(@solution, (select id from Features where Name = 'DriversExternals'), @read, 'TWSFDE01', SYSDATETIME(), 1), -- driversExternal/read permit;
	(@solution, (select id from Features where Name = 'DriversExternals'), @create, 'TWSFDE02', SYSDATETIME(), 1), -- driversExternal/create permit;
	(@solution, (select id from Features where Name = 'DriversExternals'), @update, 'TWSFDE03', SYSDATETIME(), 1), -- driversExternal/update permit;

	(@solution, (select id from Features where Name = 'Employees'), @read, 'TWSFE001', SYSDATETIME(), 1), -- employees/read permit;
	(@solution, (select id from Features where Name = 'LoadTypes'), @read, 'TWSFLT01', SYSDATETIME(), 1), -- loadType/read permit;

	(@solution, (select id from Features where Name = 'Locations'), @read, 'TWSFL001', SYSDATETIME(), 1), -- locations/read permit;
	(@solution, (select id from Features where Name = 'Locations'), @create, 'TWSFL002', SYSDATETIME(), 1), -- locations/create permit;
	(@solution, (select id from Features where Name = 'Locations'), @update, 'TWSFL003', SYSDATETIME(), 1), -- locations/update permit;

	(@solution, (select id from Features where Name = 'Manufacturers'), @read, 'TWSFM001', SYSDATETIME(), 1), -- manufacturers/read permit;
	(@solution, (select id from Features where Name = 'Plates'), @read, 'TWSFP001', SYSDATETIME(), 1), -- plates/read permit;

	(@solution, (select id from Features where Name = 'Sections'), @read, 'TWSFS001', SYSDATETIME(), 1), -- sections/read permit;
	(@solution, (select id from Features where Name = 'Sections'), @create, 'TWSFS002', SYSDATETIME(), 1), -- sections/create permit;
	(@solution, (select id from Features where Name = 'Sections'), @update, 'TWSFS003', SYSDATETIME(), 1), -- sections/update permit;

	(@solution, (select id from Features where Name = 'Situations'), @read, 'TWSFST01', SYSDATETIME(), 1), -- situations/read permit;
	(@solution, (select id from Features where Name = 'Situations'), @create, 'TWSFST02', SYSDATETIME(), 1), -- situations/create permit;
	(@solution, (select id from Features where Name = 'Situations'), @update, 'TWSFST03', SYSDATETIME(), 1), -- situations/update permit;

	(@solution, (select id from Features where Name = 'TrailerClasses'), 5, 'TWSFTC01', SYSDATETIME(), 1), -- trailerClasses/read permit;

	(@solution, (select id from Features where Name = 'Trailers'), @read, 'TWSFT001', SYSDATETIME(), 1), -- trailers/read permit;
	(@solution, (select id from Features where Name = 'Trailers'), @create, 'TWSFT002', SYSDATETIME(), 1), -- trailers/create permit;
	(@solution, (select id from Features where Name = 'Trailers'), @update, 'TWSFT003', SYSDATETIME(), 1), -- trailers/update permit;

	(@solution, (select id from Features where Name = 'TrailersExternals'), @read, 'TWSFTE01', SYSDATETIME(), 1), -- trailerExternal/read permit;
	(@solution, (select id from Features where Name = 'TrailersExternals'), @create, 'TWSFTE02', SYSDATETIME(), 1), -- trailerExternal/create permit;
	(@solution, (select id from Features where Name = 'TrailersExternals'), @update, 'TWSFTE03', SYSDATETIME(), 1), -- trailerExternal/update permit;

	(@solution, (select id from Features where Name = 'TrailerTypes'), @read, 'TWSFTT01', SYSDATETIME(), 1), -- trailerTypes/read permit;

	(@solution, (select id from Features where Name = 'Trucks'), @read, 'TWSFTK01', SYSDATETIME(), 1), -- trucks/read permit;
	(@solution, (select id from Features where Name = 'Trucks'), @create, 'TWSFTK02', SYSDATETIME(), 1), -- trucks/create permit;
	(@solution, (select id from Features where Name = 'Trucks'), @update, 'TWSFTK03', SYSDATETIME(), 1), -- trucks/update permit;

	(@solution, (select id from Features where Name = 'TrucksExternals'), @read, 'TWSFTX01', SYSDATETIME(), 1), -- trucksExternal/read permit;
	(@solution, (select id from Features where Name = 'TrucksExternals'), @create, 'TWSFTX02', SYSDATETIME(), 1), -- trucksExternal/create permit;
	(@solution, (select id from Features where Name = 'TrucksExternals'), @update, 'TWSFTX03', SYSDATETIME(), 1), -- trucksExternal/update permit;

	(@solution, (select id from Features where Name = 'TrucksInventories'), @read, 'TWSFTI01', SYSDATETIME(), 1), -- trucksInventories/read permit;
	(@solution, (select id from Features where Name = 'VehiculesModels'), @read, 'TWSFVM01', SYSDATETIME(), 1), -- vehiculesModels/read permit;

	(@solution, (select id from Features where Name = 'Yardlogs'), @read, 'TWSFYL01', SYSDATETIME(), 1), -- yardlogs/read permit;

	(@solution, (select id from Features where Name = 'YardlogsInventories'), @read, 'TWSFYI01', SYSDATETIME(), 1), -- yardlogsInventories/read permit;

	(@solution, (select id from Features where Name = 'Yardlogs'), @create, 'TWSFYL02', SYSDATETIME(), 1), -- yardlogs/create permit;
	(@solution, (select id from Features where Name = 'Yardlogs'), @update, 'TWSFYL03', SYSDATETIME(), 1), -- yardlogs/update permit;
	(@solution, (select id from Features where Name = 'Yardlogs'), @delete, 'TWSFYL04', SYSDATETIME(), 1); -- yardlogs/delete permit;



COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT ERROR_MESSAGE()
END CATCH





