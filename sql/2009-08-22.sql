if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CheckBannerCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CheckBannerCount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[qryAppendDefaultQuestions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[qryAppendDefaultQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_DeleteTempData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_DeleteTempData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_InsertTempData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_InsertTempData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineApproval]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineApproval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineCancel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineCancel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineCopy]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineCopy]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineCurrentToArchive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineCurrentToArchive]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineModify]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineModify]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_OutlineRename]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_OutlineRename]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_TestData]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_TestData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_zzz]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_zzz]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_zzz_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_zzz_01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_zzz_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_zzz_02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_zzz_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_zzz_03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ASE_zzz_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ASE_zzz_04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzAppendCCCM6100]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[zzzAppendCCCM6100]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzAppendCampusTotblCCCM6100]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[zzzAppendCampusTotblCCCM6100]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzAppendTblINI]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[zzzAppendTblINI]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzAppendTblINIList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[zzzAppendTblINIList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_6]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_6]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_5]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_5]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ACCJC_2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ACCJC_2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_AllQuestions]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_AllQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_3]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_4]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_4]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency2]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApprovalHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApprovalHistory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Approvers]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Approvers]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Approvers2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Approvers2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApproversDivisionChair]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApproversDivisionChair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApproversNoDivisionChair]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApproversNoDivisionChair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Assessments]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Assessments]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CompsByAlphaNum]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CompsByAlphaNum]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CompsByAlphaNumID]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CompsByAlphaNumID]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CompsByID]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CompsByID]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_EffectiveTerms]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_EffectiveTerms]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_GenericContent2Linked]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_GenericContent2Linked]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_HelpGetContent]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_HelpGetContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_1]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Incomplete_Assessment_2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Incomplete_Assessment_2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Linked2PSLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Linked2PSLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency2Assessment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency2Assessment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency2Content]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency2Content]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency2GESLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency2GESLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency2MethodEval]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency2MethodEval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCompetency2PSLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCompetency2PSLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedContent2Compentency]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedContent2Compentency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedCountItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedCountItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedSLO2Assessment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedSLO2Assessment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedSLO2GESLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedSLO2GESLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkedSLO2MethodEval]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkedSLO2MethodEval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_OutlineValidation]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_OutlineValidation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceCampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceCampusItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceCourseItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceCourseItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewerComments]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewerComments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLO2Assessment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLO2Assessment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLOByProgress_2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLOByProgress_2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_WriteSyllabus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_WriteSyllabus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CampusReportItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CampusReportItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastApprover]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastApprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastDisapprover]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastDisapprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseReportItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseReportItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLOByProgress_1]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLOByProgress_1]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[jdbclog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[jdbclog]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblArea]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblArea]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblAssessedData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblAssessedData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblAssessedDataARC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblAssessedDataARC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblAssessedQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblAssessedQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblAttach]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblAttach]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseARC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseARC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseAssess]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseAssess]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseCAN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseCAN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseComp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseComp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseCompAss]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseCompAss]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseCompetency]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseCompetency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseContentSLO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseContentSLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseLinked]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseLinked]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseLinked2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseLinked2]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDocs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDocs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblExtra]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblExtra]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblFDCategory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblFDCategory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblFDProgram]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblFDProgram]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblForms]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblForms]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblGESLO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblGESLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblGenericContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblGenericContent]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblMisc]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblMisc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPDF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPDF]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPosition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPosition]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPreReq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPreReq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblProps]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblProps]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblSLOARC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblSLOARC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblSalutation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblSalutation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblStatement]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblStatement]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTabs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTabs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTasks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTasks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempAttach]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempAttach]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseACCJC]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseACCJC]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseCompetency]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseCompetency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseContentSLO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseContentSLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseLinked]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseLinked]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempCourseLinked2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempCourseLinked2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempExtra]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempExtra]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempGESLO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempGESLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempGenericContent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempGenericContent]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempPreReq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempPreReq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTempXRef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTempXRef]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTemplate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTemplate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblTest]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblTest]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblText]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblText]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblccowiq]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblccowiq]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblsyllabus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblsyllabus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzBanner]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzBanner]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzCCCM6100]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzCCCM6100]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzTableINI]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzTableINI]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzTableINIList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzTableINIList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzalpha]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzalpha]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzcollege]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzcollege]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzdept]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzdept]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzdivision]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzdivision]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzztemp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzztemp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zzzterm]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zzzterm]
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
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Number] [smallint] NULL ,
	[CCCM6100] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Friendly] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Len] [smallint] NULL ,
	[Question_Max] [smallint] NULL ,
	[Question_Type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Ini] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Explain] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[jdbclog] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[date] [datetime] NULL ,
	[logger] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[priority] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
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
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NOT NULL ,
	[dte] [smalldatetime] NOT NULL ,
	[approver] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NOT NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[approvaldate] [smalldatetime] NOT NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NOT NULL ,
	[approver] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NOT NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprover] (
	[approverid] [int] IDENTITY (1, 1) NOT NULL ,
	[approver_seq] [int] NULL ,
	[approver] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[delegated] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[multilevel] [bit] NOT NULL ,
	[department] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addedby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[experimental] [bit] NULL ,
	[route] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblArea] (
	[ID] [int] NOT NULL ,
	[area] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[code] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[codedescr] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tblAssessedDataARC] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[accjcid] [int] NULL ,
	[qid] [int] NULL ,
	[question] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approvedby] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblAttach] (
	[id] [numeric](18, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filedescr] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filename] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filesize] [float] NULL ,
	[filedate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCampusData] (
	[id] [numeric](10, 0) NOT NULL ,
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
	[C13] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C14] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C15] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C16] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C17] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C18] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C19] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C20] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C21] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C22] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C23] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C24] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C25] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C26] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C27] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C28] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C29] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C30] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCampusQuestions] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionnumber] [int] NULL ,
	[questionseq] [int] NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[change] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[required] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCoReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NULL ,
	[CoreqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CoreqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourse] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[Progress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NULL ,
	[maxcredit] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[X65] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL 
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

CREATE TABLE [dbo].[tblCourseARC] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Progress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NULL ,
	[maxcredit] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[X65] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL 
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

CREATE TABLE [dbo].[tblCourseCAN] (
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
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DispID] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NULL ,
	[maxcredit] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[X65] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseComp] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CompID] [numeric](10, 0) NULL ,
	[Comp] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCompAss] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[compid] [numeric](10, 0) NOT NULL ,
	[assessmentid] [numeric](10, 0) NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCompetency] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [int] NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[content] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseContent] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [numeric](10, 0) NULL ,
	[ShortContent] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LongContent] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseContentSLO] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[contentid] [numeric](10, 0) NOT NULL ,
	[sloid] [numeric](10, 0) NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseLinked] (
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[src] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[dst] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ref] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseLinked2] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] NULL ,
	[item] [int] NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item2] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseQuestions] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[type] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[questionnumber] [int] NOT NULL ,
	[questionseq] [int] NOT NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[change] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[required] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tblDocs] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filename] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[show] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblExtra] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Src] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NOT NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblFDCategory] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [int] NOT NULL ,
	[category] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblFDProgram] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [int] NOT NULL ,
	[program] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblForms] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[link] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblGESLO] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[geid] [int] NOT NULL ,
	[slolevel] [int] NULL ,
	[sloevals] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblGenericContent] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[src] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](18, 0) NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHelp] (
	[id] [numeric](10, 0) NOT NULL ,
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
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[seq] [int] NULL ,
	[category] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[kid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[kdesc] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[flag] [bit] NULL ,
	[blink] [bit] NULL ,
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
	[start] [datetime] NULL ,
	[audit] [datetime] NULL ,
	[enddate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLevel] (
	[levelid] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[levelname] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblMail] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[from] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cc] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bcc] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subject] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblMisc] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[coursetype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[descr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[val] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPDF] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kix] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[field01] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[field02] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPosition] (
	[posid] [decimal](18, 0) NOT NULL ,
	[posname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPreReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NULL ,
	[PrereqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[PrereqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblProps] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[propname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[propdescr] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subject] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[content] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[source] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[source] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tblSLOARC] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[hid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[statement] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTabs] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[tab] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTasks] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submittedfor] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submittedby] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempAttach] (
	[id] [numeric](18, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filedescr] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filename] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filesize] [float] NULL ,
	[filedate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCampusData] (
	[id] [numeric](18, 0) NOT NULL ,
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
	[C13] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C14] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C15] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C16] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C17] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C18] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C19] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C20] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C21] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C22] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C23] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C24] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C25] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C26] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C27] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C28] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C29] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C30] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCoReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NULL ,
	[CoreqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoreqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
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
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DispID] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Division] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[credits] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[repeatable] [bit] NULL ,
	[maxcredit] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[crosslisted] [bit] NULL ,
	[coursedate] [smalldatetime] NULL ,
	[effectiveterm] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[gradingoptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursedescr] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[X65] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseACCJC] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [int] NULL ,
	[CompID] [int] NULL ,
	[Assessmentid] [int] NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[AssessedDate] [smalldatetime] NULL ,
	[AssessedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
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
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CompID] [numeric](10, 0) NULL ,
	[Comp] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseCompAss] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[compid] [numeric](10, 0) NOT NULL ,
	[assessmentid] [numeric](10, 0) NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseCompetency] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [int] NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[content] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseContent] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [numeric](10, 0) NULL ,
	[ShortContent] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LongContent] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseContentSLO] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[contentid] [numeric](10, 0) NOT NULL ,
	[sloid] [numeric](10, 0) NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseLinked] (
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[src] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[dst] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ref] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseLinked2] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] NULL ,
	[item] [int] NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item2] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempExtra] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Src] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NOT NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempGESLO] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[geid] [int] NOT NULL ,
	[slolevel] [int] NULL ,
	[sloevals] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempGenericContent] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[src] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](18, 0) NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempPreReq] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NULL ,
	[PrereqAlpha] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PrereqNum] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempXRef] (
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Id] [numeric](10, 0) NULL ,
	[CourseAlphaX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNumX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTemplate] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[area] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[content] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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

