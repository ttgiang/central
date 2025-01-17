if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CheckBannerCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CheckBannerCount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_DeleteTempData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_DeleteTempData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineApproval]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineApproval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineCancel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineCancel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineCurrentToArchive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineCurrentToArchive]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineModify]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineModify]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_TestData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_TestData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CampusReportItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CampusReportItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseReportItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseReportItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJC_2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJC_2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDCampusCourse]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDCampusCourse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDCampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDCampusItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100_Campus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100_Campus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100_Sys]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100_Sys]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CampusItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CampusQuestions]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CampusQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CampusQuestionsYN]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CampusQuestionsYN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastApproverX]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastApproverX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastDisapproverX]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastDisapproverX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseQuestions]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseQuestionsYN]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseQuestionsYN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_3]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_4]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_4]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceCampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceCampusItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceCourseItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceCourseItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_WriteSyllabus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_WriteSyllabus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescription]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescription]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionHAW]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionHAW]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionHIL]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionHIL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionHON]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionHON]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionKAP]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionKAP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionKAU]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionKAU]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionLEE]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionLEE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionMAN]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionMAN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionMAU]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionMAU]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionWIN]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionWIN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJCDescriptionWOA]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJCDescriptionWOA]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJC_1]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJC_1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Assessments]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Assessments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CompsByAlphaNum]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CompsByAlphaNum]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CompsByAlphaNumID]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CompsByAlphaNumID]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CompsByID]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CompsByID]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastApprover]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastApprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastDisapprover]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastDisapprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_1]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BANNER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BANNER]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BannerAlpha]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BannerAlpha]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BannerCollege]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BannerCollege]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BannerDept]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BannerDept]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BannerDivision]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BannerDivision]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BannerTerms]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BannerTerms]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CCCM6100]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CCCM6100]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApproval]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApproval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprovalHist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprovalHist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprovalHist2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprovalHist2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprover]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblAssessedData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblAssessedData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblAssessedQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblAssessedQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCoReq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCoReq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseACCJC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseACCJC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseArc]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseArc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseAssess]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseAssess]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseCan]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseCan]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseComp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseComp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseCompAss]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseCompAss]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseReport]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDegree]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDegree]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDistribution]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDistribution]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHelp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHelp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblHelpidx]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblHelpidx]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblINI]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblINI]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblJSID]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblJSID]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblLevel]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblLevel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblMail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblMail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPosition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPosition]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPreReq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPreReq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblReviewHist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblReviewHist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblReviewHist2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblReviewHist2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblReviewers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblReviewers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblSLO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblSLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblSalutation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblSalutation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblStatement]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblStatement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTasks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTasks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCampusData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCampusData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCoReq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCoReq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseAssess]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseAssess]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseComp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseComp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseCompAss]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseCompAss]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempPreReq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempPreReq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempXRef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempXRef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTest]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTest]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblUserLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblUserLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblUsers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblUsers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblUsersX]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblUsersX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblXRef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblXRef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblcampus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblcampus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblsyllabus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblsyllabus]
GO

