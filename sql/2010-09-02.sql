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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ProgramsApprovalStatus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ProgramsApprovalStatus]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApprovalStatus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApprovalStatus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApprovalsWithoutTasks]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApprovalsWithoutTasks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ApproverHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ApproverHistory]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_AttachedLatestVersion]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_AttachedLatestVersion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDCampusCourse]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDCampusCourse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDCampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDCampusItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100ByIDProgramItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100ByIDProgramItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100_Campus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100_Campus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CCCM6100_Program]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CCCM6100_Program]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Mode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Mode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Mode2]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Mode2]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_OutlineValidation]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_OutlineValidation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ProgramDepartmentChairs]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ProgramDepartmentChairs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ProgramForViewing]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ProgramForViewing]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceCampusItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceCampusItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceCourseItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceCourseItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_ResequenceProgramItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_ResequenceProgramItems]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_programitems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_programitems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_programquestions]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_programquestions]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[forums]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[forums]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[jdbclog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[jdbclog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[messages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[messages]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[programs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[programs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[programsX]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[programsX]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprovalHistX]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprovalHistX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprovalHistXX]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprovalHistXX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprovalHistXXX]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprovalHistXXX]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblApprover]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblApprover]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblArchivedProgram]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblArchivedProgram]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusOutlines]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusOutlines]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblChairs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblChairs]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCurrentProgram]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCurrentProgram]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblMail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblMail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblMisc]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblMisc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblMode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblMode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblMode2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblMode2]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblProgramQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblProgramQuestions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblPrograms]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblPrograms]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblProposedProgram]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblProposedProgram]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblValues]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblValues]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblValuesdata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblValuesdata]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbljobs]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbljobs]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblprogramdegree]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblprogramdegree]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblsyllabus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblsyllabus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbltempPrograms]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbltempPrograms]
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
	[Question_Type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Ini] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Question_Explain] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comments] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rules] [bit] NULL ,
	[rulesform] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[forums] (
	[forum_id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[creator] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requestor] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[forum_name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[forum_description] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[forum_start_date] [datetime] NULL ,
	[forum_grouping] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[jdbclog] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[date] [datetime] NULL ,
	[logger] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[priority] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[messages] (
	[message_id] [int] IDENTITY (1, 1) NOT NULL ,
	[forum_id] [int] NULL ,
	[item] [int] NULL ,
	[thread_id] [int] NULL ,
	[thread_parent] [int] NULL ,
	[thread_level] [int] NULL ,
	[message_author] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message_author_notify] [bit] NULL ,
	[message_timestamp] [datetime] NULL ,
	[message_subject] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message_body] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message_Approved] [bit] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[programs] (
	[key] [int] IDENTITY (1, 1) NOT NULL ,
	[id] [int] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [decimal](18, 0) NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degreeid] [numeric](18, 0) NULL ,
	[divisionid] [numeric](18, 0) NULL ,
	[effectivedate] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[outcomes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[hid] [decimal](18, 0) NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votefor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteagainst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteabstain] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datedeleted] [smalldatetime] NULL ,
	[dateapproved] [smalldatetime] NULL ,
	[regents] [bit] NOT NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[programsX] (
	[key] [int] IDENTITY (1, 1) NOT NULL ,
	[id] [int] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[type] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [decimal](18, 0) NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degreeid] [numeric](18, 0) NULL ,
	[divisionid] [numeric](18, 0) NULL ,
	[effectivedate] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[outcomes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[hid] [decimal](18, 0) NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votefor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteagainst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteabstain] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datedeleted] [smalldatetime] NULL ,
	[dateapproved] [smalldatetime] NULL ,
	[regents] [bit] NOT NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
	[coursealpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NOT NULL ,
	[dte] [smalldatetime] NOT NULL ,
	[approver] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [smallint] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[approvaldate] [smalldatetime] NULL ,
	[coursealpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NOT NULL ,
	[approver] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [smallint] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHistX] (
	[id] [int] NULL ,
	[seq] [int] IDENTITY (1, 1) NOT NULL ,
	[dte] [datetime] NULL ,
	[usr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pos] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHistXX] (
	[id] [int] NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[approver] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [smallint] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approver_seq] [int] NULL ,
	[votesfor] [int] NULL ,
	[votesagainst] [int] NULL ,
	[votesabstain] [int] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblApprovalHistXXX] (
	[id] [int] NULL ,
	[seq] [int] NOT NULL ,
	[dte] [smalldatetime] NULL ,
	[usr] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pos] [nvarchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approved] [bit] NOT NULL ,
	[campus] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[route] [numeric](18, 0) NULL ,
	[availableDate] [smalldatetime] NULL ,
	[startdate] [smalldatetime] NULL ,
	[enddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblArchivedProgram] (
	[id] [numeric](18, 0) NOT NULL ,
	[seq] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[program_id] [numeric](18, 0) NOT NULL ,
	[effectivedate] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[objectives] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[modifiedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[modifieddate] [smalldatetime] NULL ,
	[historyid] [numeric](18, 0) NULL ,
	[proposer] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votefor] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteagainst] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteabstain] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[comments] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datedeleted] [smalldatetime] NULL ,
	[divisioncode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[regents] [bit] NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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

CREATE TABLE [dbo].[tblCampusOutlines] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[category] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetitle] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HAW] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HIL] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HON] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[KAP] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[KAU] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LEE] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MAN] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UHMC] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WIN] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WOA] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HAW_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HIL_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HON_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[KAP_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[KAU_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LEE_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MAN_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UHMC_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WIN_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WOA_2] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
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
	[audiofile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[defalt] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblChairs] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[programid] [int] NOT NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblCoReq] (
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CourseType] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[id] [numeric](10, 0) NULL ,
	[CoreqAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoreqNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NOT NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[consent] [bit] NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
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
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE01] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE02] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE03] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE04] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE05] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE01] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE02] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE03] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE04] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE05] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE01] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE02] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE03] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE04] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE05] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[Comp] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[reviewed] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[revieweddate] [smalldatetime] NULL ,
	[reviewedby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[content] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[LongContent] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[audiofile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[defalt] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tblCurrentProgram] (
	[id] [numeric](18, 0) NOT NULL ,
	[seq] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[program_id] [numeric](18, 0) NOT NULL ,
	[effectivedate] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[objectives] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[modifiedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[modifieddate] [smalldatetime] NULL ,
	[historyid] [numeric](18, 0) NULL ,
	[proposer] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votefor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteagainst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteabstain] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[comments] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datedeleted] [smalldatetime] NULL ,
	[dateapproved] [smalldatetime] NULL ,
	[divisioncode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[regents] [bit] NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[divisioncode] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[divisionname] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[chairname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[delegated] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
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
	[valu] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[linkeddst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[linkedtable] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tblMail] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[from] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[to] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bcc] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subject] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[val] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblMode] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[mode] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[override] [bit] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblMode2] (
	[id] [numeric](18, 0) NOT NULL ,
	[seq] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[item] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionnumber] [numeric](18, 0) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPDF] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[type] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[kix] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[seq] [int] NULL ,
	[field01] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[field02] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [datetime] NULL ,
	[colum] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[PrereqAlpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PrereqNum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Grading] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[consent] [bit] NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblProgramQuestions] (
	[id] [numeric](18, 0) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[questionnumber] [int] NOT NULL ,
	[questionseq] [int] NOT NULL ,
	[question] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[include] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[change] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[help] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[required] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[helpfile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[audiofile] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[defalt] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblPrograms] (
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[type] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [decimal](18, 0) NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degreeid] [numeric](18, 0) NULL ,
	[divisionid] [numeric](18, 0) NULL ,
	[effectivedate] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[outcomes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[hid] [decimal](18, 0) NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votefor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteagainst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteabstain] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datedeleted] [smalldatetime] NULL ,
	[dateapproved] [smalldatetime] NULL ,
	[regents] [bit] NOT NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p14] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblProposedProgram] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[program_id] [numeric](18, 0) NULL ,
	[effectivedate] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[objectives] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addedby] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[addeddate] [smalldatetime] NULL ,
	[modifiedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[modifieddate] [smalldatetime] NULL ,
	[main_edit] [bit] NULL ,
	[program_edit] [bit] NULL ,
	[division_edit] [bit] NULL ,
	[title_edit] [bit] NULL ,
	[descr_edit] [bit] NULL ,
	[effectivedate_edit] [bit] NULL ,
	[regent_edit] [bit] NULL ,
	[objectives_edit] [bit] NULL ,
	[functions_edit] [bit] NULL ,
	[organized_edit] [bit] NULL ,
	[enroll_edit] [bit] NULL ,
	[resources_edit] [bit] NULL ,
	[efficient_edit] [bit] NULL ,
	[effectiveness_edit] [bit] NULL ,
	[proposed_edit] [bit] NULL ,
	[rationale_edit] [bit] NULL ,
	[substantive_edit] [bit] NULL ,
	[articulated_edit] [bit] NULL ,
	[additionalstaff_edit] [bit] NULL ,
	[requiredhours_edit] [bit] NULL ,
	[progress] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposer] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[copied] [bit] NULL ,
	[copiedfrom] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Comments] [varchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DivisionApprove] [bit] NULL ,
	[DivisionDisapprove] [bit] NULL ,
	[DivisionLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DivisionDateApproved] [smalldatetime] NULL ,
	[DivisionComments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CommitteeApprove] [bit] NULL ,
	[CommitteeDisapprove] [bit] NULL ,
	[CommitteeLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CommitteeDateApproved] [smalldatetime] NULL ,
	[CommitteeComments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FacultyApprove] [bit] NULL ,
	[FacultyDisapprove] [bit] NULL ,
	[FacultyLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FacultyDateApproved] [smalldatetime] NULL ,
	[FacultyComments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DeanApprove] [bit] NULL ,
	[DeanDisApprove] [bit] NULL ,
	[DeanLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DeanDateApproved] [smalldatetime] NULL ,
	[DeanComments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ProvostApprove] [bit] NULL ,
	[ProvostDisApprove] [bit] NULL ,
	[ProvostLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ProvostDateApproved] [smalldatetime] NULL ,
	[ProvostComments] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DivVoteFor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DivVoteAgainst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DivVoteAbstain] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[divisioncode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[regents] [bit] NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblProps] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[propname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[propdescr] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subject] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[content] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cc] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblRequest] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[request] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[status] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[userid] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[submitteddate] [smalldatetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist] (
	[id] [numeric](10, 0) IDENTITY (1, 1) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[source] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[acktion] [int] NULL ,
	[enabled] [bit] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblReviewHist2] (
	[id] [numeric](10, 0) NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[item] [int] NULL ,
	[dte] [smalldatetime] NULL ,
	[reviewer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[source] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[acktion] [int] NULL ,
	[enabled] [bit] NULL 
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
	[coursealpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL ,
	[inviter] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[role] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[rdr] [numeric](18, 0) NULL ,
	[consent] [bit] NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
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
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE01] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE02] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE03] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE04] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MESSAGEPAGE05] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[Comp] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Approved] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApprovedDate] [smalldatetime] NULL ,
	[ApprovedBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AuditDate] [smalldatetime] NULL ,
	[AuditBy] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rdr] [numeric](18, 0) NULL ,
	[reviewed] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[revieweddate] [smalldatetime] NULL ,
	[reviewedby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[content] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[LongContent] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
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
	[rdr] [numeric](18, 0) NULL ,
	[consent] [bit] NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
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
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblTemplate] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
	[action] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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

