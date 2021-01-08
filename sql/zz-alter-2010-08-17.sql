--
-- secondary in for when we need to save processing time
--
ALTER TABLE tblCampusOutlines ADD HAW_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD HIL_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD HON_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD KAP_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD KAU_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD LEE_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD MAN_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD MAU_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD WIN_2 varchar(100);
ALTER TABLE tblCampusOutlines ADD WOA_2 varchar(100);

--
-- historyid
--
CREATE 
  INDEX [PK_tblCourse_Historyid] ON [dbo].[tblCourse] ([historyid])
WITH
    DROP_EXISTING
ON [PRIMARY]

--
-- data to 1000
--
ALTER TABLE tblCourseCompetency ALTER column content varchar(1000);
ALTER TABLE tblCourseComp ALTER column comp varchar(1000);
ALTER TABLE tblCourseContent ALTER column longcontent varchar(1000);
ALTER TABLE tbltempCourseCompetency ALTER column content varchar(1000);
ALTER TABLE tbltempCourseComp ALTER column comp varchar(1000);
ALTER TABLE tbltempCourseContent ALTER column longcontent varchar(1000);

--
-- MESSAGEPAGE filler
--
INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',91,'MESSAGEPAGE','MESSAGEPAGE01',0,0,'wysiwyg',null,null,'Provide on screen instructions',null,null)

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',92,'MESSAGEPAGE','MESSAGEPAGE02',0,0,'wysiwyg',null,null,'Provide on screen instructions',null,null)

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',93,'MESSAGEPAGE','MESSAGEPAGE03',0,0,'wysiwyg',null,null,'Provide on screen instructions',null,null)

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',94,'MESSAGEPAGE','MESSAGEPAGE04',0,0,'wysiwyg',null,null,'Provide on screen instructions',null,null)

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',95,'MESSAGEPAGE','MESSAGEPAGE05',0,0,'wysiwyg',null,null,'Provide on screen instructions',null,null)

--
-- UHMC
--

ALTER TABLE tblTemplate ALTER column campus varchar(10);

EXEC sp_rename 'tblcampusoutlines.MAU', 'UHMC', 'COLUMN'; 
EXEC sp_rename 'tblcampusoutlines.MAU_2', 'UHMC_2', 'COLUMN'; 