CREATE TABLE [dbo].[tblText] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [int] IDENTITY (1, 1) NOT NULL ,
	[title] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edition] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[author] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[publisher] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[yeer] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[isbn] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUserLog] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[userid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[script] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Id] [numeric](10, 0) NOT NULL ,
	[CourseAlphaX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNumX] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
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

CREATE TABLE [dbo].[tblccowiq] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[topic] [int] NOT NULL ,
	[seq] [int] NOT NULL ,
	[category] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[header] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
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

CREATE TABLE [dbo].[zzzBanner] (
	[ID] [int] NOT NULL ,
	[INSTITUTION] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_ALPHA] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_NUMBER] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EFFECTIVE_TERM] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_TITLE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_LONG_TITLE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_DIVISION] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_DEPT] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_COLLEGE] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MAX_RPT_UNITS] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[REPEAT_LIMIT] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_HIGH] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_LOW] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_IND] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_HIGH] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_LOW] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_IND] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_HIGH] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_LOW] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_IND] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_HIGH] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_LOW] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_IND] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_HIGH] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_LOW] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_IND] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzCCCM6100] (
	[id] [int] NULL ,
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

CREATE TABLE [dbo].[zzzTableINI] (
	[id] [int] NULL ,
	[seq] [int] NULL ,
	[category] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kdesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kedit] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[klanid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kdate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzTableINIList] (
	[id] [int] NULL ,
	[seq] [int] NULL ,
	[category] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kdesc] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kedit] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[klanid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kdate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzalpha] (
	[ID] [int] NOT NULL ,
	[COURSE_ALPHA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ALPHA_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzcollege] (
	[COLLEGE_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[COLL_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzdept] (
	[DEPT_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DEPT_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzdivision] (
	[DIVISION_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DIVS_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzztemp] (
	[id] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[zzzterm] (
	[TERM_CODE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TERM_DESCRIPTION] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[jdbclog] WITH NOCHECK ADD 
	CONSTRAINT [PK_jdbclog] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApproval] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApproval] PRIMARY KEY  CLUSTERED 
	(
		[approval_id],
		[approval_seq],
		[coursealpha],
		[coursenum]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApprovalHist] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApprovalHist] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid],
		[seq],
		[dte]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApprovalHist2] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApprovalHist2] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid],
		[dte],
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblApprover] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblApprover] PRIMARY KEY  CLUSTERED 
	(
		[approverid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblArea] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblArea] PRIMARY KEY  CLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblAssessedData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblAssessedData] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblAssessedQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblAssessedQuestions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblAttach] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblAttach] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusData] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusQuestions] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCoReq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCoReq] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Campus],
		[CourseAlpha],
		[CourseNum],
		[CourseType],
		[CoreqAlpha],
		[CoreqNum]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourse] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourse] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseACCJC] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseACCJC] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseARC] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseArc] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseAssess] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseAssess] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[assessmentid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseCAN] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseCan] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseCompAss] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseCompAss] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[compid],
		[assessmentid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseCompetency] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseCompetency] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseContentSLO] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseContentSLO] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[contentid],
		[sloid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseQuestions] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[type],
		[questionnumber],
		[questionseq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCourseReport] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCourseReport] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDegree] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDegree] PRIMARY KEY  CLUSTERED 
	(
		[degree_id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDistribution] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDistribution] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[title]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDocs] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDocs] PRIMARY KEY  CLUSTERED 
	(
		[filename]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblExtra] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblExtra] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Src],
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblFDCategory] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblFDCategory] PRIMARY KEY  CLUSTERED 
	(
		[degree],
		[seq]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblFDProgram] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblFD] PRIMARY KEY  CLUSTERED 
	(
		[degree],
		[seq]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblGESLO] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblGESLO] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[historyid],
		[geid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblGenericContent] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblGenericContent] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid],
		[src]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblHelp] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblHelp] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblHelpidx] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblHelpidx] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblINI] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblINI] PRIMARY KEY  CLUSTERED 
	(
		[category],
		[campus],
		[kid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblInfo] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblInfo] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblJSID] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblJSID] PRIMARY KEY  CLUSTERED 
	(
		[jsid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblLevel] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblLevel] PRIMARY KEY  CLUSTERED 
	(
		[levelid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblMail] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblMail] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblMisc] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblMisc] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPDF] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPDF] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPosition] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPosition] PRIMARY KEY  CLUSTERED 
	(
		[posid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPreReq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPreReq] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Campus],
		[CourseAlpha],
		[CourseNum],
		[CourseType],
		[PrereqAlpha],
		[PrereqNum]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblProps] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblProps] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblReviewHist] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblReviewHist] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblReviewHist2] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblReviewHist2] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblReviewers] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblReviewers] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblSLO] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblSLO] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[hid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblSLOARC] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblSLOARC] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblSalutation] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblSalutation] PRIMARY KEY  CLUSTERED 
	(
		[salid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblStatement] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblStatement] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTabs] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTabs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTasks] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTasks] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempAttach] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempAttach] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCampusData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCampusData] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourse] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourse] PRIMARY KEY  CLUSTERED 
	(
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseACCJC] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseACCJC] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseAssess] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseAssess] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[assessmentid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseCompAss] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseCompAss] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[compid],
		[assessmentid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseCompetency] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseCompetency] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempCourseContentSLO] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempCourseContentSLO] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[contentid],
		[sloid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempExtra] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempExtra] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Src],
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempGESLO] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempGESLO] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[historyid],
		[geid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTempGenericContent] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTempGenericContent] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid],
		[src]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTemplate] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTemplate] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblText] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblBooks] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblUserLog] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblUserLog] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblUsers] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblUsers] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[userid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblXRef] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblXRef] PRIMARY KEY  CLUSTERED 
	(
		[historyid],
		[Id],
		[auditdate]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblcampus] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblcampus] PRIMARY KEY  CLUSTERED 
	(
		[campus]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblccowiq] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblccowiq] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[topic],
		[seq]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblsyllabus] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblsyllabus] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[CCCM6100] ADD 
	CONSTRAINT [DF__CCCM6100__Questi__727BF387] DEFAULT (0) FOR [Question_Len],
	CONSTRAINT [aaaaaCCCM6100_PK] PRIMARY KEY  NONCLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

 CREATE  INDEX [PK_cccm6100_campus_qn] ON [dbo].[CCCM6100]([campus], [Question_Number]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[jdbclog] ADD 
	CONSTRAINT [DF_jdbclog_date] DEFAULT (getdate()) FOR [date]
GO

 CREATE  INDEX [PK_jdbclog_date] ON [dbo].[jdbclog]([date]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_jdbclog_logger] ON [dbo].[jdbclog]([logger]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApproval] ADD 
	CONSTRAINT [DF_tblApproval_approval_date] DEFAULT (getdate()) FOR [approval_date]
GO

 CREATE  INDEX [PK_tblApproval_Status] ON [dbo].[tblApproval]([campus], [coursealpha], [coursenum], [status]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApprovalHist] ADD 
	CONSTRAINT [DF__tblApprov__appro__216BEC9A] DEFAULT (0) FOR [approver_seq],
	CONSTRAINT [DF__tblApprov__votes__7740A8A4] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF__tblApprov__votes__7834CCDD] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF__tblApprov__votes__7928F116] DEFAULT (0) FOR [votesabstain]
