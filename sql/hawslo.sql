delete FROM hawslo where crsalpha='HOST' and crsno='290';
update hawslo set status='CUR';
update hawslo set status='PRE' where crsalpha='AEC' and crsno='80';
update hawslo set status='PRE' where crsalpha='AEC' and crsno='110B';

--delete from tblcoursecomp where campus='HAW' and auditby='SYSADM-HAW-SLO'