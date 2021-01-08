use ccv2;

IF (SELECT COUNT(*) FROM tblstatement WHERE type='Disability' AND campus='KAU') = 0 BEGIN
	insert into tblstatement(type,statement,campus,auditby,auditdate) values('Disability','','KAU','KATHLEN',getdate());
END

ALTER TABLE tblcourse ALTER column gradingoptions varchar(100);
ALTER TABLE tblCourseARC ALTER column gradingoptions varchar(100);
ALTER TABLE tblCourseCAN ALTER column gradingoptions varchar(100);
ALTER TABLE tblCourseCC2 ALTER column gradingoptions varchar(100);
ALTER TABLE tblTempCourse ALTER column gradingoptions varchar(100);

/------------------------------------------------------
/* AccessLevelSysAdm
------------------------------------------------------*/
IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='AccessLevelSysAdm') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','AccessLevelSysAdm','CC Access Level with SysAdm','SELECT levelid, levelname FROM tblLevel ORDER BY levelid','','N','THANHG');
END

pause

md C:\tomcat\webapps\centraldocs\docs\profiles

create xml folder
md C:\tomcat\webapps\centraldocs\docs\outlines\HAW\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\HIL\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\HON\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\KAP\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\KAU\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\LEE\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\MAN\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\TTG\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\UHMC\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\WIN\xml
md C:\tomcat\webapps\centraldocs\docs\outlines\WOA\xml

md C:\tomcat\webapps\centraldocs\docs\programs\HAW\xml
md C:\tomcat\webapps\centraldocs\docs\programs\HIL\xml
md C:\tomcat\webapps\centraldocs\docs\programs\HON\xml
md C:\tomcat\webapps\centraldocs\docs\programs\KAP\xml
md C:\tomcat\webapps\centraldocs\docs\programs\KAU\xml
md C:\tomcat\webapps\centraldocs\docs\programs\LEE\xml
md C:\tomcat\webapps\centraldocs\docs\programs\MAN\xml
md C:\tomcat\webapps\centraldocs\docs\programs\TTG\xml
md C:\tomcat\webapps\centraldocs\docs\programs\UHMC\xml
md C:\tomcat\webapps\centraldocs\docs\programs\WIN\xml
md C:\tomcat\webapps\centraldocs\docs\programs\WOA\xml

md C:\tomcat\webapps\centraldocs\docs\outlines\HAW\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\HIL\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\HON\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\KAP\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\KAU\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\LEE\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\MAN\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\TTG\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\UHMC\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\WIN\pdf
md C:\tomcat\webapps\centraldocs\docs\outlines\WOA\pdf

md C:\tomcat\webapps\centraldocs\docs\programs\HAW\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\HIL\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\HON\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\KAP\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\KAU\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\LEE\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\MAN\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\TTG\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\UHMC\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\WIN\pdf
md C:\tomcat\webapps\centraldocs\docs\programs\WOA\pdf

update forums set campus='ALL' where forum_id=203 and historyid='ER00035'
update forums set campus='ALL' where forum_id=196 and historyid='ER00032'
update forums set campus='ALL' where forum_id=200 and historyid='ER00034'
update forums set campus='ALL' where forum_id=197 and historyid='ER00033'

cnvWin
tg00000

INLINE
	--li.jsp
	--casx.jsp
	--TempDB.resetReviewStatus(conn,campus);
	--TempDBW.resetReviewStatus(conn,campus);
	--	prgraw.jsp
	--TempDBX.reviewOutline(conn,campus,alpha,num,kix,Constant.APPROVAL,user,hide);
		--crsappr.jsp
		--crsrvwer.jsp

	ReviewerDB
		crsrvwstsp.jsp
		prgrvwstsp.jsp
		crsrvwx.jsp

	--TempDBA
		--prgdts.jsp
	
	cmprmtrx.jsp

review in review
	ER99999

/------------------------------------------------------
/* for testing
------------------------------------------------------*/
update tblusers set userlevel=2,password='c0mp1ex',campus='MAN' where userid like 'TESTUSER%';

update tblusers set userlevel=3,campus='MAN' where userid like 'THANHG%';

update tblSystem set valu='NO' where named='sendmail';

update tblSystem set valu='0' where named='useGmail';
update tblSystem set valu='ttgiang@yahoo.com' where named='testEmail';
update tblini set kval1='0' where campus='KAP' AND kid='ForceSendMailFromTest';

