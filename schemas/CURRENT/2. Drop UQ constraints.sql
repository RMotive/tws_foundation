-- Execute this queries to drop unnecesary UQ constraints in Trucks and Employees Tables.
use [TWS Business];

-- DELETE all UQ Constraints form Employees table.
DECLARE @table_name NVARCHAR(256) = 'Employees';
DECLARE @constraint_name NVARCHAR(256);
DECLARE @sql NVARCHAR(MAX);

-- Cursor for all contraints iteration.
DECLARE constraint_cursor CURSOR FOR
SELECT i.name
FROM sys.indexes i
JOIN sys.objects o ON i.object_id = o.object_id
WHERE o.name = @table_name
AND i.is_unique = 1
AND i.is_primary_key = 0;

-- Cursor initialization
OPEN constraint_cursor;

-- Constraints iterations.
FETCH NEXT FROM constraint_cursor INTO @constraint_name;
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Drop constraint command.
    SET @sql = 'ALTER TABLE ' + @table_name + ' DROP CONSTRAINT ' + @constraint_name;
    EXEC sp_executesql @sql;

    -- Go to next constraint.
    FETCH NEXT FROM constraint_cursor INTO @constraint_name;
END

-- Close cursor.
CLOSE constraint_cursor;
DEALLOCATE constraint_cursor;

--> DROP Motor UQ Constraint from Trucks table
DECLARE @table_name NVARCHAR(256) = 'Trucks';
DECLARE @column_name NVARCHAR(256) = 'Motor';
DECLARE @constraint_name NVARCHAR(256);
DECLARE @sql NVARCHAR(MAX);

-- Get the constraint name from column and table.
SELECT @constraint_name = i.name
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.objects o ON i.object_id = o.object_id
WHERE o.name = @table_name
AND c.name = @column_name
AND i.is_unique = 1
AND i.is_primary_key = 0;

-- IF the constraint exist, then execute the drop command.
IF @constraint_name IS NOT NULL
BEGIN
    SET @sql = 'ALTER TABLE ' + @table_name + ' DROP CONSTRAINT ' + @constraint_name;
    EXEC sp_executesql @sql;
END