CREATE TABLE [dbo].[tblValues] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[topic] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[subtopic] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[shortdescr] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[longdescr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[valueid] [int] NULL ,
	[seq] [int] NULL ,
	[src] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblValuesdata] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursealpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursenum] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[coursetype] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[X] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[XID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Y] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[YID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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
	[auditby] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[pending] [bit] NULL ,
	[approvedby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[approveddate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblcampus] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[campusdescr] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[courseitems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campusitems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[programitems] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
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

CREATE TABLE [dbo].[tbljobs] (
	[id] [numeric](18, 0) IDENTITY (1, 1) NOT NULL ,
	[job] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[num] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[s1] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[s2] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[s3] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[n1] [numeric](18, 0) NULL ,
	[n2] [numeric](18, 0) NULL ,
	[n3] [numeric](18, 0) NULL ,
	[t1] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[t2] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[t3] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tblprogramdegree] (
	[degreeid] [decimal](18, 0) IDENTITY (1, 1) NOT NULL ,
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[alpha] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[dte] [smalldatetime] NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL 
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

CREATE TABLE [dbo].[tbltempPrograms] (
	[campus] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[historyid] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[type] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[seq] [decimal](18, 0) NULL ,
	[progress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[degreeid] [numeric](18, 0) NOT NULL ,
	[divisionid] [numeric](18, 0) NULL ,
	[effectivedate] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[title] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[descr] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[outcomes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[functions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[organized] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[enroll] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[resources] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[efficient] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[effectiveness] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[proposed] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rationale] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[substantive] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[articulated] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[additionalstaff] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[requiredhours] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditby] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[auditdate] [smalldatetime] NULL ,
	[hid] [decimal](18, 0) NULL ,
	[proposer] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[votefor] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteagainst] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[voteabstain] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reviewdate] [smalldatetime] NULL ,
	[comments] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[datedeleted] [smalldatetime] NULL ,
	[dateapproved] [smalldatetime] NULL ,
	[regents] [bit] NOT NULL ,
	[regentsdate] [smalldatetime] NULL ,
	[route] [int] NULL ,
	[subprogress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit] [bit] NULL ,
	[edit0] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit1] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[edit2] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[reason] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p14] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p15] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p16] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p17] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p18] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p19] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[p20] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[BannerDept] WITH NOCHECK ADD 
	CONSTRAINT [PK_BannerDept] PRIMARY KEY  CLUSTERED 
	(
		[DEPT_CODE]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[forums] WITH NOCHECK ADD 
	CONSTRAINT [PK_forums] PRIMARY KEY  CLUSTERED 
	(
		[forum_id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[jdbclog] WITH NOCHECK ADD 
	CONSTRAINT [PK_jdbclog] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[messages] WITH NOCHECK ADD 
	CONSTRAINT [PK_messages] PRIMARY KEY  CLUSTERED 
	(
		[message_id]
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

ALTER TABLE [dbo].[tblArchivedProgram] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblArchivedProgram] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[seq]
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
		[id],
		[accjcid],
		[qid]
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
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusData] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusData] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusDataMAU] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusDataMAU] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[historyid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusOutlines] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusOutlines] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblCampusQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusQuestions] PRIMARY KEY  CLUSTERED 
	(
		[id]
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
		[id],
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

ALTER TABLE [dbo].[tblCurrentProgram] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCurrentProgram] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDebug] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDebug] PRIMARY KEY  CLUSTERED 
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