update tblSystem set valu='http://localhost:8080/central/core/cas.jsp' where named='href';
update tblSystem set valu='localhost:8080' where named='server';

update tblINI set kval1='0' where kid='EnablePasswordConfirmation';
update tblINI set kval1='0' where kid='EnableOutlineValidation';
update tblINI set kval1='1' where kid='CancelApprovalAnyTime';

update tblINI set kval1='0' where kid='EnableMessageBoard';
delete from forumsx;
insert into forumsx(userid,fid) select distinct 'THANHG', forum_id from forums

update tblSystem set valu='localhost:8080' where named='testSystem';
update tblSystem set valu='localhost:8080' where named='localHost';

/------------------------------------------------------
/*
------------------------------------------------------*/
ALTER TABLE tblCampusData ADD C56 text;
ALTER TABLE tblCampusData ADD C57 text;
ALTER TABLE tblCampusData ADD C58 text;
ALTER TABLE tblCampusData ADD C59 text;
ALTER TABLE tblCampusData ADD C60 text;
ALTER TABLE tblCampusData ADD C61 text;
ALTER TABLE tblCampusData ADD C62 text;
ALTER TABLE tblCampusData ADD C63 text;
ALTER TABLE tblCampusData ADD C64 text;
ALTER TABLE tblCampusData ADD C65 text;
ALTER TABLE tblCampusData ADD C66 text;
ALTER TABLE tblCampusData ADD C67 text;
ALTER TABLE tblCampusData ADD C68 text;
ALTER TABLE tblCampusData ADD C69 text;
ALTER TABLE tblCampusData ADD C70 text;
ALTER TABLE tblCampusData ADD C71 text;
ALTER TABLE tblCampusData ADD C72 text;
ALTER TABLE tblCampusData ADD C73 text;
ALTER TABLE tblCampusData ADD C74 text;
ALTER TABLE tblCampusData ADD C75 text;
ALTER TABLE tblCampusData ADD C76 text;
ALTER TABLE tblCampusData ADD C77 text;
ALTER TABLE tblCampusData ADD C78 text;
ALTER TABLE tblCampusData ADD C79 text;

ALTER TABLE tblTempCampusData ADD C56 text;
ALTER TABLE tblTempCampusData ADD C57 text;
ALTER TABLE tblTempCampusData ADD C58 text;
ALTER TABLE tblTempCampusData ADD C59 text;
ALTER TABLE tblTempCampusData ADD C60 text;
ALTER TABLE tblTempCampusData ADD C61 text;
ALTER TABLE tblTempCampusData ADD C62 text;
ALTER TABLE tblTempCampusData ADD C63 text;
ALTER TABLE tblTempCampusData ADD C64 text;
ALTER TABLE tblTempCampusData ADD C65 text;
ALTER TABLE tblTempCampusData ADD C66 text;
ALTER TABLE tblTempCampusData ADD C67 text;
ALTER TABLE tblTempCampusData ADD C68 text;
ALTER TABLE tblTempCampusData ADD C69 text;
ALTER TABLE tblTempCampusData ADD C70 text;
ALTER TABLE tblTempCampusData ADD C71 text;
ALTER TABLE tblTempCampusData ADD C72 text;
ALTER TABLE tblTempCampusData ADD C73 text;
ALTER TABLE tblTempCampusData ADD C74 text;
ALTER TABLE tblTempCampusData ADD C75 text;
ALTER TABLE tblTempCampusData ADD C76 text;
ALTER TABLE tblTempCampusData ADD C77 text;
ALTER TABLE tblTempCampusData ADD C78 text;
ALTER TABLE tblTempCampusData ADD C79 text;

/------------------------------------------------------
/* EnableCCLab
------------------------------------------------------*/
IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='EnableCCLab') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','EnableCCLab','Determines whether experimental features are displayed for all CC users','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('EnableCCLab','YESNO','Determines whether experimental features are displayed for all CC users','','radio')
END

/------------------------------------------------------
/* AllowRevisionsDuringApprovalBlackout
------------------------------------------------------*/
IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='AllowRevisionsDuringApprovalBlackout') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','AllowRevisionsDuringApprovalBlackout','Are revisions permitted during approval blackout','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('AllowRevisionsDuringApprovalBlackout','YESNO','Are revisions permitted during approval blackout','','radio')
END

