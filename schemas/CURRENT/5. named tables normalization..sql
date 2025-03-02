

use [TWS Security];

DECLARE @tableName NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- List of table names to which you want to add the Description field
DECLARE @tableNames TABLE (TableName NVARCHAR(MAX));
INSERT INTO @tableNames (TableName) VALUES ('Contacts');

-- Cursor to iterate over the table names
DECLARE table_cursor CURSOR FOR
SELECT TableName FROM @tableNames;

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construct the SQL statement to add the Description field only if it doesn't exist
    SET @sql = 'IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS ' +
               'WHERE TABLE_NAME = ''' + @tableName + ''' AND COLUMN_NAME = ''Description'') ' +
               'BEGIN ' +
               'ALTER TABLE ' + @tableName + ' ADD Description VARCHAR(200); ' +
               'END;';
    
    -- Execute the SQL statement
    EXEC sp_executesql @sql;
    
    FETCH NEXT FROM table_cursor INTO @tableName;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;
