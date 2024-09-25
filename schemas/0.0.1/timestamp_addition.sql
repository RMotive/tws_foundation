-- Updating Security tables --
use [TWS Security];

DECLARE @ColumnName NVARCHAR(128) = 'Timestamp';
DECLARE @ColumnType NVARCHAR(128) = 'DATETIME NOT NULL DEFAULT GETDATE()';
DECLARE @SQL NVARCHAR(MAX) = '';

-- Generate SQL to add the column if it doesn't exist
SELECT @SQL = @SQL + 'IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = ''' + TABLE_SCHEMA + ''' AND TABLE_NAME = ''' + TABLE_NAME + ''' AND COLUMN_NAME = ''' + @ColumnName + ''') ' +
              'BEGIN ' +
              'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
              ' ADD ' + QUOTENAME(@ColumnName) + ' ' + @ColumnType + '; ' +
              'END;' + CHAR(13)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Print the SQL for debugging
PRINT @SQL;

-- Execute the SQL to add the column
EXEC sp_executesql @SQL;

-- Updating Business tables --
use [TWS Business];

DECLARE @ColumnName NVARCHAR(128) = 'Timestamp';
DECLARE @SQL NVARCHAR(MAX) = '';

-- Generate SQL to drop constraints associated with the column
SELECT @SQL = @SQL + 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
              ' DROP CONSTRAINT ' + QUOTENAME(CONSTRAINT_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
WHERE COLUMN_NAME = @ColumnName;

-- Print the SQL for debugging
PRINT @SQL;

-- Execute the SQL to drop constraints
EXEC sp_executesql @SQL;

-- Reset the variable @SQL
SET @SQL = '';

-- Generate SQL to drop the column
SELECT @SQL = @SQL + 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
              ' DROP COLUMN ' + QUOTENAME(@ColumnName) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = @ColumnName;

-- Print the SQL for debugging
PRINT @SQL;

-- Execute the SQL to drop the column
EXEC sp_executesql @SQL;


DECLARE @ColumnName NVARCHAR(128) = 'Timestamp';
DECLARE @ColumnType NVARCHAR(128) = 'DATETIME NOT NULL DEFAULT GETDATE()';
DECLARE @SQL NVARCHAR(MAX) = '';

-- Generate SQL to add the column if it doesn't exist
SELECT @SQL = @SQL + 'IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = ''' + TABLE_SCHEMA + ''' AND TABLE_NAME = ''' + TABLE_NAME + ''' AND COLUMN_NAME = ''' + @ColumnName + ''') ' +
              'BEGIN ' +
              'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
              ' ADD ' + QUOTENAME(@ColumnName) + ' ' + @ColumnType + '; ' +
              'END;' + CHAR(13)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Print the SQL for debugging
PRINT @SQL;

-- Execute the SQL to add the column
EXEC sp_executesql @SQL;