GO

 CREATE  INDEX [PK_tblApprovalHist_Key] ON [dbo].[tblApprovalHist]([campus], [coursealpha], [coursenum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApprovalHist2] ADD 
	CONSTRAINT [DF__tblApprov__appro__226010D3] DEFAULT (0) FOR [approver_seq],
	CONSTRAINT [DF__tblApprov__votes__7A1D154F] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF__tblApprov__votes__7B113988] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF__tblApprov__votes__7C055DC1] DEFAULT (0) FOR [votesabstain]
GO

 CREATE  INDEX [PK_tblApprovalHist2_Key] ON [dbo].[tblApprovalHist2]([campus], [coursealpha], [coursenum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApprover] ADD 
	CONSTRAINT [DF_tblApprover_experimental] DEFAULT (0) FOR [experimental],
	CONSTRAINT [DF__tblApprov__route__2BE97B0D] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblApprover_campus] ON [dbo].[tblApprover]([campus], [approver_seq]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblAssessedData] ADD 
	CONSTRAINT [DF_tblAssessedData_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblAssessedData_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblAssessedData_Key] ON [dbo].[tblAssessedData]([campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_AssessedDataArc_Key] ON [dbo].[tblAssessedDataARC]([campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblAssessedQuestions] ADD 
	CONSTRAINT [DF_tblAssessedQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblAttach] ADD 
	CONSTRAINT [DF_tblAttach_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCampusData] ADD 
	CONSTRAINT [DF_tblCampusData_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblCampusData_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCampusData_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCampusData_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblCampusData_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblCampusData_Key] ON [dbo].[tblCampusData]([campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCampusQuestions] ADD 
	CONSTRAINT [DF_tblCampusQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCampus__requi__0C70CFB4] DEFAULT ('N') FOR [required]
GO

ALTER TABLE [dbo].[tblCoReq] ADD 
	CONSTRAINT [DF_tblCoReq_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblCoReq_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCoReq__rdr__4E739D3B] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblCourse] ADD 
	CONSTRAINT [DF_tblCourse_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCourse_edit] DEFAULT (1) FOR [edit],
	CONSTRAINT [DF_tblCourse_Progress] DEFAULT ('MODIFY') FOR [Progress],
	CONSTRAINT [DF_tblCourse_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCourse_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblCourse_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourse__route__2818EA29] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblCourse_Key] ON [dbo].[tblCourse]([campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseACCJC] ADD 
	CONSTRAINT [DF_tblCourseACCJC_AuditDate] DEFAULT (getdate()) FOR [AuditDate]
GO

ALTER TABLE [dbo].[tblCourseARC] ADD 
	CONSTRAINT [DF_tblCourseArc_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourse__route__2A01329B] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblCourseArc_Key] ON [dbo].[tblCourseARC]([campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseAssess] ADD 
	CONSTRAINT [DF_tblCourseAssess_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseCAN] ADD 
	CONSTRAINT [DF_tblCourseCan_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourse__route__2AF556D4] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblCourseCan_Key] ON [dbo].[tblCourseCAN]([campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseComp] ADD 
	CONSTRAINT [DF_tblCourseComp_CompID] DEFAULT (0) FOR [CompID],
	CONSTRAINT [DF_tblCourseComp_AuditDate] DEFAULT (getdate()) FOR [AuditDate],
	CONSTRAINT [DF__tblCourseCo__rdr__53385258] DEFAULT (0) FOR [rdr]
GO

 CREATE  INDEX [PK_CourseComp_Key] ON [dbo].[tblCourseComp]([Campus], [CourseAlpha], [CourseNum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_CourseComp_HistoryID] ON [dbo].[tblCourseComp]([historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseCompAss] ADD 
	CONSTRAINT [DF_tblCourseCompAss_compid] DEFAULT (0) FOR [compid],
	CONSTRAINT [DF_tblCourseCompAss_assessmentid] DEFAULT (0) FOR [assessmentid],
	CONSTRAINT [DF_tblCourseCompAss_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseCompetency] ADD 
	CONSTRAINT [DF_tblCourseCompetency_AuditDate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourseCo__rdr__7F16D496] DEFAULT (0) FOR [rdr]
GO

 CREATE  INDEX [PK_tblCourseCompetencyOutline] ON [dbo].[tblCourseCompetency]([campus], [coursealpha], [coursenum], [coursetype]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseContent] ADD 
	CONSTRAINT [DF_tblCourseContent_ContentID] DEFAULT (0) FOR [ContentID],
	CONSTRAINT [DF_tblCourseContent_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourseCo__rdr__515009E6] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblCourseContentSLO] ADD 
	CONSTRAINT [DF_tblCourseContentSLO_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseLinked] ADD 
	CONSTRAINT [DF__tblCourseLi__ref__4A6E022D] DEFAULT (0) FOR [ref]
GO

ALTER TABLE [dbo].[tblCourseLinked2] ADD 
	CONSTRAINT [DF__tblCourse__cours__45A94D10] DEFAULT ('PRE') FOR [coursetype],
	CONSTRAINT [DF__tblCourse__audit__469D7149] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourse__item2__1F4E99FE] DEFAULT (0) FOR [item2]
GO

ALTER TABLE [dbo].[tblCourseQuestions] ADD 
	CONSTRAINT [DF__tblCourse__requi__0D64F3ED] DEFAULT ('N') FOR [required]
GO

ALTER TABLE [dbo].[tblDistribution] ADD 
	CONSTRAINT [DF_tblDistribution_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblDistribution_Campus] ON [dbo].[tblDistribution]([campus], [title]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblDocs] ADD 
	CONSTRAINT [DF_tblDocs_type] DEFAULT ('C') FOR [type],
	CONSTRAINT [DF_tblDocs_show] DEFAULT ('Y') FOR [show]
GO

ALTER TABLE [dbo].[tblExtra] ADD 
	CONSTRAINT [DF_tblExtra_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblExtra_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblExtra__rdr__7B9B496D] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblForms] ADD 
	CONSTRAINT [DF__tblForms__auditd__24134F1B] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblGESLO] ADD 
	CONSTRAINT [DF_tblGESLO_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblGenericContent] ADD 
	CONSTRAINT [DF_tblGenericContent_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblGenericContent_AuditDate] DEFAULT (getdate()) FOR [AuditDate],
	CONSTRAINT [DF_tblGenericContent_rdr] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblHelpidx] ADD 
	CONSTRAINT [DF_tblHelpidx_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblINI] ADD 
	CONSTRAINT [DF_tblINI_seq] DEFAULT (0) FOR [seq],
	CONSTRAINT [DF_tblINI_kdate] DEFAULT (getdate()) FOR [kdate]
