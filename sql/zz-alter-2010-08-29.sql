SELECT     userid AS [User], script AS Action, [action] AS Description, datetime AS [Date/Time]
FROM         tblUserLog
WHERE     (historyid = 's23d20i9166')
ORDER BY datetime

CREATE UNIQUE CLUSTERED
  INDEX [PK_tblCourseQuestions] ON [dbo].[tblCourseQuestions] ([id], [campus], [type], [questionnumber], [questionseq])
WITH
    FILLFACTOR = 90
    ,DROP_EXISTING
ON [PRIMARY]


ALTER TABLE forums ADD src varchar(50);
Go


UPDATE tblApprovalHist SET historyid='x39i22i1049233' WHERE CAMPUS='LEE' AND historyid='108';
UPDATE tblApprovalHist SET historyid='x39i22i1049238' WHERE CAMPUS='LEE' AND historyid='124';
UPDATE tblApprovalHist SET historyid='x39i22i1049240' WHERE CAMPUS='LEE' AND historyid='126';
UPDATE tblApprovalHist SET historyid='x39i22i1049244' WHERE CAMPUS='LEE' AND historyid='142';
UPDATE tblApprovalHist SET historyid='x39i22i1049246' WHERE CAMPUS='LEE' AND historyid='151';
UPDATE tblApprovalHist SET historyid='x39i22i1049249' WHERE CAMPUS='LEE' AND historyid='157';
UPDATE tblApprovalHist SET historyid='x39i22i1049255' WHERE CAMPUS='LEE' AND historyid='179';
UPDATE tblApprovalHist SET historyid='y39i22i1053257' WHERE CAMPUS='LEE' AND historyid='181';
UPDATE tblApprovalHist SET historyid='y39i22i1053269' WHERE CAMPUS='LEE' AND historyid='201';
UPDATE tblApprovalHist SET historyid='y39i22i1053270' WHERE CAMPUS='LEE' AND historyid='202';
UPDATE tblApprovalHist SET historyid='y39i22i1053271' WHERE CAMPUS='LEE' AND historyid='203';
	
ALTER TABLE tblCoReq ADD approvedby varchar(50);
ALTER TABLE tblCoReq ADD approveddate smalldatetime;

ALTER TABLE tblTempCoReq ADD approvedby varchar(50);
ALTER TABLE tblTempCoReq ADD approveddate smalldatetime;

ALTER TABLE tblPreReq ADD approvedby varchar(50);
ALTER TABLE tblPreReq ADD approveddate smalldatetime;

ALTER TABLE tblTempPreReq ADD approvedby varchar(50);
ALTER TABLE tblTempPreReq ADD approveddate smalldatetime;

ALTER TABLE tblXRef ADD approvedby varchar(50);
ALTER TABLE tblXRef ADD approveddate smalldatetime;

ALTER TABLE tblTempXRef ADD approvedby varchar(50);
ALTER TABLE tblTempXRef ADD approveddate smalldatetime;

ALTER TABLE tblExtra ADD approvedby varchar(50);
ALTER TABLE tblExtra ADD approveddate smalldatetime;

ALTER TABLE tblTempExtra ADD approvedby varchar(50);
ALTER TABLE tblTempExtra ADD approveddate smalldatetime;

-- FCO
-- TALIN
-- NALO
-- B6400