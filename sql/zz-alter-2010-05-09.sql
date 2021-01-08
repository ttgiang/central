--
-- tblApprovalHist
--
DROP INDEX tblApprovalHist.PK_tblApprovalHist_Main
GO

CREATE  INDEX [PK_tblApprovalHist_Main] ON [dbo].[tblApprovalHist]([campus], [coursealpha], [coursenum], [seq]) ON [PRIMARY]
GO

DROP INDEX tblApprovalHist2.PK_tblApprovalHist2_Main
GO

CREATE  INDEX [PK_tblApprovalHist2_Main] ON [dbo].[tblApprovalHist2]([campus], [coursealpha], [coursenum], [seq]) ON [PRIMARY]
GO

--
-- vw_ApprovalStatus
--
CREATE VIEW dbo.vw_ApprovalStatus
AS
SELECT     TOP 100 PERCENT c.campus, c.id, c.CourseAlpha, c.CourseNum, c.proposer, c.Progress, c.dateproposed, c.auditdate, c.route, c.subprogress, i.kid
FROM         dbo.tblCourse c INNER JOIN
                      dbo.tblINI i ON c.campus = i.campus AND c.route = i.id
WHERE     (c.CourseType = 'PRE') AND (c.route > 0) AND (i.category = 'ApprovalRouting') AND (c.CourseAlpha <> '')
ORDER BY c.campus, c.CourseAlpha, c.CourseNum

--
-- PK_XRefDB_Main
--
ALTER TABLE tblProps alter column content text
GO

--
-- PK_XRefDB_Main
--
DROP index tblXRef.PK_XRefDB_Main
GO

CREATE  INDEX [PK_XRefDB_Main] ON [dbo].[tblXRef]([campus], [CourseAlpha], [CourseNum], [CourseType], [CourseAlphaX], [CourseNumX]) ON [PRIMARY]
GO

--
-- PK_tblApproval_Seq
--
CREATE 
  INDEX [PK_tblApproval_Seq] ON [dbo].[tblApproval] ([campus], [coursealpha], [coursenum], [approval_seq])
WITH
    DROP_EXISTING
ON [PRIMARY]

--
-- PK_tblProps_Campus
--
DROP index tblProps.PK_tblProps_Campus
GO

CREATE  INDEX [PK_tblProps_Campus] ON [dbo].[tblProps]([campus], [propname]) WITH  FILLFACTOR = 90 ON [PRIMARY]
WITH
    DROP_EXISTING
ON [PRIMARY]

--
-- vw_ReviewerHistory
--
CREATE VIEW dbo.vw_ReviewerHistory
AS
SELECT     historyid, source, seq, item, acktion, dte, reviewer, campus, coursealpha, coursenum, comments, question
FROM         (SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                              CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM          tblReviewHist r INNER JOIN
                                              tblCourseQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = '1')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist r INNER JOIN
                                             tblCampusQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE  (r.source = '2')) ReviewHistory
UNION
SELECT     historyid, source, seq, item,acktion, dte, reviewer, campus, coursealpha, coursenum, comments, question
FROM         (SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                              CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM          tblReviewHist2 r INNER JOIN
                                              tblCourseQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE      (r.source = '1')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist2 r INNER JOIN
                                             tblCampusQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = '2')) ReviewHistory2


--
-- tblCourse
--
update tbltabs set alpha='coreqalpha',num='coreqnum' where tab='tblcoreq'
update tbltabs set alpha='prereqalpha',num='prereqnum' where tab='tblprereq'
update tbltabs set alpha='coursealphax',num='coursenumx' where tab='tblxref'
delete one of 2 tblxref

--
-- tblCourse
--
ALTER TABLE [dbo].[tblCourse] ADD 
	CONSTRAINT [DF_tblCourse_CourseType_1] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCourse_edit_1] DEFAULT (1) FOR [edit],
	CONSTRAINT [DF_tblCourse_Progress_1] DEFAULT ('MODIFY') FOR [Progress],
	CONSTRAINT [DF_tblCourse_edit1_1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCourse_edit2_1] DEFAULT (1) FOR [edit2]
GO

DROP INDEX tblCourse.PK_tblCourse_Main
GO

CREATE  INDEX [PK_tblCourse_Main] ON [dbo].[tblCourse]([campus], [CourseAlpha], [CourseNum], [CourseType]) ON [PRIMARY]
GO

DROP INDEX tblCourse.PK_tblCourse_Historyid
GO

CREATE  INDEX [PK_tblCourse_Historyid] ON [dbo].[tblCourse]([historyid]) ON [PRIMARY]
GO

DROP INDEX tblCourseARC.PK_tblCourse_MainARC
GO

CREATE  INDEX [PK_tblCourse_MainARC] ON [dbo].[tblCourseARC]([campus], [CourseAlpha], [CourseNum], [CourseType]) ON [PRIMARY]
GO

DROP INDEX tblCourseARC.PK_tblCourse_HistoryidARC
GO

CREATE  INDEX [PK_tblCourse_HistoryidARC] ON [dbo].[tblCourseARC]([historyid]) ON [PRIMARY]
GO

DROP INDEX tblCourseCAN.PK_tblCourse_MainCAN
GO

CREATE  INDEX [PK_tblCourse_MainCAN] ON [dbo].[tblCourseCAN]([campus], [CourseAlpha], [CourseNum], [CourseType]) ON [PRIMARY]
GO

DROP INDEX tblCourseCAN.PK_tblCourse_HistoryidCAN
GO

CREATE  INDEX [PK_tblCourse_HistoryidCAN] ON [dbo].[tblCourseCAN]([historyid]) ON [PRIMARY]
GO

--
-- tblTabs
--
ALTER TABLE [dbo].[tblTabs] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTabs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

 CREATE  INDEX [PK_TblTabs_Tab] ON [dbo].[tblTabs]([tab]) ON [PRIMARY]
GO

