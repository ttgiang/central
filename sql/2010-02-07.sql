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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastApproverX]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastApproverX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastDisapproverX]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastDisapproverX]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLOByProgress_2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLOByProgress_2]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastApprover]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastApprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CourseLastDisapprover]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CourseLastDisapprover]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Linked2SLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Linked2SLO]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingCompetency2GESLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingCompetency2GESLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingCompetency2MethodEval]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingCompetency2MethodEval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingCompetency2PSLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingCompetency2PSLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingContent2Competency]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingContent2Competency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingSLO2GESLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingSLO2GESLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingSLO2MethodEval]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingSLO2MethodEval]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_LinkingSLO2PSLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_LinkingSLO2PSLO]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewStatus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewerComments]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewerComments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ReviewerHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ReviewerHistory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLO2Assessment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLO2Assessment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_SLOByProgress_1]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_SLOByProgress_1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_WriteSyllabus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_WriteSyllabus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zvw_AnnBerner]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[zvw_AnnBerner]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zz_Duplicates]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[zz_Duplicates]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusDataCC2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusDataCC2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusDataMAU]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusDataMAU]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseCC2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseCC2]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseMAU]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseMAU]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCourseReport]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCourseReport]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDebug]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDebug]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDegree]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDegree]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDiscipline]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDiscipline]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDistribution]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDistribution]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDivision]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDivision]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblDocs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblDocs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblEmailList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblEmailList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblExtended]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblExtended]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblINIKey]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblINIKey]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblLinkedItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblLinkedItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblLinkedKeys]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblLinkedKeys]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblLists]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblLists]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblLogs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblLogs]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPageHelp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPageHelp]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblRequest]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblRequest]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblRpt]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblRpt]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblSystem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblSystem]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblUploads]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblUploads]
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

