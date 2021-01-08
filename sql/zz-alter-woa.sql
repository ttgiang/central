delete from tblcoursequestions where campus='WOA';
delete from tblcampusquestions where campus='WOA';
delete from tblcourse where campus='WOA';
delete from tblcampusdata where campus='WOA';
delete from tblini where campus='WOA';

/* tblCampusQuestions */
INSERT INTO tblCampusQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
extra, [permanent], append, headertext)
SELECT 'WOA', type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
extra, [permanent], append, headertext
FROM tblCampusQuestions where campus='MAN';

update tblCampusQuestions set include='N',required='N',questionseq=0 where campus='WOA';

/* tblCourseQuestions */
INSERT INTO tblcoursequestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
extra, [permanent], append, headertext)
SELECT 'WOA', type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
extra, [permanent], append, headertext
FROM tblCourseQuestions where campus='MAN';

/* tblINI */
insert into tblini(seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script)
SELECT seq, category, 'WOA', kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script
FROM tblINI where campus='MAN';

