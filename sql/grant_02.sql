-- I've updated this with Aaron Bertrand's suggestions from the comments.
-- Thanks to Aaron for helping make this better!
DECLARE @sql AS NVARCHAR(MAX);
DECLARE @newline AS NVARCHAR(2);
DECLARE @user_name AS NVARCHAR(100);
DECLARE @sproc_name_pattern AS NVARCHAR(10);

SET @sql = N''
SET @newline = NCHAR(13) + NCHAR(10);
SET @user_name = N'ccusr';
-- escaping _ prevents it from matching any single character
-- including the wildcard makes this much more portable between DBs
SET @sproc_name_pattern = N'sproc[_]%';

-- using QUOTENAME will properly escape any object names with spaces
-- or other funky characters
SELECT @sql = @sql
              + N'GRANT EXECUTE ON '
              + QUOTENAME(OBJECT_SCHEMA_NAME([object_id])) + '.'
              + QUOTENAME([name])
              + N' TO '
              + QUOTENAME(@user_name)
              + N';'
              + @newline + @newline
  FROM sys.procedures
 WHERE [name] LIKE @sproc_name_pattern;

-- this is my version of debug code, I usually run it once with the PRINT intact
-- before I actually use sp_executesql
--PRINT @sql;

EXEC sp_executesql @sql;