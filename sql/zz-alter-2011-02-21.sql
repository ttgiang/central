/* END */

drop table _programsX;
drop table _tblApprovalHistX;
drop table _tblApprovalHistXX;
drop table _tblApprovalHistXXX;
drop table _tblCourseLEE;
drop table programs;

update tblSystem set valu='NO' where named='sendmail';

update tblINI set kval1='0' where kid='EnablePasswordConfirmation';

update tblINI set kval1='0' where kid='EnableOutlineValidation';


/* END */

/* ----------- */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHtml]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHtml]
GO

CREATE TABLE [dbo].[tblHtml] (
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[html] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/* ----------- */

insert into tblhtml (campus,historyid,category,html)
select campus, historyid, 'course' as category, '01/01/2000'
from tblcourse

/* ----------- */

insert into tblhtml (campus,historyid,category,html)
select campus, historyid, 'program' as category, '01/01/2000'
from tblprograms

/* ----------- */

ALTER TABLE tblUserLog ALTER column action varchar(500);

-- B64

/* ----------- */
 
DELETE FROM tblSystem WHERE campus='GLOBAL' AND named='documents';
DELETE FROM tblSystem WHERE campus='GLOBAL' AND named='aseGenericUploadFolder';
DELETE FROM tblSystem WHERE campus='GLOBAL' AND named='documentsURL';
DELETE FROM tblSystem WHERE campus='GLOBAL' AND named='aseUploadFolder';
DELETE FROM tblSystem WHERE campus='GLOBAL' AND named='aseUploadTempFolder';
DELETE FROM tblSystem WHERE campus='GLOBAL' AND named='aseGenericUploadFolder';

/* ----------- */

INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','documents','\\tomcat\\webapps\\centraldocs\\docs\\','');
INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','aseGenericUploadFolder','/centraldocs/docs/uploads/','');
INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','documentsURL','/centraldocs/docs/','')	;
INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','aseUploadFolder','/centraldocs/docs/campus/','');
INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','aseUploadTempFolder','/centraldocs/docs/temp/','')	;
INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','aseGenericUploadFolder','/centraldocs/docs/uploads/','');

/* ----------- */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SystemQuestionsInUse]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SystemQuestionsInUse]
GO

CREATE VIEW dbo.vw_SystemQuestionsInUse
AS
SELECT     DERIVEDTBL.questionnumber, DERIVEDTBL.In_Use, dbo.CCCM6100.CCCM6100 AS Question
FROM         (SELECT     questionnumber AS questionnumber, COUNT(questionnumber) AS In_Use
                       FROM          (SELECT     tc.questionnumber
                                               FROM          tblCourseQuestions tc INNER JOIN
                                                                      CCCM6100 ON tc.questionnumber = CCCM6100.Question_Number
                                               WHERE      (CCCM6100.campus = 'SYS') AND (tc.include = 'Y') AND (CCCM6100.type = 'Course')
                                               GROUP BY tc.questionnumber, tc.campus
                                               HAVING      (tc.campus IN ('HIL', 'LEE', 'KAP', 'UHMC'))) DERIVEDTBL
                       GROUP BY questionnumber) DERIVEDTBL INNER JOIN
                      dbo.CCCM6100 ON DERIVEDTBL.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.campus = 'SYS') AND (dbo.CCCM6100.type = 'Course')

/* ----------- */

/*
	INSTITUTION SLO - PENDING
*/

ISLO
		1) add to table - 	7	Institution LO	X81	ILO	tblValues	(tblLinkedItem)
		2) uncomment from crsqlst.jsp
		3) distributed X81 as question throughout

	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','EnableInstitutionLearningOutcomes','Determines whether ILO will be displayed','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('EnableInstitutionLearningOutcomes','YESNO','Determines whether ILO will be displayed','','radio')

/* ----------- */
		
C:\tomcat\webapps\central\docs\forum		
C:\tomcat\webapps\centraldocs\docs\forum		

