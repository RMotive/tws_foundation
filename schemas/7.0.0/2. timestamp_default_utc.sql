USE [TWS Security]
BEGIN 
    -- Check if the cursor already exists and deallocate it if it does
    IF CURSOR_STATUS('global', 'TableCursor') >= -1
    BEGIN
        CLOSE TableCursor
        DEALLOCATE TableCursor
    END

    DECLARE @TableName NVARCHAR(128)
    DECLARE @ColumnName NVARCHAR(128)
    DECLARE @SQL NVARCHAR(MAX)

    DECLARE TableCursor CURSOR FOR
    SELECT TABLE_NAME, COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE COLUMN_NAME = 'Timestamp' AND DATA_TYPE IN ('datetime', 'datetime2') AND COLUMN_DEFAULT IS NULL

    OPEN TableCursor
    FETCH NEXT FROM TableCursor INTO @TableName, @ColumnName

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = 'ALTER TABLE [' + @TableName + '] ADD CONSTRAINT DF_' + @TableName + '_' + @ColumnName + ' DEFAULT GETUTCDATE() FOR [' + @ColumnName + ']'
        EXEC sp_executesql @SQL

        FETCH NEXT FROM TableCursor INTO @TableName, @ColumnName
    END

    CLOSE TableCursor
    DEALLOCATE TableCursor
END
GO

USE [TWS Business]
BEGIN 
    -- Check if the cursor already exists and deallocate it if it does
    IF CURSOR_STATUS('global', 'TableCursor') >= -1
    BEGIN
        CLOSE TableCursor
        DEALLOCATE TableCursor
    END

    DECLARE @TableName NVARCHAR(128)
    DECLARE @ColumnName NVARCHAR(128)
    DECLARE @SQL NVARCHAR(MAX)

    DECLARE TableCursor CURSOR FOR
    SELECT TABLE_NAME, COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE COLUMN_NAME = 'Timestamp' AND DATA_TYPE IN ('datetime', 'datetime2') AND COLUMN_DEFAULT IS NULL

    OPEN TableCursor
    FETCH NEXT FROM TableCursor INTO @TableName, @ColumnName

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @SQL = 'ALTER TABLE [' + @TableName + '] ADD CONSTRAINT DF_' + @TableName + '_' + @ColumnName + ' DEFAULT GETUTCDATE() FOR [' + @ColumnName + ']'
        EXEC sp_executesql @SQL

        FETCH NEXT FROM TableCursor INTO @TableName, @ColumnName
    END

    CLOSE TableCursor
    DEALLOCATE TableCursor
END
GO