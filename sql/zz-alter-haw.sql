use ccv2

DELETE FROM tblApprover WHERE campus='HAW'
DELETE FROM tblAssessedQuestions WHERE campus='HAW'
--DELETE FROM tblcampus WHERE campus='HAW'
DELETE FROM tblCampusData WHERE campus='HAW'
DELETE FROM tblCampusQuestions WHERE campus='HAW'
DELETE FROM tblCourse WHERE campus='HAW'
DELETE FROM tblCourseQuestions WHERE campus='HAW'
DELETE FROM tblDiscipline WHERE campus='HAW'
DELETE FROM tblDistribution WHERE campus='HAW'
DELETE FROM tblHelpidx WHERE campus='HAW'
DELETE FROM tblHtml WHERE campus='HAW'
DELETE FROM tblINI WHERE campus='HAW'
DELETE FROM tblJSID WHERE campus='HAW'
--DELETE FROM tblProgramQuestions WHERE campus='HAW'
--DELETE FROM tblProps WHERE campus='HAW'
--DELETE FROM tblStatement WHERE campus='HAW'
DELETE FROM tblTasks WHERE campus='HAW'
--DELETE FROM tblTemplate WHERE campus='HAW'
DELETE FROM tblUserLog WHERE campus='HAW'
DELETE FROM tblUserLog2 WHERE campus='HAW'
DELETE FROM tblUsers WHERE campus='HAW'


-- clean up
delete from tblcampusdata where campus='HAW';
delete from tblcourse where campus='HAW';

--DELETE FROM tblchairs WHERE campus<>'HAW';
--DELETE FROM tblDiscipline WHERE campus<>'HAW';
DELETE FROM tbldivision WHERE campus<>'HAW';
DELETE FROM tblApprover WHERE campus<>'HAW';
DELETE FROM tblCampusQuestions WHERE campus<>'HAW';
DELETE FROM tblCourseQuestions WHERE campus<>'HAW';
DELETE FROM tblINI WHERE campus<>'HAW';
DELETE FROM tblUsers WHERE campus<>'HAW';

use ccv2

--
--approver
--
delete from tblApprover where campus='HAW';
delete from tblApproverHAW where campus<>'HAW';
INSERT INTO tblapprover(approver_seq, approver, delegated, multilevel, department, division, campus, addedby, addeddate, experimental, route, availableDate, startdate, enddate)
SELECT approver_seq, approver, delegated, multilevel, department, division, campus, addedby, addeddate, experimental, route, availableDate, startdate, enddate
FROM tblApproverHAW

--
--CAMPUS
--
delete from tblCampusQuestions where campus='HAW';
delete from tblCampusQuestionsHAW where campus<>'HAW';
insert into tblCampusQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext)
SELECT     campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext
FROM         tblCampusQuestionsHAW
WHERE     (campus = 'HAW');

--
--Course
--
delete from tblCourseQuestions where campus='HAW';
delete from tblCourseQuestionsHAW where campus<>'HAW';
insert into tblCourseQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext)
SELECT     campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext
FROM         tblCourseQuestionsHAW
WHERE     (campus = 'HAW');

--
--INI
--
delete from tblini where campus='HAW';
delete from tbliniHAW where campus<>'HAW';

--select max(id) from tblini
--delete ID from tblHAW
--create with new ID identity
insert into tblini(seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script)
SELECT seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script
FROM tblINIHAW

--
--user
--
delete from tblusers where campus='HAW';

delete from tblusersHAW where campus<>'HAW';

INSERT INTO tblusers(campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, [check], 
	position, lastused, auditby, auditdate, alphas, sendnow, attachment, website, weburl, college)
SELECT campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, [check], 
	position, lastused, auditby, auditdate, alphas, sendnow, attachment, website, weburl, college
FROM tblUsersHAW




