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


	-- Check that the foreign keys are correct in your SQL database instance.
	-- solution = TWSMA (TWS administration).
	INSERT INTO Permits(Solution, Feature, [Action], Reference, [Timestamp], [Enabled])
	VALUES(2, 22, 3, 'TWSFA001', SYSDATETIME(), 1), -- Addesses/read permit;
	(2, 23, 3, 'TWSFC001', SYSDATETIME(), 1), -- carriers/read permit;

	(2, 24, 3, 'TWSFDV01', SYSDATETIME(), 1), -- drivers/read permit;
	(2, 24, 4, 'TWSFDV02', SYSDATETIME(), 1), -- drivers/create permit;
	(2, 24, 5, 'TWSFDV03', SYSDATETIME(), 1), -- drivers/update permit;

	(2, 25, 3, 'TWSFDE01', SYSDATETIME(), 1), -- driversExternal/read permit;
	(2, 25, 4, 'TWSFDE02', SYSDATETIME(), 1), -- driversExternal/create permit;
	(2, 25, 5, 'TWSFDE03', SYSDATETIME(), 1), -- driversExternal/update permit;

	(2, 26, 3, 'TWSFE001', SYSDATETIME(), 1), -- employees/read permit;
	(2, 27, 3, 'TWSFLT01', SYSDATETIME(), 1), -- loadType/read permit;

	(2, 28, 3, 'TWSFL001', SYSDATETIME(), 1), -- locations/read permit;
	(2, 28, 4, 'TWSFL002', SYSDATETIME(), 1), -- locations/create permit;
	(2, 28, 5, 'TWSFL003', SYSDATETIME(), 1), -- locations/update permit;

	(2, 29, 3, 'TWSFM001', SYSDATETIME(), 1), -- manufacturers/read permit;
	(2, 30, 3, 'TWSFP001', SYSDATETIME(), 1), -- plates/read permit;

	(2, 31, 3, 'TWSFS001', SYSDATETIME(), 1), -- sections/read permit;
	(2, 31, 4, 'TWSFS002', SYSDATETIME(), 1), -- sections/create permit;
	(2, 31, 5, 'TWSFS003', SYSDATETIME(), 1), -- sections/update permit;

	(2, 32, 3, 'TWSFST01', SYSDATETIME(), 1), -- situations/read permit;
	(2, 32, 4, 'TWSFST02', SYSDATETIME(), 1), -- situations/create permit;
	(2, 32, 5, 'TWSFST03', SYSDATETIME(), 1), -- situations/update permit;

	(2, 33, 5, 'TWSFTC01', SYSDATETIME(), 1), -- trailerClasses/read permit;

	(2, 34, 3, 'TWSFT001', SYSDATETIME(), 1), -- trailers/read permit;
	(2, 34, 4, 'TWSFT002', SYSDATETIME(), 1), -- trailers/create permit;
	(2, 34, 5, 'TWSFT003', SYSDATETIME(), 1), -- trailers/update permit;

	(2, 35, 3, 'TWSFTE01', SYSDATETIME(), 1), -- trailerExternal/read permit;
	(2, 35, 4, 'TWSFTE02', SYSDATETIME(), 1), -- trailerExternal/create permit;
	(2, 35, 5, 'TWSFTE03', SYSDATETIME(), 1), -- trailerExternal/update permit;

	(2, 36, 3, 'TWSFTT01', SYSDATETIME(), 1), -- trailerTypes/read permit;

	(2, 37, 3, 'TWSFTK01', SYSDATETIME(), 1), -- trucks/read permit;
	(2, 37, 4, 'TWSFTK02', SYSDATETIME(), 1), -- trucks/create permit;
	(2, 37, 5, 'TWSFTK03', SYSDATETIME(), 1), -- trucks/update permit;

	(2, 38, 3, 'TWSFTX01', SYSDATETIME(), 1), -- trucksExternal/read permit;
	(2, 38, 4, 'TWSFTX02', SYSDATETIME(), 1), -- trucksExternal/create permit;
	(2, 38, 5, 'TWSFTX03', SYSDATETIME(), 1), -- trucksExternal/update permit;

	(2, 39, 3, 'TWSFTI01', SYSDATETIME(), 1), -- trucksInventories/read permit;
	(2, 40, 3, 'TWSFVM01', SYSDATETIME(), 1), -- vehiculesModels/read permit;

	(2, 41, 3, 'TWSFYL01', SYSDATETIME(), 1), -- yardlogs/read permit;

	(2, 42, 3, 'TWSFYI01', SYSDATETIME(), 1), -- yardlogsInventories/read permit;

	(2, 41, 4, 'TWSFYL02', SYSDATETIME(), 1), -- yardlogs/create permit;
	(2, 41, 5, 'TWSFYL03', SYSDATETIME(), 1), -- yardlogs/update permit;
	(2, 41, 6, 'TWSFYL04', SYSDATETIME(), 1); -- yardlogs/delete permit;



COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	PRINT ERROR_MESSAGE()
END CATCH





