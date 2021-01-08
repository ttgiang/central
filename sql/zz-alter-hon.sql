/* ------------------------------------------*/
/* TEST 2 PROD											*/
/* ------------------------------------------*/

/* remove other campus	*/

DELETE FROM tblApproval WHERE campus<>'HON'
DELETE FROM tblApprovalHist WHERE campus<>'HON'
DELETE FROM tblApprovalHist2 WHERE campus<>'HON'
DELETE FROM tblHelpidx WHERE campus<>'HON'
DELETE FROM tblInfo WHERE campus<>'HON'
DELETE FROM tblAssessedData WHERE campus<>'HON'
DELETE FROM tblAssessedDataARC WHERE campus<>'HON'
DELETE FROM tblAssessedQuestions WHERE campus<>'HON'
DELETE FROM tblAttach WHERE campus<>'HON'
DELETE FROM tbljobs WHERE campus<>'HON'
DELETE FROM tblCampusData WHERE campus<>'HON'
DELETE FROM tblProgramQuestions WHERE campus<>'HON'
DELETE FROM tblccowiq WHERE campus<>'HON'
DELETE FROM tblCoReq WHERE campus<>'HON'
DELETE FROM tblCourse WHERE campus<>'HON'
DELETE FROM tblCourseACCJC WHERE campus<>'HON'
DELETE FROM tblSystem WHERE campus<>'HON'
DELETE FROM tblCourseARC WHERE campus<>'HON'
DELETE FROM tblCourseAssess WHERE campus<>'HON'
DELETE FROM tblTasks WHERE campus<>'HON'
DELETE FROM tblCourseCAN WHERE campus<>'HON'
DELETE FROM tblCourseComp WHERE campus<>'HON'
DELETE FROM tblCourseCompAss WHERE campus<>'HON'
DELETE FROM tblUserLog2 WHERE campus<>'HON'
DELETE FROM tblCourseCompetency WHERE campus<>'HON'
DELETE FROM tblCourseContent WHERE campus<>'HON'
DELETE FROM tblCourseContentSLO WHERE campus<>'HON'
DELETE FROM tblApprover WHERE campus<>'HON'
DELETE FROM tblauthority WHERE campus<>'HON'
DELETE FROM tblCourseLinked WHERE campus<>'HON'
DELETE FROM tblCampusQuestions WHERE campus<>'HON'
DELETE FROM tblCourseQuestions WHERE campus<>'HON'
DELETE FROM tblCourseReport WHERE campus<>'HON'
DELETE FROM tblDiscipline WHERE campus<>'HON'
DELETE FROM tblDistribution WHERE campus<>'HON'
DELETE FROM tblDivision WHERE campus<>'HON'
DELETE FROM tblDocs WHERE campus<>'HON'
DELETE FROM tblEmailList WHERE campus<>'HON'
DELETE FROM tblExtra WHERE campus<>'HON'
DELETE FROM tblFDCategory WHERE campus<>'HON'
DELETE FROM tblFDProgram WHERE campus<>'HON'
DELETE FROM tblGenericContent WHERE campus<>'HON'
DELETE FROM tblGESLO WHERE campus<>'HON'
DELETE FROM tblcampus WHERE campus<>'HON'
DELETE FROM tblForms WHERE campus<>'HON'
DELETE FROM tblINI WHERE campus<>'HON'
DELETE FROM tblJSID WHERE campus<>'HON'
DELETE FROM tblArchivedProgram WHERE campus<>'HON'
DELETE FROM tblLinkedKeys WHERE campus<>'HON'
DELETE FROM tblCurrentProgram WHERE campus<>'HON'
DELETE FROM tblLists WHERE campus<>'HON'
DELETE FROM tblProposedProgram WHERE campus<>'HON'
DELETE FROM tblMail WHERE campus<>'HON'
DELETE FROM tblMisc WHERE campus<>'HON'
DELETE FROM tblMode WHERE campus<>'HON'
DELETE FROM tblPageHelp WHERE campus<>'HON'
DELETE FROM tblPosition WHERE campus<>'HON'
DELETE FROM tblPreReq WHERE campus<>'HON'
DELETE FROM tblprogramdegree WHERE campus<>'HON'
DELETE FROM tblPrograms WHERE campus<>'HON'
DELETE FROM tblCourseCC2 WHERE campus<>'HON'
DELETE FROM tblProps WHERE campus<>'HON'
DELETE FROM tblRequest WHERE campus<>'HON'
DELETE FROM tblReviewers WHERE campus<>'HON'
DELETE FROM tblReviewHist WHERE campus<>'HON'
DELETE FROM tblReviewHist2 WHERE campus<>'HON'
DELETE FROM tblRpt WHERE campus<>'HON'
DELETE FROM tblSLO WHERE campus<>'HON'
DELETE FROM tblSLOARC WHERE campus<>'HON'
DELETE FROM tblStatement WHERE campus<>'HON'
DELETE FROM tblsyllabus WHERE campus<>'HON'
DELETE FROM tblTempAttach WHERE campus<>'HON'
DELETE FROM tblTempCampusData WHERE campus<>'HON'
DELETE FROM tblTempCoReq WHERE campus<>'HON'
DELETE FROM tblTempCourse WHERE campus<>'HON'
DELETE FROM tblTempCourseACCJC WHERE campus<>'HON'
DELETE FROM tblTempCourseAssess WHERE campus<>'HON'
DELETE FROM tblTempCourseComp WHERE campus<>'HON'
DELETE FROM tblTempCourseCompAss WHERE campus<>'HON'
DELETE FROM tblTempCourseCompetency WHERE campus<>'HON'
DELETE FROM tblTempCourseContent WHERE campus<>'HON'
DELETE FROM tblfiledrop WHERE campus<>'HON'
DELETE FROM tblTempCourseContentSLO WHERE campus<>'HON'
DELETE FROM tblTempCourseLinked WHERE campus<>'HON'
DELETE FROM tblTempExtra WHERE campus<>'HON'
DELETE FROM tblTempGenericContent WHERE campus<>'HON'
DELETE FROM tblTempGESLO WHERE campus<>'HON'
DELETE FROM tblTemplate WHERE campus<>'HON'
DELETE FROM tblHtml WHERE campus<>'HON'
DELETE FROM tblTempPreReq WHERE campus<>'HON'
DELETE FROM tblRename WHERE campus<>'HON'
DELETE FROM tbltempPrograms WHERE campus<>'HON'
DELETE FROM tblTempXRef WHERE campus<>'HON'
DELETE FROM tblTest WHERE campus<>'HON'
DELETE FROM tblUploads WHERE campus<>'HON'
DELETE FROM tblUserLog WHERE campus<>'HON'
DELETE FROM tblUsers WHERE campus<>'HON'
DELETE FROM tblSearch WHERE campus<>'HON'
DELETE FROM tblUsersX WHERE campus<>'HON'
DELETE FROM tblValues WHERE campus<>'HON'
DELETE FROM tblValuesdata WHERE campus<>'HON'
DELETE FROM tblXRef WHERE campus<>'HON'

