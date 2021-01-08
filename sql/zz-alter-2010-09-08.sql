
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','IncludeSLOOnCreate','Determines whether student learning outcomes (SLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('IncludeSLOOnCreate','YESNO','Determines whether student learning outcomes (SLO) are included when creating an outline','','radio')

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','IncludePLOOnCreate','Determines whether program learning outcomes (PLO) are included when creating an outline','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('IncludePLOOnCreate','YESNO','Determines whether program learning outcomes (PLO) are included when creating an outline','','radio')

DELETE FROM tblApprover WHERE approver='' OR approver is null


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ProgramDepartmentChairs]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ProgramDepartmentChairs]
GO

CREATE VIEW dbo.vw_ProgramDepartmentChairs
AS
SELECT     TOP 100 PERCENT dbo.tblDivision.campus, dbo.tblDivision.divisionname, dbo.tblChairs.coursealpha, dbo.tblDivision.chairname, 
                      dbo.tblChairs.programid, dbo.tblDivision.delegated
FROM         dbo.tblDivision INNER JOIN
                      dbo.tblChairs ON dbo.tblDivision.divid = dbo.tblChairs.programid
ORDER BY dbo.tblDivision.campus, dbo.tblChairs.coursealpha

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','EnableOtherDepartmentLink','Determines whether links to other departments are used','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('EnableOtherDepartmentLink','YESNO','Determines whether links to other departments are used','','radio')

ALTER TABLE tblReviewHist ALTER column source char(2);
ALTER TABLE tblReviewHist2 ALTER column source char(2);

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewerHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewerHistory]
GO

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
                       WHERE  (r.source = '2')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist r INNER JOIN
                                             tblProgramQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE  (r.source = '-1')
		) ReviewHistory
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
                       WHERE     (r.source = '2')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist2 r INNER JOIN
                                             tblProgramQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = '-1')
		) ReviewHistory2


-- TALIN
-- FCO
-- NALO
-- B6400