CREATE TABLE [dbo].[BANNER] (
	[id] [int] NOT NULL ,
	[INSTITUTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_ALPHA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_NUMBER] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EFFECTIVE_TERM] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_TITLE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_LONG_TITLE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_DIVISION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_DEPT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_COLLEGE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MAX_RPT_UNITS] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[REPEAT_LIMIT] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_HIGH] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_LOW] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_IND] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_HIGH] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_LOW] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_IND] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_HIGH] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_LOW] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_IND] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_HIGH] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_LOW] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_IND] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_HIGH] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_LOW] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_IND] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerAlpha] (
	[COURSE_ALPHA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ALPHA_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerCollege] (
	[COLLEGE_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[COLL_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerDept] (
	[DEPT_CODE] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DEPT_DESCRIPTION] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerDivision] (
	[DIVISION_CODE] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DIVS_DESCRIPTION] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerTerms] (
	[TERM_CODE] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TERM_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CCCM6100] (
	[id] [int] NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Number] [smallint] NULL ,
	[CCCM6100] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Friendly] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Len] [smallint] NULL ,
	[Question_Max] [smallint] NULL ,
	[Question_Type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Ini] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Explain] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApproval] (
	[approval_id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[approval_seq] [int] NOT NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[approved_by] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[waiting_for] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approval_date] [smalldatetime] NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHist] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[historyid] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[approver] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NOT NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[approvaldate] [smalldatetime] NOT NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[approver] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NOT NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprover] (
	[approverid] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[approver_seq] [int] NULL ,
	[approver] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[delegated] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[multilevel] [bit] NOT NULL ,
	[department] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addedby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblAssessedData] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[accjcid] [int] NULL ,
	[qid] [int] NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approvedby] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblAssessedQuestions] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionnumber] [int] NULL ,
	[questionseq] [int] NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCampusData] (
	[id] [numeric](10, 0) NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C1] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C2] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C3] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C4] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C5] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C6] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C7] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C8] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C9] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C10] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C11] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C12] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCampusQuestions] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionnumber] [int] NULL ,
	[questionseq] [int] NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCoReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NOT NULL ,
	[CoreqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoreqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourse] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NOT NULL ,
	[Progress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NOT NULL ,
	[maxcredit] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NOT NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseACCJC] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [int] NULL ,
	[CompID] [int] NULL ,
	[Assessmentid] [int] NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[AssessedDate] [smalldatetime] NULL ,
	[AssessedBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseArc] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NOT NULL ,
	[Progress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NOT NULL ,
	[maxcredit] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NOT NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseAssess] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[assessmentid] [int] IDENTITY (1, 1) NOT NULL ,
	[assessment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCan] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NOT NULL ,
	[Progress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NOT NULL ,
	[maxcredit] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NOT NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseComp] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CompID] [numeric](10, 0) NOT NULL ,
	[Comp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCompAss] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[compid] [numeric](10, 0) NOT NULL ,
	[assessmentid] [int] NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseContent] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [numeric](10, 0) NOT NULL ,
	[ShortContent] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LongContent] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseQuestions] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[questionnumber] [int] NOT NULL ,
	[questionseq] [int] NOT NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[change] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseReport] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Order] [int] NULL ,
	[Question_Number] [smallint] NULL ,
	[Field_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Indent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDegree] (
	[degree_id] [decimal](18, 0) NOT NULL ,
	[degree_alpha] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree_title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree_desc] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree_date] [smalldatetime] NULL ,
	[addedby] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[modifiedby] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[modifieddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDistribution] (
	[seq] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[title] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[members] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHelp] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[content] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHelpidx] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[category] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subtitle] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblINI] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[category] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[kid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[kdesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kedit] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[klanid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblInfo] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[InfoTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[InfoContent] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DatePosted] [smalldatetime] NULL ,
	[Author] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[flag] [bit] NOT NULL ,
	[blink] [bit] NOT NULL ,
	[startdate] [smalldatetime] NULL ,
	[enddate] [smalldatetime] NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblJSID] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[page] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[username] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[start] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[audit] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enddate] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLevel] (
	[levelid] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[levelname] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblMail] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[from] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bcc] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subject] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPosition] (
	[posid] [decimal](18, 0) NOT NULL ,
	[posname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPreReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NOT NULL ,
	[PrereqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PrereqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[historyid] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewers] (
	[Id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblSLO] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[hid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblSalutation] (
	[salid] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[saldescr] [nvarchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblStatement] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[type] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[statement] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTasks] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submittedfor] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submittedby] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCampusData] (
	[id] [numeric](18, 0) NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C1] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C2] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C3] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C4] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C5] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C6] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C7] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C8] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C9] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C10] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C11] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C12] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCoReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NOT NULL ,
	[CoreqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoreqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourse] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[Progress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NULL ,
	[maxcredit] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseAssess] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[assessmentid] [int] NOT NULL ,
	[assessment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseComp] (
	[historyid] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CompID] [int] NOT NULL ,
	[Comp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseCompAss] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[compid] [int] NOT NULL ,
	[assessmentid] [int] NOT NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseContent] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [int] NOT NULL ,
	[ShortContent] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LongContent] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempPreReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NOT NULL ,
	[PrereqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PrereqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempXRef] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[CourseAlphaX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNumX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTest] (
	[id] [int] NULL ,
	[tabo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id1] [int] NULL ,
	[id2] [int] NULL ,
	[text1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[text2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUserLog] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[userid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[script] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[action] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datetime] [smalldatetime] NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUsers] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[userid] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[password] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[uh] [int] NULL ,
	[firstname] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastname] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[fullname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userlevel] [int] NULL ,
	[department] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [nvarchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[email] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[salutation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[location] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hours] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[phone] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[check] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[position] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastused] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUsersX] (
	[id] [int] NOT NULL ,
	[campus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[password] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[uh] [int] NULL ,
	[firstname] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastname] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[fullname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userlevel] [int] NULL ,
	[department] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [nvarchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[email] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[salutation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[location] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hours] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[phone] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[check] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[position] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastused] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblXRef] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[CourseAlphaX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNumX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblcampus] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campusdescr] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[courseitems] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campusitems] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblsyllabus] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[yeer] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[textbooks] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[objectives] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[grading] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[disability] [bit] NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApproval] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApproval] PRIMARY KEY  CLUSTERED 
	(
		[approval_id],
		[approval_seq],
		[coursealpha],
		[coursenum]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApprovalHist] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApprovalHist] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApprovalHist2] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApprovalHist2] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid],
		[approvaldate]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApprover] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApprover] PRIMARY KEY  CLUSTERED 
	(
		[approverid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblAssessedData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblAssessedData] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblAssessedQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblAssessedQuestions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusData] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusQuestions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCoReq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCoReq] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourse] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourse] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseACCJC] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseACCJC] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseArc] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseArc] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseAssess] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseAssess] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[assessmentid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseCan] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseCan] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseComp] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseComp] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[CompID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseCompAss] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseCompAss] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[compid],
		[assessmentid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseContent] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseContent] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[ContentID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseQuestions] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[type],
		[questionnumber],
		[questionseq]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseReport] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseReport] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDegree] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDegree] PRIMARY KEY  CLUSTERED 
	(
		[degree_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDistribution] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDistribution] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[title]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblHelp] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblHelp] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblHelpidx] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblHelpidx] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblINI] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblINI] PRIMARY KEY  CLUSTERED 
	(
		[category],
		[campus],
		[kid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblInfo] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblInfo] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblJSID] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblJSID] PRIMARY KEY  CLUSTERED 
	(
		[jsid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblLevel] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblLevel] PRIMARY KEY  CLUSTERED 
	(
		[levelid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblMail] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblMail] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPosition] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPosition] PRIMARY KEY  CLUSTERED 
	(
		[posid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPreReq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPreReq] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblReviewHist] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblReviewHist] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblReviewHist2] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblReviewHist2] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblReviewers] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblReviewers] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblSLO] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblSLO] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[hid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblSalutation] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblSalutation] PRIMARY KEY  CLUSTERED 
	(
		[salid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblStatement] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblStatement] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTasks] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTasks] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCampusData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCampusData] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCoReq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCoReq] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourse] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourse] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseAssess] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseAssess] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[assessmentid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseComp] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseComp] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[CompID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseCompAss] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseCompAss] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[compid],
		[assessmentid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseContent] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseContent] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[ContentID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempPreReq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempPreReq] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempXRef] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempXRef] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblUserLog] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblUserLog] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblUsers] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblUsers] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[userid]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblXRef] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblXRef] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblcampus] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblcampus] PRIMARY KEY  CLUSTERED 
	(
		[campus]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblsyllabus] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblsyllabus] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApproval] ADD 
	CONSTRAINT [DF_tblApproval_approval_date] DEFAULT (getdate()) FOR [approval_date]