/* drop what won't be copied	*/

DROP table tblApproval
DROP table tblApprovalHist
DROP table tblApprovalHist2
DROP table tblHelpidx
DROP table tblInfo
DROP table tbljobs
DROP table tblAssessedData
DROP table tblAssessedDataARC
DROP table tblAssessedQuestions
DROP table tblTasks
DROP table tblAttach
--DROP table tblCampusData
DROP table tblSystem
DROP table tblCampusDataCC2
DROP table tblCampusDataMAU
DROP table tblccowiq
DROP table tblCoReq
DROP table tblUserLog2
DROP table tblCourseACCJC
DROP table tblCourseARC
DROP table tblCourseAssess
DROP table tblCourseCAN
DROP table tblCourseCC2
DROP table tblCourseComp
DROP table tblCourseCompAss
DROP table tblCourseCompetency
DROP table tblCourseContent
DROP table tblCourseContentSLO
DROP table tblCourseLinked
DROP table tblCourseMAU
DROP table tblCourseReport
DROP table tblDiscipline
DROP table tblCampusDataMAN
DROP table tblDocs
DROP table tblExtra
DROP table tblFDCategory
DROP table tblFDProgram
DROP table tblCourseMAN
DROP table tblCampusDataWIN
DROP table tblGenericContent
DROP table tblCourseWIN
DROP table tblGESLO
DROP table tblcampus
DROP table tblCourseWIN_ARC
DROP table tblForms
DROP table tblCampusDataHON
DROP table tblCourseHON
DROP table tblJSID
DROP table tblArchivedProgram
DROP table tblLinkedKeys
DROP table tblCurrentProgram
DROP table tblLists
DROP table tblProposedProgram
DROP table tblauthority
DROP table tblMail
DROP table tblMisc
DROP table tblMode
DROP table tblCourseUHMC
DROP table tblPageHelp
DROP table tblCampusDataUHMC
DROP table tblCourse
DROP table tblPosition
DROP table tblPreReq
DROP table tblprogramdegree
DROP table tblPrograms
DROP table tblProps
DROP table tblRequest
DROP table tblReviewers
DROP table tblReviewHist
DROP table tblReviewHist2
DROP table tblRpt
DROP table tblSLO
DROP table tblHtml
DROP table tblSLOARC
DROP table tblsyllabus
DROP table tblTempAttach
DROP table tblTempCampusData
DROP table tblTempCoReq
DROP table tblTempCourse
DROP table tblTempCourseACCJC
DROP table tblTempCourseAssess
DROP table tblTempCourseComp
DROP table tblTempCourseCompAss
DROP table tblTempCourseCompetency
DROP table tblTempCourseContent
DROP table tblTempCourseContentSLO
DROP table tblTempCourseLinked
DROP table tblTempExtra
DROP table tblTempGenericContent
DROP table tblTempGESLO
DROP table tblSearch
DROP table tblTempPreReq
DROP table tbltempPrograms
DROP table tblTempXRef
DROP table tblTest
DROP table tblUploads
DROP table tblUserLog
DROP table tblUsersX
DROP table tblValues
DROP table tblValuesdata
DROP table tblXRef
DROP table tblCourseQuestionsMAUOLD
DROP TABLE tblArea;
DROP TABLE tbldebug;
DROP TABLE tblidx;
DROP TABLE tbljobname;
DROP TABLE tbllevel;
DROP TABLE tblmode2;
DROP TABLE tblPDF;
DROP TABLE tblReportingStatus;
DROP TABLE tblSalutation;
DROP TABLE tblTabs;
DROP TABLE tblTaskMsg;
DROP TABLE tblTempCourseLinked2;
DROP TABLE tblText;
DROP TABLE tblcampusoutlines;