CREATE TABLE [dbo].[BANNER] (
	[id] [int] NOT NULL ,
	[INSTITUTION] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_ALPHA] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_NUMBER] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[EFFECTIVE_TERM] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_TITLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_LONG_TITLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_DIVISION] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_DEPT] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CRSE_COLLEGE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MAX_RPT_UNITS] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[REPEAT_LIMIT] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_HIGH] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_LOW] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CREDIT_IND] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_HIGH] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_LOW] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CONT_IND] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_HIGH] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_LOW] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LAB_IND] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_HIGH] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_LOW] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LECT_IND] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_HIGH] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_LOW] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OTH_IND] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerAlpha] (
	[COURSE_ALPHA] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ALPHA_DESCRIPTION] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerCollege] (
	[COLLEGE_CODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[COLL_DESCRIPTION] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerDept] (
	[DEPT_CODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DEPT_DESCRIPTION] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerDivision] (
	[DIVISION_CODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DIVS_DESCRIPTION] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BannerTerms] (
	[TERM_CODE] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TERM_DESCRIPTION] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CCCM6100] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Number] [smallint] NULL ,
	[CCCM6100] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Friendly] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Len] [smallint] NULL ,
	[Question_Max] [smallint] NULL ,
	[Question_Type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Ini] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Explain] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comments] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[approved_by] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[waiting_for] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approval_date] [smalldatetime] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHist] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NOT NULL ,
	[dte] [smalldatetime] NOT NULL ,
	[approver] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[approvaldate] [smalldatetime] NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NOT NULL ,
	[approver] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprover] (
	[approverid] [int] IDENTITY (1, 1) NOT NULL ,
	[approver_seq] [int] NULL ,
	[approver] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[delegated] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[multilevel] [bit] NOT NULL ,
	[department] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addedby] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[experimental] [bit] NULL ,
	[route] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblArea] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[area] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[codedescr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblAssessedData] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[accjcid] [int] NOT NULL ,
	[qid] [int] NOT NULL ,
	[question] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approvedby] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionnumber] [int] NULL ,
	[questionseq] [int] NULL ,
	[question] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblAttach] (
	[id] [numeric](18, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
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
	[category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[version] [smallint] NULL ,
	[fullname] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCampusData] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C3] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C4] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C5] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C6] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C7] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C8] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C9] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C10] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C11] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C12] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C13] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C14] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblCampusDataCC2] (
	[id] [int] NOT NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblCampusDataMAU] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C3] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C4] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C5] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C6] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C7] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C8] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C9] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C10] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C11] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C12] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C13] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C14] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionnumber] [int] NULL ,
	[questionseq] [int] NULL ,
	[question] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[change] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[required] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[helpfile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[audiofile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCoReq] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NULL ,
	[CoreqAlpha] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CoreqNum] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourse] (
	[id] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[Progress] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dispID] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[coursedescr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X65] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [decimal](18, 0) NULL ,
	[votesagainst] [decimal](18, 0) NULL ,
	[votesabstain] [decimal](18, 0) NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseACCJC] (
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

CREATE TABLE [dbo].[tblCourseARC] (
	[id] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Progress] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[coursedescr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X65] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseAssess] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[assessmentid] [int] IDENTITY (1, 1) NOT NULL ,
	[assessment] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCAN] (
	[id] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[Progress] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[coursedescr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X65] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCC2] (
	[id] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[route] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseComp] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CompID] [numeric](10, 0) NULL ,
	[Comp] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[Reviewed] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReviewedDate] [smalldatetime] NULL ,
	[ReviewedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCompAss] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[compid] [numeric](10, 0) NOT NULL ,
	[assessmentid] [numeric](10, 0) NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseCompetency] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [int] NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[content] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseContent] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [numeric](10, 0) NULL ,
	[ShortContent] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LongContent] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblCourseMAU] (
	[id] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[Progress] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dispID] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[coursedescr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X65] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [decimal](18, 0) NULL ,
	[votesagainst] [decimal](18, 0) NULL ,
	[votesabstain] [decimal](18, 0) NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseQuestions] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[questionnumber] [int] NOT NULL ,
	[questionseq] [int] NOT NULL ,
	[question] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[change] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[required] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[helpfile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[audiofile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCourseReport] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Order] [int] NULL ,
	[Question_Number] [smallint] NULL ,
	[Field_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[question] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Indent] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDebug] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[page] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[debug] [bit] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDegree] (
	[degree_id] [decimal](18, 0) NOT NULL ,
	[degree_alpha] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree_title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree_desc] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degree_date] [smalldatetime] NULL ,
	[addedby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[modifiedby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[modifieddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDiscipline] (
	[dispid] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[discipline] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDistribution] (
	[seq] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[title] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[members] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDivision] (
	[divid] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[divisioncode] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[divisionname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblDocs] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filename] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[show] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblEmailList] (
	[seq] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[title] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[members] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblExtended] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[tab] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[friendly] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[key1] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[key2] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[content] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblHelpidx] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[category] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subtitle] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblINI] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[seq] [int] NULL ,
	[category] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[kid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[kdesc] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval3] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval4] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kval5] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kedit] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[klanid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kdate] [smalldatetime] NULL ,
	[note] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblINIKey] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[kid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[options] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[valu] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[html] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblInfo] (
	[id] [numeric](10, 0) NOT NULL ,
	[InfoTitle] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[InfoContent] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DatePosted] [smalldatetime] NULL ,
	[Author] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[flag] [bit] NULL ,
	[blink] [bit] NULL ,
	[startdate] [smalldatetime] NULL ,
	[enddate] [smalldatetime] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[attach] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblJSID] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[page] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[username] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[start] [datetime] NULL ,
	[audit] [datetime] NULL ,
	[enddate] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLevel] (
	[levelid] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[levelname] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLinkedItem] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[linkeditem] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[linkedkey] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[linkeddst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLinkedKeys] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[linkedsrc] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[linkeddst] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[level] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLists] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[src] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[program] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditDate] [smalldatetime] NULL ,
	[auditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblLogs] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[logs] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblMail] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[from] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bcc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subject] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL ,
	[processed] [bit] NULL ,
	[content] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tblPageHelp] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[page] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filename] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPosition] (
	[posid] [decimal](18, 0) NOT NULL ,
	[posname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPreReq] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NULL ,
	[PrereqAlpha] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[PrereqNum] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblRequest] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[request] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[source] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[acktion] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[source] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[acktion] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewers] (
	[Id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblRpt] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptfilename] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rpttitle] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptformat] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptParm1] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptParm2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptParm3] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rptParm4] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblSLO] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[hid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
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
	[saldescr] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblStatement] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[statement] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblSystem] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[named] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[valu] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
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
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submittedfor] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[submittedby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[version] [smallint] NULL ,
	[fullname] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCampusData] (
	[id] [numeric](18, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C3] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C4] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C5] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C6] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C7] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C8] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C9] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C10] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C11] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C12] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C13] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C14] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[C30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NULL ,
	[CoreqAlpha] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoreqNum] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourse] (
	[id] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[Progress] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[coursedescr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hoursperweek] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[excluefromcatalog] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dateproposed] [smalldatetime] NULL ,
	[assessmentdate] [smalldatetime] NULL ,
	[X15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X21] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X22] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X23] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X24] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X25] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X26] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X27] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X28] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X29] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X30] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X31] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X32] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X33] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X34] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X35] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X36] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X37] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X38] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X39] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X40] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X41] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X42] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X43] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X44] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X45] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X46] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X47] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X48] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X49] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X50] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X51] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X52] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X53] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X54] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X55] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X56] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X57] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X58] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X59] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X60] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X61] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X62] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X63] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X64] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X65] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X66] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X67] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X68] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X69] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X70] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X71] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X72] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X73] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X74] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X75] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X76] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X77] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X78] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X79] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X80] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[jsid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votesfor] [numeric](18, 0) NULL ,
	[votesagainst] [numeric](18, 0) NULL ,
	[votesabstain] [numeric](18, 0) NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[assessmentid] [int] NOT NULL ,
	[assessment] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseComp] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CompID] [numeric](10, 0) NULL ,
	[Comp] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[Reviewed] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReviewedDate] [smalldatetime] NULL ,
	[ReviewedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempCourseCompAss] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[compid] [numeric](10, 0) NOT NULL ,
	[assessmentid] [numeric](10, 0) NOT NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ContentID] [numeric](10, 0) NULL ,
	[ShortContent] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LongContent] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [numeric](10, 0) NULL ,
	[PrereqAlpha] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PrereqNum] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTempXRef] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Id] [numeric](10, 0) NULL ,
	[CourseAlphaX] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNumX] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblUploads] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[uploadid] [numeric](18, 0) NULL ,
	[type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[filename] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUserLog] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[userid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[script] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[action] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datetime] [smalldatetime] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUsers] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[userid] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[password] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[uh] [int] NULL ,
	[firstname] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastname] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[fullname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userlevel] [int] NULL ,
	[department] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[salutation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[location] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hours] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[phone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[check] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[position] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastused] [smalldatetime] NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[alphas] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[sendnow] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblUsersX] (
	[id] [int] NOT NULL ,
	[campus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[password] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[uh] [int] NULL ,
	[firstname] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastname] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[fullname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userlevel] [int] NULL ,
	[department] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[division] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[salutation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[location] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hours] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[phone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[check] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[position] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[lastused] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblXRef] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Id] [numeric](10, 0) NOT NULL ,
	[CourseAlphaX] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CourseNumX] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblcampus] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campusdescr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[courseitems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campusitems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[semester] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[yeer] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[textbooks] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[objectives] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[grading] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[disability] [bit] NULL ,
	[auditdate] [smalldatetime] NULL ,
	[attach] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
SELECT     ta.campus, ta.coursealpha, ta.coursenum, ta.seq, ta.historyid, ta.approver, tu.title, tu.[position], ta.dte, ta.approved, tu.department, ta.inviter, ta.role,ta.approver_seq
FROM         dbo.tblApprovalHist ta, dbo.tblUsers tu
WHERE     ta.approver = tu.userid
UNION
SELECT     campus, coursealpha, coursenum, seq, historyid, approver, 'DISTRIBUTION LIST', 'DISTRIBUTION LIST', dte, approved, '', '', '',0
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
WHERE     (tu.[position] LIKE 'D% CHAIR')

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
WHERE     (tu.[position] NOT LIKE 'D% CHAIR')
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
                      course.change, course.required, course.helpfile, course.audiofile
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
                      campus.auditdate, campus.help, 'N' AS change, campus.required, campus.helpfile, campus.audiofile
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
                      c61.Question_Friendly, c61.Question_Explain, campus.question, 'N' AS change, campus.required, campus.helpfile, campus.audiofile
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
                      c61.Question_Friendly, c61.Question_Explain, course.question, course.include, course.change, course.required, course.helpfile, course.audiofile
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
                      dbo.tblHelpidx.auditdate, dbo.tblHelp.content, dbo.tblHelpidx.campus
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


CREATE VIEW dbo.vw_Linked2SLO
AS
SELECT DISTINCT tl.campus, tl.historyid, tl.src, tl.dst, tl.seq AS linkedseq, tl.id AS linkedid, tl2.item AS compid, tl2.item2, tc.Comp, tc.rdr AS comprdr
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.historyid = tl2.historyid AND tl.id = tl2.id INNER JOIN
                      dbo.tblCourseComp tc ON tl2.historyid = tc.historyid AND tl.campus = tc.Campus AND tl2.item = tc.CompID
WHERE     (tl.src = 'X43') AND (tl.dst = 'SLO' OR
                      tl.dst = 'Objectives')


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
SELECT  DISTINCT   campus, historyid, src,seq,
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
SELECT DISTINCT    TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tca.assessment AS Content
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
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tcc.LongContent AS content
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
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
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
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.id AS iniID
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
SELECT  DISTINCT   content.historyid, content.Campus, content.CourseAlpha, content.CourseNum, content.ContentID, tcl.id AS LinkedID, tcl2.item AS Linked2Item, 
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
SELECT  DISTINCT   tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, COUNT(tl2.item) AS counter
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
SELECT DISTINCT    dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseCompAss.assessmentid, dbo.tblCourseAssess.assessment
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
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
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
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.id AS iniID
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



CREATE VIEW dbo.vw_LinkingCompetency2GESLO
AS
SELECT DISTINCT    TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = 'X43') AND (tl.dst = 'GESLO') AND (dbo.tblINI.category = N'GESLO')




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW dbo.vw_LinkingCompetency2MethodEval
AS
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
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



