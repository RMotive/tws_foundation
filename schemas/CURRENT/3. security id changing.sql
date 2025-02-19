use [TWS Security];

DECLARE @sql NVARCHAR(MAX) = N'';
DECLARE @table NVARCHAR(128);
DECLARE @column NVARCHAR(128);
DECLARE @constraint NVARCHAR(128);
DECLARE @parent_table NVARCHAR(128);
DECLARE @parent_column NVARCHAR(128);
DECLARE @referenced_table NVARCHAR(128);

-- Step 1: Identify all tables with Id columns of type INT
DECLARE table_cursor CURSOR FOR
SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'int' AND COLUMN_NAME IN ('id', 'Id');

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @table, @column;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- If the column is 'id' (lowercase), rename it to 'Id' (uppercase)
    IF @column = 'id'
    BEGIN
        SET @sql = @sql + N'EXEC sp_rename ''' + @table + N'.id'', ''Id'', ''COLUMN'';' + CHAR(13);
        SET @column = 'Id';
    END

    -- Step 2: Drop unique constraints or indexes that depend on the Profile column
    DECLARE uc_cursor CURSOR FOR
    SELECT name
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(@table) AND index_id > 0 AND name = 'UC_Profile_Permit';

    OPEN uc_cursor;
    FETCH NEXT FROM uc_cursor INTO @constraint;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'DROP INDEX ' + QUOTENAME(@constraint) + N' ON ' + QUOTENAME(@table) + N';' + CHAR(13);
        FETCH NEXT FROM uc_cursor INTO @constraint;
    END;

    CLOSE uc_cursor;
    DEALLOCATE uc_cursor;

    -- Step 3: Drop foreign key constraints that reference these Id columns
    DECLARE fk_cursor CURSOR FOR
    SELECT fk.name AS ForeignKeyName, tp.name AS ParentTableName, cp.name AS ParentColumnName, tr.name AS ReferencedTableName
    FROM sys.foreign_keys AS fk
    INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
    INNER JOIN sys.tables AS tr ON fk.referenced_object_id = tr.object_id
    INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.columns AS cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
    INNER JOIN sys.columns AS cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
    WHERE cr.name = @column AND tr.name = @table AND cr.system_type_id = 56;

    OPEN fk_cursor;
    FETCH NEXT FROM fk_cursor INTO @constraint, @parent_table, @parent_column, @referenced_table;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'ALTER TABLE ' + QUOTENAME(@parent_table) +
                   N' DROP CONSTRAINT ' + QUOTENAME(@constraint) + N';' + CHAR(13);
        FETCH NEXT FROM fk_cursor INTO @constraint, @parent_table, @parent_column, @referenced_table;
    END;

    CLOSE fk_cursor;
    DEALLOCATE fk_cursor;

    -- Step 4: Drop primary key constraints
    DECLARE pk_cursor CURSOR FOR
    SELECT k.name AS ConstraintName, t.name AS TableName
    FROM sys.key_constraints AS k
    INNER JOIN sys.tables AS t ON k.parent_object_id = t.object_id
    WHERE k.type = 'PK' AND t.name = @table;

    OPEN pk_cursor;
    FETCH NEXT FROM pk_cursor INTO @constraint, @table;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'ALTER TABLE ' + QUOTENAME(@table) +
                   N' DROP CONSTRAINT ' + QUOTENAME(@constraint) + N';' + CHAR(13);
        FETCH NEXT FROM pk_cursor INTO @constraint, @table;
    END;

    CLOSE pk_cursor;
    DEALLOCATE pk_cursor;

    -- Step 5: Alter Id column type
    SET @sql = @sql + N'ALTER TABLE ' + QUOTENAME(@table) +
               N' ALTER COLUMN ' + QUOTENAME(@column) + N' BIGINT;' + CHAR(13);

    -- Step 6: Alter referencing columns to match the new data type
    DECLARE ref_cursor CURSOR FOR
    SELECT tp.name AS ParentTableName, cp.name AS ParentColumnName
    FROM sys.foreign_keys AS fk
    INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
    INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.columns AS cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
    WHERE fkc.referenced_object_id = OBJECT_ID(@table) AND fkc.referenced_column_id = COLUMNPROPERTY(OBJECT_ID(@table), @column, 'ColumnId');

    OPEN ref_cursor;
    FETCH NEXT FROM ref_cursor INTO @parent_table, @parent_column;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'ALTER TABLE ' + QUOTENAME(@parent_table) +
                   N' ALTER COLUMN ' + QUOTENAME(@parent_column) + N' BIGINT;' + CHAR(13);
        FETCH NEXT FROM ref_cursor INTO @parent_table, @parent_column;
    END;

    CLOSE ref_cursor;
    DEALLOCATE ref_cursor;

    -- Step 7: Recreate primary key constraints
    DECLARE recreate_pk_cursor CURSOR FOR
    SELECT k.name AS ConstraintName, t.name AS TableName
    FROM sys.key_constraints AS k
    INNER JOIN sys.tables AS t ON k.parent_object_id = t.object_id
    WHERE k.type = 'PK' AND t.name = @table;

    OPEN recreate_pk_cursor;
    FETCH NEXT FROM recreate_pk_cursor INTO @constraint, @table;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'ALTER TABLE ' + QUOTENAME(@table) +
                   N' ADD CONSTRAINT ' + QUOTENAME(@constraint) +
                   N' PRIMARY KEY (' + QUOTENAME(@column) + N');' + CHAR(13);
        FETCH NEXT FROM recreate_pk_cursor INTO @constraint, @table;
    END;

    CLOSE recreate_pk_cursor;
    DEALLOCATE recreate_pk_cursor;

    -- Step 8: Recreate foreign key constraints with the specified naming convention
    DECLARE recreate_fk_cursor CURSOR FOR
    SELECT fk.name AS ForeignKeyName, tp.name AS ParentTableName, cp.name AS ParentColumnName, tr.name AS ReferencedTableName
    FROM sys.foreign_keys AS fk
    INNER JOIN sys.tables AS tp ON fk.parent_object_id = tp.object_id
    INNER JOIN sys.tables AS tr ON fk.referenced_object_id = tr.object_id
    INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.columns AS cp ON fkc.parent_column_id = cp.column_id AND fkc.parent_object_id = cp.object_id
    INNER JOIN sys.columns AS cr ON fkc.referenced_column_id = cr.column_id AND fkc.referenced_object_id = cr.object_id
    WHERE cr.name = @column AND tr.name = @table AND cr.system_type_id = 56;

    OPEN recreate_fk_cursor;
    FETCH NEXT FROM recreate_fk_cursor INTO @constraint, @parent_table, @parent_column, @referenced_table;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'ALTER TABLE ' + QUOTENAME(@parent_table) +
                   N' ADD CONSTRAINT ' + N'FK_' + @parent_table + '_' + @table +
                   N' FOREIGN KEY (' + QUOTENAME(@parent_column) + N') REFERENCES ' +
                   QUOTENAME(@referenced_table) + N'(' + QUOTENAME(@column) + N');' + CHAR(13);
        FETCH NEXT FROM recreate_fk_cursor INTO @constraint, @parent_table, @parent_column, @referenced_table;
    END;

    CLOSE recreate_fk_cursor;
    DEALLOCATE recreate_fk_cursor;

    -- Step 9: Recreate unique constraints or indexes
    DECLARE recreate_uc_cursor CURSOR FOR
    SELECT name
    FROM sys.indexes
    WHERE object_id = OBJECT_ID(@table) AND index_id > 0 AND name = 'UC_Profile_Permit';

    OPEN recreate_uc_cursor;
    FETCH NEXT FROM recreate_uc_cursor INTO @constraint;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @sql = @sql + N'CREATE UNIQUE INDEX ' + QUOTENAME(@constraint) + N' ON ' + QUOTENAME(@table) +
                   N' (' + QUOTENAME(@column) + N', Profile);' + CHAR(13);
        FETCH NEXT FROM recreate_uc_cursor INTO @constraint;
    END;

    CLOSE recreate_uc_cursor;
    DEALLOCATE recreate_uc_cursor;

    FETCH NEXT FROM table_cursor INTO @table, @column;
END;

CLOSE table_cursor