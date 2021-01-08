--
-- add column to vw_ReviewerHistory
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewerHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewerHistory]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ReviewerHistory
AS
SELECT     historyid, source, seq, item, acktion, dte, reviewer, campus, coursealpha, coursenum, comments, question
FROM         (SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                              CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM          tblReviewHist r INNER JOIN
                                              tblCourseQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = '1' OR r.source = '2')) ReviewHistory
UNION
SELECT     historyid, source, seq, item,acktion, dte, reviewer, campus, coursealpha, coursenum, comments, question
FROM         (SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                              CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM          tblReviewHist2 r INNER JOIN
                                              tblCourseQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE      (r.source = '1'  OR r.source = '2')) ReviewHistory2
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- add column to tblCourseQuestions
--
ALTER TABLE tblReviewHist ADD enabled bit DEFAULT 0
GO

ALTER TABLE tblReviewHist2 ADD enabled bit DEFAULT 0
GO

--
-- add column to tblextended
--
DELETE
FROM         tblReviewHist
WHERE     (historyid = 'TTG-B17k17g976')
GO

DELETE
FROM         tblReviewHist2
WHERE     (historyid = 'TTG-B17k17g976')
GO

--
-- add column to tblextended
--
UPDATE tblDebug SET debug=1
GO

--
-- add column to tblextended
--
INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblCourseContent','X19','historyid','')	
INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblCourseCompetency','X43','historyid','')	

INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblCourseLinked','X19','historyid','src')	
INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblCourseLinked','X71','historyid','src')	
INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblCourseLinked','X72','historyid','src')	

INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblCourseComp','X18','historyid','')	
INSERT INTO tblextended (tab,friendly,key1,key2) VALUES('tblGESLO','71','historyid','')	


GO

--
-- add column to tblCourseQuestions
--
ALTER TABLE tblLinkedItem ADD linkedtable varchar(30)
GO

--
-- add column to campus questions
--
ALTER TABLE CCCM6100 ALTER column Question_Type varchar(20)
GO

--
-- add column to campus questions
--
ALTER TABLE tblCampusQuestions ADD defalt text
GO

--
-- add column to tblCourseQuestions
--
ALTER TABLE tblCourseQuestions ADD defalt text
GO

--
-- add column to vw_CCCM6100_Campus
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100_Campus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100_Campus]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100_Campus
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, campus.question, 'N' AS change, campus.required, campus.helpfile, campus.audiofile,c61.rules,c61.rulesform,defalt
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblCampusQuestions campus ON c61.Question_Number = campus.questionnumber AND c61.type = campus.type AND 
                      c61.campus = campus.campus
WHERE     (c61.type = 'Campus') AND (campus.type = 'Campus')
ORDER BY campus.campus, campus.questionseq, c61.campus, c61.type

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- add column to vw_CCCM6100_Sys
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100_Sys]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100_Sys]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100_Sys
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, course.question, course.include, course.change, course.required, course.helpfile, course.audiofile,
	c61.rules,c61.rulesform,defalt
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblCourseQuestions course ON c61.Question_Number = course.questionnumber AND c61.type = course.type
WHERE     (c61.campus = 'SYS') AND (course.type = 'Course')
ORDER BY course.campus, course.questionseq, c61.campus

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- add column to vw_CCCM6100ByIDCampusCourse
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDCampusCourse]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDCampusCourse]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100ByIDCampusCourse
AS
SELECT     TOP 100 PERCENT course.id, course.campus, course.questionnumber, course.questionseq, course.question, course.include, c61.Question_Friendly, 
                      c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, course.auditby, course.auditdate, course.help, 
                      course.change, course.required, course.helpfile, course.audiofile,rules,rulesform,defalt
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = 'Course')
ORDER BY course.id, course.campus, course.questionnumber

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- add column to vw_CCCM6100ByIDCampusItems
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDCampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDCampusItems]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100ByIDCampusItems
AS
SELECT     TOP 100 PERCENT campus.campus, campus.id, campus.questionnumber, campus.questionseq, campus.question, campus.include, 
                      c61.Question_Friendly, c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, campus.auditby, 
                      campus.auditdate, campus.help, 'N' AS change, campus.required, campus.helpfile, campus.audiofile,rules,rulesform,defalt
FROM         dbo.tblCampusQuestions campus INNER JOIN
                      dbo.CCCM6100 c61 ON campus.campus = c61.campus AND campus.type = c61.type AND campus.questionnumber = c61.Question_Number
WHERE     (c61.type = 'Campus')
ORDER BY campus.campus, campus.id, campus.questionnumber

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- add column to vw_ApproverHistory
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApproverHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApproverHistory]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ApproverHistory
AS
SELECT     a1.historyid, a1.campus, a1.coursealpha, a1.coursenum, a1.dte, a1.approver_seq, a1.approver, a1.approved, CAST(a1.comments AS varchar(500)) 
                      AS comments
FROM         tblApprovalHist a1
UNION
SELECT     a2.historyid, a2.campus, a2.coursealpha, a2.coursenum, a2.dte, a2.approver_seq, a2.approver, a2.approved, CAST(a2.comments AS varchar(500)) 
                      AS comments
FROM         tblApprovalHist2 a2

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- add column to vw_Mode
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Mode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Mode]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Mode
AS
SELECT     tm.id, tm.campus, tm.mode, tm.item, tcq.questionnumber, tcq.questionseq, tcq.question, tm.override
FROM         dbo.tblCourseQuestions tcq INNER JOIN
                      dbo.CCCM6100 c61 ON tcq.questionnumber = c61.Question_Number INNER JOIN
                      dbo.tblMode tm ON tcq.campus = tm.campus AND c61.Question_Friendly = tm.item
WHERE     (c61.campus = 'SYS') AND (c61.type = 'Course')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- cccm6100
--
update cccm6100 
set question_len=90, question_max=5,question_type='textarea200'
where campus='SYS'
AND type='Course' 
AND question_number=73
AND question_friendly='X69'
GO

--
-- vw_Mode2
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Mode2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Mode2]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Mode2
AS
SELECT dbo.tblMode.id, dbo.tblMode.campus, dbo.tblMode.mode, dbo.tblMode.item, dbo.tblMode.override, dbo.tblMode2.seq, 
		dbo.tblMode2.item AS requireditem
FROM dbo.tblMode INNER JOIN
dbo.tblMode2 ON dbo.tblMode.id = dbo.tblMode2.id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