GO

ALTER TABLE [dbo].[tblApprover] ADD 
	CONSTRAINT [DF_tblApprover_addeddate] DEFAULT (getdate()) FOR [addeddate]
GO

ALTER TABLE [dbo].[tblAssessedData] ADD 
	CONSTRAINT [DF_tblAssessedData_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblAssessedData_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblAssessedQuestions] ADD 
	CONSTRAINT [DF_tblAssessedQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCampusData] ADD 
	CONSTRAINT [DF_tblCampusData_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCampusData_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCampusData_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblCampusData_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCampusQuestions] ADD 
	CONSTRAINT [DF_tblCampusQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCoReq] ADD 
	CONSTRAINT [DF_tblCoReq_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourse] ADD 
	CONSTRAINT [DF_tblCourse_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCourse_edit] DEFAULT (1) FOR [edit],
	CONSTRAINT [DF_tblCourse_Progress] DEFAULT ('MODIFY') FOR [Progress],
	CONSTRAINT [DF_tblCourse_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCourse_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblCourse_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseACCJC] ADD 
	CONSTRAINT [DF_tblCourseACCJC_AuditDate] DEFAULT (getdate()) FOR [AuditDate]
GO

ALTER TABLE [dbo].[tblCourseArc] ADD 
	CONSTRAINT [DF_tblCourseArc_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseAssess] ADD 
	CONSTRAINT [DF_tblCourseAssess_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseCan] ADD 
	CONSTRAINT [DF_tblCourseCan_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseComp] ADD 
	CONSTRAINT [DF_tblCourseComp_AuditDate] DEFAULT (getdate()) FOR [AuditDate]
GO

ALTER TABLE [dbo].[tblCourseCompAss] ADD 
	CONSTRAINT [DF_tblCourseCompAss_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseContent] ADD 
	CONSTRAINT [DF_tblCourseContent_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblDistribution] ADD 
	CONSTRAINT [DF_tblDistribution_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblHelpidx] ADD 
	CONSTRAINT [DF_tblHelpidx_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblINI] ADD 
	CONSTRAINT [DF_tblINI_kdate] DEFAULT (getdate()) FOR [kdate]
GO

ALTER TABLE [dbo].[tblInfo] ADD 
	CONSTRAINT [DF_tblInfo_DatePosted] DEFAULT (getdate()) FOR [DatePosted]
GO

ALTER TABLE [dbo].[tblMail] ADD 
	CONSTRAINT [DF_tblMail_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblPreReq] ADD 
	CONSTRAINT [DF_tblPreReq_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblReviewHist] ADD 
	CONSTRAINT [DF_tblReviewHist_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblReviewHist2] ADD 
	CONSTRAINT [DF_tblReviewHist2_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblStatement] ADD 
	CONSTRAINT [DF_tblStatement_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTasks] ADD 
	CONSTRAINT [DF_tblTasks_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblTempCampusData] ADD 
	CONSTRAINT [DF_tblTempCampusData_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblTempCampusData_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblTempCampusData_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCoReq] ADD 
	CONSTRAINT [DF_tblTempCoReq_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCourse] ADD 
	CONSTRAINT [DF_tblTempCourse_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCourseAssess] ADD 
	CONSTRAINT [DF_tblTempCourseAssess_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCourseComp] ADD 
	CONSTRAINT [DF_tblTempCourseComp_AuditDate] DEFAULT (getdate()) FOR [AuditDate]
