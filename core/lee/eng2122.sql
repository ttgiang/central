use ccv2;

-- using X15 as prereq
-- saved individual item
-- saved to large input box

drop table ENG2122;

SELECT *
INTO ENG2122
FROM
(
select 'course' as tab, historyid, coursealpha, coursenum, coursetitle, effectiveterm, coursedate, cast(x15 as varchar(1000)) as prereqs, 0 as done
from tblcourse
where campus='LEE' and coursetype = 'CUR' and (x15 like '%21%' or x15 like '%22%')
union
SELECT 'prereq' as tab, p.historyid, p.CourseAlpha, p.CourseNum, c.coursetitle, c.effectiveterm, c.coursedate, p.PrereqAlpha + ' ' + p.PrereqNum as prereqs, 0 as done
FROM   tblPreReq p inner join tblcourse c on p.historyid = c.historyid
WHERE     (p.Campus = 'LEE') AND (p.CourseType = 'CUR') AND (p.PrereqAlpha = 'ENG')
and (p.PrereqNum = '21' or p.PrereqNum = '22')
union
select 'campus' as tab, historyid, coursealpha, coursenum, coursetitle, effectiveterm, coursedate, cast(c25 as varchar(1000)) as prereqs, 0 as done
from
(
	select crs.historyid, crs.coursealpha, crs.coursenum, crs.coursetitle, crs.effectiveterm, crs.coursedate, cps.c25
	from tblcourse crs inner join tblcampusdata cps on crs.historyid = cps.historyid
	where crs.campus='LEE' and crs.coursetype = 'CUR'
) as inner_table
where c25 like '%ENG%' and (c25 like '%21%' or c25 like '%22%')
) as x;

alter table eng2122 add auditby varchar(50);
alter table eng2122 add auditdate datetime;
alter table eng2122 add updates text;

SELECT DISTINCT historyid, coursealpha, coursenum, coursetitle, effectiveterm, 
convert(varchar, coursedate, 101) as coursedate, auditby, auditdate, 
cast(updates as varchar(1000)) as updates
from ENG2122 
order by auditdate asc, coursealpha, coursenum;

md ENG2122
SELECT 'copy_' + historyid + '.html' AS course FROM ENG2122;