ALTER TABLE [dbo].[tblDiscipline] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDiscipline] PRIMARY KEY  CLUSTERED 
	(
		[dispid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDistribution] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDistribution] PRIMARY KEY  CLUSTERED 
	(
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDivision] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDivision] PRIMARY KEY  CLUSTERED 
	(
		[divid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblDocs] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblDocs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblEmailList] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblEmailList] PRIMARY KEY  CLUSTERED 
	(
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblExtended] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblExtended] PRIMARY KEY  CLUSTERED 
	(
		[id]
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
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblFDProgram] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblFD] PRIMARY KEY  CLUSTERED 
	(
		[degree],
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
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
		[historyid],
		[id],
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

ALTER TABLE [dbo].[tblINIKey] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblINIKey] PRIMARY KEY  CLUSTERED 
	(
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

ALTER TABLE [dbo].[tblLinkedItem] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblLinkedItem] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblLinkedKeys] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblLinkedKeys] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblLists] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblLists] PRIMARY KEY  CLUSTERED 
	(
		[id]
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

ALTER TABLE [dbo].[tblMode] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblMode] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblMode2] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblMode2] PRIMARY KEY  CLUSTERED 
	(
		[id],
		[seq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPDF] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPDF] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPageHelp] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPageHelp] PRIMARY KEY  CLUSTERED 
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

ALTER TABLE [dbo].[tblProgramQuestions] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblProgramQuestions] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[type],
		[questionnumber],
		[questionseq]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblPrograms] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblPrograms] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[historyid],
		[type]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblProposedProgram] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblProposedProgram] PRIMARY KEY  CLUSTERED 
	(
		[id]
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

ALTER TABLE [dbo].[tblRpt] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblRpt] PRIMARY KEY  CLUSTERED 
	(
		[id]
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

ALTER TABLE [dbo].[tblSystem] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblSystem] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblTabs] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblTabs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
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
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
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
		[historyid],
		[id],
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