UPDATE tblcampus SET campus='UHMC',campusdescr='University of Hawaii Maui College' WHERE campus='MAU'
UPDATE tblApproval SET campus='UHMC' WHERE campus='MAU';
UPDATE tblApprovalHist SET campus='UHMC' WHERE campus='MAU';
UPDATE tblApprovalHist2 SET campus='UHMC' WHERE campus='MAU';
UPDATE tblApprover SET campus='UHMC' WHERE campus='MAU';
UPDATE tblAssessedData SET campus='UHMC' WHERE campus='MAU';
UPDATE tblAssessedDataARC SET campus='UHMC' WHERE campus='MAU';
UPDATE tblAssessedQuestions SET campus='UHMC' WHERE campus='MAU';
UPDATE tblAttach SET campus='UHMC' WHERE campus='MAU';
UPDATE tblcampus SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCampusData SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCampusDataCC2 SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCampusDataMAU SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCampusQuestions SET campus='UHMC' WHERE campus='MAU';
UPDATE tblccowiq SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCoReq SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourse SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseACCJC SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseARC SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseAssess SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseCAN SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseCC2 SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseComp SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseCompAss SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseCompetency SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseContent SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseContentSLO SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseLinked SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseMAU SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseQuestions SET campus='UHMC' WHERE campus='MAU';
UPDATE tblCourseReport SET campus='UHMC' WHERE campus='MAU';
UPDATE tblDiscipline SET campus='UHMC' WHERE campus='MAU';
UPDATE tblDistribution SET campus='UHMC' WHERE campus='MAU';
UPDATE tblDivision SET campus='UHMC' WHERE campus='MAU';
UPDATE tblDocs SET campus='UHMC' WHERE campus='MAU';
UPDATE tblEmailList SET campus='UHMC' WHERE campus='MAU';
UPDATE tblExtra SET campus='UHMC' WHERE campus='MAU';
UPDATE tblForms SET campus='UHMC' WHERE campus='MAU';
UPDATE tblGenericContent SET campus='UHMC' WHERE campus='MAU';
UPDATE tblGESLO SET campus='UHMC' WHERE campus='MAU';
UPDATE tblHelpidx SET campus='UHMC' WHERE campus='MAU';
UPDATE tblInfo SET campus='UHMC' WHERE campus='MAU';
UPDATE tblINI SET campus='UHMC' WHERE campus='MAU';
UPDATE tblJSID SET campus='UHMC' WHERE campus='MAU';
UPDATE tblLinkedKeys SET campus='UHMC' WHERE campus='MAU';
UPDATE tblLists SET campus='UHMC' WHERE campus='MAU';
UPDATE tblMail SET campus='UHMC' WHERE campus='MAU';
UPDATE tblMisc SET campus='UHMC' WHERE campus='MAU';
UPDATE tblMode SET campus='UHMC' WHERE campus='MAU';
UPDATE tblPageHelp SET campus='UHMC' WHERE campus='MAU';
UPDATE tblPosition SET campus='UHMC' WHERE campus='MAU';
UPDATE tblPreReq SET campus='UHMC' WHERE campus='MAU';
UPDATE tblProps SET campus='UHMC' WHERE campus='MAU';
UPDATE tblRequest SET campus='UHMC' WHERE campus='MAU';
UPDATE tblReviewers SET campus='UHMC' WHERE campus='MAU';
UPDATE tblReviewHist SET campus='UHMC' WHERE campus='MAU';
UPDATE tblReviewHist2 SET campus='UHMC' WHERE campus='MAU';
UPDATE tblRpt SET campus='UHMC' WHERE campus='MAU';
UPDATE tblSLO SET campus='UHMC' WHERE campus='MAU';
UPDATE tblSLOARC SET campus='UHMC' WHERE campus='MAU';
UPDATE tblStatement SET campus='UHMC' WHERE campus='MAU';
UPDATE tblsyllabus SET campus='UHMC' WHERE campus='MAU';
UPDATE tblSystem SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTasks SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempAttach SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCampusData SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCoReq SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourse SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseACCJC SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseAssess SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseComp SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseCompAss SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseCompetency SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseContent SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseContentSLO SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempCourseLinked SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempExtra SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempGenericContent SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempGESLO SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTemplate SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempPreReq SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTempXRef SET campus='UHMC' WHERE campus='MAU';
UPDATE tblTest SET campus='UHMC' WHERE campus='MAU';
UPDATE tblUploads SET campus='UHMC' WHERE campus='MAU';
UPDATE tblUserLog SET campus='UHMC' WHERE campus='MAU';
UPDATE tblUsers SET campus='UHMC' WHERE campus='MAU';
UPDATE tblUsersX SET campus='UHMC' WHERE campus='MAU';
UPDATE tblValues SET campus='UHMC' WHERE campus='MAU';
UPDATE tblValues SET campus='UHMC' WHERE campus='MAU';
UPDATE tblXRef SET campus='UHMC' WHERE campus='MAU';
UPDATE CCCM6100 SET campus='UHMC' WHERE campus='MAU';

--
-- PK_CCCM6100_Main
--
CREATE 
  INDEX [PK_CCCM6100_Main] ON [dbo].[CCCM6100] ([campus], [type], [Question_Number])

ON [PRIMARY]

--
-- add MESSAGEPAGEs (filler)
--
ALTER TABLE tblCourse ADD MESSAGEPAGE01 text;
ALTER TABLE tblCourse ADD MESSAGEPAGE02 text;
ALTER TABLE tblCourse ADD MESSAGEPAGE03 text;
ALTER TABLE tblCourse ADD MESSAGEPAGE04 text;
ALTER TABLE tblCourse ADD MESSAGEPAGE05 text;

ALTER TABLE tblCourseARC ADD MESSAGEPAGE01 text;
ALTER TABLE tblCourseARC ADD MESSAGEPAGE02 text;
ALTER TABLE tblCourseARC ADD MESSAGEPAGE03 text;
ALTER TABLE tblCourseARC ADD MESSAGEPAGE04 text;
ALTER TABLE tblCourseARC ADD MESSAGEPAGE05 text;

ALTER TABLE tblCourseCAN ADD MESSAGEPAGE01 text;
ALTER TABLE tblCourseCAN ADD MESSAGEPAGE02 text;
ALTER TABLE tblCourseCAN ADD MESSAGEPAGE03 text;
ALTER TABLE tblCourseCAN ADD MESSAGEPAGE04 text;
ALTER TABLE tblCourseCAN ADD MESSAGEPAGE05 text;