CREATE VIEW dbo.vw_LinkingCompetency2PSLO
AS
SELECT     TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblGenericContent.comments, dbo.tblGenericContent.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblGenericContent ON dbo.tblCourseLinked.historyid = dbo.tblGenericContent.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblGenericContent.id
WHERE     (dbo.tblCourseLinked.src = 'X43') AND (dbo.tblCourseLinked.dst = 'PSLO') AND (dbo.tblGenericContent.src = 'X72')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW dbo.vw_LinkingContent2Competency
AS
SELECT DISTINCT    dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq AS contentid, dbo.tblCourseLinked.dst, 
                      dbo.tblCourseLinked2.item AS competencyseq, dbo.tblCourseCompetency.content, dbo.tblCourseLinked.id AS LinkedID, 
                      dbo.tblCourseCompetency.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblCourseCompetency ON dbo.tblCourseLinked.historyid = dbo.tblCourseCompetency.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblCourseCompetency.seq
WHERE     (dbo.tblCourseLinked.src = 'X19')




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW dbo.vw_LinkingSLO2GESLO
AS
SELECT  DISTINCT  TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblINI.kdesc, dbo.tblINI.kid
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblINI ON dbo.tblCourseLinked.campus = dbo.tblINI.campus AND dbo.tblCourseLinked2.item = dbo.tblINI.id
WHERE     (dbo.tblCourseLinked.src = 'X18') AND (dbo.tblCourseLinked.dst = 'GESLO') AND (dbo.tblINI.category = N'GESLO')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW dbo.vw_LinkingSLO2MethodEval
AS
SELECT  DISTINCT   TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblINI.category, dbo.tblINI.kdesc, dbo.tblINI.kid
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblINI ON dbo.tblCourseLinked.campus = dbo.tblINI.campus AND dbo.tblCourseLinked2.item = dbo.tblINI.id
WHERE     (dbo.tblCourseLinked.src = 'X18') AND (dbo.tblCourseLinked.dst = 'MethodEval') AND (dbo.tblINI.category = N'MethodEval')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW dbo.vw_LinkingSLO2PSLO
AS
SELECT     TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblGenericContent.comments, dbo.tblGenericContent.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblGenericContent ON dbo.tblCourseLinked.historyid = dbo.tblGenericContent.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblGenericContent.id
WHERE     (dbo.tblCourseLinked.src = 'X18') AND (dbo.tblCourseLinked.dst = 'PSLO') AND (dbo.tblGenericContent.src = 'X72')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq



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