GO

ALTER TABLE [dbo].[tblTempCourseCompAss] ADD 
	CONSTRAINT [DF_tblTempCourseCompAss_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCourseContent] ADD 
	CONSTRAINT [DF_tblTempCourseContent_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempPreReq] ADD 
	CONSTRAINT [DF_tblTempPreReq_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTest] ADD 
	CONSTRAINT [DF_tblTest_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblUserLog] ADD 
	CONSTRAINT [DF_tblUserLog_datetime] DEFAULT (getdate()) FOR [datetime]
GO

ALTER TABLE [dbo].[tblUsers] ADD 
	CONSTRAINT [DF_tblUsers_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblsyllabus] ADD 
	CONSTRAINT [DF_tblsyllabus_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescription
AS
SELECT     accjc.id, accjc.ContentID, content.ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, assess.assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseContent content ON accjc.Campus = content.Campus AND accjc.CourseAlpha = content.CourseAlpha AND 
                      accjc.CourseNum = content.CourseNum AND accjc.CourseType = content.CourseType AND accjc.ContentID = content.ContentID INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType INNER JOIN
                      dbo.tblCourseAssess assess ON accjc.Assessmentid = assess.assessmentid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionHAW
AS
SELECT     accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, 
                      accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionHIL
AS
SELECT     accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, 
                      accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionHON
AS
SELECT     accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, 
                      accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionKAP 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionKAU 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionLEE 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionMAN 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionMAU 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionWIN 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJCDescriptionWOA 
AS 
SELECT accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM tblCourseACCJC AS accjc INNER JOIN tblCourseComp AS [comp] ON (accjc.CourseAlpha = comp.CourseAlpha) AND (accjc.CourseNum = comp.CourseNum) AND (accjc.CompID = comp.CompID) AND (accjc.Campus = comp.Campus) AND (accjc.CourseType = comp.CourseType)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJC_1
AS
SELECT     TOP 100 PERCENT dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum, dbo.tblCourseComp.CourseType, 
                      dbo.tblCourseComp.CompID, dbo.tblCourseComp.Comp, dbo.tblCourseCompAss.assessmentid
FROM         dbo.tblCourseCompAss INNER JOIN
                      dbo.tblCourseComp ON dbo.tblCourseComp.CourseType = dbo.tblCourseCompAss.CourseType AND 
                      dbo.tblCourseComp.CourseNum = dbo.tblCourseCompAss.CourseNum AND 
                      dbo.tblCourseComp.CourseAlpha = dbo.tblCourseCompAss.CourseAlpha AND dbo.tblCourseComp.Campus = dbo.tblCourseCompAss.Campus AND 
                      dbo.tblCourseCompAss.compid = dbo.tblCourseComp.CompID
ORDER BY dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum, dbo.tblCourseComp.CourseType, 
                      dbo.tblCourseComp.CompID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Assessments
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid, tca.assessment
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourseCompAss tcca ON tcc.CompID = tcca.compid INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CompsByAlphaNum
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid, tcc.Comp
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourseCompAss tcca ON tcc.CompID = tcca.compid INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CompsByAlphaNumID
AS
SELECT     TOP 100 PERCENT tca.campus, tcc.CourseAlpha, tcc.CourseNum, tca.assessmentid, tcc.CompID, tcc.Comp
FROM         dbo.tblCourseCompAss tcca INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid INNER JOIN
                      dbo.tblCourseComp tcc ON tcca.compid = tcc.CompID
ORDER BY tca.campus, tcc.CourseAlpha, tcc.CourseNum, tca.assessmentid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CompsByID
AS
SELECT DISTINCT TOP 100 PERCENT tca.campus, tca.assessmentid, tcc.CourseAlpha + ' ' + tcc.CourseNum AS outline
FROM         dbo.tblCourseCompAss tcca INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid INNER JOIN
                      dbo.tblCourseComp tcc ON tcca.compid = tcc.CompID
ORDER BY tca.campus, tca.assessmentid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseLastApprover
AS
SELECT     campus, coursealpha, coursenum, MAX(seq) AS MaxOfseq
FROM         dbo.tblApprovalHist
GROUP BY campus, coursealpha, coursenum, approved
HAVING      (campus = 'LEECC') AND (coursealpha = 'ICS') AND (coursenum = '241') AND (approved = - 1)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseLastDisapprover
AS
SELECT     campus, coursealpha, coursenum, MAX(seq) AS MaxOfseq
FROM         dbo.tblApprovalHist
GROUP BY campus, coursealpha, coursenum, approved
HAVING      (campus = 'LEECC') AND (coursealpha = 'ICS') AND (coursenum = '241') AND (approved = 1)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Incomplete_Assessment_1
AS
SELECT     dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id AS accjcid
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseACCJC ON dbo.tblCourseComp.CompID = dbo.tblCourseACCJC.CompID
GROUP BY dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id, dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum,
                       dbo.tblCourseComp.CourseType

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Incomplete_Assessment_2
AS
SELECT DISTINCT accjcid
FROM         dbo.tblAssessedData

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_SLO
AS
SELECT     c.Campus, c.CourseAlpha, c.CourseNum, c.CourseType, a.id, c.Comp, a.AssessedBy, a.AssessedDate
FROM         dbo.tblCourseACCJC a INNER JOIN
                      dbo.tblCourseComp c ON a.CourseType = c.CourseType AND a.Campus = c.Campus AND a.CompID = c.CompID AND a.CourseNum = c.CourseNum AND 
                      a.CourseAlpha = c.CourseAlpha
GROUP BY c.Campus, c.CourseAlpha, c.CourseNum, c.CourseType, a.id, c.Comp, a.AssessedBy, a.AssessedDate

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ACCJC_2
AS
SELECT     TOP 100 PERCENT dbo.vw_ACCJC_1.Campus, dbo.vw_ACCJC_1.CourseAlpha, dbo.vw_ACCJC_1.CourseNum, dbo.vw_ACCJC_1.CourseType, 
                      dbo.vw_ACCJC_1.CompID, dbo.vw_ACCJC_1.assessmentid, dbo.vw_ACCJC_1.Comp, dbo.tblCourseAssess.assessment
FROM         dbo.vw_ACCJC_1 INNER JOIN
                      dbo.tblCourseAssess ON dbo.vw_ACCJC_1.assessmentid = dbo.tblCourseAssess.assessmentid AND 
                      dbo.vw_ACCJC_1.Campus = dbo.tblCourseAssess.campus
ORDER BY dbo.vw_ACCJC_1.Campus, dbo.vw_ACCJC_1.CourseAlpha, dbo.vw_ACCJC_1.CourseNum, dbo.vw_ACCJC_1.CourseType, dbo.vw_ACCJC_1.CompID, 
                      dbo.vw_ACCJC_1.assessmentid

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100ByIDCampusCourse
AS
SELECT     TOP 100 PERCENT course.id, course.campus, course.questionnumber, course.questionseq, course.question, course.include, c61.Question_Friendly, 
                      c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, course.auditby, course.auditdate, course.help, 
                      course.change
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = 'Course')
ORDER BY course.id, course.campus, course.questionnumber

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100ByIDCampusItems
AS
SELECT     TOP 100 PERCENT campus.campus, campus.id, campus.questionnumber, campus.questionseq, campus.question, campus.include, 
                      c61.Question_Friendly, c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, campus.auditby, 
                      campus.auditdate, campus.help, 'N' AS change
