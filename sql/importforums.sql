DELETE FROM forums
Go

SET IDENTITY_INSERT forums ON
GO

INSERT INTO forums(
	forum_id,
	campus,
	historyid,
	creator,
	requestor,
	forum_name,
	forum_description,
	forum_start_date,
	forum_grouping,
	src,
	counter,
	status,
	priority,
	auditdate,
	createddate
)
select 
	forum_id,
	campus,
	historyid,
	creator,
	requestor,
	forum_name,
	forum_description,
	cast(convert(varchar, forum_start_date, 102) AS datetime) AS forum_start_date,
	forum_grouping,
	src,
	counter,
	status,
	priority,
	cast(convert(varchar, auditdate, 102) AS datetime) AS auditdate,
	cast(convert(varchar, auditdate, 102) AS datetime) AS createddate
from combined