GO

 CREATE  INDEX [PK_tblINI_KID] ON [dbo].[tblINI]([campus], [kid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblInfo] ADD 
	CONSTRAINT [DF_tblInfo_DatePosted] DEFAULT (getdate()) FOR [DatePosted],
	CONSTRAINT [DF_tblInfo_flag] DEFAULT (0) FOR [flag],
	CONSTRAINT [DF_tblInfo_blink] DEFAULT (0) FOR [blink]
GO

ALTER TABLE [dbo].[tblMail] ADD 
	CONSTRAINT [DF_tblMail_dte] DEFAULT (getdate()) FOR [dte]
GO

 CREATE  INDEX [PK_Misc_Main] ON [dbo].[tblMisc]([campus], [historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_Misc_Key] ON [dbo].[tblMisc]([campus], [coursealpha], [coursenum], [coursetype]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblPDF] ADD 
	CONSTRAINT [DF_tblPDF_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblPDF_User] ON [dbo].[tblPDF]([userid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblPDF_Kix] ON [dbo].[tblPDF]([kix]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblPreReq] ADD 
	CONSTRAINT [DF_tblPreReq_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblPreReq_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblPreReq__rdr__4D7F7902] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblProps] ADD 
	CONSTRAINT [DF_tblProps_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblProps_Campus] ON [dbo].[tblProps]([campus]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblReviewHist] ADD 
	CONSTRAINT [DF_tblReviewHist_dte] DEFAULT (getdate()) FOR [dte],
	CONSTRAINT [DF_tblReviewHist_source] DEFAULT (1) FOR [source]
GO

ALTER TABLE [dbo].[tblReviewHist2] ADD 
	CONSTRAINT [DF_tblReviewHist2_dte] DEFAULT (getdate()) FOR [dte],
	CONSTRAINT [DF_tblReviewHist2_source] DEFAULT (1) FOR [source]
GO

ALTER TABLE [dbo].[tblSLO] ADD 
	CONSTRAINT [DF_tblSLO_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblSLO_Core] ON [dbo].[tblSLO]([campus], [CourseAlpha], [CourseNum], [CourseType]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblStatement] ADD 
	CONSTRAINT [DF_tblStatement_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTasks] ADD 
	CONSTRAINT [DF_tblTasks_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblTempAttach] ADD 
	CONSTRAINT [DF_tblTempAttach_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCampusData] ADD 
	CONSTRAINT [DF_tblTempCampusData_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTempCampusData_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblTempCampusData_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblTempCampusData_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCoReq] ADD 
	CONSTRAINT [DF_tblTempCoReq_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTempCoReq_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempCoRe__rdr__505BE5AD] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTempCourse] ADD 
	CONSTRAINT [DF_tblTempCourse_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tbltempCo__route__290D0E62] DEFAULT (1) FOR [route]
GO

ALTER TABLE [dbo].[tblTempCourseACCJC] ADD 
	CONSTRAINT [DF_tblTempCourseACCJC_AuditDate] DEFAULT (getdate()) FOR [AuditDate]
GO

ALTER TABLE [dbo].[tblTempCourseAssess] ADD 
	CONSTRAINT [DF_tblTempCourseAssess_assessmentid] DEFAULT (0) FOR [assessmentid],
	CONSTRAINT [DF_tblTempCourseAssess_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempCourseComp] ADD 
	CONSTRAINT [DF_tblTempCourseComp_CompID] DEFAULT (0) FOR [CompID],
	CONSTRAINT [DF_tblTempCourseComp_AuditDate] DEFAULT (getdate()) FOR [AuditDate],
	CONSTRAINT [DF__tblTempCour__rdr__542C7691] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTempCourseCompAss] ADD 
	CONSTRAINT [DF_tblTempCourseCompAss_compid] DEFAULT (0) FOR [compid],
	CONSTRAINT [DF_tblTempCourseCompAss_assessmentid] DEFAULT (0) FOR [assessmentid],
	CONSTRAINT [DF_tblTempCourseCompAss_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblTempCourseCompetencyOutline] ON [dbo].[tblTempCourseCompetency]([campus], [coursealpha], [coursenum], [coursetype]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblTempCourseContent] ADD 
	CONSTRAINT [DF_tblTempCourseContent_ContentID] DEFAULT (0) FOR [ContentID],
	CONSTRAINT [DF_tblTempCourseContent_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempCour__rdr__52442E1F] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTempCourseLinked] ADD 
	CONSTRAINT [DF_tblTempCourseLinked_ref] DEFAULT (0) FOR [ref]
GO