FROM         dbo.tblCampusQuestions campus INNER JOIN
                      dbo.CCCM6100 c61 ON campus.campus = c61.campus AND campus.type = c61.type AND campus.questionnumber = c61.Question_Number
WHERE     (c61.type = 'Campus')
ORDER BY campus.campus, campus.id, campus.questionnumber

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100_Campus
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, campus.question, 'N' AS change
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CCCM6100_Sys
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, course.question, course.include, course.change
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblCourseQuestions course ON c61.Question_Number = course.questionnumber AND c61.type = course.type
WHERE     (c61.campus = 'SYS') AND (course.type = 'Course')
ORDER BY course.campus, course.questionseq, c61.campus

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CampusItems
AS
SELECT     TOP 100 PERCENT campus.id, campus.campus, c61.Question_Number, campus.questionseq AS Seq, c61.Question_Friendly AS Field_Name, 
                      campus.question, c61.Question_Len AS Length, c61.Question_Max AS Maximum, campus.include, 'N' AS change, c61.type
FROM         dbo.tblCampusQuestions campus INNER JOIN
                      dbo.CCCM6100 c61 ON campus.questionnumber = c61.Question_Number AND campus.campus = c61.campus AND campus.type = c61.type AND 
                      campus.campus = c61.type
ORDER BY campus.campus, campus.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CampusQuestions
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, dbo.CCCM6100.Question_Number, campus.question, 
                      dbo.CCCM6100.Question_Friendly
FROM         dbo.CCCM6100 INNER JOIN
                      dbo.tblCampusQuestions campus ON dbo.CCCM6100.type = campus.type AND dbo.CCCM6100.campus = campus.campus AND 
                      dbo.CCCM6100.Question_Number = campus.questionnumber
WHERE     (campus.type = 'Campus') AND (campus.include = 'Y')
ORDER BY campus.campus, campus.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CampusQuestionsYN
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, dbo.CCCM6100.Question_Number, campus.question, 
                      dbo.CCCM6100.Question_Friendly