ALTER TABLE tblTempCourse ADD MESSAGEPAGE01 text;
ALTER TABLE tblTempCourse ADD MESSAGEPAGE02 text;
ALTER TABLE tblTempCourse ADD MESSAGEPAGE03 text;
ALTER TABLE tblTempCourse ADD MESSAGEPAGE04 text;
ALTER TABLE tblTempCourse ADD MESSAGEPAGE05 text;

--
-- requisites with consent
--
--ALTER TABLE tblPreReq ADD consent bit default 0;
--ALTER TABLE tblTempPreReq ADD consent bit default 0;
--ALTER TABLE tblCoReq ADD consent bit default 0;
--ALTER TABLE tblTempCoReq ADD consent bit default 0;

--
-- tblValues
--
ALTER TABLE tblValues ADD valueid int;
ALTER TABLE tblValues ADD seq int;

--
-- tblApprover
--
ALTER TABLE tblApprover ADD availableDate varchar(20);
ALTER TABLE tblApprover ADD startdate varchar(20);
ALTER TABLE tblApprover ADD enddate varchar(20);

--
-- SYSTEM VALUES
--

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('AllowFacultyToRenameRenumber','YESNO','Determines whether faculty can rename/renumber outlines','','radio')
INSERT INTO tblSystem (campus,named,valu,descr) VALUES('GLOBAL','dbHost','nalo','')
INSERT INTO tblDEBUG (page,debug) VALUES('ProgramServlet',1)