ALTER TABLE [dbo].[tblTempCourseLinked2] ADD 
	CONSTRAINT [DF__tblTempCo__cours__4A8DFDBE] DEFAULT ('PRE') FOR [coursetype],
	CONSTRAINT [DF__tblTempCo__audit__4B8221F7] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempCo__item2__2042BE37] DEFAULT (0) FOR [item2]
GO

ALTER TABLE [dbo].[tblTempExtra] ADD 
	CONSTRAINT [DF_tblTempExtra_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTempExtra_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempExtra__rdr__7B9B496D] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTempGESLO] ADD 
	CONSTRAINT [DF_tblTempGESLO_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTempGenericContent] ADD 
	CONSTRAINT [DF_tblTempGenericContent_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTempGenericContent_AuditDate] DEFAULT (getdate()) FOR [AuditDate],
	CONSTRAINT [DF_tblTempGenericContent_rdr] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTempPreReq] ADD 
	CONSTRAINT [DF_tblTempPreReq_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTempPreReq_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempPreR__rdr__4F67C174] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTemplate] ADD 
	CONSTRAINT [DF_tblTemplate_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblTest] ADD 
	CONSTRAINT [DF_tblTest_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTest_dte] DEFAULT (getdate()) FOR [dte]
GO

ALTER TABLE [dbo].[tblUserLog] ADD 
	CONSTRAINT [DF_tblUserLog_datetime] DEFAULT (getdate()) FOR [datetime]
GO

ALTER TABLE [dbo].[tblUsers] ADD 
	CONSTRAINT [DF_tblUsers_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblUsers_UserID] ON [dbo].[tblUsers]([userid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblXRef] ADD 
	CONSTRAINT [DF_tblXRef_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblsyllabus] ADD 
	CONSTRAINT [DF_tblsyllabus_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblsyllabus_UserID] ON [dbo].[tblsyllabus]([userid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblsyllabus_Outline] ON [dbo].[tblsyllabus]([campus], [coursealpha], [coursenum]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblsyllabus_Semester] ON [dbo].[tblsyllabus]([semester]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblsyllabus_Yeer] ON [dbo].[tblsyllabus]([yeer]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[zzzCCCM6100] ADD 
	CONSTRAINT [DF__zzzCCCM6100__id__6DB73E6A] DEFAULT (0) FOR [id],
	CONSTRAINT [DF__zzzCCCM61__Quest__6EAB62A3] DEFAULT (0) FOR [Question_Len]
GO

ALTER TABLE [dbo].[zzzTableINI] ADD 
	CONSTRAINT [DF__zzzTableINI__id__68F2894D] DEFAULT (0) FOR [id],
	CONSTRAINT [DF__zzzTableINI__seq__69E6AD86] DEFAULT (0) FOR [seq]
GO

ALTER TABLE [dbo].[zzzTableINIList] ADD 
	CONSTRAINT [DF__zzzTableINIL__id__642DD430] DEFAULT (0) FOR [id],
	CONSTRAINT [DF__zzzTableINI__seq__6521F869] DEFAULT (0) FOR [seq]
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

/*
	listing of SLOs with progress
 */
CREATE VIEW dbo.vw_SLOByProgress_1
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.historyid, tcc.CourseAlpha, tcc.CourseNum, tc.coursetitle
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourse tc ON tcc.historyid = tc.historyid
WHERE     (tcc.CourseType = 'PRE') OR
                      (tcc.CourseType = 'CUR')
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

CREATE VIEW dbo.vw_ACCJCDescription
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
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

CREATE VIEW dbo.vw_ACCJCDescriptionHAW
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     ('' = 'HAW')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'HIL')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'HON')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'KAP')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'KAU')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'LEE')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'MAN')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'MAU')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'WIN')

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
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N'WOA')

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

CREATE VIEW dbo.vw_ApprovalHistory
AS
SELECT     ta.campus, ta.coursealpha, ta.coursenum, ta.seq, ta.historyid, ta.approver, tu.title, tu.[position], ta.dte, ta.approved, tu.department
FROM         dbo.tblApprovalHist ta, dbo.tblUsers tu
WHERE     ta.approver = tu.userid
UNION
SELECT     campus, coursealpha, coursenum, seq, historyid, approver, 'DISTRIBUTION LIST', 'DISTRIBUTION LIST', dte, approved, ''
FROM         dbo.tblApprovalHist ta
WHERE     approver LIKE '%]'


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Approvers
AS
SELECT TOP 100 PERCENT u.campus, a.approver_seq, a.approver, a.delegated, u.[position], u.division
FROM dbo.tblApprover a, dbo.tblUsers u
WHERE a.approver = u.userid
ORDER BY a.approver_seq


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Approvers2
AS
SELECT     TOP 100 PERCENT *
FROM         (SELECT     a.approverid, a.approver_seq, a.Approver, u.Title, u.Position, u.Department, u.Division, a.delegated, a.campus, a.experimental, 
                                              a.route
                       FROM          tblUsers u, tblApprover a
                       WHERE      u.userid = a.approver
                       UNION
                       SELECT     approverid, approver_seq, approver, 'DISTRIBUTION LIST', 'DISTRIBUTION LIST', '', '', '', campus, '0' AS experimental, route
                       FROM         tblApprover
                       WHERE     approver LIKE '%]') X
ORDER BY campus, approver_seq

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ApproversDivisionChair
AS
SELECT     ta.approver_seq AS Sequence, ta.approver, tu.title, tu.[position], tu.department, tu.campus, ta.route
FROM         dbo.tblApprover ta INNER JOIN
                      dbo.tblUsers tu ON ta.approver = tu.userid
WHERE     (tu.[position] LIKE 'DIVISION%')
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_ApproversNoDivisionChair
AS
SELECT     ta.approver_seq AS Sequence, ta.approver, tu.title, tu.[position], tu.department, tu.campus, ta.route
FROM         dbo.tblApprover ta INNER JOIN
                      dbo.tblUsers tu ON ta.approver = tu.userid
WHERE     (tu.[position] NOT LIKE 'DIVISION%')
UNION
SELECT     approver_seq AS Sequence, approver, 'DISTRIBUTION LIST', 'DISTRIBUTION LIST', '', campus, route
FROM         dbo.tblApprover
WHERE     approver LIKE '%]'



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

CREATE VIEW dbo.vw_CCCM6100ByIDCampusCourse
AS
SELECT     TOP 100 PERCENT course.id, course.campus, course.questionnumber, course.questionseq, course.question, course.include, c61.Question_Friendly, 
                      c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, course.auditby, course.auditdate, course.help, 
                      course.change, course.required
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
                      campus.auditdate, campus.help, 'N' AS change, campus.required
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
                      c61.Question_Friendly, c61.Question_Explain, campus.question, 'N' AS change, campus.required
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
                      c61.Question_Friendly, c61.Question_Explain, course.question, course.include, course.change, course.required
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
                      campus.question, c61.Question_Len AS Length, c61.Question_Max AS Maximum, campus.include, 'N' AS change, c61.type, campus.required
FROM         dbo.tblCampusQuestions campus INNER JOIN
                      dbo.CCCM6100 c61 ON campus.questionnumber = c61.Question_Number AND campus.type = c61.type AND campus.campus = c61.campus
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