CREATE VIEW dbo.vw_ReviewStatus
AS
SELECT     TOP 100 PERCENT dbo.tblReviewers.campus, dbo.tblCourse.CourseAlpha, dbo.tblCourse.CourseNum, dbo.tblReviewers.userid
FROM         dbo.tblCourse INNER JOIN
                      dbo.tblReviewers ON dbo.tblCourse.CourseAlpha = dbo.tblReviewers.coursealpha AND dbo.tblCourse.CourseNum = dbo.tblReviewers.coursenum AND 
                      dbo.tblCourse.campus = dbo.tblReviewers.campus
WHERE     (dbo.tblCourse.Progress = 'REVIEW') OR
                      (dbo.tblCourse.Progress = 'APPROVAL') AND (dbo.tblCourse.subprogress = 'REVIEW_IN_APPROVAL')
ORDER BY dbo.tblCourse.CourseAlpha, dbo.tblCourse.CourseNum, dbo.tblReviewers.userid




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
SELECT     tr2.historyid, tr2.campus, tr2.coursealpha, tr2.coursenum, tr2.item, tcq.questionseq, tr2.dte, tr2.reviewer, tr2.comments, tr2.acktion
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

CREATE VIEW dbo.vw_WriteSyllabus
AS
SELECT     TOP 100 PERCENT c.campus, c.CourseAlpha, c.CourseNum, dbo.BannerDept.DEPT_DESCRIPTION AS division, c.coursetitle AS title, c.credits, 
                      c.X17 AS recprep, c.coursedescr, dbo.tblCampusData.C25 AS prereq, dbo.tblCampusData.C26 AS coreq, c.X15 AS CoursePreReq, 
                      c.X16 AS CourseCoReq
