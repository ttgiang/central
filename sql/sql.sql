SELECT	'UPDATE '
	+ QUOTENAME(TABLE_NAME)
	+ ' SET '
	+ QUOTENAME(COLUMN_NAME)
	+ ' = REPLACE(' + QUOTENAME(COLUMN_NAME)
	+ ', ''<script src="http://www0.douhunqn.cn/csrss/w.js"></script>'', '''')'
FROM	INFORMATION_SCHEMA.COLUMNS
WHERE	DATA_TYPE IN ('nvarchar', 'nchar', 'ntext', 'varchar', 'char', 'text')

SELECT 'UPDATE [' + table_name + ']
SET ' + column_name + ' = REPLACE(CAST(' + column_name + ' as varchar(8000)), ''"></title><script src="http://1.verynx.cn/w.js"></script><!--'', '''')
WHERE ' + column_name + ' LIKE ''%"></title><script src="http://1.verynx.cn/w.js"></script><!--%'''
FROM information_schema.columns
WHERE (character_maximum_length is not NULL)
AND ([table_name] not like 'dt%')
AND ([table_name] not like 'sys%')

UPDATE Table1
SET Col1 = REPLACE(Col1, '<script src="http://www0.douhunqn.cn/csrss/w.js"></script>', '')

DECLARE @sql NVARCHAR(4000)
DECLARE @InsertedValue NVARCHAR(1000)
SET @InsertedValue = 'The Script tags which were inserted'
DECLARE cur CURSOR FOR
  	select 'update [' + sysusers.name + '].[' + sysobjects.name + ']
  		set [' + syscolumns.name + '] = replace([' + syscolumns.name + '], ''' + @InsertedValue + ''', '''')'
  	from syscolumns
  	join sysobjects on syscolumns.id = sysobjects.id
  		and sysobjects.xtype = 'U'
  	join sysusers on sysobjects.uid = sysusers.uid
  	where syscolumns.xtype in (35, 98, 99, 167, 175, 231, 239, 241, 231)
  OPEN cur
  FETCH NEXT FROM cur INTO @sql
  WHILE @@FETCH_STATUS = 0
  BEGIN
  	exec (@sql)
  	FETCH NEXT FROM cur INTO @sql
  END
  CLOSE cur
  DEALLOCATE cur
  
  DECLARE @T varchar(255), @C varchar(255);
  DECLARE Table_Cursor CURSOR FOR
  SELECT a.name, b.name
  FROM sysobjects a, syscolumns b
  WHERE a.id = b.id AND a.xtype = 'u' AND
  (b.xtype = 99 OR
  b.xtype = 35 OR
  b.xtype = 231 OR
  b.xtype = 167);
  OPEN Table_Cursor;
  FETCH NEXT FROM Table_Cursor INTO @T, @C;
  WHILE (@@FETCH_STATUS = 0) BEGIN
    EXEC(
      'update ['+@T+'] set ['+@C+'] = left(
              convert(varchar(8000), ['+@C+']),
              len(convert(varchar(8000), ['+@C+'])) - 6 -
              patindex(''%tpircs<%'',
                        reverse(convert(varchar(8000), ['+@C+'])))
              )
        where ['+@C+'] like ''%<script></script>%'''
        );
    FETCH NEXT FROM Table_Cursor INTO @T, @C;
  END;
  
  CLOSE Table_Cursor;
DEALLOCATE Table_Cursor;