/* ----------- */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedMatrix]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedMatrix]
GO

CREATE VIEW dbo.vw_LinkedMatrix
AS
SELECT DISTINCT TOP 100 PERCENT tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, tl.id, tl2.item, dbo.tblINI.kid AS shortdescr, dbo.tblINI.kdesc AS longdescr
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id LEFT OUTER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id AND tl.campus = dbo.tblINI.campus
ORDER BY tl.campus, tl.historyid, tl.src, tl.dst, tl.seq

/* ----------- */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApprovalStatus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApprovalStatus]
GO

CREATE VIEW dbo.vw_ApprovalStatus
AS
SELECT     TOP 100 PERCENT C.campus, C.id, C.historyid, C.CourseAlpha, C.CourseNum, C.coursetitle, C.route, C.proposer, C.Progress, C.subprogress, 
                      C.dateproposed, C.auditdate, I.kid
FROM         (SELECT     c.id, c.historyid, c.campus, c.CourseAlpha, c.CourseNum, c.Progress, c.coursetitle, c.route, c.proposer, c.subprogress, c.dateproposed, 
                                              c.auditdate
                       FROM          tblCourse c
                       WHERE      c.CourseType = 'PRE' AND NOT coursealpha IS NULL AND coursealpha <> '') C LEFT OUTER JOIN
                          (SELECT     campus, id, i.kid
                            FROM          tblINI i
                            WHERE      category = 'ApprovalRouting') I ON C.campus = I.campus AND I.id = C.route
ORDER BY C.campus, C.CourseAlpha, C.CourseNum

/* ----------- */

INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','attachment','NO','')

insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','ABIT','Applied Business and Information Technology');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','ACC','Accounting');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','AJ','Administration of Justice');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','ANR','Agriculture and Natural Resources');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','AH-D','Allied Health – Dental');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','AH-N','Allied Health – Nursing');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','ABRP','Auto Body Repair and Painting');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','AT','Automotive Technology');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','BC','Business Careers');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','BT','Business Technology');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','CA','Culinary Arts');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','ACE','Early Childhood Education');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','ECET','Electronic & Computer Engineering Technology');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','FT','Fashion Technology');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','HT','Hospitality and Tourism');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','HS','Human Services');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','SC','Sustainable Construction');
insert into tbldivision (campus,divisioncode,divisionname) VALUES ('UHMC','LAP','Liberal Arts Program');

/* ----------- */

ALTER TABLE forums ALTER column forum_description text;
ALTER TABLE forums ADD counter int;
ALTER TABLE forums ADD status varchar(20);
ALTER TABLE forums ADD priority int;
ALTER TABLE forums ADD auditdate smalldatetime;
ALTER TABLE forums ADD createddate smalldatetime;

ALTER TABLE tblvalues alter column shortdescr varchar(500);

INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('HAW', 'SLOGlobalUpdate', 'THANHG', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('HIL', 'SLOGlobalUpdate', 'THANHG,KOMENAKA', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('HON', 'SLOGlobalUpdate', 'THANHG', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('MAN', 'SLOGlobalUpdate', 'THANHG', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('LEE', 'SLOGlobalUpdate', 'THANHG,WALBRIT', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('KAP', 'SLOGlobalUpdate', 'THANHG,SPOPE', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('KAU', 'SLOGlobalUpdate', 'THANHG', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('UHMC', 'SLOGlobalUpdate', 'THANHG,BGK', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('WIN', 'SLOGlobalUpdate', 'THANHG', 'THANHG', GETDATE())
INSERT INTO tblDistribution (campus, title, members, auditby, auditdate) VALUES ('WOA', 'SLOGlobalUpdate', 'THANHG', 'THANHG', GETDATE())

CREATE  INDEX [PK_Attach2] ON [dbo].[tblAttach]([historyid], [coursealpha], [coursenum]) ON [PRIMARY]
GO

CREATE  INDEX [PK_AttachKixCategory] ON [dbo].[tblAttach]([historyid], [category]) ON [PRIMARY]
GO

ALTER TABLE tblReviewers ADD inviter varchar(50);

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewStatus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewStatus]
GO

CREATE VIEW dbo.vw_ReviewStatus
AS
SELECT  
	r.campus, c.CourseAlpha, c.CourseNum, r.userid, c.reviewdate, c.proposer, c.historyid, r.inviter, c.progress, c.subprogress
FROM 
	dbo.tblCourse AS c RIGHT OUTER JOIN
	dbo.tblReviewers AS r ON c.CourseAlpha = r.coursealpha 
	AND c.CourseNum = r.coursenum 
	AND c.campus = r.campus
WHERE
(c.coursetype='PRE' AND c.Progress = 'REVIEW') 
OR
(c.coursetype='PRE' AND c.Progress = 'APPROVAL' AND c.subprogress = 'REVIEW_IN_APPROVAL')

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','ReviewerWithinApprovalCanVote','Determines whether ILO will be displayed','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('ReviewerWithinApprovalCanVote','YESNO','Determines whether reviewers within approval can vote','','radio')

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApprovalStatus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApprovalStatus]
GO

CREATE VIEW dbo.vw_ApprovalStatus
AS
SELECT     TOP 100 PERCENT C.campus, C.id, C.historyid, C.CourseAlpha, C.CourseNum, C.coursetitle, C.route, C.proposer, C.Progress, C.subprogress, 
                      C.dateproposed, C.auditdate, I.kid
FROM         (SELECT     c.id, c.historyid, c.campus, c.CourseAlpha, c.CourseNum, c.Progress, c.coursetitle, c.route, c.proposer, c.subprogress, c.dateproposed, 
                                              c.auditdate
                       FROM          tblCourse c
                       WHERE      c.CourseType = 'PRE' AND NOT coursealpha IS NULL AND coursealpha <> '') C LEFT OUTER JOIN
                          (SELECT     campus, id, i.kid
                            FROM          tblINI i
                            WHERE      category = 'ApprovalRouting') I ON C.campus = I.campus AND I.id = C.route
WHERE     (C.route > 0)
ORDER BY C.campus, C.CourseAlpha, C.CourseNum

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApprovalsWithoutTasks]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApprovalsWithoutTasks]
GO

CREATE VIEW dbo.vw_ApprovalsWithoutTasks
AS
SELECT     TOP 100 PERCENT outline, campus
FROM         (SELECT     campus, rtrim(coursealpha) + rtrim(coursenum) AS outline
                       FROM          tblCourse
                       WHERE      (progress = 'APPROVAL' OR
                                              subprogress = 'REVIEW_IN_APPROVAL') AND coursetype = 'PRE') tblOutlines
WHERE     (outline NOT IN
                          (SELECT     tasks
                            FROM          (SELECT     campus, rtrim(coursealpha) + rtrim(coursenum) AS tasks
                                                    FROM          tblTasks
                                                    WHERE      (message = 'Approve outline' OR
                                                                           message = 'Review outline') AND coursetype = 'PRE') AS tblTasks))
ORDER BY campus, outline

CREATE VIEW dbo.vw_ProgramForViewing
AS
SELECT     TOP 100 PERCENT tp.campus, tp.historyid, tpd.alpha AS Program, dbo.tblDivision.divisionname, tp.title, tp.effectivedate AS [Effective Date], 
                      tp.auditby AS [Updated By], tp.auditdate AS [Updated Date], tp.type, tp.degreeid, tp.descr, tpd.title AS degreeTitle, tp.progress, tp.divisionid, tp.proposer,
                       dbo.tblDivision.divisioncode, tp.hid, tp.auditby, tp.effectivedate, tp.auditdate, tp.route, tp.outcomes, tp.functions, tp.organized, tp.enroll, tp.resources, 
                      tp.efficient, tp.effectiveness, tp.proposed, tp.rationale, tp.substantive, tp.articulated, tp.additionalstaff, tp.requiredhours, tp.votefor, tp.voteagainst, 
                      tp.voteabstain, tp.reviewdate, tp.comments, tp.datedeleted, tp.dateapproved, tp.regents, tp.regentsdate, tp.subprogress, tp.edit, tp.edit0, tp.edit1, 
                      tp.edit2
FROM         dbo.tblPrograms tp INNER JOIN
                      dbo.tblprogramdegree tpd ON tp.degreeid = tpd.degreeid INNER JOIN
                      dbo.tblDivision ON tp.divisionid = dbo.tblDivision.divid AND tp.campus = dbo.tblDivision.campus
ORDER BY tpd.alpha, tpd.title, tp.effectivedate

nalo-prod

ALTER TABLE forums ALTER column forum_grouping char(20);
ALTER TABLE forums ADD edit char;
ALTER TABLE forums ADD auditby varchar(50);

UPDATE forums
SET edit='0' 
WHERE status='Completed'

update forums 
set edit = '1' 
where status<>'Completed';

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTaskMsg]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTaskMsg]
GO

CREATE TABLE [dbo].[tblTaskMsg] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[category] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[aktion] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subprogress] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[initmenu] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submenu] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[mytask] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [char] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

