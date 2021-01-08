/* ---- */
update tblCampusOutlines set man=null,man_2=null;
update tblCampusOutlines set kau=null,MAN_2=null;

/* ---- tblCourseQuestions */
INSERT INTO tblCourseQuestions
	(campus, type, questionnumber, questionseq, question, 
	include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt)
SELECT	'MAN','Course',question_number,0,cccm6100,'N','N',cccm6100,'THANHG',getdate(),'N','','',''
FROM	CCCM6100
WHERE	(campus = 'SYS') AND (type = 'Course') 

/* ---- tblCampusQuestions */
DELETE FROM tblCampusQuestions WHERE campus='MAN';

INSERT INTO tblCampusQuestions (campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt)
SELECT campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt
FROM MAN_tblCampusQuestions

/* ---- tblCourseQuestions */
DELETE FROM tblCourseQuestions WHERE campus='MAN';

INSERT INTO tblCourseQuestions (campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt)
SELECT campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt
FROM MAN_tblCourseQuestions

/* ---- tblINI */
DELETE FROM tblINI WHERE campus='MAN';

INSERT INTO tblINI (seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note)
SELECT seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note
FROM MAN_tblINI

/* ---- tblUsers */
DELETE FROM tblUsers WHERE campus='MAN';

INSERT INTO tblUsers (campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, 
[check], [position], lastused, auditby, auditdate, alphas, sendnow)
SELECT campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, 
[check], [position], lastused, auditby, auditdate, alphas, sendnow
FROM MAN_tblUsers
