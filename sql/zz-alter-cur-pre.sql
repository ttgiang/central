drop table tempPRE;

drop table tempCUR;

select campus,progress,historyid,coursealpha,coursenum,coursetype,coursedate,auditdate
into tempCUR
from tblcourse where coursetype='CUR';

select campus,progress,historyid,coursealpha,coursenum,coursetype,coursedate,auditdate
into tempPRE
from tblcourse where coursetype='PRE';

select c.historyid,c.campus,c.coursealpha,c.coursenum,c.progress,c.coursedate,c.auditdate,p.progress as p_progress,p.coursedate as pre_coursedate,p.auditdate as pre_auditdate
from tempCUR c join tempPRE p on
c.campus=p.campus
and c.coursealpha=p.coursealpha
and c.coursenum=p.coursenum
where c.progress <> 'APPROVED'
order by c.campus,c.coursealpha,c.coursenum