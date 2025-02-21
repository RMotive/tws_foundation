--- Adding unique constraints
Use [TWS Business]

--> Trucks
IF NOT EXISTS (
    SELECT Common, COUNT(*)
    FROM Trucks
    GROUP BY Common
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Common pointers, then add the unique constraint
	ALTER TABLE Trucks
	ADD CONSTRAINT UQ_Trucks_TrucksCommons UNIQUE (Common);
	PRINT 'Truck Common constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on trucks. Constraint not applied.';
END

--> External Trucks
IF NOT EXISTS (
    SELECT Common, COUNT(*)
    FROM Trucks_Externals
    GROUP BY Common
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Common pointers, then add the unique constraint
	ALTER TABLE Trucks_Externals
	ADD CONSTRAINT UQ_TrucksExternals_TrucksCommons UNIQUE (Common);
	PRINT 'External Truck Common constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on external trucks. Constraint not applied.';
END

--> Trailers
IF NOT EXISTS (
    SELECT Common, COUNT(*)
    FROM Trailers
    GROUP BY Common
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Common pointers, then add the unique constraint
	ALTER TABLE Trailers
	ADD CONSTRAINT UQ_Trailers_TrailersCommons UNIQUE (Common);
	PRINT 'Triler Common constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Trailers. Constraint not applied.';
END

--> Trailers Externals
IF NOT EXISTS (
    SELECT Common, COUNT(*)
    FROM Trailers_Externals
    GROUP BY Common
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Common pointers, then add the unique constraint
	ALTER TABLE Trailers_Externals
	ADD CONSTRAINT UQ_TrailersExternals_TrailersCommons UNIQUE (Common);
	PRINT 'External Triler Common constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Externals Trailers. Constraint not applied.';
END

--> Drivers Externals - common
IF NOT EXISTS (
    SELECT Common, COUNT(*)
    FROM Drivers_Externals
    GROUP BY Common
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Common pointers, then add the unique constraint
	ALTER TABLE Drivers_Externals
	ADD CONSTRAINT UQ_DriversExternals_DriversCommons UNIQUE (Common);
	PRINT 'Drivers Externals common constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Drivers Externals. Constraint not applied.';
END

--> Drivers Externals - identification
IF NOT EXISTS (
    SELECT Identification, COUNT(*)
    FROM Drivers_Externals
    GROUP BY Identification
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated identifications pointers, then add the unique constraint
	ALTER TABLE Drivers_Externals
	ADD CONSTRAINT UQ_DriversExternals_Identifications UNIQUE (Identification);
	PRINT 'Drivers external Identification constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Drivers externals - identification. Constraint not applied.';
END

--> Drivers - common
IF NOT EXISTS (
    SELECT Common, COUNT(*)
    FROM Drivers
    GROUP BY Common
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated common pointers, then add the unique constraint
	ALTER TABLE Drivers
	ADD CONSTRAINT UQ_Drivers_DriversCommons UNIQUE (Common);
	PRINT 'Drivers common constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Drivers - Common. Constraint not applied.';
END

--> Drivers - Employee
IF NOT EXISTS (
    SELECT Employee, COUNT(*)
    FROM Drivers
    GROUP BY Employee
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Employee pointers, then add the unique constraint
	ALTER TABLE Drivers
	ADD CONSTRAINT UQ_Drivers_Employees UNIQUE (Employee);
	PRINT 'Drivers Employees constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Drivers - Employee. Constraint not applied.';
END

--> Employee - Identification
IF NOT EXISTS (
    SELECT Identification, COUNT(*)
    FROM Employees
    GROUP BY Identification
    HAVING COUNT(*) > 1
)
BEGIN
    -- If there is not duplicated Identification pointers, then add the unique constraint
	ALTER TABLE Employees
	ADD CONSTRAINT UQ_Employees_Identifications UNIQUE (Identification);
	PRINT ' Employees - Identification constraint added.';

END
ELSE
BEGIN
    PRINT 'Duplicated pointers founded on Employees - Identification. Constraint not applied.';
END