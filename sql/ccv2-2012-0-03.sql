use ccv2

/* ------------------------------------------*/
/* experimentaldate									*/
/* ------------------------------------------*/
ALTER TABLE tblcourse ADD experimentaldate smalldatetime;
ALTER TABLE tblcoursearc ADD experimentaldate smalldatetime;
ALTER TABLE tblcoursecan ADD experimentaldate smalldatetime;
ALTER TABLE tbltempcourse ADD experimentaldate smalldatetime;

/* remove HON from tables */
delete from tblcampusdata where campus='HON';
delete from tblCampusQuestions where campus='HON';
delete from tblCourse where campus='HON';
delete from tblCourseQuestions where campus='HON';
delete from tblDocs where campus='HON';
delete from tblINI where campus='HON';
delete from tblUsers where campus='HON';

/* import HON_tblCampusData */
INSERT INTO tblCampusData(id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit0, edit1, edit2, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19,
C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, jsid, auditdate, auditby, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47,
C48, C49, C50, C51, C52, C53, C54, C55)
SELECT id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit0, edit1, edit2, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19,
C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, jsid, auditdate, auditby, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47,
C48, C49, C50, C51, C52, C53, C54, C55
FROM HON_tblCampusData
WHERE campus='HON'

/* import tblCampusQuestions */
INSERT INTO tblCampusQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext,
extra, [permanent], append, headertext)
SELECT campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext,
extra, [permanent], append, headertext
FROM HON_tblCampusQuestions
WHERE campus='HON'

/* import tblCourse */
INSERT INTO tblCourse(id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits, repeatable, maxcredit,
articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate, auditdate, excluefromcatalog, dateproposed,
assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43,
X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60, X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75,
X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst, votesabstain, route, subprogress, MESSAGEPAGE01, MESSAGEPAGE02, MESSAGEPAGE03,
MESSAGEPAGE04, MESSAGEPAGE05, X81, X82, X83, X84, X85, X86, X87, X88, X89, X90, X91, X92, X93, X94, X95, X96, X97, X98, X99)
SELECT id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits, repeatable, maxcredit,
articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate, auditdate, excluefromcatalog, dateproposed,
assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43,
X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60, X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75,
X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst, votesabstain, route, subprogress, MESSAGEPAGE01, MESSAGEPAGE02, MESSAGEPAGE03,
MESSAGEPAGE04, MESSAGEPAGE05, X81, X82, X83, X84, X85, X86, X87, X88, X89, X90, X91, X92, X93, X94, X95, X96, X97, X98, X99
FROM HON_tblCourse
WHERE campus='HON'

/* import tblCourseQuestions */
INSERT INTO tblCourseQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext,
extra, [permanent], append, headertext)
SELECT campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext,
extra, [permanent], append, headertext
FROM HON_tblCourseQuestions
WHERE campus='HON'

/* import tbldocs */
INSERT INTO tblDocs(type, filename, show, campus, alpha, num, status)
SELECT type, filename, show, campus, alpha, num, status
FROM HON_tblDocs
WHERE campus='HON'

/* import tblINI */
INSERT INTO tblINI(seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script)
SELECT seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script
FROM HON_tblINI
WHERE campus='HON'

/* import HON_tblUsers */
INSERT INTO tblusers(campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, [check],
position, lastused, auditby, auditdate, alphas, sendnow, attachment, website, weburl, college)
SELECT campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, [check],
position, lastused, auditby, auditdate, alphas, sendnow, attachment, website, weburl, college
FROM HON_tblUsers
WHERE campus='HON'

/* ------------------------------------------*/
/* filedrop												*/
/* ------------------------------------------*/
ALTER TABLE tblfiledrop ADD descr text;

/* ------------------------------------------*/
/* schema												*/
/* ------------------------------------------*/
ALTER TABLE tbltasks ALTER COLUMN message varchar(50);
ALTER TABLE tblDocs ADD status char(3);
update tbldocs set status='ARC';

/* ------------------------------------------*/
/* start here											*/
/* ------------------------------------------*/
ALTER TABLE tblhelpidx ALTER column title varchar(50);
ALTER TABLE tblhelpidx ALTER column subtitle varchar(50);

/* ------------------------------------------*/
/* cccm6100 											*/
/* ------------------------------------------*/
update cccm6100 set CCCM6100 = 'Do Not Use - course alpha',comments='Do Not Use - course alpha'
where campus='TTG' and type='Campus' and Question_Number=27 and  Question_Friendly='C27';

update cccm6100 set CCCM6100 = 'Do Not Use - course number',comments='Do Not Use - course number'
where campus='TTG' and type='Campus' and Question_Number=28 and  Question_Friendly='C28';

update cccm6100 set CCCM6100 = 'Do Not Use - reserved for CC',comments='Do Not Use - reserved for CC'
where campus='TTG' and type='Campus' and Question_Number=29 and  Question_Friendly='C29';

update cccm6100 set CCCM6100 = 'Do Not Use - reserved for CC',comments='Do Not Use - reserved for CC'
where campus='TTG' and type='Campus' and Question_Number=30 and  Question_Friendly='C30';

/* ------------------------------------------*/
/* index												  */
/* ------------------------------------------*/
insert into tblSystem(campus,named,valu,descr)
values('GLOBAL','documentIndex','/tomcat/webapps/centraldocs/docs/index','Lucene index location');

/* ------------------------------------------*/
/* vw_EffectiveTerms								  */
/* ------------------------------------------*/
ALTER VIEW [dbo].[vw_EffectiveTerms]
AS
SELECT     tc.campus, tc.historyid, tc.CourseAlpha AS Alpha, tc.CourseNum AS Number, tc.coursetitle AS Title, bt.TERM_DESCRIPTION AS Term, bt.TERM_CODE, tc.proposer,
                      tc.coursedate
FROM         dbo.tblCourse AS tc INNER JOIN
                      dbo.BannerTerms AS bt ON tc.effectiveterm = bt.TERM_CODE
WHERE     (tc.CourseType = 'CUR')

/* ------------------------------------------*/
/* PK_tblUsers_name 								  */
/* ------------------------------------------*/
CREATE NONCLUSTERED INDEX [PK_tblUsers_name] ON [dbo].[tblUsers]
(
	[lastname] ASC,
	[firstname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


/* ------------------------------------------*/
/* cccm6100 											*/
/* ------------------------------------------*/
UPDATE tblCampusQuestions SET question='Do Not Use - reserved for CC',help='Do Not Use - reserved for CC',headertext='Do Not Use - reserved for CC'
WHERE questionnumber>=27 and questionnumber<=30;

UPDATE tblCampusQuestions SET question='Do Not Use - Explain Course Alpha',help='Do Not Use - Explain Course Alpha',headertext='Do Not Use - Explain Course Alpha'
WHERE questionnumber=27;

UPDATE tblCampusQuestions SET question='Do Not Use - Explain Course Number',help='Do Not Use - Explain Course Number',headertext='Do Not Use - Explain Course Number'
WHERE questionnumber=28;

/* ------------------------------------------*/
/* zz-rename											*/
/* ------------------------------------------*/
zz-props (only for MAN)
