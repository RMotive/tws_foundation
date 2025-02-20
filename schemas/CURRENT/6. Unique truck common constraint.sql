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