--
-- NumberOfCreditsRangeValue
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('HAW','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('HIL','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('HON','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('MAN','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('LEE','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('KAP','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('KAU','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('UHMC','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('WIN','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('WOA','System','NumberOfCreditsRangeValue','Provide a range for low and high values in number of credits drop down list','0','15','Variable,Other','Y','THANHG');

UPDATE tblINI SET kval1=0,kval2=0 WHERE kid='NumberOfCreditsRangeValue' AND campus='HIL' AND category='System'
UPDATE tblINI SET kval1=0,kval2=0 WHERE kid='NumberOfCreditsRangeValue' AND campus='LEE' AND category='System'
UPDATE tblINI SET kval1=0,kval2=0 WHERE kid='NumberOfCreditsRangeValue' AND campus='KAP' AND category='System'

--
-- DisplayConsentForCourseMods
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','DisplayConsentForCourseMods','Determines whether consent selections appear on Course Modifications PreReq screen.','0','','Y','THANHG');

UPDATE tblINI SET kval1 = 0 WHERE kid='DisplayConsentForCourseMods' AND campus='LEE' AND category='System'
UPDATE tblINI SET kval1 = 0 WHERE kid='DisplayConsentForCourseMods' AND campus='UHMC' AND category='System'
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('DisplayConsentForCourseMods','YESNO','Determines whether consent selections appear on Course Modifications PreReq screen','','radio')

--
-- DisplayOrConsentForPreReqs
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','DisplayOrConsentForPreReqs','Determines whether or consent is displayed on pre-requisite screen.','0','','Y','THANHG');

UPDATE tblINI SET kval1 = 1 WHERE kid='DisplayOrConsentForPreReqs' AND campus='UHMC' AND category='System'
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('DisplayOrConsentForPreReqs','YESNO','Determines whether or consent is displayed on pre-requisite screen','','radio')

--
-- NumberOfContactHoursRangeValue
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('HAW','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('HIL','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('HON','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('MAN','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('LEE','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('KAP','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('KAU','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('UHMC','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('WIN','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kval3,kedit,klanid) VALUES('WOA','System','NumberOfContactHoursRangeValue','A drop down list with the range of values for contact hours.','0','15','Variable,Other','Y','THANHG');

UPDATE tblINI SET kval1=0,kval2=0 WHERE kid='NumberOfContactHoursRangeValue' AND campus='HIL' AND category='System'
UPDATE tblINI SET kval1=0,kval2=0 WHERE kid='NumberOfContactHoursRangeValue' AND campus='LEE' AND category='System'
UPDATE tblINI SET kval1=0,kval2=0 WHERE kid='NumberOfContactHoursRangeValue' AND campus='KAP' AND category='System'

--
-- ApprovalSubmissionAsPackets
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','ApprovalSubmissionAsPackets','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('ApprovalSubmissionAsPackets','YESNO','Dictates whether submissions for approval should be done as packets only. 1=YES, 0=N0. If YES, only the department/division chair may submit for approvals.','','radio')

--
-- ProposedOutlineBlockedDate
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','ProposedOutlineBlockedDate','Dates where outline proposals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');

--
-- OutlineProposalBlackOutDate
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','OutlineApprovalBlackOutDate','Dates where outline approvals are not allowed<br/>(provide start date in Value 1 and end date in Value 2)','01/01/1900','01/01/1900','Y','THANHG');

--
-- EnableApprovalByDates
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','EnableApprovalByDates','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('EnableApprovalByDates','YESNO','Turns on approval by date process. This initiates the process of requiring approvers to approve an outline by the approval end date or the outline is sent forward to the next approver.','','radio')

--
-- CrossListingRequiresApproval
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','CrossListingRequiresApproval','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('CrossListingRequiresApproval','YESNO','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','','radio')

--
-- PreReqRequiresApproval
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','PreReqRequiresApproval','Determines whether pre-requsites requires approval.','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('PreReqRequiresApproval','YESNO','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','','radio')

--
-- CoReqRequiresApproval
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','CoReqRequiresApproval','Determines whether co-requsites requires approval.','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('CoReqRequiresApproval','YESNO','Determines whether a cross listed class requires approval from the department/division chair of the cross listed alpha.','','radio')

--
-- kval3
--
UPDATE TBLINI SET kval3='Variable,Other',kedit='Y' WHERE kid='NumberOfContactHoursRangeValue' ;
UPDATE TBLINI SET kval3='Variable,Other',kedit='Y' WHERE kid='NumberOfCreditsRangeValue';

--
-- tbltask - historyid
--
ALTER TABLE tblTasks ADD category varchar(20);
ALTER TABLE tblTasks ADD historyid varchar(18);

--
-- tblTasks - route
--
ALTER TABLE tblTasks ALTER column coursealpha varchar(50);
ALTER TABLE tblTasks ALTER column coursenum varchar(50);
--UPDATE tblTasks SET category='outline';
--UPDATE tblTasks SET category='program' WHERE NOT category IS NULL;

--
-- TODO tblJobs
--
ALTER TABLE tblJobs ALTER column alpha varchar(50);
ALTER TABLE tblJobs ALTER column num varchar(50);

--
-- tblUserLog
--
ALTER TABLE tblUserLog ALTER COLUMN action varchar(100);

--
-- LEE approver sequence
--
update tblApprover set approver='LOCOCO',delegated='LOCOCO' WHERE campus='LEE' AND approver='LCURRIVA';
update tblApprover set approver='MLANE',delegated='MLANE' WHERE campus='LEE' AND approver='BERNER';
update tblApprover set approver='LIONGSON',delegated='LIONGSON' WHERE campus='LEE' AND approver='PATSYLEE';

DELETE FROM tblINI WHERE campus='LEE' AND category='ApprovalRouting' AND kid='Experimental';
DELETE FROM tblINI WHERE campus='LEE' AND category='ApprovalRouting' AND kid='Graduate';
DELETE FROM tblINI WHERE campus='LEE' AND category='ApprovalRouting' AND kid='IndependentStudies';
DELETE FROM tblINI WHERE campus='LEE' AND category='ApprovalRouting' AND kid='PHD';
DELETE FROM tblINI WHERE campus='LEE' AND category='ApprovalRouting' AND kid='Topical';

update tbltasks set submittedfor='MLANE' WHERE campus='LEE' AND submittedfor='BERNER' AND message like 'Approve%'
update tbltasks set submittedfor='LOCOCO' WHERE campus='LEE' AND submittedfor='LCURRIVA' AND message like 'Approve%'
update tbltasks set submittedfor='LIONGSON' WHERE campus='LEE' AND submittedfor='PATSYLEE' AND message like 'Approve%'

--
-- tbluserlog for programs
--
ALTER TABLE tbluserlog ALTER COLUMN alpha varchar(50);
ALTER TABLE tbluserlog ALTER COLUMN num varchar(50);
ALTER TABLE tbluserlog ALTER COLUMN action varchar(100);

--
-- tblmail for programs
--
ALTER TABLE tblmail ALTER COLUMN alpha varchar(50);
ALTER TABLE tblmail ALTER COLUMN num varchar(50);

--
-- history and review
--
ALTER TABLE tblApprovalHist ALTER COLUMN coursealpha varchar(50);
ALTER TABLE tblApprovalHist ALTER COLUMN coursenum varchar(50);

ALTER TABLE tblApprovalHist2 ALTER COLUMN coursealpha varchar(50);
ALTER TABLE tblApprovalHist2 ALTER COLUMN coursenum varchar(50);

ALTER TABLE tblReviewHist ALTER COLUMN coursealpha varchar(50);
ALTER TABLE tblReviewHist ALTER COLUMN coursenum varchar(50);

ALTER TABLE tblReviewHist2 ALTER COLUMN coursealpha varchar(50);
ALTER TABLE tblReviewHist2 ALTER COLUMN coursenum varchar(50);

--
-- tblCampus
--
ALTER TABLE tblCampus ADD programitems text;

--
-- debug
--
INSERT INTO tbldebug (page,debug) VALUES('Alpha',0)
INSERT INTO tbldebug (page,debug) VALUES('AlphaDB',0)
INSERT INTO tbldebug (page,debug) VALUES('AlphaServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('AntiSpamy',0)
INSERT INTO tbldebug (page,debug) VALUES('Approver',0)
INSERT INTO tbldebug (page,debug) VALUES('ApproverDB',0)
INSERT INTO tbldebug (page,debug) VALUES('ApproverServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('AseConstants',0)
INSERT INTO tbldebug (page,debug) VALUES('AseHtmlFormatter',0)
INSERT INTO tbldebug (page,debug) VALUES('ASELogger',0)
INSERT INTO tbldebug (page,debug) VALUES('AsePool',0)
INSERT INTO tbldebug (page,debug) VALUES('AseProgressListener',0)
INSERT INTO tbldebug (page,debug) VALUES('AseServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('AseUtil',0)
INSERT INTO tbldebug (page,debug) VALUES('AseUtil2',0)
INSERT INTO tbldebug (page,debug) VALUES('Assess',0)
INSERT INTO tbldebug (page,debug) VALUES('AssessDB',0)
INSERT INTO tbldebug (page,debug) VALUES('AssessedData',0)
INSERT INTO tbldebug (page,debug) VALUES('AssessedDataDB',0)
INSERT INTO tbldebug (page,debug) VALUES('AssessLinkServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('AssessServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Attach',0)
INSERT INTO tbldebug (page,debug) VALUES('AttachDB',0)
INSERT INTO tbldebug (page,debug) VALUES('AutoCompleteServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Banner',0)
INSERT INTO tbldebug (page,debug) VALUES('BannerDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Batch',0)
INSERT INTO tbldebug (page,debug) VALUES('Campus',0)
INSERT INTO tbldebug (page,debug) VALUES('CampusDB',0)
INSERT INTO tbldebug (page,debug) VALUES('CancelServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('CCCM6100',0)
INSERT INTO tbldebug (page,debug) VALUES('CCCM6100DB',0)
INSERT INTO tbldebug (page,debug) VALUES('ChairPrograms',0)
INSERT INTO tbldebug (page,debug) VALUES('ChairProgramsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Chairs',0)
INSERT INTO tbldebug (page,debug) VALUES('Comp',0)
INSERT INTO tbldebug (page,debug) VALUES('CompDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Competency',0)
INSERT INTO tbldebug (page,debug) VALUES('CompetencyDB',0)
INSERT INTO tbldebug (page,debug) VALUES('ConnDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Constant',0)
INSERT INTO tbldebug (page,debug) VALUES('ConstantDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Content',0)
INSERT INTO tbldebug (page,debug) VALUES('ContentDB',0)
INSERT INTO tbldebug (page,debug) VALUES('CookieManager',0)
INSERT INTO tbldebug (page,debug) VALUES('CopyServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Course',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseACCJC',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseACCJCDB',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseApproval',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseCancel',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseCopy',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseCreate',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseCurrentToArchive',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseDB',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseDelete',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseFields',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseFieldsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseModify',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseRename',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseRestore',0)
INSERT INTO tbldebug (page,debug) VALUES('CourseServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Cowiq',0)
INSERT INTO tbldebug (page,debug) VALUES('CowiqDB',0)
INSERT INTO tbldebug (page,debug) VALUES('CreateObject',0)
INSERT INTO tbldebug (page,debug) VALUES('Cron',0)
INSERT INTO tbldebug (page,debug) VALUES('DateUtility',0)
INSERT INTO tbldebug (page,debug) VALUES('DBInfo',0)
INSERT INTO tbldebug (page,debug) VALUES('Debug',0)
INSERT INTO tbldebug (page,debug) VALUES('DebugDB',0)
INSERT INTO tbldebug (page,debug) VALUES('DebugServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Degree',0)
INSERT INTO tbldebug (page,debug) VALUES('DegreeDB',0)
INSERT INTO tbldebug (page,debug) VALUES('DegreeServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Discipline',0)
INSERT INTO tbldebug (page,debug) VALUES('DisciplineDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Distribution',0)
INSERT INTO tbldebug (page,debug) VALUES('DistributionDB',0)
INSERT INTO tbldebug (page,debug) VALUES('DistributionServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Division',0)
INSERT INTO tbldebug (page,debug) VALUES('DivisionDB',0)
INSERT INTO tbldebug (page,debug) VALUES('DivisionServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('EditFieldsServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('EditProgramFieldsServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('EmailLists',0)
INSERT INTO tbldebug (page,debug) VALUES('EmailListsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('EmailListServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Enc',0)
INSERT INTO tbldebug (page,debug) VALUES('EncDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Encrypter',0)
INSERT INTO tbldebug (page,debug) VALUES('Extra',0)
INSERT INTO tbldebug (page,debug) VALUES('ExtraDB',0)
INSERT INTO tbldebug (page,debug) VALUES('FileUploadListener',0)
INSERT INTO tbldebug (page,debug) VALUES('FileUploadServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Form',0)
INSERT INTO tbldebug (page,debug) VALUES('FormDB',0)
INSERT INTO tbldebug (page,debug) VALUES('FormsServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Forum',0)
INSERT INTO tbldebug (page,debug) VALUES('ForumDB',0)
INSERT INTO tbldebug (page,debug) VALUES('FunctionDesignation',0)
INSERT INTO tbldebug (page,debug) VALUES('Generic',0)
INSERT INTO tbldebug (page,debug) VALUES('GenericContent',0)
INSERT INTO tbldebug (page,debug) VALUES('GenericContentDB',0)
INSERT INTO tbldebug (page,debug) VALUES('GenericUploadServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('GESLO',0)
INSERT INTO tbldebug (page,debug) VALUES('GESLODB',0)
INSERT INTO tbldebug (page,debug) VALUES('Help',0)
INSERT INTO tbldebug (page,debug) VALUES('HelpDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Helper',0)
INSERT INTO tbldebug (page,debug) VALUES('HelperLEE',0)
INSERT INTO tbldebug (page,debug) VALUES('HelpServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('History',0)
INSERT INTO tbldebug (page,debug) VALUES('HistoryDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Html',0)
INSERT INTO tbldebug (page,debug) VALUES('HTMLEncoder',0)
INSERT INTO tbldebug (page,debug) VALUES('Import',0)
INSERT INTO tbldebug (page,debug) VALUES('ImportServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Ini',0)
INSERT INTO tbldebug (page,debug) VALUES('IniDB',0)
INSERT INTO tbldebug (page,debug) VALUES('IniKey',0)
INSERT INTO tbldebug (page,debug) VALUES('IniKeyDB',0)
INSERT INTO tbldebug (page,debug) VALUES('IniServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Jobs',0)
INSERT INTO tbldebug (page,debug) VALUES('JobsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('JSID',0)
INSERT INTO tbldebug (page,debug) VALUES('JSIDDB',0)
INSERT INTO tbldebug (page,debug) VALUES('LinkedUtil',0)
INSERT INTO tbldebug (page,debug) VALUES('LinkerDB',0)
INSERT INTO tbldebug (page,debug) VALUES('LinkerServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Lists',0)
INSERT INTO tbldebug (page,debug) VALUES('ListsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Log4jConfigLoader',0)
INSERT INTO tbldebug (page,debug) VALUES('Log4jInit',0)
INSERT INTO tbldebug (page,debug) VALUES('LogData',0)
INSERT INTO tbldebug (page,debug) VALUES('LogMonitorThread',0)
INSERT INTO tbldebug (page,debug) VALUES('LogServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('LogUtil',0)
INSERT INTO tbldebug (page,debug) VALUES('Mailer',0)
INSERT INTO tbldebug (page,debug) VALUES('MailerDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Messages',0)
INSERT INTO tbldebug (page,debug) VALUES('Misc',0)
INSERT INTO tbldebug (page,debug) VALUES('MiscDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Mode',0)
INSERT INTO tbldebug (page,debug) VALUES('ModeDB',0)
INSERT INTO tbldebug (page,debug) VALUES('MonitorThread',0)
INSERT INTO tbldebug (page,debug) VALUES('Msg',0)
INSERT INTO tbldebug (page,debug) VALUES('MsgDB',0)
INSERT INTO tbldebug (page,debug) VALUES('MyLogger',0)
INSERT INTO tbldebug (page,debug) VALUES('News',0)
INSERT INTO tbldebug (page,debug) VALUES('NewsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('NewsServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('NumericUtil',0)
INSERT INTO tbldebug (page,debug) VALUES('Outlines',0)
INSERT INTO tbldebug (page,debug) VALUES('OutlineServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('OutlineServletLEE',0)
INSERT INTO tbldebug (page,debug) VALUES('PDF',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFDB',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFReport$MyFontFactory',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFReport$MyImageFactory',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFReport$TableHeader',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFReport$Watermark',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFReport',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFServlet$MyFontFactory',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFServlet$MyImageFactory',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFServlet$MyPdf',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFServlet$TableHeader',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFServlet$Watermark',0)
INSERT INTO tbldebug (page,debug) VALUES('PDFServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('ProcessLog',0)
INSERT INTO tbldebug (page,debug) VALUES('ProfileServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgramApproval',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgramDegree',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgramDelete',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgramModify',0)
INSERT INTO tbldebug (page,debug) VALUES('Programs',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgramsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgramServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgressServlet$MyPdf',0)
INSERT INTO tbldebug (page,debug) VALUES('ProgressServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Props',0)
INSERT INTO tbldebug (page,debug) VALUES('PropsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('PropsServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Queries',0)
INSERT INTO tbldebug (page,debug) VALUES('Question',0)
INSERT INTO tbldebug (page,debug) VALUES('QuestionDB',0)
INSERT INTO tbldebug (page,debug) VALUES('QuestionsServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('ReassignServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('RenameServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Reorder',0)
INSERT INTO tbldebug (page,debug) VALUES('ReorderServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Request',0)
INSERT INTO tbldebug (page,debug) VALUES('RequestDB',0)
INSERT INTO tbldebug (page,debug) VALUES('RequestServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('RequisiteDB',0)
INSERT INTO tbldebug (page,debug) VALUES('RequisiteServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Review',0)
INSERT INTO tbldebug (page,debug) VALUES('ReviewDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Reviewer',0)
INSERT INTO tbldebug (page,debug) VALUES('ReviewerDB',0)
INSERT INTO tbldebug (page,debug) VALUES('ReviewServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Rpt',0)
INSERT INTO tbldebug (page,debug) VALUES('RptDB',0)
INSERT INTO tbldebug (page,debug) VALUES('SAServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Skew',0)
INSERT INTO tbldebug (page,debug) VALUES('SLO',0)
INSERT INTO tbldebug (page,debug) VALUES('SLOCancel',0)
INSERT INTO tbldebug (page,debug) VALUES('SLODB',0)
INSERT INTO tbldebug (page,debug) VALUES('SLOLinkServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('SLOServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('SQLUtil',0)
INSERT INTO tbldebug (page,debug) VALUES('SQLValues',0)
INSERT INTO tbldebug (page,debug) VALUES('Stmt',0)
INSERT INTO tbldebug (page,debug) VALUES('StmtDB',0)
INSERT INTO tbldebug (page,debug) VALUES('StmtServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Syllabus',0)
INSERT INTO tbldebug (page,debug) VALUES('SyllabusDB',0)
INSERT INTO tbldebug (page,debug) VALUES('SyllabusServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Sys',0)
INSERT INTO tbldebug (page,debug) VALUES('SysDB',0)
INSERT INTO tbldebug (page,debug) VALUES('SysServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Tables',0)
INSERT INTO tbldebug (page,debug) VALUES('TalinServlet$Talin',0)
INSERT INTO tbldebug (page,debug) VALUES('TalinServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Task',0)
INSERT INTO tbldebug (page,debug) VALUES('TaskCleaningServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('TaskDB',0)
INSERT INTO tbldebug (page,debug) VALUES('TaskServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Terms',0)
INSERT INTO tbldebug (page,debug) VALUES('TermsDB',0)
INSERT INTO tbldebug (page,debug) VALUES('Text',0)
INSERT INTO tbldebug (page,debug) VALUES('TextDB',0)
INSERT INTO tbldebug (page,debug) VALUES('TextServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Tools',0)
INSERT INTO tbldebug (page,debug) VALUES('Upload',0)
INSERT INTO tbldebug (page,debug) VALUES('UploadServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('UrlEncoderEx',0)
INSERT INTO tbldebug (page,debug) VALUES('User',0)
INSERT INTO tbldebug (page,debug) VALUES('UserDB',0)
INSERT INTO tbldebug (page,debug) VALUES('UserServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Util',0)
INSERT INTO tbldebug (page,debug) VALUES('UtilServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Validation',0)
INSERT INTO tbldebug (page,debug) VALUES('ValidationServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('Values',0)
INSERT INTO tbldebug (page,debug) VALUES('ValuesData',0)
INSERT INTO tbldebug (page,debug) VALUES('ValuesDB',0)
INSERT INTO tbldebug (page,debug) VALUES('ValuesServlet',0)
INSERT INTO tbldebug (page,debug) VALUES('WebSite',0)
INSERT INTO tbldebug (page,debug) VALUES('XRef',0)
INSERT INTO tbldebug (page,debug) VALUES('XRefDB',0)

--
-- cccm6100
--
ALTER TABLE jdbclog ALTER column logger varchar(200);
ALTER TABLE jdbclog ALTER column message text;

--
-- OutineSubmissionWithProgram
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','OutineSubmissionWithProgram','Allow outlines to be submitted with programs.','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('OutineSubmissionWithProgram','YESNO','Allow outlines to be submitted with programs','','radio')

--
-- AllowFacultyToDeleteOutline
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','AllowFacultyToDeleteOutline','Determines whether faculty has outline delete option.','1','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('AllowFacultyToDeleteOutline','YESNO','Determines whether faculty has outline delete option','','radio')

--
-- AllowFacultyToReactiveOutline
--
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','AllowFacultyToReactiveOutline','Determines whether faculty has outline restore option.','1','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('AllowFacultyToReactiveOutline','YESNO','Determines whether faculty has outline restore option','','radio')

--
-- cccm6100
--
UPDATE cccm6100
SET question_type='texthidden', question_explain='C32'
WHERE campus='SYS' AND type='Course' AND question_number=27

UPDATE cccm6100
SET question_type='wysiwyg', question_explain='C33'
WHERE campus='SYS' AND type='Course' AND question_number=29

--
-- ProgramLinkedToOutlineRequiresApproval
--

ALTER TABLE tblExtra ADD pending bit default(0);
ALTER TABLE tblTempExtra ADD pending bit default(0);

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','ProgramLinkedToOutlineRequiresApproval','Determines whether an outline designed for programs requires approval.','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('ProgramLinkedToOutlineRequiresApproval','YESNO','Determines whether an outline designed for programs requires approval.','','radio')

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','NotifyChairOnProgramToOutlineLink','Determines whether department/division chairs are notified when programs are attached to outlines.','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('NotifyChairOnProgramToOutlineLink','YESNO','Determines whether department/division chairs are notified when programs are attached to outlines.','','radio')

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','RequiredOrElectiveRequiresApproval','Determines whether outlie required/elective requires approval.','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('RequiredOrElectiveRequiresApproval','YESNO','Determines whether outlie required/elective requires approval.','','radio')

INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','NotifyChairOnRequiredOrElective','Determines whether department/division chairs are notified when required/elective are used','0','','Y','THANHG');

INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('NotifyChairOnRequiredOrElective','YESNO','Determines whether department/division chairs are notified when required/elective are used','','radio')

-- TALIN STOPPED HERE
-- NALO STOPPED HERE
-- FCO STOPPED HERE
-- B6400 STOPPED HERE