ALTER TABLE [dbo].[tblUploads] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblUploads] PRIMARY KEY  CLUSTERED 
	(
		[id]
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

ALTER TABLE [dbo].[tblValues] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblValues] PRIMARY KEY  CLUSTERED 
	(
		[id]
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
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbljobs] WITH NOCHECK ADD 
	CONSTRAINT [PK_tbljobs] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblprogramdegree] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblprogramdegree] PRIMARY KEY  CLUSTERED 
	(
		[degreeid]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tblsyllabus] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblsyllabus] PRIMARY KEY  CLUSTERED 
	(
		[id]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tbltempPrograms] WITH NOCHECK ADD 
	CONSTRAINT [PK_tbltempPrograms] PRIMARY KEY  CLUSTERED 
	(
		[campus],
		[historyid],
		[type]
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

 CREATE  INDEX [PK_CCCM6100_Main] ON [dbo].[CCCM6100]([campus], [type], [Question_Number]) WITH  FILLFACTOR = 90 ON [PRIMARY]
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

 CREATE  INDEX [PK_tblApproval_Seq] ON [dbo].[tblApproval]([campus], [coursealpha], [coursenum], [approval_seq]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApprovalHist] ADD 
	CONSTRAINT [DF__tblApprov__appro__2779CBAB] DEFAULT (0) FOR [approver_seq],
	CONSTRAINT [DF__tblApprov__votes__7E42ABEE] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF__tblApprov__votes__7F36D027] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF__tblApprov__votes__002AF460] DEFAULT (0) FOR [votesabstain]
GO

 CREATE  INDEX [PK_tblApprovalHist_Main] ON [dbo].[tblApprovalHist]([campus], [coursealpha], [coursenum], [seq]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApprovalHist2] ADD 
	CONSTRAINT [DF__tblApprov__appro__286DEFE4] DEFAULT (0) FOR [approver_seq],
	CONSTRAINT [DF__tblApprov__votes__011F1899] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF__tblApprov__votes__02133CD2] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF__tblApprov__votes__0307610B] DEFAULT (0) FOR [votesabstain]
GO

 CREATE  INDEX [PK_tblApprovalHist2_Main] ON [dbo].[tblApprovalHist2]([campus], [coursealpha], [coursenum], [seq]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblApprovalHistX] ADD 
	CONSTRAINT [DF_tblApprovalHist_campus] DEFAULT ('LCC') FOR [campus]
GO

ALTER TABLE [dbo].[tblApprover] ADD 
	CONSTRAINT [DF_tblApprover_experimental] DEFAULT (0) FOR [experimental],
	CONSTRAINT [DF__tblApprov__route__1EE485AA] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblApprover_campus] ON [dbo].[tblApprover]([campus], [approver_seq]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblArchivedProgram] ADD 
	CONSTRAINT [DF_tblArchivedProgram_campus] DEFAULT ('LCC') FOR [campus]
GO

ALTER TABLE [dbo].[tblAssessedData] ADD 
	CONSTRAINT [DF_tblAssessedData_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblAssessedData_accjcid] DEFAULT (0) FOR [accjcid],
	CONSTRAINT [DF_tblAssessedData_qid] DEFAULT (0) FOR [qid],
	CONSTRAINT [DF_tblAssessedData_auditdate] DEFAULT (getdate()) FOR [auditdate]
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

ALTER TABLE [dbo].[tblCampusDataMAU] ADD 
	CONSTRAINT [DF_tblCampusDataMAU_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblCampusDataMAU_CourseType] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCampusDataMAU_edit1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCampusDataMAU_edit2] DEFAULT (1) FOR [edit2],
	CONSTRAINT [DF_tblCampusDataMAU_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCampusQuestions] ADD 
	CONSTRAINT [DF_tblCampusQuestions_include] DEFAULT ('N') FOR [include],
	CONSTRAINT [DF_tblCampusQuestions_change] DEFAULT ('N') FOR [change],
	CONSTRAINT [DF_tblCampusQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCampus__requi__0ADD8CFD] DEFAULT ('N') FOR [required]
GO

ALTER TABLE [dbo].[tblCoReq] ADD 
	CONSTRAINT [DF_tblCoReq_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblCoReq_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCoReq__rdr__7B9B496D] DEFAULT (0) FOR [rdr],
	CONSTRAINT [DF__tblCoReq__consen__58A712EB] DEFAULT (0) FOR [consent],
	CONSTRAINT [DF__tblCoReq__pendin__5C77A3CF] DEFAULT (0) FOR [pending]
GO

ALTER TABLE [dbo].[tblCourse] ADD 
	CONSTRAINT [DF_tblCourse_CourseType_1] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCourse_edit_1] DEFAULT (1) FOR [edit],
	CONSTRAINT [DF_tblCourse_Progress_1] DEFAULT ('MODIFY') FOR [Progress],
	CONSTRAINT [DF_tblCourse_edit1_1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCourse_edit2_1] DEFAULT (1) FOR [edit2]
GO

 CREATE  INDEX [PK_tblCourse_Main] ON [dbo].[tblCourse]([campus], [CourseAlpha], [CourseNum], [CourseType]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblCourse_Historyid] ON [dbo].[tblCourse]([historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseACCJC] ADD 
	CONSTRAINT [DF_tblCourseACCJC_AuditDate] DEFAULT (getdate()) FOR [AuditDate]
GO

ALTER TABLE [dbo].[tblCourseARC] ADD 
	CONSTRAINT [DF_tblCourseArc_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF_tblCourseARC_excluefromcatalog] DEFAULT (0) FOR [excluefromcatalog],
	CONSTRAINT [DF_tblCourseARC_votesfor] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF_tblCourseARC_votesagainst] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF_tblCourseARC_votesabstain] DEFAULT (0) FOR [votesabstain],
	CONSTRAINT [DF__tblCourse__route__39987BE6] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblCourse_MainARC] ON [dbo].[tblCourseARC]([campus], [CourseAlpha], [CourseNum], [CourseType]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblCourse_HistoryidARC] ON [dbo].[tblCourseARC]([historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseAssess] ADD 
	CONSTRAINT [DF_tblCourseAssess_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseCAN] ADD 
	CONSTRAINT [DF_tblCourseCan_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF_tblCourseCAN_excluefromcatalog] DEFAULT (0) FOR [excluefromcatalog],
	CONSTRAINT [DF_tblCourseCAN_votesfor] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF_tblCourseCAN_votesagainst] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF_tblCourseCAN_votesabstain] DEFAULT (0) FOR [votesabstain],
	CONSTRAINT [DF__tblCourse__route__3A8CA01F] DEFAULT (1) FOR [route]
