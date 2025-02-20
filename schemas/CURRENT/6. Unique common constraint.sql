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