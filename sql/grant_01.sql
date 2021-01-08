use ccv2;

exec sp_addrolemember db_datareader, "ccusr" 
go

exec sp_addrolemember db_datawriter , "ccusr"
go