CREATE VIEW dbo.vw_CourseItems
AS
SELECT     TOP 100 PERCENT course.id, course.campus, c61.Question_Number, course.questionseq AS Seq, course.question, 
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, course.include, course.change, 
                      course.required
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

CREATE VIEW dbo.vw_EffectiveTerms
AS
SELECT tc.campus,
	tc.historyid,
	tc.CourseAlpha AS Alpha,
	tc.CourseNum As [Number],
	tc.coursetitle As Title,
	bt.TERM_DESCRIPTION AS Term,
	bt.TERM_CODE
FROM         tblCourse tc, BannerTerms bt
WHERE 
tc.effectiveterm = bt.TERM_CODE AND 
tc.coursetype='CUR'


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_GenericContent2Linked
AS
SELECT     tl.historyid, tl.src, tl.seq, tl.id, tl2.item
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblGenericContent tg ON tl.historyid = tg.historyid AND tl.seq = tg.id AND tl.src = tg.src INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_HelpGetContent
AS
SELECT     TOP 100 PERCENT dbo.tblHelpidx.id, dbo.tblHelpidx.category, dbo.tblHelpidx.title, dbo.tblHelpidx.subtitle, dbo.tblHelpidx.auditby, 
                      dbo.tblHelpidx.auditdate, dbo.tblHelp.content
FROM         dbo.tblHelp INNER JOIN
                      dbo.tblHelpidx ON dbo.tblHelp.id = dbo.tblHelpidx.id
ORDER BY dbo.tblHelpidx.category, dbo.tblHelpidx.title


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
SELECT     dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id AS accjcid
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseACCJC ON dbo.tblCourseComp.CompID = dbo.tblCourseACCJC.CompID
GROUP BY dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id, dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum,
                       dbo.tblCourseComp.CourseType, dbo.tblCourseComp.historyid

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

CREATE VIEW dbo.vw_Linked2PSLO
AS
SELECT     dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.dst, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblGenericContent.src AS GenericSource, dbo.tblGenericContent.comments, 
                      dbo.tblGenericContent.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblGenericContent ON dbo.tblCourseLinked2.historyid = dbo.tblGenericContent.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblGenericContent.id
WHERE     (dbo.tblCourseLinked.dst = 'PSLO')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE VIEW dbo.vw_LinkedCompetency
AS
SELECT     campus, historyid, src,seq,
sum(CASE WHEN dst='Assess' THEN id ELSE 0 END) As Assess,
sum(CASE WHEN dst='Content' THEN id ELSE 0 END) As Content,
sum(CASE WHEN dst='MethodEval' THEN id ELSE 0 END) As MethodEval,
sum(CASE WHEN dst='GESLO' THEN id ELSE 0 END) As GESLO
FROM         tblCourseLinked
GROUP BY campus, historyid, src,seq




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedCompetency2Assessment
AS
SELECT     TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tca.assessment AS Content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblCourseAssess tca ON tl2.item = tca.assessmentid
WHERE     (tl.src = 'X43') AND (tl.dst = 'Assess')





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedCompetency2Content
AS
SELECT     TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tcc.LongContent AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblCourseContent tcc ON tl2.item = tcc.ContentID
WHERE     (tl.src = 'X43') AND (tl.dst = 'Content')


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedCompetency2GESLO
AS
SELECT     TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = 'X43') AND (tl.dst = 'GESLO') AND (dbo.tblINI.category = 'GESLO')


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedCompetency2MethodEval
AS
SELECT     TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = 'X43') AND (tl.dst = 'MethodEval') AND (dbo.tblINI.category = 'MethodEval')




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_LinkedCompetency2PSLO
AS
SELECT DISTINCT TOP 100 PERCENT tl.campus, tl.historyid, tl.seq, tl.id, tl2.item, tcc.rdr AS comprdr, tgc.rdr AS pslordr, tl.src AS fromSrc, tgc.src AS toSrc
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.historyid = tl2.historyid AND tl.id = tl2.id INNER JOIN
                      dbo.tblGenericContent tgc ON tl2.historyid = tgc.historyid AND tl2.item = tgc.id INNER JOIN
                      dbo.tblCourseCompetency tcc ON tgc.historyid = tcc.historyid AND tl.seq = tcc.seq
WHERE     (tl.src = 'X43') AND (tl.dst = 'PSLO') AND (tgc.src = 'X72')
ORDER BY tcc.rdr


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_LinkedContent2Compentency
AS
SELECT     content.historyid, content.Campus, content.CourseAlpha, content.CourseNum, content.ContentID, tcl.id AS LinkedID, tcl2.item AS Linked2Item, 
                      comp.content
FROM         dbo.tblCourseContent content INNER JOIN
                      dbo.tblCourseLinked tcl ON content.historyid = tcl.historyid AND content.ContentID = tcl.seq INNER JOIN
                      dbo.tblCourseLinked2 tcl2 ON tcl.id = tcl2.id INNER JOIN
                      dbo.tblCourseCompetency comp ON content.historyid = comp.historyid AND tcl2.item = comp.seq
WHERE     (tcl.src = 'X19') AND (tcl.dst = 'Competency')


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedCountItems
AS
SELECT     tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, COUNT(tl2.item) AS counter
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id
GROUP BY tl.seq, tl.historyid, tl.src, tl.dst, tl.campus, tl.historyid, tl.src, tl.dst


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedSLO2Assessment
AS
SELECT     dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseCompAss.assessmentid, dbo.tblCourseAssess.assessment
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseCompAss ON dbo.tblCourseComp.historyid = dbo.tblCourseCompAss.historyid AND 
                      dbo.tblCourseComp.CompID = dbo.tblCourseCompAss.compid INNER JOIN
                      dbo.tblCourseAssess ON dbo.tblCourseCompAss.assessmentid = dbo.tblCourseAssess.assessmentid


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_LinkedSLO2GESLO
AS
SELECT     TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = 'X18') AND (tl.dst = 'GESLO') AND (dbo.tblINI.category = 'GESLO')

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_LinkedSLO2MethodEval
AS
SELECT     TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = 'X18') AND (tl.dst = 'MethodEval') AND (dbo.tblINI.category = 'MethodEval')


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_OutlineValidation
AS
SELECT 	tc.campus, tc.questionnumber, tc.questionseq, c.Question_Friendly
FROM 		tblCourseQuestions tc INNER JOIN
		CCCM6100 c ON tc.questionnumber = c.Question_Number
WHERE 	(tc.include = 'Y') AND 
		(tc.required = 'Y') AND 
		(c.campus = 'SYS') AND 
		(c.type = 'Course')


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

CREATE VIEW dbo.vw_ReviewerComments
AS
SELECT     tr2.historyid, tr2.campus, tr2.coursealpha, tr2.coursenum, tr2.item, tcq.questionseq, tr2.dte, tr2.reviewer, tr2.comments
FROM         dbo.tblReviewHist2 tr2 INNER JOIN
                      dbo.tblCourseQuestions tcq ON tr2.campus = tcq.campus AND tr2.item = tcq.questionnumber

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

