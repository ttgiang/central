/* ------------------------------------------*/
/* IMPORT												*/
/* ------------------------------------------*/

delete from tblcourse where campus='HAW';
delete from tblcampusdata where campus='HAW';

insert into tblcourse(id, historyid, campus, coursealpha, coursenum, coursetype, progress, effectiveterm, coursetitle, division, dispid, auditdate)
SELECT     idx, historyid, 'HAW', coursealpha, coursenum, coursetype, progress, effectiveterm, coursetitle, division, dispid, auditdate
FROM         courseHAW;

insert into tblcampusdata(historyid, campus, coursealpha, coursenum, coursetype, auditdate, auditby)
SELECT     historyid, 'HAW', coursealpha, coursenum, coursetype, auditdate, 'SYSADM'
FROM         courseHAW;

FILL campus outlines