-- NLO

ALTER TABLE messages ALTER column message_subject varchar(100);

ALTER TABLE tblDocs ALTER column filename varchar(50);

UPDATE tblCourse SET proposer = 'AAMODT' WHERE campus='KAP' AND coursealpha='MUS' and coursenum='253' and coursetype='PRE';

USE [ccv2]
GO
/****** Object:  Table [dbo].[tblSearch]    Script Date: 02/18/2011 23:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSearch](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[historyid] [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[src] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF

-- cctest
-- FCO
-- TLN

----------  KAP

SELECT	c.historyid, c.proposer, c.CourseAlpha, c.CourseNum, c.CourseType, c.route, c.Progress,  c.subprogress, a.seq, t.message
INTO		ZZZ
FROM		tblCourse c INNER JOIN
			tblTasks t ON c.proposer = t.submittedfor AND c.CourseAlpha = t.coursealpha AND 
			c.CourseNum = t.coursenum AND c.campus = t.campus LEFT OUTER JOIN
			tblApprovalHist a ON c.historyid = a.historyid
WHERE    (c.campus = 'KAP') AND (c.route > 0) AND (c.Progress = 'MODIFY') AND (c.CourseType = 'PRE') AND (a.seq IS NULL)

UPDATE    tblCourse
SET              route = 0
WHERE     (historyid IN
                          (SELECT     ZZZ.historyid
                            FROM          tblCourse AS tblCourse_1 INNER JOIN
                                                   ZZZ ON tblCourse_1.historyid = ZZZ.historyid AND tblCourse_1.CourseAlpha = ZZZ.CourseAlpha AND 
                                                   tblCourse_1.CourseNum = ZZZ.CourseNum AND tblCourse_1.CourseType = ZZZ.CourseType))
---------- UHMC

SELECT     tblHelpidx.id, tblHelpidx.campus, tblHelpidx.category, tblHelpidx.title, tblHelpidx.subtitle, tblHelpidx.auditby, tblHelpidx.auditdate, 
                      tblHelp.[content]
FROM         tblHelpidx INNER JOIN
                      tblHelp ON tblHelpidx.id = tblHelp.id
WHERE     (tblHelpidx.campus = 'UHMC')

use [nalo];
SELECT     help
from tblCoursequestions
where campus='UHMC'
and include='Y'

SELECT *
INTO Z001
FROM tblCoursequestions
WHERE campus='UHMC';

ALTER TABLE Z001 DROP COLUMN ID;

select max(id)
from tblCoursequestions

ALTER TABLE Z001 ADD ID int IDENTITY(1210,1)

SET IDENTITY_INSERT tblCoursequestions OFF;

INSERT INTO tblCoursequestions
SELECT *
FROM Z001