/------------------------------------------------------
/* reviewer
------------------------------------------------------*/
ALTER TABLE tblreviewers ADD level int;
ALTER TABLE tblreviewers ADD progress varchar(50);
ALTER TABLE tblreviewers ADD duedate datetime;

IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='AllowReviewInReview') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','AllowReviewInReview','Are reviews within reviews permitted','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('AllowReviewInReview','YESNO','Are reviews within reviews permitted','','radio')
END

/------------------------------------------------------
/* ER00010
------------------------------------------------------*/
update CCCM6100 set Question_len=90,Question_max=5,question_type='textarea200'
WHERE campus='SYS' AND type = 'Course' and  Question_Friendly='X74' and Question_Number = 78

/------------------------------------------------------
/* tblmisc
------------------------------------------------------*/
ALTER TABLE tblMisc ADD edited1 varchar(256);
ALTER TABLE tblMisc ADD edited2 varchar(256);

/------------------------------------------------------
/* zdf00126
------------------------------------------------------*/
ALTER TABLE zdf00126 ADD effectiveterm varchar(12);
ALTER TABLE zdf00126 ADD proposer varchar(50);

/------------------------------------------------------
/* IncludeProposerOnApprovalEmail
------------------------------------------------------*/
IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='IncludeProposerOnApprovalEmail') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','IncludeProposerOnApprovalEmail','Should proposer receive email during approval','1','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('IncludeProposerOnApprovalEmail','YESNO','Should proposer receive email during approval','','radio')
END

/------------------------------------------------------
/* honors explain
------------------------------------------------------*/
update CCCM6100 set Question_Explain='C70'
WHERE campus='SYS' AND type = 'Course' and  Question_Friendly='X81' and Question_Number = 85

/------------------------------------------------------
/* reporting status
------------------------------------------------------*/
ALTER TABLE tblreportingstatus ADD historyid varchar(18);

/------------------------------------------------------
/* extended
------------------------------------------------------*/
insert into tblExtended(tab,friendly,key1,key2) values('tblextra','X17','historyid','');
insert into tblExtended(tab,friendly,key1,key2) values('tblText','X20','historyid','');
insert into tblExtended(tab,friendly,key1,key2) values('tblGenericContent','X72','historyid','');

/------------------------------------------------------
/* CourseSummary
------------------------------------------------------*/

delete from tblini where category='System' AND kid='CourseSummary';
delete from tblINIkey where kid='CourseSummary';
IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='OutlineSummary') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','OutlineSummary','Display a one (1) page outline summary','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('OutlineSummary','YESNO','Display a one (1) page outline summary','','radio')
END
/------------------------------------------------------
/* scripting
------------------------------------------------------*/

call zz-userlist.sql here

/------------------------------------------------------
/* campus
------------------------------------------------------*/


/------------------------------------------------------
/* end date
------------------------------------------------------*/

DaysToNotifyEndDate
	Number of days to check for course outline end dates. For example, check for end dates coming up in 60 days. This date determines when CC sends notifications to CC_AUTHORITY.

	Value 1: number of days
	Value 2: frequency to send (DAILY, WEEKLY)


CCAuthority
	Faculty ID(s) responsible for receiving messages/tasks when CC is unable to determine department chairs.

	Value 1: faculty ID(s). If more than 1, separate IDs with commas

/------------------------------------------------------
/* servers
------------------------------------------------------*/

====> cctest
====> tln
====> Thanh

/------------------------------------------------------
/* zz-alter_2
------------------------------------------------------*/
zz-alter_2 (only in test)

/------------------------------------------------------
/* MAINTENANCE
------------------------------------------------------*/

/------------------------------------------------------
/* backup
------------------------------------------------------*/
use master;

BACKUP DATABASE [ccv2]
TO DISK = 'c:\data\ccv2.Bak'
   WITH FORMAT,
      MEDIANAME = 'ccv2',
      NAME = 'Full Backup of ccv2';
GO

/------------------------------------------------------
/* restore
------------------------------------------------------*/
use master;

RESTORE DATABASE [ccv2] FROM DISK = 'c:\data\ccv2_PROD_ASE_20130413.Bak';

/------------------------------------------------------
/* shrink
------------------------------------------------------*/

DBCC CHECKDB;
DBCC SHRINKDATABASE (ccv2,10);