FROM         dbo.CCCM6100 INNER JOIN
                      dbo.tblCampusQuestions campus ON dbo.CCCM6100.type = campus.type AND dbo.CCCM6100.campus = campus.campus AND 
                      dbo.CCCM6100.Question_Number = campus.questionnumber
WHERE     (campus.type = 'Campus')
ORDER BY campus.campus, campus.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseItems
AS
SELECT     TOP 100 PERCENT course.id, course.campus, c61.Question_Number, course.questionseq AS Seq, course.question, 
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, course.include, course.change
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = 'Course')
ORDER BY course.campus, course.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseLastApproverX
AS
SELECT     dbo.vw_CourseLastApprover.campus, dbo.vw_CourseLastApprover.coursealpha, dbo.vw_CourseLastApprover.coursenum, 
                      dbo.tblApprovalHist.approver
FROM         dbo.vw_CourseLastApprover INNER JOIN
                      dbo.tblApprovalHist ON dbo.vw_CourseLastApprover.MaxOfseq = dbo.tblApprovalHist.seq AND 
                      dbo.vw_CourseLastApprover.coursenum = dbo.tblApprovalHist.coursenum AND 
                      dbo.vw_CourseLastApprover.coursealpha = dbo.tblApprovalHist.coursealpha AND dbo.vw_CourseLastApprover.campus = dbo.tblApprovalHist.campus

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseLastDisapproverX
AS
SELECT     dbo.vw_CourseLastDisapprover.campus, dbo.vw_CourseLastDisapprover.coursealpha, dbo.vw_CourseLastDisapprover.coursenum, 
                      dbo.tblApprovalHist.approver
FROM         dbo.vw_CourseLastDisapprover INNER JOIN
                      dbo.tblApprovalHist ON dbo.vw_CourseLastDisapprover.campus = dbo.tblApprovalHist.campus AND 
                      dbo.vw_CourseLastDisapprover.coursealpha = dbo.tblApprovalHist.coursealpha AND 
                      dbo.vw_CourseLastDisapprover.coursenum = dbo.tblApprovalHist.coursenum AND 
                      dbo.vw_CourseLastDisapprover.MaxOfseq = dbo.tblApprovalHist.seq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseQuestions
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, dbo.CCCM6100.Question_Number, course.question, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 ON course.questionnumber = dbo.CCCM6100.Question_Number AND course.type = dbo.CCCM6100.type
WHERE     (course.type = 'Course') AND (course.include = 'Y')
ORDER BY course.campus, course.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseQuestionsYN
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, dbo.CCCM6100.Question_Number, course.question, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 ON course.questionnumber = dbo.CCCM6100.Question_Number AND course.type = dbo.CCCM6100.type
WHERE     (course.type = 'Course')
ORDER BY course.campus, course.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Incomplete_Assessment_3
AS
SELECT     accjcid
FROM         dbo.vw_Incomplete_Assessment_1
WHERE     (accjcid NOT IN
                          (SELECT     ACCJCID
                            FROM          vw_Incomplete_Assessment_2))

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Incomplete_Assessment_4
AS
SELECT DISTINCT dbo.tblAssessedData.accjcid
FROM         dbo.vw_Incomplete_Assessment_2 INNER JOIN
                      dbo.tblAssessedData ON dbo.vw_Incomplete_Assessment_2.accjcid = dbo.tblAssessedData.accjcid
WHERE     (dbo.tblAssessedData.question IS NULL)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ResequenceCampusItems
AS
SELECT     TOP 100 PERCENT dbo.tblCampusQuestions.campus, dbo.tblCampusQuestions.questionseq, dbo.CCCM6100.Question_Friendly, 
                      dbo.tblCampusQuestions.type, dbo.tblCampusQuestions.include
FROM         dbo.tblCampusQuestions INNER JOIN
                      dbo.CCCM6100 ON dbo.tblCampusQuestions.type = dbo.CCCM6100.type AND dbo.tblCampusQuestions.campus = dbo.CCCM6100.campus AND 
                      dbo.tblCampusQuestions.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.tblCampusQuestions.type = 'Campus') AND (dbo.tblCampusQuestions.include = 'Y')
ORDER BY dbo.tblCampusQuestions.campus, dbo.tblCampusQuestions.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ResequenceCourseItems
AS
SELECT     TOP 100 PERCENT tcc.campus, tcc.questionseq, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions tcc INNER JOIN
                      dbo.CCCM6100 ON tcc.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.type = 'Course') AND (tcc.include = 'Y')
ORDER BY tcc.campus, tcc.questionseq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_WriteSyllabus
AS
SELECT     TOP 100 PERCENT c.campus, c.CourseAlpha, c.CourseNum, dbo.BannerDept.DEPT_DESCRIPTION AS division, c.coursetitle AS title, c.credits, 
                      c.X15 AS prereq, c.X16 AS coreq, c.X17 AS recprep
FROM         dbo.tblCourse c INNER JOIN
                      dbo.BannerDept ON c.dispID = dbo.BannerDept.DEPT_CODE