CREATE VIEW dbo.vw_SLO2Assessment
AS
SELECT tcc.historyid, tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcc.CompID, tcca.assessmentid, tca.assessment
FROM tblCourseComp tcc, tblCourseCompAss tcca, tblCourseAssess tca
WHERE tcc.historyid = tcca.historyid AND 
tcc.CompID = tcca.compid AND
tcc.Campus = tca.campus AND 
tcca.assessmentid = tca.assessmentid




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_SLOByProgress_2
AS
SELECT     TOP 100 PERCENT dbo.vw_SLOByProgress_1.historyid, dbo.vw_SLOByProgress_1.Campus, dbo.vw_SLOByProgress_1.CourseAlpha, 
                      dbo.vw_SLOByProgress_1.CourseNum, dbo.vw_SLOByProgress_1.coursetitle, dbo.tblSLO.progress, dbo.tblSLO.auditby AS Proposer
FROM         dbo.vw_SLOByProgress_1 INNER JOIN
                      dbo.tblSLO ON dbo.vw_SLOByProgress_1.historyid = dbo.tblSLO.hid
ORDER BY dbo.vw_SLOByProgress_1.Campus, dbo.vw_SLOByProgress_1.CourseAlpha, dbo.vw_SLOByProgress_1.CourseNum

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
                      c.X15 AS prereq, c.X16 AS coreq, c.X17 AS recprep, c.coursedescr
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

CREATE VIEW dbo.vw_AllQuestions
AS
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(500)) AS question
FROM         dbo.vw_CourseQuestionsYN
WHERE questionseq > 0
UNION
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(500)) AS question
FROM         dbo.vw_CampusQuestionsYN
WHERE questionseq > 0

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
SELECT     historyid, accjcid
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


CREATE VIEW dbo.vw_LinkedCompetency2
AS
SELECT     vw.campus, vw.historyid, vw.src, vw.seq, vw.Assess, vw.GESLO, vw.Content, vw.MethodEval, tcc.content AS Competency
FROM         dbo.vw_LinkedCompetency vw INNER JOIN
                      dbo.tblCourseCompetency tcc ON vw.historyid = tcc.historyid AND vw.seq = tcc.seq


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_Incomplete_Assessment_5
AS
SELECT     accjcid
FROM         dbo.vw_Incomplete_Assessment_3
UNION
SELECT     accjcid
FROM         vw_Incomplete_Assessment_4

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_Incomplete_Assessment_6
AS
SELECT     dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum, dbo.tblCourseComp.CourseType, 
                      dbo.vw_Incomplete_Assessment_1.CompID, dbo.vw_Incomplete_Assessment_1.accjcid, dbo.tblCourseComp.Comp
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.vw_Incomplete_Assessment_5 INNER JOIN
                      dbo.vw_Incomplete_Assessment_1 ON dbo.vw_Incomplete_Assessment_5.accjcid = dbo.vw_Incomplete_Assessment_1.accjcid ON 
                      dbo.tblCourseComp.CompID = dbo.vw_Incomplete_Assessment_1.CompID


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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE qryAppendDefaultQuestions
AS
INSERT INTO tblCourseQuestions (type, campus, questionnumber, question, auditby) 
SELECT CCCM6100.type, CCCM6100.campus, CCCM6100.Question_Number, CCCM6100.CCCM6100, 'THANHG' AS auditby
FROM CCCM6100
WHERE (((CCCM6100.campus)='SYS' Or (CCCM6100.campus)='LEECC')) 

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
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_InsertTempData
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@user varchar(30),
	@type varchar(10)
AS
BEGIN TRANSACTION
INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCoreq 
	SELECT * FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempPreReq
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

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
	@history varchar(18),
	@reviewdate varchar(20)
AS
DECLARE @AseError int
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
EXEC @AseError = sp_ASE_InsertTempData @campus, @alpha, @num, @user, 'CUR'
If @AseError <> 0 GOTO ERR_HANDLER
-- STEP 3: update temp tables
BEGIN TRANSACTION
UPDATE tblTempCourse 
	SET coursetype='ARC',progress='ARCHIVED',proposer=@user,coursedate=@date,historyid=@history
	WHERE coursealpha=@alpha AND coursenum=@num AND campus=@campus
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCoreq 
	SET coursetype='ARC',auditdate=@date,historyid=@history 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempPreReq 
	SET coursetype='ARC',auditdate=@date,historyid=@history 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseComp 
	SET coursetype='ARC',auditdate=@date,historyid=@history 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseContent 
	SET coursetype='ARC',auditdate=@date,historyid=@history 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCampusData 
	SET coursetype='ARC',auditdate=@date,historyid=@history 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseCompAss 
	SET coursetype='ARC',auditdate=@date,historyid=@history 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 4: move CUR to ARC
INSERT INTO tblCourseARC 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 5: delete CUR
DELETE FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblCoReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 6: update from PRE to CUR
UPDATE tblCourse 
	SET coursetype='CUR',progress='APPROVED',edit1='',edit2='',coursedate=@date,auditdate=@date,proposer=@user,reviewdate=@reviewdate 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCampusData 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCoReq 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblPreReq 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseComp 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseContent 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseCompAss 
	SET coursetype='CUR',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 7: move history and clear
INSERT INTO tblApprovalHist2 
	(id,historyid,approvaldate,coursealpha,coursenum,dte,campus,seq,approver,approved,comments ) 
	SELECT tba.id,tba.historyid,@date,tba.coursealpha,tba.coursenum,tba.dte,tba.campus,tba.seq,tba.approver,tba.approved,tba.comments 
	FROM tblApprovalHist tba WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblApprovalHist 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT TRANSACTION
EXEC sp_ASE_TestData @campus, @alpha, @num, 'PRE'
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

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
-- STEP 1: delete from temp tables
EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user
-- STEP 2: prepare cancelled record by moving to CAN
BEGIN TRANSACTION
INSERT INTO tblTempCourse 
	SELECT * FROM tblcourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourse 
	SET coursetype='CAN',progress='CANCELLED',coursedate=@date,proposer=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseCAN 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CAN'
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 3: delete PRE
DELETE FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 4: update to CAN for all supporting data
UPDATE tblCoreq 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblPreReq 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseComp 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseContent 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCampusData 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseCompAss 
	SET coursetype='CAN',auditdate=@date,auditby=@user 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 5: move history
INSERT INTO tblApprovalHist2 ( historyid, approvaldate, coursealpha, coursenum, dte, campus, seq, approver, approved, comments ) 
	SELECT tba.historyid, @date, tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq, tba.approver, tba.approved, tba.comments 
	FROM tblApprovalHist tba 
	WHERE coursealpha=@alpha AND coursenum=@num AND campus=@campus
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblApprovalHist 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 6: move review history
INSERT INTO tblReviewHist2  (historyid, campus, coursealpha, coursenum, item, dte, reviewer, comments) 
	SELECT historyid, campus, coursealpha, coursenum, item, dte, reviewer, comments
	 FROM tblReviewHist
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
DELETE FROM tblReviewHist 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT TRANSACTION
EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineCopy
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(30),
	@history varchar(18),
	@date varchar(20),
	@reason varchar(30)
AS
BEGIN TRANSACTION
-- DELETE from
DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
-- DELETE to
DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
	