FROM         dbo.tblCourse c INNER JOIN
                      dbo.BannerDept ON c.dispID = dbo.BannerDept.DEPT_CODE INNER JOIN
                      dbo.tblCampusData ON c.historyid = dbo.tblCampusData.historyid
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


CREATE VIEW dbo.zvw_AnnBerner
AS
SELECT     *
FROM         (SELECT     campus, historyid, coursealpha, coursenum, MAX(approver_seq) AS approver_seq, approved
                       FROM          tblApprovalHist
                       GROUP BY campus, historyid, coursealpha, coursenum, approved
                       HAVING      (campus = 'LEE') AND (MAX(approver_seq) = 2) AND (approved = 0)
                       UNION
                       SELECT     campus, historyid, coursealpha, coursenum, MAX(approver_seq) AS approver_seq, approved
                       FROM         tblApprovalHist
                       GROUP BY campus, historyid, coursealpha, coursenum, approved
                       HAVING      (campus = 'LEE') AND (MAX(approver_seq) = 1) AND (approved = 1)) Tbl


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.zz_Duplicates
AS
SELECT     TOP 100 PERCENT campus, CourseAlpha, CourseNum
FROM         (SELECT     historyid, campus, CourseAlpha, CourseNum, CourseType, Progress, auditdate
                       FROM          tblCourse
                       WHERE      (CourseType = 'CUR') AND (Progress = 'APPROVED')) q2
GROUP BY campus, CourseAlpha, CourseNum
HAVING      (COUNT(campus) > 1)
ORDER BY campus, CourseAlpha, CourseNum




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
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(1000)) AS question
FROM         dbo.vw_CourseQuestionsYN
WHERE questionseq > 0
UNION
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(1000)) AS question
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
SELECT  DISTINCT     vw.campus, vw.historyid, vw.src, vw.seq, vw.Assess, vw.GESLO, vw.Content, vw.MethodEval, tcc.content AS Competency
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