WHERE     (c.CourseType = 'CUR')
ORDER BY c.campus, c.CourseAlpha, c.CourseNum

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CampusReportItems
AS
SELECT     id, campus, Seq, Question_Number, Field_Name, question, '1' AS Indent
FROM         dbo.vw_CampusItems
WHERE     (include = 'Y')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_CourseReportItems
AS
SELECT     id, campus, Seq, Question_Number, Field_Name, question, '0' AS Indent
FROM         dbo.vw_CourseItems
WHERE     (include = 'Y')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.CheckBannerCount
   (@campus CHAR(3))
AS
BEGIN
   IF ((SELECT COUNT(*)
   FROM BANNER
   WHERE institution = @campus) > 1)
   RETURN 1
ELSE
   RETURN 0
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_DeleteTempData
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@user varchar(30)
AS

DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND proposer=@user

DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND auditby=@user

DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND auditby=@user

DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND auditby=@user

DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND approvedby=@user

DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND auditby=@user

DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND auditby=@user
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineApproval
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@date varchar(20),
	@user varchar(50),
	@history varchar(18)
AS

BEGIN TRANSACTION

-- outline approval takes the following steps...
-- 1) delete old data from temp tables
-- 2) copy CUR records to temp table
-- 3) set CUR to ARC
-- 4) move to ARC table
-- 5) delete CUR record
-- 6) update PRE to CUR
-- 7) move history

-- STEP 1: delete from temp tables

EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user

-- STEP 2: insert into temp tables

INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCoreq 
	SELECT * FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempPreReq
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

-- STEP 3: update temp tables

UPDATE tblTempCourse 
	SET coursetype='ARC',progress='ARCHIVED',proposer=@user,coursedate=@date,historyid=@history
	WHERE coursealpha=@alpha AND coursenum=@num AND campus=@campus

UPDATE tblTempCoreq 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempPreReq 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCourseComp 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCourseContent 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCampusData 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCourseCompAss 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

-- STEP 4: move CUR to ARC

INSERT INTO tblCourseARC 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

-- STEP 5: delete CUR

DELETE FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

DELETE FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

DELETE FROM tblCoReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

DELETE FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

DELETE FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

DELETE FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

DELETE FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

-- STEP 6: update from PRE to CUR

UPDATE tblCourse 
	SET coursetype='CUR',progress='APPROVED',edit1='',edit2='',coursedate=@date,auditdate=@date,proposer=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCampusData 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCoReq 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblPreReq 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCourseComp 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCourseContent 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCourseCompAss 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

-- STEP 7: move history and clear

INSERT INTO tblApprovalHist2 
	(id,historyid,approvaldate,coursealpha,coursenum,dte,campus,seq,approver,approved,comments ) 
	SELECT tba.id,tba.historyid,@date,tba.coursealpha,tba.coursenum,tba.dte,tba.campus,tba.seq,tba.approver,tba.approved,tba.comments 
	FROM tblApprovalHist tba WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

DELETE FROM tblApprovalHist 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

IF @@ERROR <> 0
	BEGIN
		ROLLBACK
		RETURN -1
	END

COMMIT

EXEC sp_ASE_TestData @campus, @alpha, @num, 'PRE'

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineCancel
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@date varchar(20),
	@user varchar(50)
AS

BEGIN TRANSACTION

-- STEP 1: delete from temp tables

EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user

-- STEP 2: prepare cancelled record by moving to CAN

INSERT INTO tblTempCourse 
	SELECT * FROM tblcourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblTempCourse 
	SET coursetype='CAN',progress='CANCELLED',coursedate=@date,proposer=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

INSERT INTO tblCourseCAN 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CAN'

-- STEP 3: delete PRE

DELETE FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

-- STEP 4: update to CAN for all supporting data

UPDATE tblCoreq 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblPreReq 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCourseComp 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCourseContent 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCampusData 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

UPDATE tblCourseCompAss 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

-- STEP 5: move history

INSERT INTO tblApprovalHist2 ( historyid, approvaldate, coursealpha, coursenum, dte, campus, seq, approver, approved, comments ) 
	SELECT tba.historyid, @date, tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq, tba.approver, tba.approved, tba.comments 
	FROM tblApprovalHist tba 
	WHERE coursealpha=@alpha AND coursenum=@num AND campus=@campus

DELETE FROM tblApprovalHist 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

-- STEP 6: move review history

INSERT INTO tblReviewHist2  (historyid, campus, coursealpha, coursenum, item, dte, reviewer, comments) 
	SELECT historyid, campus, coursealpha, coursenum, item, dte, reviewer, comments
	 FROM tblReviewHist
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

DELETE FROM tblReviewHist 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

IF @@ERROR <> 0
	BEGIN
		ROLLBACK
		RETURN -1
	END

COMMIT

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineCurrentToArchive
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@date varchar(30),
	@user varchar(30),
	@history varchar(18)
AS

BEGIN TRANSACTION

EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user

DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

INSERT INTO tblTempCourse 
	SELECT * FROM tblcourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