-- INSERTS
INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCoreq 
	SELECT * FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempPreReq
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
-- UPDATE to PRE
UPDATE tblTempCourse 
	SET	id=@history,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1',
		proposer=@user,historyid=@history,
		dateproposed=@date,
		auditdate=NULL,
		reviewdate=NULL,
		assessmentdate=NULL,
		coursedate=NULL,
		coursealpha=@toalpha,
		coursenum=@tonum,
		reason=@reason
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCoReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempPreReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseComp 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseContent 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCampusData 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseCompAss 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
-- INSERT 
INSERT INTO tblCourse 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

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
INSERT INTO tblTempCourse 
	SELECT * FROM tblcourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourse 
	SET coursetype='ARC',progress='ARCHIVED',proposer=@user,coursedate=@date,historyid=@history
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseARC 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='ARC'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCoreq 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblPreReq 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseComp 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseContent 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCampusData 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseCompAss 
	SET coursetype='ARC',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT TRANSACTION
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineDelete
	@campus varchar(10),
	@alpha varchar(10),
	@num varchar(10),
	@type varchar(10)
AS
BEGIN TRANSACTION
DELETE FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type	
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
DELETE FROM tblXRef 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype=@type
If @@error <> 0 goto ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

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
DECLARE @AseError int
-- STEP 1: delete from temp tables
EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user
-- STEP 2: copy CUR data to temp
EXEC @AseError = sp_ASE_InsertTempData @campus, @alpha, @num, @user, 'CUR'
If @AseError <> 0 GOTO ERR_HANDLER
-- STEP 3: update CUR to PRe
BEGIN TRANSACTION
UPDATE tblTempCourse 
	SET	id=@history,coursetype='PRE',edit=1,progress='MODIFY',edit0='',edit1='1',edit2='1',
		proposer=@user,historyid=@history,jsid=@jsid,
		dateproposed=@date,
		auditdate=NULL,
		reviewdate=NULL,
		assessmentdate=NULL,
		coursedate=NULL
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='CUR'
If @@ERROR <> 0 GOTO ERR_HANDLER
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
	If @@ERROR <> 0 GOTO ERR_HANDLER
END
UPDATE tblTempCoReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempPreReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseComp 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseContent 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCampusData 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseCompAss 
	SET historyid=@history,coursetype='PRE',auditdate=@date 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num
If @@ERROR <> 0 GOTO ERR_HANDLER
-- STEP 4: move to main tables to be worked on
INSERT INTO tblCourse 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss
	WHERE campus=@campus AND coursealpha=@alpha AND coursenum=@num AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT TRANSACTION
EXEC sp_ASE_TestData @campus, @alpha, @num, 'PRE'
EXEC sp_ASE_DeleteTempData @campus, @alpha, @num, @user
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_OutlineRename
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(50),
	@history varchar(18),
	@date varchar(20)
AS
BEGIN TRANSACTION
UPDATE tblCampusData 
	SET coursealpha=@toalpha,coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCoreq 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCoreq 
	SET coreqalpha=@toalpha, coreqnum=@tonum,historyid=@history
	WHERE campus=@campus AND coreqalpha=@fromalpha AND coreqnum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourse 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseComp 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseCompAss 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblCourseContent 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblPreReq 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblPreReq 
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND prereqalpha=@fromalpha AND prereqnum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblXRef
	SET coursealpha=@toalpha, coursenum=@tonum,historyid=@history
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT TRANSACTION
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_zzz
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(30),
	@history varchar(18),
	@date varchar(20)
AS
BEGIN TRANSACTION
-- DELETE from
DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
-- DELETE to
DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
	
-- INSERTS
INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCoreq 
	SELECT * FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempPreReq
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
-- UPDATE to PRE
UPDATE tblTempCoReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempPreReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseComp 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseContent 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCampusData 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseCompAss 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
-- INSERT 
INSERT INTO tblCourse 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_zzz_01
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(30),
	@history varchar(18),
	@date varchar(20)
AS
BEGIN TRANSACTION
-- DELETE from
DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
-- DELETE to
DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum
	
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_zzz_02
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(30),
	@history varchar(18),
	@date varchar(20)
AS
BEGIN TRANSACTION
-- INSERTS
INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCoreq 
	SELECT * FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempPreReq
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'
If @@error <> 0 goto ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_zzz_03
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(30),
	@history varchar(18),
	@date varchar(20)
AS
BEGIN TRANSACTION
-- UPDATE to PRE
UPDATE tblTempCoReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempPreReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseComp 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseContent 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCampusData 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
UPDATE tblTempCourseCompAss 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE dbo.sp_ASE_zzz_04
	@campus varchar(10),
	@fromalpha varchar(10),
	@fromnum varchar(10),
	@toalpha varchar(10),
	@tonum varchar(10),
	@user varchar(30),
	@history varchar(18),
	@date varchar(20)
AS
BEGIN TRANSACTION
-- INSERT 
INSERT INTO tblCourse 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'
If @@ERROR <> 0 GOTO ERR_HANDLER
COMMIT
RETURN 0
ERR_HANDLER:
   ROLLBACK TRANSACTION
   RETURN -1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE zzzAppendCCCM6100
AS
INSERT INTO CCCM6100 (id, campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain) 
SELECT zzzCCCM6100.id, zzzCCCM6100.campus, zzzCCCM6100.type, zzzCCCM6100.Question_Number, zzzCCCM6100.CCCM6100, zzzCCCM6100.Question_Friendly, zzzCCCM6100.Question_Len, zzzCCCM6100.Question_Max, zzzCCCM6100.Question_Type, zzzCCCM6100.Question_Ini, zzzCCCM6100.Question_Explain
FROM zzzCCCM6100 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE zzzAppendCampusTotblCCCM6100
AS
INSERT INTO CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain) 
SELECT 'HAW' AS Expr1, CCCM6100.type, CCCM6100.Question_Number, CCCM6100.CCCM6100, CCCM6100.Question_Friendly, CCCM6100.Question_Len, CCCM6100.Question_Max, CCCM6100.Question_Type, CCCM6100.Question_Ini, CCCM6100.Question_Explain
FROM CCCM6100
WHERE (((CCCM6100.campus)='LEE')) 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE zzzAppendTblINI
AS
INSERT INTO tblINI (id, seq, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate) 
SELECT zzzTableINI.id, zzzTableINI.seq, zzzTableINI.category, zzzTableINI.campus, zzzTableINI.kid, zzzTableINI.kdesc, zzzTableINI.kval1, zzzTableINI.kval2, zzzTableINI.kval3, zzzTableINI.kval4, zzzTableINI.kval5, zzzTableINI.kedit, zzzTableINI.klanid, zzzTableINI.kdate
FROM zzzTableINI 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE zzzAppendTblINIList
AS
INSERT INTO tblINI (id, category, campus, kid, kdesc, kval1, kval2, kval3, kval4, kval5, kedit, klanid, kdate) 
SELECT zzzTableINIList.id, zzzTableINIList.category, zzzTableINIList.campus, zzzTableINIList.kid, zzzTableINIList.kdesc, zzzTableINIList.kval1, zzzTableINIList.kval2, zzzTableINIList.kval3, zzzTableINIList.kval4, zzzTableINIList.kval5, zzzTableINIList.kedit, zzzTableINIList.klanid, zzzTableINIList.kdate
FROM zzzTableINIList 

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

