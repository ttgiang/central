USE [master]
GO
CREATE DATABASE [cc-backup] ON 
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\cc-backup.mdf' ),
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\cc-backup_log.ldf' )
 FOR ATTACH
GO
if exists (select name from master.sys.databases sd where name = N'cc-backup' and SUSER_SNAME(sd.owner_sid) = SUSER_SNAME() ) EXEC [cc-backup].dbo.sp_changedbowner @loginame=N'sa', @map=false
GO