UPDATE tblTempCourse 
	SET coursetype='ARC',progress='ARCHIVED',proposer=@user,coursedate=@date,historyid=@history
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

INSERT INTO tblCourseARC 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'

UPDATE tblCoreq 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

UPDATE tblPreReq 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

UPDATE tblCourseComp 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

UPDATE tblCourseContent 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

UPDATE tblCampusData 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

UPDATE tblCourseCompAss 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

IF @@ERROR <> 0
	BEGIN
		ROLLBACK
		RETURN -1
	END

COMMIT

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineModify
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@date varchar(20),
	@user varchar(50),
	@history varchar(18),
	@jsid varchar(50)
AS

BEGIN TRANSACTION

-- STEP 1: delete from temp tables

EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user

-- STEP 2: copy CUR data to temp

INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCoReq 
	SELECT * FROM tblCoReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempPreReq 
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

-- STEP 3: update CUR to PRe

UPDATE tblTempCourse 
	SET	id=@history,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1',
		proposer=@user,historyid=@history,jsid=@jsid,reviewdate=@date,assessmentdate=@date,
		coursedate=@date,dateproposed=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'

IF 
(
	SELECT COUNT(campus)
	FROM tblCampusData
	WHERE  campus=@campus AND 
		coursealpha=@alpha AND 
		coursenum=@num AND
		(coursetype='CUR' OR coursetype='PRE')
) = 0
BEGIN
	INSERT INTO tblTempCampusData (historyid,CourseAlpha,CourseNum,auditby,campus) 
	VALUES(@history,@alpha,@num,@user,@campus)
END

UPDATE tblTempCoReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempPreReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCourseComp 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCourseContent 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCampusData 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

UPDATE tblTempCourseCompAss 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

-- STEP 4: move to main tables to be worked on

INSERT INTO tblCourse 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'

IF @@ERROR <> 0
	BEGIN
		ROLLBACK
		RETURN -1
	END

COMMIT

EXEC sp_ASE_TestData @campus, @alpha, @num, 'PRE'

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_TestData
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@type varchar(10)
AS


DELETE FROM tblTest

INSERT INTO tblTest
(tabo, historyid, campus, CourseAlpha, CourseNum, CourseType, id1, id2, text1, text2)
SELECT      'tblCourse' AS Expr3, historyid, campus, CourseAlpha, CourseNum, CourseType, 0 AS Expr1, 0 AS Expr2, proposer, coursetitle
FROM         tblCourse
WHERE     (campus=@campus) AND (CourseAlpha=@alpha) AND (CourseNum=@num) AND (CourseType=@type)

INSERT INTO tblTest
(tabo, historyid, campus, CourseAlpha, CourseNum, CourseType, id1, id2, text1, text2)
SELECT     'tblCampusData' AS Expr5, historyid, campus, CourseAlpha, CourseNum, CourseType, 0 AS Expr1, 0 AS Expr2, '' AS Expr3, '' AS Expr4
FROM         tblCampusData
WHERE     (campus=@campus) AND (CourseAlpha=@alpha) AND (CourseNum=@num) AND (CourseType=@type)

INSERT INTO tblTest
(tabo, historyid, campus, CourseAlpha, CourseNum, CourseType, id1, id2, text1, text2)
SELECT     'tblprereq' AS Expr3, historyid, Campus, CourseAlpha, CourseNum, CourseType, id, 0 AS Expr1, prereqAlpha, prereqNum
FROM         tblpreReq
WHERE     (campus=@campus) AND (CourseAlpha=@alpha) AND (CourseNum=@num) AND (CourseType=@type)

INSERT INTO tblTest
(tabo, historyid, campus, CourseAlpha, CourseNum, CourseType, id1, id2, text1, text2)
SELECT     'tblcoreq' AS Expr3, historyid, Campus, CourseAlpha, CourseNum, CourseType, id, 0 AS Expr1, CoreqAlpha, CoreqNum
FROM         tblCoReq
WHERE     (campus=@campus) AND (CourseAlpha=@alpha) AND (CourseNum=@num) AND (CourseType=@type)

INSERT INTO tblTest
(tabo, historyid, campus, CourseAlpha, CourseNum, CourseType, id1, id2, text1, text2)
SELECT     'tblCourseComp' AS Expr1, historyid, Campus, CourseAlpha, CourseNum, CourseType, CompID, Comp, '' AS Expr2, '' AS Expr3
FROM         tblCourseComp
WHERE     (campus=@campus) AND (CourseAlpha=@alpha) AND (CourseNum=@num) AND (CourseType=@type)

INSERT INTO tblTest
(tabo, historyid, campus, CourseAlpha, CourseNum, CourseType, id1, id2, text1, text2)
SELECT     'tblCourseContent' AS Expr1, historyid, Campus, CourseAlpha, CourseNum, CourseType, ContentID, 0 AS Expr2, ShortContent, LongContent
FROM         tblCourseContent
WHERE     (campus=@campus) AND (CourseAlpha=@alpha) AND (CourseNum=@num) AND (CourseType=@type)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