GO

 CREATE  INDEX [PK_tblCourse_MainCAN] ON [dbo].[tblCourseCAN]([campus], [CourseAlpha], [CourseNum], [CourseType]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblCourse_HistoryidCAN] ON [dbo].[tblCourseCAN]([historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseComp] ADD 
	CONSTRAINT [DF_tblCourseComp_CompID] DEFAULT (0) FOR [CompID],
	CONSTRAINT [DF_tblCourseComp_AuditDate] DEFAULT (getdate()) FOR [AuditDate],
	CONSTRAINT [DF__tblCourseCo__rdr__005FFE8A] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblCourseCompAss] ADD 
	CONSTRAINT [DF_tblCourseCompAss_compid] DEFAULT (0) FOR [compid],
	CONSTRAINT [DF_tblCourseCompAss_assessmentid] DEFAULT (0) FOR [assessmentid],
	CONSTRAINT [DF_tblCourseCompAss_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblCourseCompetency] ADD 
	CONSTRAINT [DF_tblCourseCompetency_AuditDate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourseCo__rdr__024846FC] DEFAULT (0) FOR [rdr]
GO

 CREATE  INDEX [PK_tblCourseCompetencyOutline] ON [dbo].[tblCourseCompetency]([campus], [coursealpha], [coursenum], [coursetype]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCourseContent] ADD 
	CONSTRAINT [DF_tblCourseContent_ContentID] DEFAULT (0) FOR [ContentID],
	CONSTRAINT [DF_tblCourseContent_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourseCo__rdr__7E77B618] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblCourseLinked] ADD 
	CONSTRAINT [DF__tblCourseLi__ref__5FBE24CE] DEFAULT (0) FOR [ref]
GO

ALTER TABLE [dbo].[tblCourseLinked2] ADD 
	CONSTRAINT [DF__tblCourse__cours__5BED93EA] DEFAULT ('PRE') FOR [coursetype],
	CONSTRAINT [DF__tblCourse__audit__5CE1B823] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourse__item2__1ADEEA9C] DEFAULT (0) FOR [item2]
GO

ALTER TABLE [dbo].[tblCourseMAU] ADD 
	CONSTRAINT [DF_tblCourseMAU_CourseType_1] DEFAULT ('PRE') FOR [CourseType],
	CONSTRAINT [DF_tblCourseMAU_edit_1] DEFAULT (1) FOR [edit],
	CONSTRAINT [DF_tblCourseMAU_Progress_1] DEFAULT ('MODIFY') FOR [Progress],
	CONSTRAINT [DF_tblCourseMAU_edit1_1] DEFAULT (1) FOR [edit1],
	CONSTRAINT [DF_tblCourseMAU_edit2_1] DEFAULT (1) FOR [edit2]
GO

ALTER TABLE [dbo].[tblCourseQuestions] ADD 
	CONSTRAINT [DF_tblCourseQuestions_include] DEFAULT ('N') FOR [include],
	CONSTRAINT [DF_tblCourseQuestions_change] DEFAULT ('N') FOR [change],
	CONSTRAINT [DF_tblCourseQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblCourse__requi__0BD1B136] DEFAULT ('N') FOR [required]
GO

ALTER TABLE [dbo].[tblCurrentProgram] ADD 
	CONSTRAINT [DF_tblCurrentProgram_campus] DEFAULT ('LCC') FOR [campus]
GO

ALTER TABLE [dbo].[tblDebug] ADD 
	CONSTRAINT [DF_tblDebug_debug] DEFAULT (0) FOR [debug]
GO

 CREATE  INDEX [PK_tblDebug_Page] ON [dbo].[tblDebug]([page]) WITH  FILLFACTOR = 90 ON [PRIMARY]
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

ALTER TABLE [dbo].[tblEmailList] ADD 
	CONSTRAINT [DF_tblEmailList_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblEmailList_Campus] ON [dbo].[tblEmailList]([campus], [title]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblExtra] ADD 
	CONSTRAINT [DF_tblExtra_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblExtra_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblExtra__rdr__7B9B496D] DEFAULT (0) FOR [rdr],
	CONSTRAINT [DF__tblExtra__pendin__0D1ADB2A] DEFAULT (0) FOR [pending]
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

ALTER TABLE [dbo].[tblInfo] ADD 
	CONSTRAINT [DF_tblInfo_DatePosted] DEFAULT (getdate()) FOR [DatePosted],
	CONSTRAINT [DF_tblInfo_flag] DEFAULT (0) FOR [flag],
	CONSTRAINT [DF_tblInfo_blink] DEFAULT (0) FOR [blink]
GO

 CREATE  INDEX [PK_tblLists_Main] ON [dbo].[tblLists]([campus], [src], [alpha]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblMail] ADD 
	CONSTRAINT [DF_tblMail_dte] DEFAULT (getdate()) FOR [dte],
	CONSTRAINT [DF__tblMail__process__6CE315C2] DEFAULT (0) FOR [processed]