/* ------------------------------------------*/
/* HON													*/
/* ------------------------------------------*/
CREATE TABLE [dbo].[hon-outline](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[filename] [nvarchar](255) NULL,
	[alpha] [varchar](50) NULL,
	[num] [varchar](50) NULL
) ON [PRIMARY]
GO


use ccv2hon;

delete from tblCampusQuestions where campus<>'HON';
delete from tblCourseQuestions where campus<>'HON';
delete from tblINI where campus<>'HON';
delete from tblValues where campus<>'HON';

use ccv2;

delete from tblCampusQuestions where campus='HON';
delete from tblCourseQuestions where campus='HON';
delete from tblINI where campus='HON';
delete from tblValues where campus='HON';

insert into tblCourseQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext)
SELECT     campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext
FROM         _tblCourseQuestions

insert into tblINI(seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script)
SELECT     seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate, note, script
FROM         _tblINI


/* ------------------------------------------*/
/* IMPORT												*/
/* ------------------------------------------*/

delete from tblcourse where campus='HON';

delete from tblcampusdata where campus='HON';

insert into tblcourse(id, historyid, campus, coursealpha, coursenum, coursetype, progress, effectiveterm, coursetitle, division, dispid, auditdate)
SELECT     idx, historyid, campus, coursealpha, coursenum, coursetype, progress, effectiveterm, coursetitle, division, dispid, auditdate
FROM         tblcourseHON;

insert into tblcampusdata(historyid, campus, coursealpha, coursenum, coursetype, auditdate, auditby)
SELECT     historyid, campus, coursealpha, coursenum, coursetype, auditdate, 'SYSADM'
FROM         tblcourseHON;

FILL campus outlines

delete from tblCampusQuestions where campus='HON';
delete from tblCourseQuestions where campus='HON';

delete from tblCampusQuestionsHON where campus<>'HON';
delete from tblCourseQuestionsHON where campus<>'HON';

insert into tblCampusQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext)
SELECT     campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext
FROM         tblCampusQuestionsHON
WHERE     (campus = 'HON');


insert into tblCourseQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext)
SELECT     campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append, headertext
FROM         tblCourseQuestionsHON
WHERE     (campus = 'HON');

delete from tblini where campus='HON';

delete from tbliniHON where campus<>'HON';

select max(id) from tblini

delete ID from tblHON

create with new ID identity

insert into tblini