GO

 CREATE  INDEX [PK_tblMail_Campus] ON [dbo].[tblMail]([campus], [id] DESC ) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_Misc_Main] ON [dbo].[tblMisc]([campus], [historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_Misc_Key] ON [dbo].[tblMisc]([campus], [coursealpha], [coursenum], [coursetype]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblMode] ADD 
	CONSTRAINT [DF_tblMode_override] DEFAULT (0) FOR [override]
GO

ALTER TABLE [dbo].[tblPDF] ADD 
	CONSTRAINT [DF_tblPDF_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblPDF_User] ON [dbo].[tblPDF]([userid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblPDF_Kix] ON [dbo].[tblPDF]([kix]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblPageHelpPageCampus] ON [dbo].[tblPageHelp]([page], [campus]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblPreReq] ADD 
	CONSTRAINT [DF_tblPreReq_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblPreReq_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblPreReq__rdr__7AA72534] DEFAULT (0) FOR [rdr],
	CONSTRAINT [DF__tblPreReq__conse__56BECA79] DEFAULT (0) FOR [consent],
	CONSTRAINT [DF__tblPreReq__pendi__5E5FEC41] DEFAULT (0) FOR [pending]
GO

ALTER TABLE [dbo].[tblProgramQuestions] ADD 
	CONSTRAINT [DF_tblProgramQuestions_include] DEFAULT ('N') FOR [include],
	CONSTRAINT [DF_tblProgramQuestions_change] DEFAULT ('N') FOR [change],
	CONSTRAINT [DF_tblProgramQuestions_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

ALTER TABLE [dbo].[tblPrograms] ADD 
	CONSTRAINT [DF_tblPrograms_seq] DEFAULT (0) FOR [seq]
GO

 CREATE  INDEX [PK_tblPrograms_main] ON [dbo].[tblPrograms]([campus], [degreeid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblprograms_historyid] ON [dbo].[tblPrograms]([historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblprograms_view] ON [dbo].[tblPrograms]([campus], [historyid], [type]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblProposedProgram] ADD 
	CONSTRAINT [DF_tblProposedProgram_proposed_edit] DEFAULT (1) FOR [proposed_edit],
	CONSTRAINT [DF_tblProposedProgram_rationale_edit] DEFAULT (1) FOR [rationale_edit],
	CONSTRAINT [DF_tblProposedProgram_substantive_edit] DEFAULT (1) FOR [substantive_edit],
	CONSTRAINT [DF_tblProposedProgram_articulated_edit] DEFAULT (1) FOR [articulated_edit],
	CONSTRAINT [DF_tblProposedProgram_additionalstaff_edit] DEFAULT (1) FOR [additionalstaff_edit],
	CONSTRAINT [DF_tblProposedProgram_campus] DEFAULT ('LCC') FOR [campus]
GO

ALTER TABLE [dbo].[tblProps] ADD 
	CONSTRAINT [DF_tblProps_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblProps_Campus] ON [dbo].[tblProps]([campus], [propname]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblReviewHist] ADD 
	CONSTRAINT [DF_tblReviewHist_dte] DEFAULT (getdate()) FOR [dte],
	CONSTRAINT [DF_tblReviewHist_source] DEFAULT (1) FOR [source],
	CONSTRAINT [DF__tblReview__ackti__73901351] DEFAULT (3) FOR [acktion],
	CONSTRAINT [DF__tblReview__enabl__4A58F394] DEFAULT (0) FOR [enabled]
GO

ALTER TABLE [dbo].[tblReviewHist2] ADD 
	CONSTRAINT [DF_tblReviewHist2_dte] DEFAULT (getdate()) FOR [dte],
	CONSTRAINT [DF_tblReviewHist2_source] DEFAULT (1) FOR [source],
	CONSTRAINT [DF__tblReview__ackti__7484378A] DEFAULT (3) FOR [acktion],
	CONSTRAINT [DF__tblReview__enabl__4B4D17CD] DEFAULT (0) FOR [enabled]
GO

ALTER TABLE [dbo].[tblRpt] ADD 
	CONSTRAINT [DF_tblRpt_campus] DEFAULT ('ALL') FOR [campus],
	CONSTRAINT [DF_tblRpt_rptformat] DEFAULT ('PDF') FOR [rptformat]
GO

ALTER TABLE [dbo].[tblSLO] ADD 
	CONSTRAINT [DF_tblSLO_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_tblSLO_Core] ON [dbo].[tblSLO]([campus], [CourseAlpha], [CourseNum], [CourseType]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblStatement] ADD 
	CONSTRAINT [DF_tblStatement_auditdate] DEFAULT (getdate()) FOR [auditdate]
GO

 CREATE  INDEX [PK_TblTabs_Tab] ON [dbo].[tblTabs]([tab]) WITH  FILLFACTOR = 90 ON [PRIMARY]
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
	CONSTRAINT [DF__tblTempCoRe__rdr__7D8391DF] DEFAULT (0) FOR [rdr],
	CONSTRAINT [DF__tblTempCo__conse__599B3724] DEFAULT (0) FOR [consent],
	CONSTRAINT [DF__tblTempCo__pendi__5D6BC808] DEFAULT (0) FOR [pending]
GO

ALTER TABLE [dbo].[tblTempCourse] ADD 
	CONSTRAINT [DF_tblTempCourse_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF_tblTempCourse_excluefromcatalog] DEFAULT (0) FOR [excluefromcatalog],
	CONSTRAINT [DF_tblTempCourse_votesfor] DEFAULT (0) FOR [votesfor],
	CONSTRAINT [DF_tblTempCourse_votesagainst] DEFAULT (0) FOR [votesagainst],
	CONSTRAINT [DF_tblTempCourse_votesabstain] DEFAULT (0) FOR [votesabstain],
	CONSTRAINT [DF__tbltempCo__route__38A457AD] DEFAULT (1) FOR [route]
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
	CONSTRAINT [DF__tblTempCour__rdr__015422C3] DEFAULT (0) FOR [rdr]
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
	CONSTRAINT [DF__tblTempCour__rdr__7F6BDA51] DEFAULT (0) FOR [rdr]
GO

ALTER TABLE [dbo].[tblTempCourseLinked] ADD 
	CONSTRAINT [DF_tblTempCourseLinked_ref] DEFAULT (0) FOR [ref]
GO

ALTER TABLE [dbo].[tblTempCourseLinked2] ADD 
	CONSTRAINT [DF__tblTempCo__cours__4A8DFDBE] DEFAULT ('PRE') FOR [coursetype],
	CONSTRAINT [DF__tblTempCo__audit__4B8221F7] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempCo__item2__1BD30ED5] DEFAULT (0) FOR [item2]
GO

ALTER TABLE [dbo].[tblTempExtra] ADD 
	CONSTRAINT [DF_tblTempExtra_id] DEFAULT (0) FOR [id],
	CONSTRAINT [DF_tblTempExtra_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblTempExtra__rdr__7B9B496D] DEFAULT (0) FOR [rdr],
	CONSTRAINT [DF__tblTempEx__pendi__0E0EFF63] DEFAULT (0) FOR [pending]
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
	CONSTRAINT [DF__tblTempPreR__rdr__7C8F6DA6] DEFAULT (0) FOR [rdr],
	CONSTRAINT [DF__tblTempPr__conse__57B2EEB2] DEFAULT (0) FOR [consent],
	CONSTRAINT [DF__tblTempPr__pendi__5F54107A] DEFAULT (0) FOR [pending]
GO

ALTER TABLE [dbo].[tblTempXRef] ADD 
	CONSTRAINT [DF__tblTempXR__pendi__5B837F96] DEFAULT (0) FOR [pending]
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

 CREATE  INDEX [PK_tblUserLog_Campus] ON [dbo].[tblUserLog]([campus], [id] DESC ) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblUsers] ADD 
	CONSTRAINT [DF_tblUsers_password] DEFAULT ('c0mp1ex') FOR [password],
	CONSTRAINT [DF_tblUsers_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblusers__sendno__3469B275] DEFAULT (1) FOR [sendnow]
GO

 CREATE  INDEX [PK_tblUsers_UserID] ON [dbo].[tblUsers]([userid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tblValues_Seq] ON [dbo].[tblValues]([campus], [topic], [subtopic], [seq]) ON [PRIMARY]
GO

 CREATE  INDEX [PK_ValuesData2] ON [dbo].[tblValuesdata]([historyid], [X], [Y], [XID], [id]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_ValuesData] ON [dbo].[tblValuesdata]([historyid], [X], [XID], [Y], [id]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblXRef] ADD 
	CONSTRAINT [DF_tblXRef_auditdate] DEFAULT (getdate()) FOR [auditdate],
	CONSTRAINT [DF__tblXRef__pending__5A8F5B5D] DEFAULT (0) FOR [pending]
GO

 CREATE  INDEX [PK_XRefDB_Main] ON [dbo].[tblXRef]([campus], [CourseAlpha], [CourseNum], [CourseType], [CourseAlphaX], [CourseNumX]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tbljobs_historyid] ON [dbo].[tbljobs]([historyid]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [PK_tbljobs_main] ON [dbo].[tbljobs]([campus], [alpha], [num]) WITH  FILLFACTOR = 90 ON [PRIMARY]
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
SELECT     ta.campus, ta.coursealpha, ta.coursenum, ta.seq, ta.historyid, ta.approver, tu.title, tu.[position], ta.dte, ta.approved, tu.department, ta.inviter, ta.role,ta.approver_seq, ta.progress
FROM         dbo.tblApprovalHist ta, dbo.tblUsers tu
WHERE     ta.approver = tu.userid AND progress <> 'RECALLED'
UNION
SELECT     campus, coursealpha, coursenum, seq, historyid, approver, 'DISTRIBUTION LIST', 'DISTRIBUTION LIST', dte, approved, '', '', '',0,''
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

CREATE VIEW dbo.vw_ApprovalStatus
AS
SELECT     TOP 100 PERCENT c.campus, c.id, c.CourseAlpha, c.CourseNum, c.proposer, c.Progress, c.dateproposed, c.auditdate, c.route, c.subprogress, i.kid
FROM         dbo.tblCourse c INNER JOIN
                      dbo.tblINI i ON c.campus = i.campus AND c.route = i.id
WHERE     (c.CourseType = 'PRE') AND (c.route > 0) AND (i.category = 'ApprovalRouting') AND (c.CourseAlpha <> '')
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

CREATE VIEW dbo.vw_ApprovalsWithoutTasks
AS
SELECT     outline
FROM         (	SELECT     rtrim(coursealpha) + '' + rtrim(coursenum) AS outline
		FROM          tblCourse
		WHERE      (progress = 'APPROVAL' OR subprogress = 'REVIEW_IN_APPROVAL') AND coursetype='PRE') tblOutlines
WHERE     (outline NOT IN
                          (SELECT     tasks
                            FROM          (SELECT     rtrim(coursealpha) + '' + rtrim(coursenum) AS tasks
                                                    FROM          tblTasks
                                                    WHERE      (message = 'Approve outline' OR message = 'Review outline')  AND coursetype='PRE') tblTasks))

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
FROM         (SELECT     a.approverid, a.approver_seq, a.Approver, u.Title, u.Position, u.Department, u.Division, a.delegated, a.campus, a.experimental, a.route, 
                                              a.startdate, a.enddate
                       FROM          tblUsers u, tblApprover a
                       WHERE      u.userid = a.approver
                       UNION
                       SELECT     approverid, approver_seq, approver, 'DISTRIBUTION LIST', 'DISTRIBUTION LIST', '', '', '', campus, '0' AS experimental, route, startdate, 
                                             enddate
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

/*
	do not include id column in this view. This view contains the highest version 
	number for each file attached
*/
CREATE VIEW dbo.vw_AttachedLatestVersion
AS
SELECT     TOP 100 PERCENT campus, category, MAX(version) AS version, historyid, fullname
FROM         dbo.tblAttach
GROUP BY fullname, campus, historyid, category, historyid, campus
ORDER BY campus, category, MAX(version)

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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- vw_CCCM6100ByIDProgramCourse
--
CREATE VIEW dbo.vw_CCCM6100ByIDProgramItems
AS
SELECT     TOP 100 PERCENT program.id, program.campus, program.questionnumber, program.questionseq, program.question, program.include, c61.Question_Friendly, 
                      c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, program.auditby, program.auditdate, program.help, 
                      program.change, program.required, program.helpfile, program.audiofile,rules,rulesform,defalt
FROM         dbo.tblprogramQuestions program INNER JOIN
                      dbo.CCCM6100 c61 ON program.questionnumber = c61.Question_Number AND program.type = c61.type
WHERE     (program.type = 'Program')
ORDER BY program.id, program.campus, program.questionnumber

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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

--
-- vw_CCCM6100_Program
--
CREATE VIEW dbo.vw_CCCM6100_Program
AS
SELECT     TOP 100 PERCENT program.campus, program.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, program.question, program.include, program.change, program.required, program.helpfile, program.audiofile,
	c61.rules,c61.rulesform,defalt
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblprogramQuestions program ON c61.Question_Number = program.questionnumber AND c61.type = program.type
WHERE     (c61.campus = 'SYS') AND (program.type = 'Progream')
ORDER BY program.campus, program.questionseq, c61.campus

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
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, course.include, course.change, course.required,
                       c61.campus AS C61Campus
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = 'Course') AND (c61.campus = 'SYS')
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
SELECT     tl.campus, tgc.src, tgc.historyid, tl.src AS fromSrc, tgc.src AS toSrc, tl.dst, tgc.id AS tgcID, tl.seq, tl.id, tl2.id AS [2tlID], tl2.item, tcc.seq AS [2tl2Item], 
							 tcc.rdr AS comprdr
FROM         dbo.tblGenericContent tgc INNER JOIN
							 dbo.tblCourseLinked tl ON tgc.historyid = tl.historyid INNER JOIN
							 dbo.tblCourseLinked2 tl2 ON tgc.historyid = tl2.historyid AND tl.id = tl2.id INNER JOIN
							 dbo.tblCourseCompetency tcc ON tgc.historyid = tcc.historyid AND tl2.item = tcc.seq
WHERE     (tgc.src = 'X72') AND (tl.src = 'X72') AND (tl.dst = 'Competency')

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
SELECT   DISTINCT  TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
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


CREATE VIEW dbo.vw_ProgramDepartmentChairs
AS
SELECT     TOP 100 PERCENT dbo.tblDivision.campus, dbo.tblDivision.divisionname, dbo.tblChairs.coursealpha, dbo.tblDivision.chairname, 
                      dbo.tblChairs.programid, dbo.tblDivision.delegated
FROM         dbo.tblDivision INNER JOIN
                      dbo.tblChairs ON dbo.tblDivision.divid = dbo.tblChairs.programid
ORDER BY dbo.tblDivision.campus, dbo.tblChairs.coursealpha



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

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

CREATE VIEW dbo.vw_ResequenceProgramItems
AS
SELECT     TOP 100 PERCENT tcc.campus, tcc.questionseq, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblProgramQuestions tcc INNER JOIN
                      dbo.CCCM6100 ON tcc.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.type = 'Program') AND (tcc.include = 'Y') AND (dbo.CCCM6100.campus <> 'TTG')
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
SELECT     TOP 100 PERCENT dbo.tblReviewers.campus, dbo.tblCourse.CourseAlpha, dbo.tblCourse.CourseNum, dbo.tblReviewers.userid, 
                      dbo.tblCourse.reviewdate
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

CREATE VIEW dbo.vw_programitems
AS
SELECT     TOP 100 PERCENT course.id, course.campus, c61.Question_Number, course.questionseq AS Seq, course.question, 
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, course.include, course.change, 
                      course.required
FROM         dbo.tblProgramQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = 'Program')
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

CREATE VIEW dbo.vw_programquestions
AS
SELECT     TOP 100 PERCENT program.campus, program.questionseq, dbo.CCCM6100.Question_Number, program.question, 
                      dbo.CCCM6100.Question_Friendly
FROM         dbo.tblProgramQuestions program INNER JOIN
                      dbo.CCCM6100 ON program.questionnumber = dbo.CCCM6100.Question_Number AND program.type = dbo.CCCM6100.type
WHERE     (program.type = N'Program') AND (program.include = 'Y') AND (dbo.CCCM6100.campus <> 'TTG')
ORDER BY program.campus, program.questionseq

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

CREATE VIEW dbo.vw_ProgramsApprovalStatus
AS
SELECT     TOP 100 PERCENT c.campus, c.historyid, c.Program, c.divisionname, c.proposer, c.progress, c.route, c.subprogress, i.kid, c.title, 
                      c.[Effective Date] AS EffectiveDate, c.divisioncode
FROM         dbo.vw_ProgramForViewing c INNER JOIN
                      dbo.tblINI i ON c.campus = i.campus AND c.route = i.id
WHERE     (i.category = 'ApprovalRouting') AND (c.route > 0) AND (c.type = 'PRE')
ORDER BY c.campus, c.Program, c.divisionname

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

