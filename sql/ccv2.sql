USE [master]
GO
/****** Object:  Login [BUILTIN\Administrators]    Script Date: 06/14/2012 14:54:02 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'BUILTIN\Administrators')
CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [BUILTIN\Users]    Script Date: 06/14/2012 14:54:02 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'BUILTIN\Users')
CREATE LOGIN [BUILTIN\Users] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [ccusr]    Script Date: 06/14/2012 14:54:02 ******/
/* For security reasons the login is created disabled and with a random password. */
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ccusr')
CREATE LOGIN [ccusr] WITH PASSWORD=N'}ì§å×_Ç,øïÑc¸`wæ@­ä£.ÌXùv°	¦', DEFAULT_DATABASE=[ccv2], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER LOGIN [ccusr] DISABLE
GO
/****** Object:  Login [NT AUTHORITY\SYSTEM]    Script Date: 06/14/2012 14:54:02 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'NT AUTHORITY\SYSTEM')
CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [THANH\SQLServer2005MSFTEUser$THANH$MSSQLSERVER]    Script Date: 06/14/2012 14:54:02 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'THANH\SQLServer2005MSFTEUser$THANH$MSSQLSERVER')
CREATE LOGIN [THANH\SQLServer2005MSFTEUser$THANH$MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [THANH\SQLServer2005MSSQLUser$THANH$MSSQLSERVER]    Script Date: 06/14/2012 14:54:02 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'THANH\SQLServer2005MSSQLUser$THANH$MSSQLSERVER')
CREATE LOGIN [THANH\SQLServer2005MSSQLUser$THANH$MSSQLSERVER] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO
/****** Object:  Login [ZIPPYS\tgiang]    Script Date: 06/14/2012 14:54:02 ******/
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'ZIPPYS\tgiang')
CREATE LOGIN [ZIPPYS\tgiang] FROM WINDOWS WITH DEFAULT_DATABASE=[ccv2], DEFAULT_LANGUAGE=[us_english]
GO
USE [ccv2]
GO
/****** Object:  User [ccusr]    Script Date: 06/14/2012 14:53:05 ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'ccusr')
CREATE USER [ccusr] FOR LOGIN [ccusr] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblApproval]    Script Date: 06/14/2012 14:45:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblApproval]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblApproval](
	[approval_id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[approval_seq] [int] NOT NULL,
	[coursealpha] [varchar](10) NOT NULL,
	[coursenum] [varchar](10) NOT NULL,
	[approved_by] [varchar](10) NULL,
	[waiting_for] [varchar](10) NULL,
	[status] [varchar](20) NULL,
	[approval_date] [smalldatetime] NULL CONSTRAINT [DF_tblApproval_approval_date]  DEFAULT (getdate()),
	[campus] [varchar](10) NULL,
 CONSTRAINT [PK_tblApproval] PRIMARY KEY CLUSTERED 
(
	[approval_id] ASC,
	[approval_seq] ASC,
	[coursealpha] ASC,
	[coursenum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblApproval]') AND name = N'PK_tblApproval_Seq')
CREATE NONCLUSTERED INDEX [PK_tblApproval_Seq] ON [dbo].[tblApproval] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[approval_seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblApproval]') AND name = N'PK_tblApproval_Status')
CREATE NONCLUSTERED INDEX [PK_tblApproval_Status] ON [dbo].[tblApproval] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempLEESLO]    Script Date: 06/14/2012 14:53:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempLEESLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tempLEESLO](
	[CrsAlphaNum] [varchar](20) NOT NULL,
	[CrsAlpha] [varchar](10) NOT NULL,
	[CrsNo] [varchar](10) NOT NULL,
	[CrsTitle] [varchar](100) NULL,
	[EffectiveTerm] [varchar](255) NULL,
	[ModifiedDate] [varchar](30) NULL,
	[SLO] [text] NULL,
	[historyid] [varchar](18) NOT NULL,
	[lineitem] [char](1) NOT NULL,
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tempLEESLO] PRIMARY KEY CLUSTERED 
(
	[CrsAlpha] ASC,
	[CrsNo] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblApprovalHist]    Script Date: 06/14/2012 14:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblApprovalHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblApprovalHist](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[seq] [int] NOT NULL,
	[dte] [smalldatetime] NOT NULL,
	[approver] [varchar](50) NULL,
	[approved] [smallint] NULL,
	[comments] [text] NULL,
	[approver_seq] [int] NULL CONSTRAINT [DF__tblApprov__appro__2779CBAB]  DEFAULT (0),
	[votesfor] [int] NULL CONSTRAINT [DF__tblApprov__votes__7E42ABEE]  DEFAULT (0),
	[votesagainst] [int] NULL CONSTRAINT [DF__tblApprov__votes__7F36D027]  DEFAULT (0),
	[votesabstain] [int] NULL CONSTRAINT [DF__tblApprov__votes__002AF460]  DEFAULT (0),
	[inviter] [varchar](20) NULL,
	[role] [varchar](20) NULL,
	[progress] [varchar](20) NULL,
 CONSTRAINT [PK_tblApprovalHist] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC,
	[seq] ASC,
	[dte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblApprovalHist]') AND name = N'PK_tblApprovalHist_Historyid')
CREATE NONCLUSTERED INDEX [PK_tblApprovalHist_Historyid] ON [dbo].[tblApprovalHist] 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblApprovalHist]') AND name = N'PK_tblApprovalHist_Main')
CREATE NONCLUSTERED INDEX [PK_tblApprovalHist_Main] ON [dbo].[tblApprovalHist] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblApprovalHist2]    Script Date: 06/14/2012 14:45:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblApprovalHist2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblApprovalHist2](
	[id] [numeric](10, 0) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[approvaldate] [smalldatetime] NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[dte] [smalldatetime] NOT NULL,
	[campus] [varchar](10) NULL,
	[seq] [int] NOT NULL,
	[approver] [varchar](50) NULL,
	[approved] [smallint] NULL,
	[comments] [text] NULL,
	[approver_seq] [int] NULL CONSTRAINT [DF__tblApprov__appro__286DEFE4]  DEFAULT (0),
	[votesfor] [int] NULL CONSTRAINT [DF__tblApprov__votes__011F1899]  DEFAULT (0),
	[votesagainst] [int] NULL CONSTRAINT [DF__tblApprov__votes__02133CD2]  DEFAULT (0),
	[votesabstain] [int] NULL CONSTRAINT [DF__tblApprov__votes__0307610B]  DEFAULT (0),
	[inviter] [varchar](20) NULL,
	[role] [varchar](20) NULL,
	[progress] [varchar](20) NULL,
 CONSTRAINT [PK_tblApprovalHist2] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC,
	[dte] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblApprovalHist2]') AND name = N'PK_tblApprovalHist2_Main')
CREATE NONCLUSTERED INDEX [PK_tblApprovalHist2_Main] ON [dbo].[tblApprovalHist2] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tempLEESLO1]    Script Date: 06/14/2012 14:53:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempLEESLO1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tempLEESLO1](
	[CrsAlphaNum] [varchar](20) NOT NULL,
	[crsalpha] [varchar](10) NULL,
	[crsno] [varchar](10) NULL,
	[CrsTitle] [varchar](100) NULL,
	[EffectiveTerm] [varchar](255) NULL,
	[ModifiedDate] [varchar](30) NULL,
	[SLO] [text] NULL,
	[historyid] [varchar](18) NULL,
	[lineitem] [char](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tempLEESLO2]    Script Date: 06/14/2012 14:53:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempLEESLO2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tempLEESLO2](
	[CrsAlphaNum] [varchar](20) NOT NULL,
	[crsalpha] [varchar](10) NULL,
	[crsno] [varchar](10) NULL,
	[CrsTitle] [varchar](100) NULL,
	[EffectiveTerm] [varchar](255) NULL,
	[ModifiedDate] [varchar](30) NULL,
	[SLO] [text] NULL,
	[historyid] [varchar](18) NULL,
	[lineitem] [char](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblHelp]    Script Date: 06/14/2012 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblHelp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblHelp](
	[id] [numeric](10, 0) NOT NULL,
	[content] [text] NULL,
 CONSTRAINT [PK_tblHelp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[tblHelpidx]    Script Date: 06/14/2012 14:49:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblHelpidx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblHelpidx](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[category] [varchar](15) NULL,
	[title] [varchar](30) NULL,
	[subtitle] [varchar](30) NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblHelpidx_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblHelpidx] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblInfo]    Script Date: 06/14/2012 14:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblInfo](
	[id] [numeric](10, 0) NOT NULL,
	[InfoTitle] [varchar](100) NULL,
	[InfoContent] [text] NULL,
	[DatePosted] [smalldatetime] NULL CONSTRAINT [DF_tblInfo_DatePosted]  DEFAULT (getdate()),
	[Author] [varchar](50) NULL,
	[flag] [bit] NULL CONSTRAINT [DF_tblInfo_flag]  DEFAULT (0),
	[blink] [bit] NULL CONSTRAINT [DF_tblInfo_blink]  DEFAULT (0),
	[startdate] [smalldatetime] NULL,
	[enddate] [smalldatetime] NULL,
	[campus] [varchar](10) NULL,
	[attach] [varchar](250) NULL,
 CONSTRAINT [PK_tblInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[templeeplo]    Script Date: 06/14/2012 14:52:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[templeeplo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[templeeplo](
	[progress] [varchar](20) NULL,
	[degree] [varchar](55) NULL,
	[division] [varchar](123) NULL,
	[title] [varchar](50) NULL,
	[effectivedate] [varchar](20) NULL,
	[LastModified] [varchar](30) NULL,
	[outcomes] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[messages]    Script Date: 06/14/2012 14:45:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[messages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[messages](
	[message_id] [int] NOT NULL,
	[forum_id] [int] NULL,
	[item] [int] NULL,
	[thread_id] [int] NULL,
	[thread_parent] [int] NULL,
	[thread_level] [int] NULL,
	[message_author] [varchar](50) NULL,
	[message_author_notify] [bit] NULL,
	[message_timestamp] [smalldatetime] NULL,
	[message_subject] [varchar](100) NULL,
	[message_body] [text] NULL,
	[message_Approved] [bit] NULL,
	[acktion] [int] NULL,
	[processed] [int] NULL,
	[processeddate] [smalldatetime] NULL,
	[closed] [int] NULL,
	[notified] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAssessedData]    Script Date: 06/14/2012 14:45:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAssessedData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblAssessedData](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL CONSTRAINT [DF_tblAssessedData_CourseType]  DEFAULT ('PRE'),
	[accjcid] [int] NOT NULL CONSTRAINT [DF_tblAssessedData_accjcid]  DEFAULT (0),
	[qid] [int] NOT NULL CONSTRAINT [DF_tblAssessedData_qid]  DEFAULT (0),
	[question] [text] NULL,
	[approvedby] [varchar](15) NULL,
	[approveddate] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblAssessedData_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblAssessedData] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[accjcid] ASC,
	[qid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tempExportPLO]    Script Date: 06/14/2012 14:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tempExportPLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tempExportPLO](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[progress] [varchar](20) NULL,
	[degree] [varchar](100) NULL,
	[division] [varchar](100) NULL,
	[title] [varchar](100) NULL,
	[effectivedate] [varchar](20) NULL,
	[LastModified] [varchar](20) NULL,
	[outcomes] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAssessedDataARC]    Script Date: 06/14/2012 14:46:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAssessedDataARC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblAssessedDataARC](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[accjcid] [int] NULL,
	[qid] [int] NULL,
	[question] [text] NULL,
	[approvedby] [varchar](15) NULL,
	[approveddate] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[forums]    Script Date: 06/14/2012 14:45:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[forums]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[forums](
	[forum_id] [int] NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[creator] [varchar](50) NULL,
	[requestor] [varchar](50) NULL,
	[forum_name] [varchar](100) NULL,
	[forum_description] [text] NULL,
	[forum_start_date] [smalldatetime] NULL,
	[forum_grouping] [char](20) NULL,
	[src] [varchar](50) NULL,
	[counter] [int] NULL,
	[status] [varchar](20) NULL,
	[priority] [int] NULL,
	[auditdate] [smalldatetime] NULL,
	[createddate] [smalldatetime] NULL,
	[edit] [char](1) NULL,
	[auditby] [varchar](50) NULL,
	[xref] [varchar](18) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[program] [varchar](100) NULL,
	[views] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAssessedQuestions]    Script Date: 06/14/2012 14:46:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAssessedQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblAssessedQuestions](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[type] [varchar](10) NULL,
	[questionnumber] [int] NULL,
	[questionseq] [int] NULL,
	[question] [text] NULL,
	[include] [char](1) NULL,
	[help] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblAssessedQuestions_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblAssessedQuestions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[faq]    Script Date: 06/14/2012 14:45:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[faq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[faq](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[category] [varchar](30) NULL,
	[question] [varchar](1000) NULL,
	[answeredseq] [int] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[notify] [bit] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAttach]    Script Date: 06/14/2012 14:46:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAttach]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblAttach](
	[id] [numeric](18, 0) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursetype] [varchar](10) NULL,
	[filedescr] [varchar](100) NULL,
	[filename] [varchar](300) NULL,
	[filesize] [float] NULL,
	[filedate] [datetime] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [datetime] NULL CONSTRAINT [DF_tblAttach_auditdate]  DEFAULT (getdate()),
	[category] [varchar](20) NULL,
	[version] [smallint] NULL,
	[fullname] [varchar](300) NULL,
 CONSTRAINT [PK_tblAttach] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblAttach]') AND name = N'PK_Attach2')
CREATE NONCLUSTERED INDEX [PK_Attach2] ON [dbo].[tblAttach] 
(
	[historyid] ASC,
	[coursealpha] ASC,
	[coursenum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblAttach]') AND name = N'PK_AttachKixCategory')
CREATE NONCLUSTERED INDEX [PK_AttachKixCategory] ON [dbo].[tblAttach] 
(
	[historyid] ASC,
	[category] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblArea]    Script Date: 06/14/2012 14:45:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblArea]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblArea](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[area] [char](10) NULL,
	[code] [varchar](10) NULL,
	[codedescr] [varchar](50) NULL,
 CONSTRAINT [PK_tblArea] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbljobs]    Script Date: 06/14/2012 14:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbljobs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbljobs](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[job] [varchar](50) NULL,
	[historyid] [varchar](18) NULL,
	[campus] [varchar](10) NULL,
	[alpha] [varchar](50) NULL,
	[num] [varchar](50) NULL,
	[type] [char](3) NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[s1] [varchar](50) NULL,
	[s2] [varchar](50) NULL,
	[s3] [varchar](50) NULL,
	[n1] [numeric](18, 0) NULL,
	[n2] [numeric](18, 0) NULL,
	[n3] [numeric](18, 0) NULL,
	[t1] [text] NULL,
	[t2] [text] NULL,
	[t3] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[tbljobs] ADD [proposer] [varchar](50) NULL
ALTER TABLE [dbo].[tbljobs] ADD [subjob] [varchar](50) NULL
ALTER TABLE [dbo].[tbljobs] ADD [route] [int] NULL
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tbljobs]') AND name = N'PK_tbljobs')
ALTER TABLE [dbo].[tbljobs] ADD  CONSTRAINT [PK_tbljobs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tbljobs]') AND name = N'PK_tbljobs_historyid')
CREATE NONCLUSTERED INDEX [PK_tbljobs_historyid] ON [dbo].[tbljobs] 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tbljobs]') AND name = N'PK_tbljobs_main')
CREATE NONCLUSTERED INDEX [PK_tbljobs_main] ON [dbo].[tbljobs] 
(
	[campus] ASC,
	[alpha] ASC,
	[num] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCampusData]    Script Date: 06/14/2012 14:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCampusData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCampusData](
	[id] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblCampusData_id]  DEFAULT (0),
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL CONSTRAINT [DF_tblCampusData_CourseType]  DEFAULT ('PRE'),
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](250) NULL CONSTRAINT [DF_tblCampusData_edit1]  DEFAULT (1),
	[edit2] [varchar](250) NULL CONSTRAINT [DF_tblCampusData_edit2]  DEFAULT (1),
	[C1] [text] NULL,
	[C2] [text] NULL,
	[C3] [text] NULL,
	[C4] [text] NULL,
	[C5] [text] NULL,
	[C6] [text] NULL,
	[C7] [text] NULL,
	[C8] [text] NULL,
	[C9] [text] NULL,
	[C10] [text] NULL,
	[C11] [text] NULL,
	[C12] [text] NULL,
	[C13] [text] NULL,
	[C14] [text] NULL,
	[C15] [text] NULL,
	[C16] [text] NULL,
	[C17] [text] NULL,
	[C18] [text] NULL,
	[C19] [text] NULL,
	[C20] [text] NULL,
	[C21] [text] NULL,
	[C22] [text] NULL,
	[C23] [text] NULL,
	[C24] [text] NULL,
	[C25] [text] NULL,
	[C26] [text] NULL,
	[C27] [text] NULL,
	[C28] [text] NULL,
	[C29] [text] NULL,
	[C30] [text] NULL,
	[jsid] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCampusData_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[C31] [text] NULL,
	[C32] [text] NULL,
	[C33] [text] NULL,
	[C34] [text] NULL,
	[C35] [text] NULL,
	[C36] [text] NULL,
	[C37] [text] NULL,
	[C38] [text] NULL,
	[C39] [text] NULL,
	[C40] [text] NULL,
	[C41] [text] NULL,
	[C42] [text] NULL,
	[C43] [text] NULL,
	[C44] [text] NULL,
	[C45] [text] NULL,
	[C46] [text] NULL,
	[C47] [text] NULL,
	[C48] [text] NULL,
	[C49] [text] NULL,
	[C50] [text] NULL,
	[C51] [text] NULL,
	[C52] [text] NULL,
	[C53] [text] NULL,
	[C54] [text] NULL,
	[C55] [text] NULL,
 CONSTRAINT [PK_tblCampusData] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[answers]    Script Date: 06/14/2012 14:45:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[answers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[answers](
	[id] [numeric](18, 0) NOT NULL,
	[seq] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[score] [int] NULL,
	[answer] [text] NULL,
	[accepted] [bit] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannerAlpha]    Script Date: 06/14/2012 14:45:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BannerAlpha]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BannerAlpha](
	[COURSE_ALPHA] [varchar](10) NOT NULL,
	[ALPHA_DESCRIPTION] [varchar](255) NULL,
 CONSTRAINT [PK_BannerAlpha] PRIMARY KEY CLUSTERED 
(
	[COURSE_ALPHA] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCampusOutlines]    Script Date: 06/14/2012 14:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCampusOutlines]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCampusOutlines](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[category] [varchar](30) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursetype] [varchar](10) NULL,
	[coursetitle] [varchar](100) NULL,
	[HAW] [varchar](18) NULL,
	[HIL] [varchar](18) NULL,
	[HON] [varchar](18) NULL,
	[KAP] [varchar](18) NULL,
	[KAU] [varchar](18) NULL,
	[LEE] [varchar](18) NULL,
	[MAN] [varchar](18) NULL,
	[UHMC] [varchar](18) NULL,
	[WIN] [varchar](18) NULL,
	[WOA] [varchar](18) NULL,
	[HAW_2] [varchar](100) NULL,
	[HIL_2] [varchar](100) NULL,
	[HON_2] [varchar](100) NULL,
	[KAP_2] [varchar](100) NULL,
	[KAU_2] [varchar](100) NULL,
	[LEE_2] [varchar](100) NULL,
	[MAN_2] [varchar](100) NULL,
	[UHMC_2] [varchar](100) NULL,
	[WIN_2] [varchar](100) NULL,
	[WOA_2] [varchar](100) NULL,
 CONSTRAINT [PK_tblCampusOutlines] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblProgramQuestions]    Script Date: 06/14/2012 14:50:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblProgramQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblProgramQuestions](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[type] [varchar](10) NOT NULL,
	[questionnumber] [int] NOT NULL,
	[questionseq] [int] NOT NULL,
	[question] [ntext] NULL,
	[include] [char](1) NULL CONSTRAINT [DF_tblProgramQuestions_include]  DEFAULT ('N'),
	[change] [char](1) NULL CONSTRAINT [DF_tblProgramQuestions_change]  DEFAULT ('N'),
	[help] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblProgramQuestions_auditdate]  DEFAULT (getdate()),
	[required] [char](10) NULL,
	[helpfile] [varchar](250) NULL,
	[audiofile] [varchar](250) NULL,
	[defalt] [text] NULL,
	[comments] [char](1) NULL,
	[len] [int] NULL,
	[counttext] [char](1) NULL,
	[extra] [char](1) NULL,
	[permanent] [char](1) NULL,
	[append] [char](1) NULL,
	[headertext] [text] NULL,
 CONSTRAINT [PK_tblProgramQuestions] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[type] ASC,
	[questionnumber] ASC,
	[questionseq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblccowiq]    Script Date: 06/14/2012 14:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblccowiq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblccowiq](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[topic] [int] NOT NULL,
	[seq] [int] NOT NULL,
	[category] [varchar](30) NULL,
	[header] [varchar](500) NULL,
	[descr] [varchar](500) NULL,
 CONSTRAINT [PK_tblccowiq] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[topic] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCoReq]    Script Date: 06/14/2012 14:46:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCoReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCoReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NOT NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NOT NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblCoReq_id]  DEFAULT (0),
	[CoreqAlpha] [varchar](10) NULL,
	[CoreqNum] [varchar](10) NULL,
	[Grading] [text] NULL,
	[auditdate] [smalldatetime] NOT NULL CONSTRAINT [DF_tblCoReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblCoReq__rdr__7B9B496D]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblCoReq__consen__58A712EB]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblCoReq__pendin__5C77A3CF]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourse]    Script Date: 06/14/2012 14:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourse](
	[id] [varchar](18) NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL CONSTRAINT [DF_tblCourse_CourseType_1]  DEFAULT ('PRE'),
	[edit] [bit] NULL CONSTRAINT [DF_tblCourse_edit_1]  DEFAULT (1),
	[Progress] [varchar](10) NULL CONSTRAINT [DF_tblCourse_Progress_1]  DEFAULT ('MODIFY'),
	[proposer] [varchar](50) NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL CONSTRAINT [DF_tblCourse_edit1_1]  DEFAULT (1),
	[edit2] [varchar](500) NULL CONSTRAINT [DF_tblCourse_edit2_1]  DEFAULT (1),
	[dispID] [char](4) NULL,
	[Division] [char](4) NULL,
	[coursetitle] [varchar](100) NULL,
	[credits] [varchar](20) NULL,
	[repeatable] [bit] NULL,
	[maxcredit] [varchar](20) NULL,
	[articulation] [text] NULL,
	[semester] [varchar](50) NULL,
	[crosslisted] [bit] NULL,
	[coursedate] [smalldatetime] NULL,
	[effectiveterm] [varchar](12) NULL,
	[gradingoptions] [varchar](50) NULL,
	[coursedescr] [text] NULL,
	[hoursperweek] [text] NULL,
	[reviewdate] [smalldatetime] NULL,
	[auditdate] [smalldatetime] NULL,
	[excluefromcatalog] [char](1) NULL,
	[dateproposed] [smalldatetime] NULL,
	[assessmentdate] [smalldatetime] NULL,
	[X15] [text] NULL,
	[X16] [text] NULL,
	[X17] [text] NULL,
	[X18] [text] NULL,
	[X19] [text] NULL,
	[X20] [text] NULL,
	[X21] [text] NULL,
	[X22] [text] NULL,
	[X23] [text] NULL,
	[X24] [text] NULL,
	[X25] [text] NULL,
	[X26] [text] NULL,
	[X27] [text] NULL,
	[X28] [text] NULL,
	[X29] [text] NULL,
	[X30] [text] NULL,
	[X31] [text] NULL,
	[X32] [text] NULL,
	[X33] [text] NULL,
	[X34] [text] NULL,
	[X35] [text] NULL,
	[X36] [text] NULL,
	[X37] [text] NULL,
	[X38] [text] NULL,
	[X39] [text] NULL,
	[X40] [text] NULL,
	[X41] [text] NULL,
	[X42] [text] NULL,
	[X43] [text] NULL,
	[X44] [text] NULL,
	[X45] [text] NULL,
	[X46] [text] NULL,
	[X47] [text] NULL,
	[X48] [text] NULL,
	[X49] [text] NULL,
	[X50] [text] NULL,
	[X51] [text] NULL,
	[X52] [text] NULL,
	[X53] [text] NULL,
	[X54] [text] NULL,
	[X55] [text] NULL,
	[X56] [text] NULL,
	[X57] [text] NULL,
	[X58] [text] NULL,
	[X59] [text] NULL,
	[X60] [text] NULL,
	[X61] [text] NULL,
	[X62] [text] NULL,
	[X63] [text] NULL,
	[X64] [text] NULL,
	[X65] [text] NULL,
	[X66] [text] NULL,
	[X67] [text] NULL,
	[X68] [text] NULL,
	[X69] [text] NULL,
	[X70] [text] NULL,
	[X71] [text] NULL,
	[X72] [text] NULL,
	[X73] [text] NULL,
	[X74] [text] NULL,
	[X75] [text] NULL,
	[X76] [text] NULL,
	[X77] [text] NULL,
	[X78] [text] NULL,
	[X79] [text] NULL,
	[X80] [text] NULL,
	[jsid] [varchar](50) NULL,
	[reason] [text] NULL,
	[votesfor] [decimal](18, 0) NULL,
	[votesagainst] [decimal](18, 0) NULL,
	[votesabstain] [decimal](18, 0) NULL,
	[route] [int] NULL,
	[subprogress] [varchar](20) NULL,
	[MESSAGEPAGE01] [text] NULL,
	[MESSAGEPAGE02] [text] NULL,
	[MESSAGEPAGE03] [text] NULL,
	[MESSAGEPAGE04] [text] NULL,
	[MESSAGEPAGE05] [text] NULL,
	[X81] [text] NULL,
	[X82] [text] NULL,
	[X83] [text] NULL,
	[X84] [text] NULL,
	[X85] [text] NULL,
	[X86] [text] NULL,
	[X87] [text] NULL,
	[X88] [text] NULL,
	[X89] [text] NULL,
	[X90] [text] NULL,
	[X91] [text] NULL,
	[X92] [text] NULL,
	[X93] [text] NULL,
	[X94] [text] NULL,
	[X95] [text] NULL,
	[X96] [text] NULL,
	[X97] [text] NULL,
	[X98] [text] NULL,
	[X99] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourse]') AND name = N'PK_tblCourse_Historyid')
CREATE NONCLUSTERED INDEX [PK_tblCourse_Historyid] ON [dbo].[tblCourse] 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourse]') AND name = N'PK_tblCourse_Main')
CREATE NONCLUSTERED INDEX [PK_tblCourse_Main] ON [dbo].[tblCourse] 
(
	[campus] ASC,
	[CourseAlpha] ASC,
	[CourseNum] ASC,
	[CourseType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourseACCJC]    Script Date: 06/14/2012 14:47:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseACCJC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseACCJC](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[ContentID] [int] NULL,
	[CompID] [int] NULL,
	[Assessmentid] [int] NULL,
	[ApprovedDate] [smalldatetime] NULL,
	[AssessedDate] [smalldatetime] NULL,
	[AssessedBy] [varchar](20) NULL,
	[AuditDate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseACCJC_AuditDate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[historyid] [varchar](18) NOT NULL,
 CONSTRAINT [PK_tblCourseACCJC] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSystem]    Script Date: 06/14/2012 14:50:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSystem](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[named] [varchar](50) NOT NULL,
	[valu] [varchar](100) NULL,
	[descr] [varchar](250) NULL,
 CONSTRAINT [PK_tblSystem] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[named] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseARC]    Script Date: 06/14/2012 14:47:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseARC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseARC](
	[id] [varchar](18) NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[edit] [varchar](500) NULL,
	[Progress] [varchar](10) NULL,
	[proposer] [varchar](50) NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](250) NULL,
	[edit2] [varchar](250) NULL,
	[DispID] [char](4) NULL,
	[Division] [char](4) NULL,
	[coursetitle] [varchar](100) NULL,
	[credits] [varchar](20) NULL,
	[repeatable] [bit] NULL,
	[maxcredit] [varchar](20) NULL,
	[articulation] [text] NULL,
	[semester] [varchar](50) NULL,
	[crosslisted] [bit] NULL,
	[coursedate] [smalldatetime] NULL,
	[effectiveterm] [varchar](12) NULL,
	[gradingoptions] [varchar](50) NULL,
	[coursedescr] [text] NULL,
	[hoursperweek] [text] NULL,
	[reviewdate] [smalldatetime] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseArc_auditdate]  DEFAULT (getdate()),
	[excluefromcatalog] [char](1) NULL CONSTRAINT [DF_tblCourseARC_excluefromcatalog]  DEFAULT (0),
	[dateproposed] [smalldatetime] NULL,
	[assessmentdate] [smalldatetime] NULL,
	[X15] [text] NULL,
	[X16] [text] NULL,
	[X17] [text] NULL,
	[X18] [text] NULL,
	[X19] [text] NULL,
	[X20] [text] NULL,
	[X21] [text] NULL,
	[X22] [text] NULL,
	[X23] [text] NULL,
	[X24] [text] NULL,
	[X25] [text] NULL,
	[X26] [text] NULL,
	[X27] [text] NULL,
	[X28] [text] NULL,
	[X29] [text] NULL,
	[X30] [text] NULL,
	[X31] [text] NULL,
	[X32] [text] NULL,
	[X33] [text] NULL,
	[X34] [text] NULL,
	[X35] [text] NULL,
	[X36] [text] NULL,
	[X37] [text] NULL,
	[X38] [text] NULL,
	[X39] [text] NULL,
	[X40] [text] NULL,
	[X41] [text] NULL,
	[X42] [text] NULL,
	[X43] [text] NULL,
	[X44] [text] NULL,
	[X45] [text] NULL,
	[X46] [text] NULL,
	[X47] [text] NULL,
	[X48] [text] NULL,
	[X49] [text] NULL,
	[X50] [text] NULL,
	[X51] [text] NULL,
	[X52] [text] NULL,
	[X53] [text] NULL,
	[X54] [text] NULL,
	[X55] [text] NULL,
	[X56] [text] NULL,
	[X57] [text] NULL,
	[X58] [text] NULL,
	[X59] [text] NULL,
	[X60] [text] NULL,
	[X61] [text] NULL,
	[X62] [text] NULL,
	[X63] [text] NULL,
	[X64] [text] NULL,
	[X65] [text] NULL,
	[X66] [text] NULL,
	[X67] [text] NULL,
	[X68] [text] NULL,
	[X69] [text] NULL,
	[X70] [text] NULL,
	[X71] [text] NULL,
	[X72] [text] NULL,
	[X73] [text] NULL,
	[X74] [text] NULL,
	[X75] [text] NULL,
	[X76] [text] NULL,
	[X77] [text] NULL,
	[X78] [text] NULL,
	[X79] [text] NULL,
	[X80] [text] NULL,
	[jsid] [varchar](50) NULL,
	[reason] [text] NULL,
	[votesfor] [numeric](18, 0) NULL CONSTRAINT [DF_tblCourseARC_votesfor]  DEFAULT (0),
	[votesagainst] [numeric](18, 0) NULL CONSTRAINT [DF_tblCourseARC_votesagainst]  DEFAULT (0),
	[votesabstain] [numeric](18, 0) NULL CONSTRAINT [DF_tblCourseARC_votesabstain]  DEFAULT (0),
	[route] [int] NULL CONSTRAINT [DF__tblCourse__route__39987BE6]  DEFAULT (1),
	[subprogress] [varchar](20) NULL,
	[MESSAGEPAGE01] [text] NULL,
	[MESSAGEPAGE02] [text] NULL,
	[MESSAGEPAGE03] [text] NULL,
	[MESSAGEPAGE04] [text] NULL,
	[MESSAGEPAGE05] [text] NULL,
	[X81] [text] NULL,
	[X82] [text] NULL,
	[X83] [text] NULL,
	[X84] [text] NULL,
	[X85] [text] NULL,
	[X86] [text] NULL,
	[X87] [text] NULL,
	[X88] [text] NULL,
	[X89] [text] NULL,
	[X90] [text] NULL,
	[X91] [text] NULL,
	[X92] [text] NULL,
	[X93] [text] NULL,
	[X94] [text] NULL,
	[X95] [text] NULL,
	[X96] [text] NULL,
	[X97] [text] NULL,
	[X98] [text] NULL,
	[X99] [text] NULL,
 CONSTRAINT [PK_tblCourseArc] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseARC]') AND name = N'PK_tblCourse_HistoryidARC')
CREATE NONCLUSTERED INDEX [PK_tblCourse_HistoryidARC] ON [dbo].[tblCourseARC] 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseARC]') AND name = N'PK_tblCourse_MainARC')
CREATE NONCLUSTERED INDEX [PK_tblCourse_MainARC] ON [dbo].[tblCourseARC] 
(
	[campus] ASC,
	[CourseAlpha] ASC,
	[CourseNum] ASC,
	[CourseType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourseAssess]    Script Date: 06/14/2012 14:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseAssess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseAssess](
	[historyid] [varchar](18) NULL,
	[campus] [varchar](10) NOT NULL,
	[assessmentid] [int] IDENTITY(1,1) NOT NULL,
	[assessment] [varchar](255) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseAssess_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
 CONSTRAINT [PK_tblCourseAssess] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[assessmentid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTasks]    Script Date: 06/14/2012 14:51:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTasks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTasks](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[submittedfor] [varchar](20) NULL,
	[submittedby] [varchar](20) NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[coursetype] [char](3) NULL,
	[progress] [varchar](20) NULL,
	[message] [varchar](30) NULL,
	[dte] [smalldatetime] NULL CONSTRAINT [DF_tblTasks_dte]  DEFAULT (getdate()),
	[inviter] [varchar](20) NULL,
	[role] [varchar](20) NULL,
	[category] [varchar](20) NULL,
	[historyid] [varchar](18) NULL,
 CONSTRAINT [PK_tblTasks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseCAN]    Script Date: 06/14/2012 14:48:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCAN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseCAN](
	[id] [varchar](18) NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[edit] [bit] NULL,
	[Progress] [varchar](10) NULL,
	[proposer] [varchar](50) NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL,
	[edit2] [varchar](500) NULL,
	[DispID] [char](4) NULL,
	[Division] [char](4) NULL,
	[coursetitle] [varchar](100) NULL,
	[credits] [varchar](20) NULL,
	[repeatable] [bit] NULL,
	[maxcredit] [varchar](20) NULL,
	[articulation] [text] NULL,
	[semester] [varchar](50) NULL,
	[crosslisted] [bit] NULL,
	[coursedate] [smalldatetime] NULL,
	[effectiveterm] [varchar](12) NULL,
	[gradingoptions] [varchar](50) NULL,
	[coursedescr] [text] NULL,
	[hoursperweek] [text] NULL,
	[reviewdate] [smalldatetime] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseCan_auditdate]  DEFAULT (getdate()),
	[excluefromcatalog] [char](1) NULL CONSTRAINT [DF_tblCourseCAN_excluefromcatalog]  DEFAULT (0),
	[dateproposed] [smalldatetime] NULL,
	[assessmentdate] [smalldatetime] NULL,
	[X15] [text] NULL,
	[X16] [text] NULL,
	[X17] [text] NULL,
	[X18] [text] NULL,
	[X19] [text] NULL,
	[X20] [text] NULL,
	[X21] [text] NULL,
	[X22] [text] NULL,
	[X23] [text] NULL,
	[X24] [text] NULL,
	[X25] [text] NULL,
	[X26] [text] NULL,
	[X27] [text] NULL,
	[X28] [text] NULL,
	[X29] [text] NULL,
	[X30] [text] NULL,
	[X31] [text] NULL,
	[X32] [text] NULL,
	[X33] [text] NULL,
	[X34] [text] NULL,
	[X35] [text] NULL,
	[X36] [text] NULL,
	[X37] [text] NULL,
	[X38] [text] NULL,
	[X39] [text] NULL,
	[X40] [text] NULL,
	[X41] [text] NULL,
	[X42] [text] NULL,
	[X43] [text] NULL,
	[X44] [text] NULL,
	[X45] [text] NULL,
	[X46] [text] NULL,
	[X47] [text] NULL,
	[X48] [text] NULL,
	[X49] [text] NULL,
	[X50] [text] NULL,
	[X51] [text] NULL,
	[X52] [text] NULL,
	[X53] [text] NULL,
	[X54] [text] NULL,
	[X55] [text] NULL,
	[X56] [text] NULL,
	[X57] [text] NULL,
	[X58] [text] NULL,
	[X59] [text] NULL,
	[X60] [text] NULL,
	[X61] [text] NULL,
	[X62] [text] NULL,
	[X63] [text] NULL,
	[X64] [text] NULL,
	[X65] [text] NULL,
	[X66] [text] NULL,
	[X67] [text] NULL,
	[X68] [text] NULL,
	[X69] [text] NULL,
	[X70] [text] NULL,
	[X71] [text] NULL,
	[X72] [text] NULL,
	[X73] [text] NULL,
	[X74] [text] NULL,
	[X75] [text] NULL,
	[X76] [text] NULL,
	[X77] [text] NULL,
	[X78] [text] NULL,
	[X79] [text] NULL,
	[X80] [text] NULL,
	[jsid] [varchar](50) NULL,
	[reason] [text] NULL,
	[votesfor] [numeric](18, 0) NULL CONSTRAINT [DF_tblCourseCAN_votesfor]  DEFAULT (0),
	[votesagainst] [numeric](18, 0) NULL CONSTRAINT [DF_tblCourseCAN_votesagainst]  DEFAULT (0),
	[votesabstain] [numeric](18, 0) NULL CONSTRAINT [DF_tblCourseCAN_votesabstain]  DEFAULT (0),
	[route] [int] NULL CONSTRAINT [DF__tblCourse__route__3A8CA01F]  DEFAULT (1),
	[subprogress] [varchar](20) NULL,
	[MESSAGEPAGE01] [text] NULL,
	[MESSAGEPAGE02] [text] NULL,
	[MESSAGEPAGE03] [text] NULL,
	[MESSAGEPAGE04] [text] NULL,
	[MESSAGEPAGE05] [text] NULL,
	[X81] [text] NULL,
	[X82] [text] NULL,
	[X83] [text] NULL,
	[X84] [text] NULL,
	[X85] [text] NULL,
	[X86] [text] NULL,
	[X87] [text] NULL,
	[X88] [text] NULL,
	[X89] [text] NULL,
	[X90] [text] NULL,
	[X91] [text] NULL,
	[X92] [text] NULL,
	[X93] [text] NULL,
	[X94] [text] NULL,
	[X95] [text] NULL,
	[X96] [text] NULL,
	[X97] [text] NULL,
	[X98] [text] NULL,
	[X99] [text] NULL,
 CONSTRAINT [PK_tblCourseCan] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCAN]') AND name = N'PK_tblCourse_HistoryidCAN')
CREATE NONCLUSTERED INDEX [PK_tblCourse_HistoryidCAN] ON [dbo].[tblCourseCAN] 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCAN]') AND name = N'PK_tblCourse_MainCAN')
CREATE NONCLUSTERED INDEX [PK_tblCourse_MainCAN] ON [dbo].[tblCourseCAN] 
(
	[campus] ASC,
	[CourseAlpha] ASC,
	[CourseNum] ASC,
	[CourseType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourseComp]    Script Date: 06/14/2012 14:48:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseComp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseComp](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[CompID] [numeric](10, 0) NULL CONSTRAINT [DF_tblCourseComp_CompID]  DEFAULT (0),
	[Comp] [varchar](1000) NULL,
	[comments] [text] NULL,
	[Approved] [char](1) NULL,
	[ApprovedDate] [smalldatetime] NULL,
	[ApprovedBy] [varchar](20) NULL,
	[AuditDate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseComp_AuditDate]  DEFAULT (getdate()),
	[AuditBy] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblCourseCo__rdr__005FFE8A]  DEFAULT (0),
	[reviewed] [char](1) NULL,
	[revieweddate] [smalldatetime] NULL,
	[reviewedby] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUserLog2]    Script Date: 06/14/2012 14:52:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUserLog2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUserLog2](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NULL,
	[script] [varchar](50) NULL,
	[action] [varchar](500) NULL,
	[alpha] [varchar](50) NULL,
	[num] [varchar](50) NULL,
	[datetime] [smalldatetime] NULL CONSTRAINT [DF_tblUserLog_datetime2]  DEFAULT (getdate()),
	[campus] [varchar](10) NULL,
	[historyid] [varchar](20) NULL,
 CONSTRAINT [PK_tblUserLog2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseCompetency]    Script Date: 06/14/2012 14:48:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCompetency]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseCompetency](
	[historyid] [varchar](18) NOT NULL,
	[seq] [int] NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursetype] [varchar](3) NULL,
	[content] [varchar](1000) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseCompetency_AuditDate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblCourseCo__rdr__024846FC]  DEFAULT (0),
 CONSTRAINT [PK_tblCourseCompetency] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCompetency]') AND name = N'PK_tblCourseCompetencyOutline')
CREATE NONCLUSTERED INDEX [PK_tblCourseCompetencyOutline] ON [dbo].[tblCourseCompetency] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[coursetype] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourseCompAss]    Script Date: 06/14/2012 14:48:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCompAss]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseCompAss](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[compid] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblCourseCompAss_compid]  DEFAULT (0),
	[assessmentid] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblCourseCompAss_assessmentid]  DEFAULT (0),
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseCompAss_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
 CONSTRAINT [PK_tblCourseCompAss] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[compid] ASC,
	[assessmentid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseContent]    Script Date: 06/14/2012 14:48:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseContent](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[ContentID] [numeric](10, 0) NULL CONSTRAINT [DF_tblCourseContent_ContentID]  DEFAULT (0),
	[ShortContent] [varchar](30) NULL,
	[LongContent] [varchar](1000) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseContent_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblCourseCo__rdr__7E77B618]  DEFAULT (0)
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseContentSLO]    Script Date: 06/14/2012 14:48:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseContentSLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseContentSLO](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[contentid] [numeric](10, 0) NOT NULL,
	[sloid] [numeric](10, 0) NOT NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
 CONSTRAINT [PK_tblCourseContentSLO] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[contentid] ASC,
	[sloid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblApprover]    Script Date: 06/14/2012 14:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblApprover]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblApprover](
	[approverid] [int] IDENTITY(1,1) NOT NULL,
	[approver_seq] [int] NULL,
	[approver] [varchar](20) NULL,
	[delegated] [varchar](20) NULL,
	[multilevel] [bit] NOT NULL,
	[department] [char](4) NULL,
	[division] [char](4) NULL,
	[campus] [varchar](50) NULL,
	[addedby] [varchar](10) NULL,
	[addeddate] [smalldatetime] NULL,
	[experimental] [bit] NULL CONSTRAINT [DF_tblApprover_experimental]  DEFAULT (0),
	[route] [numeric](18, 0) NULL CONSTRAINT [DF__tblApprov__route__1EE485AA]  DEFAULT (1),
	[availableDate] [smalldatetime] NULL,
	[startdate] [smalldatetime] NULL,
	[enddate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblApprover] PRIMARY KEY CLUSTERED 
(
	[approverid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblApprover]') AND name = N'PK_tblApprover_campus')
CREATE NONCLUSTERED INDEX [PK_tblApprover_campus] ON [dbo].[tblApprover] 
(
	[campus] ASC,
	[route] ASC,
	[approver_seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblauthority]    Script Date: 06/14/2012 14:46:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblauthority]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblauthority](
	[id] [int] NOT NULL,
	[campus] [varchar](10) NULL,
	[code] [varchar](20) NULL,
	[descr] [varchar](50) NULL,
	[level] [int] NULL,
	[chair] [varchar](50) NULL,
	[delegated] [varchar](50) NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblauthority] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseLinked]    Script Date: 06/14/2012 14:48:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseLinked]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseLinked](
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[src] [char](3) NULL,
	[seq] [int] NULL,
	[dst] [varchar](20) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[coursetype] [char](3) NULL,
	[auditdate] [datetime] NULL,
	[auditby] [varchar](20) NULL,
	[ref] [int] NULL CONSTRAINT [DF__tblCourseLi__ref__5FBE24CE]  DEFAULT (0)
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCampusQuestions]    Script Date: 06/14/2012 14:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCampusQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCampusQuestions](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[type] [varchar](10) NULL,
	[questionnumber] [int] NULL,
	[questionseq] [int] NULL,
	[question] [text] NULL,
	[include] [char](1) NULL CONSTRAINT [DF_tblCampusQuestions_include]  DEFAULT ('N'),
	[change] [char](1) NULL CONSTRAINT [DF_tblCampusQuestions_change]  DEFAULT ('N'),
	[help] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCampusQuestions_auditdate]  DEFAULT (getdate()),
	[required] [char](1) NULL CONSTRAINT [DF__tblCampus__requi__0ADD8CFD]  DEFAULT ('N'),
	[helpfile] [varchar](250) NULL,
	[audiofile] [varchar](250) NULL,
	[defalt] [text] NULL,
	[comments] [char](1) NULL,
	[len] [int] NULL,
	[counttext] [char](1) NULL,
	[extra] [char](1) NULL,
	[permanent] [char](1) NULL,
	[append] [char](1) NULL,
	[headertext] [text] NULL,
 CONSTRAINT [PK_tblCampusQuestions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseLinked2]    Script Date: 06/14/2012 14:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseLinked2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseLinked2](
	[historyid] [varchar](18) NULL,
	[id] [int] NULL,
	[item] [int] NULL,
	[coursetype] [char](3) NULL CONSTRAINT [DF__tblCourse__cours__5BED93EA]  DEFAULT ('PRE'),
	[auditdate] [datetime] NULL CONSTRAINT [DF__tblCourse__audit__5CE1B823]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[item2] [int] NULL CONSTRAINT [DF__tblCourse__item2__1ADEEA9C]  DEFAULT (0)
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCourseQuestions]    Script Date: 06/14/2012 14:48:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseQuestions](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[type] [varchar](10) NOT NULL,
	[questionnumber] [int] NOT NULL,
	[questionseq] [int] NOT NULL,
	[question] [text] NULL,
	[include] [char](1) NULL CONSTRAINT [DF_tblCourseQuestions_include]  DEFAULT ('N'),
	[change] [char](1) NULL CONSTRAINT [DF_tblCourseQuestions_change]  DEFAULT ('N'),
	[help] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCourseQuestions_auditdate]  DEFAULT (getdate()),
	[required] [char](1) NULL CONSTRAINT [DF__tblCourse__requi__0BD1B136]  DEFAULT ('N'),
	[helpfile] [varchar](250) NULL,
	[audiofile] [varchar](250) NULL,
	[defalt] [text] NULL,
	[comments] [char](1) NULL,
	[len] [int] NULL,
	[counttext] [char](1) NULL,
	[extra] [char](1) NULL,
	[permanent] [char](1) NULL,
	[append] [char](1) NULL,
	[headertext] [text] NULL,
 CONSTRAINT [PK_tblCourseQuestions] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[campus] ASC,
	[type] ASC,
	[questionnumber] ASC,
	[questionseq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblReportingStatus]    Script Date: 06/14/2012 14:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblReportingStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblReportingStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NULL,
	[type] [varchar](200) NULL,
	[links] [text] NULL,
	[outline] [varchar](200) NULL,
	[progress] [varchar](200) NULL,
	[proposer] [varchar](200) NULL,
	[curent] [varchar](200) NULL,
	[next] [varchar](200) NULL,
	[proposeddate] [varchar](200) NULL,
	[lastupdated] [varchar](200) NULL,
	[route] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblReportingStatus]') AND name = N'tblReportingStatus_Key')
CREATE NONCLUSTERED INDEX [tblReportingStatus_Key] ON [dbo].[tblReportingStatus] 
(
	[userid] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourseReport]    Script Date: 06/14/2012 14:48:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseReport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseReport](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](255) NULL,
	[Order] [int] NULL,
	[Question_Number] [smallint] NULL,
	[Field_Name] [varchar](255) NULL,
	[question] [text] NULL,
	[Indent] [varchar](255) NULL,
 CONSTRAINT [PK_tblCourseReport] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDebug]    Script Date: 06/14/2012 14:48:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDebug]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDebug](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[page] [varchar](50) NULL,
	[debug] [bit] NULL CONSTRAINT [DF_tblDebug_debug]  DEFAULT (0),
 CONSTRAINT [PK_tblDebug] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblDebug]') AND name = N'PK_tblDebug_Page')
CREATE NONCLUSTERED INDEX [PK_tblDebug_Page] ON [dbo].[tblDebug] 
(
	[page] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDegree]    Script Date: 06/14/2012 14:48:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDegree]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDegree](
	[degree_id] [decimal](18, 0) NOT NULL,
	[degree_alpha] [varchar](2) NULL,
	[degree_title] [varchar](50) NULL,
	[degree_desc] [varchar](250) NULL,
	[degree_date] [smalldatetime] NULL,
	[addedby] [varchar](20) NULL,
	[addeddate] [smalldatetime] NULL,
	[modifiedby] [varchar](20) NULL,
	[modifieddate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblDegree] PRIMARY KEY CLUSTERED 
(
	[degree_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDiscipline]    Script Date: 06/14/2012 14:48:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDiscipline]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDiscipline](
	[dispid] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [char](10) NULL,
	[discipline] [varchar](80) NULL,
 CONSTRAINT [PK_tblDiscipline] PRIMARY KEY CLUSTERED 
(
	[dispid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDistribution]    Script Date: 06/14/2012 14:48:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDistribution]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDistribution](
	[seq] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[title] [varchar](30) NOT NULL,
	[members] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblDistribution_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblDistribution] PRIMARY KEY CLUSTERED 
(
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblDistribution]') AND name = N'PK_tblDistribution_Campus')
CREATE NONCLUSTERED INDEX [PK_tblDistribution_Campus] ON [dbo].[tblDistribution] 
(
	[campus] ASC,
	[title] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDivision]    Script Date: 06/14/2012 14:48:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDivision]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDivision](
	[divid] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[divisioncode] [varchar](20) NULL,
	[divisionname] [varchar](100) NULL,
	[chairname] [varchar](50) NULL,
	[delegated] [varchar](50) NULL,
 CONSTRAINT [PK_tblDivision] PRIMARY KEY CLUSTERED 
(
	[divid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDocs]    Script Date: 06/14/2012 14:48:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDocs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDocs](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[type] [char](1) NULL CONSTRAINT [DF_tblDocs_type]  DEFAULT ('C'),
	[filename] [varchar](50) NULL,
	[show] [char](1) NULL CONSTRAINT [DF_tblDocs_show]  DEFAULT ('Y'),
	[campus] [varchar](10) NULL,
	[alpha] [varchar](10) NULL,
	[num] [varchar](10) NULL,
 CONSTRAINT [PK_tblDocs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblEmailList]    Script Date: 06/14/2012 14:48:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEmailList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEmailList](
	[seq] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[title] [varchar](30) NOT NULL,
	[members] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblEmailList_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblEmailList] PRIMARY KEY CLUSTERED 
(
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEmailList]') AND name = N'PK_tblEmailList_Campus')
CREATE NONCLUSTERED INDEX [PK_tblEmailList_Campus] ON [dbo].[tblEmailList] 
(
	[campus] ASC,
	[title] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblExtra]    Script Date: 06/14/2012 14:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblExtra]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblExtra](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NOT NULL,
	[Src] [varchar](10) NOT NULL,
	[id] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblExtra_id]  DEFAULT (0),
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[Grading] [varchar](50) NULL,
	[auditdate] [smalldatetime] NOT NULL CONSTRAINT [DF_tblExtra_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblExtra__rdr__7B9B496D]  DEFAULT (0),
	[coursetype] [char](3) NULL,
	[pending] [bit] NULL CONSTRAINT [DF__tblExtra__pendin__0D1ADB2A]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblExtra] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[Src] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFDCategory]    Script Date: 06/14/2012 14:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblFDCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblFDCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[degree] [varchar](10) NOT NULL,
	[seq] [int] NOT NULL,
	[category] [varchar](50) NULL,
 CONSTRAINT [PK_tblFDCategory] PRIMARY KEY CLUSTERED 
(
	[degree] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vw_HelpGetContent]    Script Date: 06/14/2012 14:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_HelpGetContent]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_HelpGetContent]
AS
SELECT     TOP 100 PERCENT dbo.tblHelpidx.id, dbo.tblHelpidx.category, dbo.tblHelpidx.title, dbo.tblHelpidx.subtitle, dbo.tblHelpidx.auditby, 
                      dbo.tblHelpidx.auditdate, dbo.tblHelp.content, dbo.tblHelpidx.campus
FROM         dbo.tblHelp INNER JOIN
                      dbo.tblHelpidx ON dbo.tblHelp.id = dbo.tblHelpidx.id
ORDER BY dbo.tblHelpidx.category, dbo.tblHelpidx.title
'
GO
/****** Object:  Table [dbo].[tblFDProgram]    Script Date: 06/14/2012 14:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblFDProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblFDProgram](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[degree] [varchar](10) NOT NULL,
	[seq] [int] NOT NULL,
	[program] [varchar](50) NULL,
 CONSTRAINT [PK_tblFD] PRIMARY KEY CLUSTERED 
(
	[degree] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblGenericContent]    Script Date: 06/14/2012 14:49:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblGenericContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblGenericContent](
	[historyid] [varchar](18) NOT NULL,
	[src] [varchar](10) NOT NULL,
	[id] [numeric](18, 0) NOT NULL CONSTRAINT [DF_tblGenericContent_id]  DEFAULT (0),
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[comments] [text] NULL,
	[AuditDate] [smalldatetime] NULL CONSTRAINT [DF_tblGenericContent_AuditDate]  DEFAULT (getdate()),
	[AuditBy] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NOT NULL CONSTRAINT [DF_tblGenericContent_rdr]  DEFAULT (0),
 CONSTRAINT [PK_tblGenericContent] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[id] ASC,
	[src] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblGESLO]    Script Date: 06/14/2012 14:49:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblGESLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblGESLO](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[geid] [int] NOT NULL,
	[slolevel] [int] NULL,
	[sloevals] [varchar](200) NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblGESLO_auditdate]  DEFAULT (getdate()),
	[coursetype] [char](3) NULL,
 CONSTRAINT [PK_tblGESLO] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[historyid] ASC,
	[geid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblcampus]    Script Date: 06/14/2012 14:46:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblcampus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblcampus](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[campusdescr] [varchar](50) NULL,
	[courseitems] [text] NULL,
	[campusitems] [text] NULL,
	[programitems] [text] NULL,
 CONSTRAINT [PK_tblcampus] PRIMARY KEY CLUSTERED 
(
	[campus] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblExtended]    Script Date: 06/14/2012 14:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblExtended]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblExtended](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tab] [varchar](30) NULL,
	[friendly] [varchar](15) NULL,
	[key1] [varchar](15) NULL,
	[key2] [varchar](15) NULL,
 CONSTRAINT [PK_tblExtended] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblForms]    Script Date: 06/14/2012 14:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblForms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblForms](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[title] [varchar](50) NULL,
	[link] [varchar](250) NULL,
	[descr] [text] NULL,
	[auditdate] [datetime] NULL CONSTRAINT [DF__tblForms__auditd__24134F1B]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[coursetype] [char](3) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblINI]    Script Date: 06/14/2012 14:49:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblINI]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblINI](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[seq] [int] NULL CONSTRAINT [DF_tblINI_seq]  DEFAULT (0),
	[category] [varchar](30) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[kid] [varchar](50) NOT NULL,
	[kdesc] [varchar](250) NULL,
	[kval1] [varchar](255) NULL,
	[kval2] [varchar](255) NULL,
	[kval3] [varchar](255) NULL,
	[kval4] [varchar](255) NULL,
	[kval5] [varchar](255) NULL,
	[kedit] [char](1) NULL,
	[klanid] [varchar](50) NULL,
	[kdate] [smalldatetime] NULL CONSTRAINT [DF_tblINI_kdate]  DEFAULT (getdate()),
	[note] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[tblINI] ADD [script] [varchar](50) NULL
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblINI]') AND name = N'PK_tblINI')
ALTER TABLE [dbo].[tblINI] ADD  CONSTRAINT [PK_tblINI] PRIMARY KEY CLUSTERED 
(
	[category] ASC,
	[campus] ASC,
	[kid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblJSID]    Script Date: 06/14/2012 14:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblJSID]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblJSID](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[jsid] [varchar](50) NOT NULL,
	[campus] [varchar](10) NULL,
	[page] [varchar](20) NULL,
	[alpha] [varchar](10) NULL,
	[num] [varchar](10) NULL,
	[type] [char](3) NULL,
	[username] [varchar](30) NULL,
	[start] [datetime] NULL,
	[audit] [datetime] NULL,
	[enddate] [datetime] NULL,
 CONSTRAINT [PK_tblJSID] PRIMARY KEY CLUSTERED 
(
	[jsid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblINIKey]    Script Date: 06/14/2012 14:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblINIKey]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblINIKey](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[kid] [varchar](50) NOT NULL,
	[options] [varchar](200) NULL,
	[descr] [varchar](1000) NULL,
	[valu] [varchar](20) NULL,
	[html] [varchar](20) NULL,
 CONSTRAINT [PK_tblINIKey] PRIMARY KEY CLUSTERED 
(
	[kid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLevel]    Script Date: 06/14/2012 14:49:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblLevel](
	[levelid] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[levelname] [varchar](10) NULL,
 CONSTRAINT [PK_tblLevel] PRIMARY KEY CLUSTERED 
(
	[levelid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLinkedItem]    Script Date: 06/14/2012 14:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblLinkedItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblLinkedItem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[linkeditem] [varchar](30) NULL,
	[linkedkey] [varchar](10) NULL,
	[linkeddst] [varchar](10) NULL,
	[linkedtable] [varchar](30) NULL,
 CONSTRAINT [PK_tblLinkedItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblArchivedProgram]    Script Date: 06/14/2012 14:45:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblArchivedProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblArchivedProgram](
	[id] [numeric](18, 0) NOT NULL,
	[seq] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[program_id] [numeric](18, 0) NOT NULL,
	[effectivedate] [char](20) NULL,
	[title] [varchar](50) NULL,
	[descr] [text] NULL,
	[objectives] [text] NULL,
	[functions] [text] NULL,
	[organized] [text] NULL,
	[resources] [text] NULL,
	[enroll] [text] NULL,
	[efficient] [text] NULL,
	[effectiveness] [text] NULL,
	[proposed] [text] NULL,
	[rationale] [text] NULL,
	[substantive] [text] NULL,
	[articulated] [text] NULL,
	[additionalstaff] [text] NULL,
	[requiredhours] [text] NULL,
	[addedby] [varchar](50) NULL,
	[addeddate] [smalldatetime] NULL,
	[modifiedby] [varchar](50) NULL,
	[modifieddate] [smalldatetime] NULL,
	[historyid] [numeric](18, 0) NULL,
	[proposer] [varchar](30) NULL,
	[status] [char](10) NULL,
	[votefor] [char](10) NULL,
	[voteagainst] [char](10) NULL,
	[voteabstain] [char](10) NULL,
	[reviewdate] [smalldatetime] NULL,
	[comments] [varchar](2000) NULL,
	[datedeleted] [smalldatetime] NULL,
	[divisioncode] [char](2) NULL,
	[regents] [bit] NULL,
	[regentsdate] [smalldatetime] NULL,
	[campus] [varchar](10) NULL CONSTRAINT [DF_tblArchivedProgram_campus]  DEFAULT ('LCC'),
 CONSTRAINT [PK_tblArchivedProgram] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLinkedKeys]    Script Date: 06/14/2012 14:49:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblLinkedKeys]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblLinkedKeys](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[linkedsrc] [char](10) NULL,
	[linkeddst] [varchar](30) NULL,
	[level] [int] NULL,
 CONSTRAINT [PK_tblLinkedKeys] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCurrentProgram]    Script Date: 06/14/2012 14:48:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCurrentProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCurrentProgram](
	[id] [numeric](18, 0) NOT NULL,
	[seq] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[program_id] [numeric](18, 0) NOT NULL,
	[effectivedate] [varchar](20) NULL,
	[title] [varchar](50) NULL,
	[descr] [text] NULL,
	[objectives] [text] NULL,
	[functions] [text] NULL,
	[organized] [text] NULL,
	[enroll] [text] NULL,
	[resources] [text] NULL,
	[efficient] [text] NULL,
	[effectiveness] [text] NULL,
	[proposed] [text] NULL,
	[rationale] [text] NULL,
	[substantive] [text] NULL,
	[articulated] [text] NULL,
	[additionalstaff] [text] NULL,
	[requiredhours] [text] NULL,
	[addedby] [varchar](50) NULL,
	[addeddate] [smalldatetime] NULL,
	[modifiedby] [varchar](50) NULL,
	[modifieddate] [smalldatetime] NULL,
	[historyid] [numeric](18, 0) NULL,
	[proposer] [varchar](30) NULL,
	[status] [char](10) NULL,
	[votefor] [varchar](10) NULL,
	[voteagainst] [varchar](10) NULL,
	[voteabstain] [varchar](10) NULL,
	[reviewdate] [smalldatetime] NULL,
	[comments] [varchar](2000) NULL,
	[datedeleted] [smalldatetime] NULL,
	[dateapproved] [smalldatetime] NULL,
	[divisioncode] [char](2) NULL,
	[progress] [varchar](20) NULL,
	[regents] [bit] NULL,
	[regentsdate] [smalldatetime] NULL,
	[campus] [varchar](10) NULL CONSTRAINT [DF_tblCurrentProgram_campus]  DEFAULT ('LCC'),
 CONSTRAINT [PK_tblCurrentProgram] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLists]    Script Date: 06/14/2012 14:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblLists]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblLists](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[src] [varchar](10) NOT NULL,
	[program] [varchar](50) NULL,
	[alpha] [varchar](10) NULL,
	[comments] [text] NULL,
	[auditDate] [smalldatetime] NULL,
	[auditBy] [varchar](20) NULL,
	[rdr] [int] NULL,
 CONSTRAINT [PK_tblLists] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblLists]') AND name = N'PK_tblLists_Main')
CREATE NONCLUSTERED INDEX [PK_tblLists_Main] ON [dbo].[tblLists] 
(
	[campus] ASC,
	[src] ASC,
	[alpha] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProposedProgram]    Script Date: 06/14/2012 14:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblProposedProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblProposedProgram](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[program_id] [numeric](18, 0) NULL,
	[effectivedate] [char](20) NULL,
	[title] [varchar](50) NULL,
	[descr] [text] NULL,
	[objectives] [text] NULL,
	[functions] [text] NULL,
	[organized] [text] NULL,
	[enroll] [text] NULL,
	[resources] [text] NULL,
	[efficient] [text] NULL,
	[effectiveness] [text] NULL,
	[proposed] [text] NULL,
	[rationale] [text] NULL,
	[substantive] [text] NULL,
	[articulated] [text] NULL,
	[additionalstaff] [text] NULL,
	[requiredhours] [text] NULL,
	[addedby] [text] NULL,
	[addeddate] [smalldatetime] NULL,
	[modifiedby] [varchar](50) NULL,
	[modifieddate] [smalldatetime] NULL,
	[main_edit] [bit] NULL,
	[program_edit] [bit] NULL,
	[division_edit] [bit] NULL,
	[title_edit] [bit] NULL,
	[descr_edit] [bit] NULL,
	[effectivedate_edit] [bit] NULL,
	[regent_edit] [bit] NULL,
	[objectives_edit] [bit] NULL,
	[functions_edit] [bit] NULL,
	[organized_edit] [bit] NULL,
	[enroll_edit] [bit] NULL,
	[resources_edit] [bit] NULL,
	[efficient_edit] [bit] NULL,
	[effectiveness_edit] [bit] NULL,
	[proposed_edit] [bit] NULL CONSTRAINT [DF_tblProposedProgram_proposed_edit]  DEFAULT (1),
	[rationale_edit] [bit] NULL CONSTRAINT [DF_tblProposedProgram_rationale_edit]  DEFAULT (1),
	[substantive_edit] [bit] NULL CONSTRAINT [DF_tblProposedProgram_substantive_edit]  DEFAULT (1),
	[articulated_edit] [bit] NULL CONSTRAINT [DF_tblProposedProgram_articulated_edit]  DEFAULT (1),
	[additionalstaff_edit] [bit] NULL CONSTRAINT [DF_tblProposedProgram_additionalstaff_edit]  DEFAULT (1),
	[requiredhours_edit] [bit] NULL,
	[progress] [char](10) NULL,
	[status] [char](10) NULL,
	[proposer] [varchar](30) NULL,
	[edit] [bit] NULL,
	[copied] [bit] NULL,
	[copiedfrom] [varchar](10) NULL,
	[Comments] [varchar](2000) NULL,
	[DivisionApprove] [bit] NULL,
	[DivisionDisapprove] [bit] NULL,
	[DivisionLastName] [varchar](50) NULL,
	[DivisionDateApproved] [smalldatetime] NULL,
	[DivisionComments] [ntext] NULL,
	[CommitteeApprove] [bit] NULL,
	[CommitteeDisapprove] [bit] NULL,
	[CommitteeLastName] [varchar](50) NULL,
	[CommitteeDateApproved] [smalldatetime] NULL,
	[CommitteeComments] [ntext] NULL,
	[FacultyApprove] [bit] NULL,
	[FacultyDisapprove] [bit] NULL,
	[FacultyLastName] [varchar](50) NULL,
	[FacultyDateApproved] [smalldatetime] NULL,
	[FacultyComments] [ntext] NULL,
	[DeanApprove] [bit] NULL,
	[DeanDisApprove] [bit] NULL,
	[DeanLastName] [varchar](50) NULL,
	[DeanDateApproved] [smalldatetime] NULL,
	[DeanComments] [ntext] NULL,
	[ProvostApprove] [bit] NULL,
	[ProvostDisApprove] [bit] NULL,
	[ProvostLastName] [varchar](50) NULL,
	[ProvostDateApproved] [smalldatetime] NULL,
	[ProvostComments] [ntext] NULL,
	[DivVoteFor] [varchar](10) NULL,
	[DivVoteAgainst] [varchar](10) NULL,
	[DivVoteAbstain] [varchar](10) NULL,
	[divisioncode] [char](2) NULL,
	[regents] [bit] NULL,
	[regentsdate] [smalldatetime] NULL,
	[campus] [varchar](10) NULL CONSTRAINT [DF_tblProposedProgram_campus]  DEFAULT ('LCC'),
 CONSTRAINT [PK_tblProposedProgram] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMail]    Script Date: 06/14/2012 14:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMail](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[from] [varchar](500) NULL,
	[to] [varchar](500) NULL,
	[cc] [varchar](500) NULL,
	[bcc] [varchar](500) NULL,
	[subject] [varchar](255) NULL,
	[alpha] [varchar](50) NULL,
	[num] [varchar](50) NULL,
	[campus] [varchar](10) NULL,
	[dte] [smalldatetime] NULL CONSTRAINT [DF_tblMail_dte]  DEFAULT (getdate()),
	[processed] [bit] NULL CONSTRAINT [DF__tblMail__process__6CE315C2]  DEFAULT (0),
	[content] [text] NULL,
	[attachment] [varchar](150) NULL,
 CONSTRAINT [PK_tblMail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMail]') AND name = N'PK_tblMail_Campus')
CREATE NONCLUSTERED INDEX [PK_tblMail_Campus] ON [dbo].[tblMail] 
(
	[campus] ASC,
	[id] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMisc]    Script Date: 06/14/2012 14:49:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMisc]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMisc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[coursetype] [varchar](10) NOT NULL,
	[descr] [varchar](50) NULL,
	[val] [text] NULL,
	[userid] [varchar](50) NULL,
	[auditdate] [datetime] NULL,
	[edit1] [varchar](256) NULL,
	[edit2] [varchar](256) NULL,
 CONSTRAINT [PK_tblMisc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMisc]') AND name = N'PK_Misc_Key')
CREATE NONCLUSTERED INDEX [PK_Misc_Key] ON [dbo].[tblMisc] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[coursetype] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMisc]') AND name = N'PK_Misc_Main')
CREATE NONCLUSTERED INDEX [PK_Misc_Main] ON [dbo].[tblMisc] 
(
	[campus] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMode]    Script Date: 06/14/2012 14:49:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMode](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[mode] [char](20) NULL,
	[item] [char](20) NULL,
	[override] [bit] NULL CONSTRAINT [DF_tblMode_override]  DEFAULT (0),
 CONSTRAINT [PK_tblMode] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMode2]    Script Date: 06/14/2012 14:49:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMode2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMode2](
	[id] [numeric](18, 0) NOT NULL,
	[seq] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[item] [char](20) NULL,
	[questionnumber] [numeric](18, 0) NULL,
 CONSTRAINT [PK_tblMode2] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPageHelp]    Script Date: 06/14/2012 14:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPageHelp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPageHelp](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[page] [varchar](10) NULL,
	[campus] [varchar](10) NULL,
	[filename] [varchar](50) NULL,
 CONSTRAINT [PK_tblPageHelp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPageHelp]') AND name = N'PK_tblPageHelpPageCampus')
CREATE NONCLUSTERED INDEX [PK_tblPageHelpPageCampus] ON [dbo].[tblPageHelp] 
(
	[page] ASC,
	[campus] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPDF]    Script Date: 06/14/2012 14:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPDF]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPDF](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[type] [varchar](20) NULL,
	[userid] [varchar](50) NULL,
	[kix] [varchar](50) NULL,
	[seq] [int] NULL,
	[field01] [text] NULL,
	[field02] [text] NULL,
	[auditdate] [datetime] NULL CONSTRAINT [DF_tblPDF_auditdate]  DEFAULT (getdate()),
	[colum] [varchar](20) NULL,
 CONSTRAINT [PK_tblPDF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPDF]') AND name = N'PK_tblPDF_Kix')
CREATE NONCLUSTERED INDEX [PK_tblPDF_Kix] ON [dbo].[tblPDF] 
(
	[kix] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPDF]') AND name = N'PK_tblPDF_User')
CREATE NONCLUSTERED INDEX [PK_tblPDF_User] ON [dbo].[tblPDF] 
(
	[userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPosition]    Script Date: 06/14/2012 14:49:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPosition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPosition](
	[posid] [decimal](18, 0) NOT NULL,
	[posname] [varchar](50) NULL,
	[campus] [varchar](10) NULL,
 CONSTRAINT [PK_tblPosition] PRIMARY KEY CLUSTERED 
(
	[posid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblidx]    Script Date: 06/14/2012 14:49:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblidx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblidx](
	[seq] [int] IDENTITY(1,1) NOT NULL,
	[idx] [char](4) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblPreReq]    Script Date: 06/14/2012 14:49:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPreReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPreReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NOT NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NOT NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblPreReq_id]  DEFAULT (0),
	[PrereqAlpha] [varchar](10) NULL,
	[PrereqNum] [varchar](10) NULL,
	[Grading] [text] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblPreReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblPreReq__rdr__7AA72534]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblPreReq__conse__56BECA79]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblPreReq__pendi__5E5FEC41]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDivRoutes]    Script Date: 06/14/2012 14:48:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblDivRoutes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblDivRoutes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[route] [int] NOT NULL,
	[divid] [int] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblDivRoutes]') AND name = N'PK_Route')
CREATE NONCLUSTERED INDEX [PK_Route] ON [dbo].[tblDivRoutes] 
(
	[route] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblprogramdegree]    Script Date: 06/14/2012 14:49:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblprogramdegree]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblprogramdegree](
	[degreeid] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[alpha] [varchar](10) NULL,
	[title] [varchar](50) NULL,
	[descr] [varchar](250) NULL,
	[dte] [smalldatetime] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblprogramdegree] PRIMARY KEY CLUSTERED 
(
	[degreeid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[messagesX]    Script Date: 06/14/2012 14:45:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[messagesX]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[messagesX](
	[fid] [int] NULL,
	[tp] [int] NULL,
	[mid] [int] NULL,
	[tl] [int] NULL,
	[author] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[messagesX]') AND name = N'PK_Main')
CREATE NONCLUSTERED INDEX [PK_Main] ON [dbo].[messagesX] 
(
	[fid] ASC,
	[tp] ASC,
	[mid] ASC,
	[tl] ASC,
	[author] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPrograms]    Script Date: 06/14/2012 14:50:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPrograms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPrograms](
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[type] [char](3) NOT NULL,
	[seq] [decimal](18, 0) NULL CONSTRAINT [DF_tblPrograms_seq]  DEFAULT (0),
	[progress] [varchar](20) NULL,
	[degreeid] [numeric](18, 0) NULL,
	[divisionid] [numeric](18, 0) NULL,
	[effectivedate] [varchar](20) NULL,
	[title] [varchar](50) NULL,
	[descr] [text] NULL,
	[outcomes] [text] NULL,
	[functions] [text] NULL,
	[organized] [text] NULL,
	[enroll] [text] NULL,
	[resources] [text] NULL,
	[efficient] [text] NULL,
	[effectiveness] [text] NULL,
	[proposed] [text] NULL,
	[rationale] [text] NULL,
	[substantive] [text] NULL,
	[articulated] [text] NULL,
	[additionalstaff] [text] NULL,
	[requiredhours] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[hid] [decimal](18, 0) NULL,
	[proposer] [varchar](50) NULL,
	[votefor] [varchar](10) NULL,
	[voteagainst] [varchar](10) NULL,
	[voteabstain] [varchar](10) NULL,
	[reviewdate] [smalldatetime] NULL,
	[comments] [text] NULL,
	[datedeleted] [smalldatetime] NULL,
	[dateapproved] [smalldatetime] NULL,
	[regents] [bit] NOT NULL,
	[regentsdate] [smalldatetime] NULL,
	[route] [int] NULL,
	[subprogress] [varchar](20) NULL,
	[edit] [bit] NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL,
	[edit2] [varchar](500) NULL,
	[reason] [text] NULL,
	[p14] [text] NULL,
	[p15] [text] NULL,
	[p16] [text] NULL,
	[p17] [text] NULL,
	[p18] [text] NULL,
	[p19] [text] NULL,
	[p20] [text] NULL,
 CONSTRAINT [PK_tblPrograms] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[historyid] ASC,
	[type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPrograms]') AND name = N'PK_tblprograms_historyid')
CREATE NONCLUSTERED INDEX [PK_tblprograms_historyid] ON [dbo].[tblPrograms] 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPrograms]') AND name = N'PK_tblPrograms_main')
CREATE NONCLUSTERED INDEX [PK_tblPrograms_main] ON [dbo].[tblPrograms] 
(
	[campus] ASC,
	[degreeid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPrograms]') AND name = N'PK_tblprograms_view')
CREATE NONCLUSTERED INDEX [PK_tblprograms_view] ON [dbo].[tblPrograms] 
(
	[campus] ASC,
	[historyid] ASC,
	[type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCourseCC2]    Script Date: 06/14/2012 14:48:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCourseCC2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCourseCC2](
	[id] [nvarchar](18) NULL,
	[historyid] [nvarchar](18) NULL,
	[campus] [nvarchar](10) NULL,
	[CourseAlpha] [nvarchar](10) NULL,
	[CourseNum] [nvarchar](10) NULL,
	[CourseType] [nvarchar](10) NULL,
	[edit] [bit] NOT NULL,
	[Progress] [nvarchar](10) NULL,
	[proposer] [nvarchar](50) NULL,
	[edit0] [nvarchar](50) NULL,
	[edit1] [nvarchar](250) NULL,
	[edit2] [nvarchar](250) NULL,
	[dispID] [nvarchar](4) NULL,
	[Division] [nvarchar](4) NULL,
	[coursetitle] [nvarchar](100) NULL,
	[credits] [nvarchar](10) NULL,
	[repeatable] [bit] NOT NULL,
	[maxcredit] [nvarchar](10) NULL,
	[articulation] [nvarchar](50) NULL,
	[semester] [nvarchar](10) NULL,
	[crosslisted] [bit] NOT NULL,
	[coursedate] [smalldatetime] NULL,
	[effectiveterm] [nvarchar](12) NULL,
	[gradingoptions] [nvarchar](20) NULL,
	[coursedescr] [ntext] NULL,
	[hoursperweek] [nvarchar](20) NULL,
	[reviewdate] [smalldatetime] NULL,
	[auditdate] [smalldatetime] NULL,
	[excluefromcatalog] [nvarchar](1) NULL,
	[dateproposed] [smalldatetime] NULL,
	[assessmentdate] [smalldatetime] NULL,
	[X15] [ntext] NULL,
	[X16] [ntext] NULL,
	[X17] [ntext] NULL,
	[X18] [ntext] NULL,
	[X19] [ntext] NULL,
	[X20] [ntext] NULL,
	[X21] [ntext] NULL,
	[X22] [ntext] NULL,
	[X23] [ntext] NULL,
	[X24] [ntext] NULL,
	[X25] [ntext] NULL,
	[X26] [ntext] NULL,
	[X27] [ntext] NULL,
	[X28] [ntext] NULL,
	[X29] [ntext] NULL,
	[X30] [ntext] NULL,
	[X31] [ntext] NULL,
	[X32] [ntext] NULL,
	[X33] [ntext] NULL,
	[X34] [ntext] NULL,
	[X35] [ntext] NULL,
	[X36] [ntext] NULL,
	[X37] [ntext] NULL,
	[X38] [ntext] NULL,
	[X39] [ntext] NULL,
	[X40] [ntext] NULL,
	[X41] [ntext] NULL,
	[X42] [ntext] NULL,
	[X43] [ntext] NULL,
	[X44] [ntext] NULL,
	[X45] [ntext] NULL,
	[X46] [ntext] NULL,
	[X47] [ntext] NULL,
	[X48] [ntext] NULL,
	[X49] [ntext] NULL,
	[X50] [ntext] NULL,
	[X51] [ntext] NULL,
	[X52] [ntext] NULL,
	[X53] [ntext] NULL,
	[X54] [ntext] NULL,
	[X55] [ntext] NULL,
	[X56] [ntext] NULL,
	[X57] [ntext] NULL,
	[X58] [ntext] NULL,
	[X59] [ntext] NULL,
	[X60] [ntext] NULL,
	[X61] [ntext] NULL,
	[X62] [ntext] NULL,
	[X63] [ntext] NULL,
	[X64] [ntext] NULL,
	[jsid] [nvarchar](50) NULL,
	[route] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[forumsx]    Script Date: 06/14/2012 14:45:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[forumsx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[forumsx](
	[userid] [varchar](50) NOT NULL,
	[fid] [int] NOT NULL,
 CONSTRAINT [PK_forumsx] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[fid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblProps]    Script Date: 06/14/2012 14:50:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblProps]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblProps](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[propname] [varchar](50) NULL,
	[propdescr] [varchar](250) NULL,
	[subject] [varchar](100) NULL,
	[content] [text] NULL,
	[cc] [varchar](50) NULL,
	[auditby] [varchar](30) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblProps_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblProps] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblProps]') AND name = N'PK_tblProps_Campus')
CREATE NONCLUSTERED INDEX [PK_tblProps_Campus] ON [dbo].[tblProps] 
(
	[campus] ASC,
	[propname] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblReviewers]    Script Date: 06/14/2012 14:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblReviewers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblReviewers](
	[Id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[userid] [varchar](50) NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[inviter] [varchar](50) NULL,
 CONSTRAINT [PK_tblReviewers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRequest]    Script Date: 06/14/2012 14:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblRequest](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[descr] [varchar](100) NULL,
	[request] [text] NULL,
	[comments] [text] NULL,
	[status] [varchar](20) NULL,
	[userid] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL,
	[submitteddate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblReviewHist]    Script Date: 06/14/2012 14:50:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblReviewHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblReviewHist](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[item] [int] NULL,
	[dte] [smalldatetime] NULL CONSTRAINT [DF_tblReviewHist_dte]  DEFAULT (getdate()),
	[reviewer] [varchar](50) NULL,
	[comments] [text] NULL,
	[source] [char](2) NULL CONSTRAINT [DF_tblReviewHist_source]  DEFAULT (1),
	[acktion] [int] NULL CONSTRAINT [DF__tblReview__ackti__73901351]  DEFAULT (3),
	[enabled] [bit] NULL CONSTRAINT [DF__tblReview__enabl__4A58F394]  DEFAULT (0),
 CONSTRAINT [PK_tblReviewHist] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRpt]    Script Date: 06/14/2012 14:50:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblRpt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblRpt](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](50) NULL CONSTRAINT [DF_tblRpt_campus]  DEFAULT ('ALL'),
	[rptname] [varchar](50) NULL,
	[rptfilename] [varchar](50) NULL,
	[rpttitle] [varchar](50) NULL,
	[rptformat] [char](10) NULL CONSTRAINT [DF_tblRpt_rptformat]  DEFAULT ('PDF'),
	[rptParm1] [varchar](20) NULL,
	[rptParm2] [varchar](20) NULL,
	[rptParm3] [varchar](20) NULL,
	[rptParm4] [varchar](20) NULL,
 CONSTRAINT [PK_tblRpt] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSalutation]    Script Date: 06/14/2012 14:50:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSalutation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSalutation](
	[salid] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[saldescr] [varchar](6) NULL,
 CONSTRAINT [PK_tblSalutation] PRIMARY KEY CLUSTERED 
(
	[salid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSLO]    Script Date: 06/14/2012 14:50:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSLO](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[hid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[progress] [varchar](15) NULL,
	[comments] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblSLO_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblSLO] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[hid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSLO]') AND name = N'PK_tblSLO_Core')
CREATE NONCLUSTERED INDEX [PK_tblSLO_Core] ON [dbo].[tblSLO] 
(
	[campus] ASC,
	[CourseAlpha] ASC,
	[CourseNum] ASC,
	[CourseType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSLOARC]    Script Date: 06/14/2012 14:50:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSLOARC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSLOARC](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[hid] [varchar](18) NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[progress] [varchar](15) NULL,
	[comments] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblSLOARC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblReviewHist2]    Script Date: 06/14/2012 14:50:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblReviewHist2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblReviewHist2](
	[id] [numeric](10, 0) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[item] [int] NULL,
	[dte] [smalldatetime] NULL CONSTRAINT [DF_tblReviewHist2_dte]  DEFAULT (getdate()),
	[reviewer] [varchar](50) NULL,
	[comments] [text] NULL,
	[source] [char](2) NULL CONSTRAINT [DF_tblReviewHist2_source]  DEFAULT (1),
	[acktion] [int] NULL CONSTRAINT [DF__tblReview__ackti__7484378A]  DEFAULT (3),
	[enabled] [bit] NULL CONSTRAINT [DF__tblReview__enabl__4B4D17CD]  DEFAULT (0),
 CONSTRAINT [PK_tblReviewHist2] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblStatement]    Script Date: 06/14/2012 14:50:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblStatement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblStatement](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NULL,
	[statement] [text] NULL,
	[campus] [varchar](10) NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblStatement_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblStatement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblsyllabus]    Script Date: 06/14/2012 14:50:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblsyllabus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblsyllabus](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[userid] [varchar](50) NULL,
	[semester] [varchar](20) NULL,
	[yeer] [char](4) NULL,
	[textbooks] [text] NULL,
	[objectives] [text] NULL,
	[grading] [text] NULL,
	[comments] [text] NULL,
	[disability] [bit] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblsyllabus_auditdate]  DEFAULT (getdate()),
	[attach] [varchar](250) NULL,
 CONSTRAINT [PK_tblsyllabus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTabs]    Script Date: 06/14/2012 14:50:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTabs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTabs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tab] [varchar](30) NULL,
	[alpha] [varchar](15) NULL,
	[num] [varchar](15) NULL,
	[imprt] [bit] NULL CONSTRAINT [DF__tblTabs__imprt__1CDC41A7]  DEFAULT ((0)),
	[importtype] [varchar](20) NULL,
	[importcolumns] [int] NULL,
	[importcolumnname] [varchar](200) NULL,
 CONSTRAINT [PK_tblTabs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTabs]') AND name = N'PK_TblTabs_Tab')
CREATE NONCLUSTERED INDEX [PK_TblTabs_Tab] ON [dbo].[tblTabs] 
(
	[tab] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTempAttach]    Script Date: 06/14/2012 14:51:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempAttach]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempAttach](
	[id] [numeric](18, 0) NOT NULL,
	[historyid] [varchar](18) NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursetype] [varchar](10) NULL,
	[filedescr] [varchar](100) NULL,
	[filename] [varchar](300) NULL,
	[filesize] [float] NULL,
	[filedate] [datetime] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [datetime] NULL CONSTRAINT [DF_tblTempAttach_auditdate]  DEFAULT (getdate()),
	[category] [varchar](20) NULL,
	[version] [smallint] NULL,
	[fullname] [varchar](300) NULL,
 CONSTRAINT [PK_tblTempAttach] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCampusData]    Script Date: 06/14/2012 14:51:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCampusData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCampusData](
	[id] [numeric](18, 0) NOT NULL CONSTRAINT [DF_tblTempCampusData_id]  DEFAULT (0),
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](250) NULL CONSTRAINT [DF_tblTempCampusData_edit1]  DEFAULT (1),
	[edit2] [varchar](250) NULL CONSTRAINT [DF_tblTempCampusData_edit2]  DEFAULT (1),
	[C1] [text] NULL,
	[C2] [text] NULL,
	[C3] [text] NULL,
	[C4] [text] NULL,
	[C5] [text] NULL,
	[C6] [text] NULL,
	[C7] [text] NULL,
	[C8] [text] NULL,
	[C9] [text] NULL,
	[C10] [text] NULL,
	[C11] [text] NULL,
	[C12] [text] NULL,
	[C13] [text] NULL,
	[C14] [text] NULL,
	[C15] [text] NULL,
	[C16] [text] NULL,
	[C17] [text] NULL,
	[C18] [text] NULL,
	[C19] [text] NULL,
	[C20] [text] NULL,
	[C21] [text] NULL,
	[C22] [text] NULL,
	[C23] [text] NULL,
	[C24] [text] NULL,
	[C25] [text] NULL,
	[C26] [text] NULL,
	[C27] [text] NULL,
	[C28] [text] NULL,
	[C29] [text] NULL,
	[C30] [text] NULL,
	[jsid] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCampusData_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[C31] [text] NULL,
	[C32] [text] NULL,
	[C33] [text] NULL,
	[C34] [text] NULL,
	[C35] [text] NULL,
	[C36] [text] NULL,
	[C37] [text] NULL,
	[C38] [text] NULL,
	[C39] [text] NULL,
	[C40] [text] NULL,
	[C41] [text] NULL,
	[C42] [text] NULL,
	[C43] [text] NULL,
	[C44] [text] NULL,
	[C45] [text] NULL,
	[C46] [text] NULL,
	[C47] [text] NULL,
	[C48] [text] NULL,
	[C49] [text] NULL,
	[C50] [text] NULL,
	[C51] [text] NULL,
	[C52] [text] NULL,
	[C53] [text] NULL,
	[C54] [text] NULL,
	[C55] [text] NULL,
 CONSTRAINT [PK_tblTempCampusData] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCoReq]    Script Date: 06/14/2012 14:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCoReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCoReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblTempCoReq_id]  DEFAULT (0),
	[CoreqAlpha] [varchar](10) NULL,
	[CoreqNum] [varchar](10) NULL,
	[Grading] [text] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCoReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempCoRe__rdr__7D8391DF]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblTempCo__conse__599B3724]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblTempCo__pendi__5D6BC808]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblChairs]    Script Date: 06/14/2012 14:46:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChairs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblChairs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[programid] [int] NOT NULL,
	[coursealpha] [varchar](10) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourse]    Script Date: 06/14/2012 14:51:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourse](
	[id] [varchar](18) NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[edit] [bit] NULL,
	[Progress] [varchar](10) NULL,
	[proposer] [varchar](50) NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL,
	[edit2] [varchar](500) NULL,
	[DispID] [char](4) NULL,
	[Division] [char](4) NULL,
	[coursetitle] [varchar](100) NULL,
	[credits] [varchar](20) NULL,
	[repeatable] [bit] NULL,
	[maxcredit] [varchar](20) NULL,
	[articulation] [text] NULL,
	[semester] [varchar](50) NULL,
	[crosslisted] [bit] NULL,
	[coursedate] [smalldatetime] NULL,
	[effectiveterm] [varchar](12) NULL,
	[gradingoptions] [varchar](50) NULL,
	[coursedescr] [text] NULL,
	[hoursperweek] [text] NULL,
	[reviewdate] [smalldatetime] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCourse_auditdate]  DEFAULT (getdate()),
	[excluefromcatalog] [char](1) NULL CONSTRAINT [DF_tblTempCourse_excluefromcatalog]  DEFAULT (0),
	[dateproposed] [smalldatetime] NULL,
	[assessmentdate] [smalldatetime] NULL,
	[X15] [text] NULL,
	[X16] [text] NULL,
	[X17] [text] NULL,
	[X18] [text] NULL,
	[X19] [text] NULL,
	[X20] [text] NULL,
	[X21] [text] NULL,
	[X22] [text] NULL,
	[X23] [text] NULL,
	[X24] [text] NULL,
	[X25] [text] NULL,
	[X26] [text] NULL,
	[X27] [text] NULL,
	[X28] [text] NULL,
	[X29] [text] NULL,
	[X30] [text] NULL,
	[X31] [text] NULL,
	[X32] [text] NULL,
	[X33] [text] NULL,
	[X34] [text] NULL,
	[X35] [text] NULL,
	[X36] [text] NULL,
	[X37] [text] NULL,
	[X38] [text] NULL,
	[X39] [text] NULL,
	[X40] [text] NULL,
	[X41] [text] NULL,
	[X42] [text] NULL,
	[X43] [text] NULL,
	[X44] [text] NULL,
	[X45] [text] NULL,
	[X46] [text] NULL,
	[X47] [text] NULL,
	[X48] [text] NULL,
	[X49] [text] NULL,
	[X50] [text] NULL,
	[X51] [text] NULL,
	[X52] [text] NULL,
	[X53] [text] NULL,
	[X54] [text] NULL,
	[X55] [text] NULL,
	[X56] [text] NULL,
	[X57] [text] NULL,
	[X58] [text] NULL,
	[X59] [text] NULL,
	[X60] [text] NULL,
	[X61] [text] NULL,
	[X62] [text] NULL,
	[X63] [text] NULL,
	[X64] [text] NULL,
	[X65] [text] NULL,
	[X66] [text] NULL,
	[X67] [text] NULL,
	[X68] [text] NULL,
	[X69] [text] NULL,
	[X70] [text] NULL,
	[X71] [text] NULL,
	[X72] [text] NULL,
	[X73] [text] NULL,
	[X74] [text] NULL,
	[X75] [text] NULL,
	[X76] [text] NULL,
	[X77] [text] NULL,
	[X78] [text] NULL,
	[X79] [text] NULL,
	[X80] [text] NULL,
	[jsid] [varchar](50) NULL,
	[reason] [text] NULL,
	[votesfor] [numeric](18, 0) NULL CONSTRAINT [DF_tblTempCourse_votesfor]  DEFAULT (0),
	[votesagainst] [numeric](18, 0) NULL CONSTRAINT [DF_tblTempCourse_votesagainst]  DEFAULT (0),
	[votesabstain] [numeric](18, 0) NULL CONSTRAINT [DF_tblTempCourse_votesabstain]  DEFAULT (0),
	[route] [int] NULL CONSTRAINT [DF__tbltempCo__route__38A457AD]  DEFAULT (1),
	[subprogress] [varchar](20) NULL,
	[MESSAGEPAGE01] [text] NULL,
	[MESSAGEPAGE02] [text] NULL,
	[MESSAGEPAGE03] [text] NULL,
	[MESSAGEPAGE04] [text] NULL,
	[MESSAGEPAGE05] [text] NULL,
	[X81] [text] NULL,
	[X82] [text] NULL,
	[X83] [text] NULL,
	[X84] [text] NULL,
	[X85] [text] NULL,
	[X86] [text] NULL,
	[X87] [text] NULL,
	[X88] [text] NULL,
	[X89] [text] NULL,
	[X90] [text] NULL,
	[X91] [text] NULL,
	[X92] [text] NULL,
	[X93] [text] NULL,
	[X94] [text] NULL,
	[X95] [text] NULL,
	[X96] [text] NULL,
	[X97] [text] NULL,
	[X98] [text] NULL,
	[X99] [text] NULL,
 CONSTRAINT [PK_tblTempCourse] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hon_outline]    Script Date: 06/14/2012 14:45:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hon_outline]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[hon_outline](
	[id] [float] NULL,
	[filename] [nvarchar](max) NULL,
	[alpha] [nvarchar](max) NULL,
	[num] [nvarchar](max) NULL,
	[campus] [nvarchar](max) NULL,
	[type] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[tblTempCourseAssess]    Script Date: 06/14/2012 14:51:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseAssess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseAssess](
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[assessmentid] [int] NOT NULL CONSTRAINT [DF_tblTempCourseAssess_assessmentid]  DEFAULT (0),
	[assessment] [varchar](255) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCourseAssess_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
 CONSTRAINT [PK_tblTempCourseAssess] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[assessmentid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseComp]    Script Date: 06/14/2012 14:51:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseComp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseComp](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[CompID] [numeric](10, 0) NULL CONSTRAINT [DF_tblTempCourseComp_CompID]  DEFAULT (0),
	[Comp] [varchar](1000) NULL,
	[comments] [text] NULL,
	[Approved] [char](1) NULL,
	[ApprovedDate] [smalldatetime] NULL,
	[ApprovedBy] [varchar](20) NULL,
	[AuditDate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCourseComp_AuditDate]  DEFAULT (getdate()),
	[AuditBy] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempCour__rdr__015422C3]  DEFAULT (0),
	[reviewed] [char](1) NULL,
	[revieweddate] [smalldatetime] NULL,
	[reviewedby] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vw_ProgramsApprovalStatus]    Script Date: 06/14/2012 14:53:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ProgramsApprovalStatus]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ProgramsApprovalStatus]
AS
SELECT     TOP 100 PERCENT c.campus, c.historyid, c.Program, c.divisionname, c.proposer, c.progress, c.route, c.subprogress, i.kid, c.title, 
                      c.[Effective Date] AS EffectiveDate, c.divisioncode
FROM         dbo.vw_ProgramForViewing c INNER JOIN
                      dbo.tblINI i ON c.campus = i.campus AND c.route = i.id
WHERE     (i.category = ''ApprovalRouting'') AND (c.route > 0) AND (c.type = ''PRE'')
ORDER BY c.campus, c.Program, c.divisionname
'
GO
/****** Object:  Table [dbo].[tblTempCourseCompAss]    Script Date: 06/14/2012 14:51:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseCompAss]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseCompAss](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[compid] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblTempCourseCompAss_compid]  DEFAULT (0),
	[assessmentid] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblTempCourseCompAss_assessmentid]  DEFAULT (0),
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCourseCompAss_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
 CONSTRAINT [PK_tblTempCourseCompAss] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[compid] ASC,
	[assessmentid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseACCJC]    Script Date: 06/14/2012 14:51:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseACCJC]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseACCJC](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[ContentID] [int] NULL,
	[CompID] [int] NULL,
	[Assessmentid] [int] NULL,
	[ApprovedDate] [smalldatetime] NULL,
	[AssessedDate] [smalldatetime] NULL,
	[AssessedBy] [varchar](20) NULL,
	[AuditDate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCourseACCJC_AuditDate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[historyid] [varchar](18) NOT NULL,
 CONSTRAINT [PK_tblTempCourseACCJC] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseCompetency]    Script Date: 06/14/2012 14:51:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseCompetency]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseCompetency](
	[historyid] [varchar](18) NOT NULL,
	[seq] [int] NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursetype] [varchar](3) NULL,
	[content] [varchar](1000) NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL,
 CONSTRAINT [PK_tblTempCourseCompetency] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseCompetency]') AND name = N'PK_tblTempCourseCompetencyOutline')
CREATE NONCLUSTERED INDEX [PK_tblTempCourseCompetencyOutline] ON [dbo].[tblTempCourseCompetency] 
(
	[campus] ASC,
	[coursealpha] ASC,
	[coursenum] ASC,
	[coursetype] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zDF00126]    Script Date: 06/14/2012 14:53:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[zDF00126]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[zDF00126](
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[Progress] [varchar](10) NULL,
	[auditdate] [smalldatetime] NULL,
	[coursedate] [smalldatetime] NULL,
	[historyid] [varchar](18) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseContent]    Script Date: 06/14/2012 14:51:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseContent](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[ContentID] [numeric](10, 0) NULL CONSTRAINT [DF_tblTempCourseContent_ContentID]  DEFAULT (0),
	[ShortContent] [varchar](30) NULL,
	[LongContent] [varchar](1000) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCourseContent_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempCour__rdr__7F6BDA51]  DEFAULT (0)
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblfiledrop]    Script Date: 06/14/2012 14:49:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblfiledrop]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblfiledrop](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[userid] [varchar](50) NULL,
	[location] [varchar](250) NULL,
	[src] [varchar](50) NULL,
	[auditdate] [datetime] NULL,
 CONSTRAINT [PK_tblfiledrop] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseContentSLO]    Script Date: 06/14/2012 14:52:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseContentSLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseContentSLO](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[contentid] [numeric](10, 0) NOT NULL,
	[sloid] [numeric](10, 0) NOT NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
 CONSTRAINT [PK_tblTempCourseContentSLO] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[contentid] ASC,
	[sloid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseLinked]    Script Date: 06/14/2012 14:52:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseLinked]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseLinked](
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[src] [char](3) NULL,
	[seq] [int] NULL,
	[dst] [varchar](20) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[coursetype] [char](3) NULL,
	[auditdate] [datetime] NULL,
	[auditby] [varchar](20) NULL,
	[ref] [int] NULL CONSTRAINT [DF_tblTempCourseLinked_ref]  DEFAULT (0)
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblminutes]    Script Date: 06/14/2012 14:49:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblminutes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblminutes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dte] [datetime] NULL,
	[attendees] [varchar](250) NULL,
	[userid] [varchar](50) NULL,
	[minutes] [text] NULL,
 CONSTRAINT [PK_tblminutes_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempCourseLinked2]    Script Date: 06/14/2012 14:52:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempCourseLinked2]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempCourseLinked2](
	[historyid] [varchar](18) NULL,
	[id] [int] NULL,
	[item] [int] NULL,
	[coursetype] [char](3) NULL CONSTRAINT [DF__tblTempCo__cours__4A8DFDBE]  DEFAULT ('PRE'),
	[auditdate] [datetime] NULL CONSTRAINT [DF__tblTempCo__audit__4B8221F7]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[item2] [int] NULL CONSTRAINT [DF__tblTempCo__item2__1BD30ED5]  DEFAULT (0)
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempExtra]    Script Date: 06/14/2012 14:52:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempExtra]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempExtra](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NOT NULL,
	[Src] [varchar](10) NOT NULL,
	[id] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblTempExtra_id]  DEFAULT (0),
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[Grading] [varchar](50) NULL,
	[auditdate] [smalldatetime] NOT NULL CONSTRAINT [DF_tblTempExtra_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempExtra__rdr__7B9B496D]  DEFAULT (0),
	[coursetype] [char](3) NULL,
	[pending] [bit] NULL CONSTRAINT [DF__tblTempEx__pendi__0E0EFF63]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblTempExtra] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[Src] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannerLevel]    Script Date: 06/14/2012 14:45:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BannerLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BannerLevel](
	[level_code] [varchar](10) NULL,
	[level_descr] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempGenericContent]    Script Date: 06/14/2012 14:52:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempGenericContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempGenericContent](
	[historyid] [varchar](18) NOT NULL,
	[src] [varchar](10) NOT NULL,
	[id] [numeric](18, 0) NOT NULL CONSTRAINT [DF_tblTempGenericContent_id]  DEFAULT (0),
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[comments] [text] NULL,
	[AuditDate] [smalldatetime] NULL CONSTRAINT [DF_tblTempGenericContent_AuditDate]  DEFAULT (getdate()),
	[AuditBy] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NOT NULL CONSTRAINT [DF_tblTempGenericContent_rdr]  DEFAULT (0),
 CONSTRAINT [PK_tblTempGenericContent] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[id] ASC,
	[src] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[forumsdev]    Script Date: 06/14/2012 14:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[forumsdev]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[forumsdev](
	[forum_id] [int] NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[creator] [varchar](50) NULL,
	[requestor] [varchar](50) NULL,
	[forum_name] [varchar](100) NULL,
	[forum_description] [text] NULL,
	[forum_start_date] [smalldatetime] NULL,
	[forum_grouping] [char](20) NULL,
	[src] [varchar](50) NULL,
	[counter] [int] NULL,
	[status] [varchar](20) NULL,
	[priority] [int] NULL,
	[auditdate] [smalldatetime] NULL,
	[createddate] [smalldatetime] NULL,
	[edit] [char](1) NULL,
	[auditby] [varchar](50) NULL,
	[xref] [varchar](18) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[program] [varchar](100) NULL,
	[views] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempGESLO]    Script Date: 06/14/2012 14:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempGESLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempGESLO](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[geid] [int] NOT NULL,
	[slolevel] [int] NULL,
	[sloevals] [varchar](200) NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempGESLO_auditdate]  DEFAULT (getdate()),
	[coursetype] [char](3) NULL,
 CONSTRAINT [PK_tblTempGESLO] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[historyid] ASC,
	[geid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTemplate]    Script Date: 06/14/2012 14:52:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTemplate](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[area] [char](20) NULL,
	[type] [char](3) NULL,
	[content] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTemplate_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblTemplate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblHtml]    Script Date: 06/14/2012 14:49:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblHtml]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblHtml](
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[category] [varchar](20) NULL,
	[html] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempPreReq]    Script Date: 06/14/2012 14:52:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempPreReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempPreReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblTempPreReq_id]  DEFAULT (0),
	[PrereqAlpha] [varchar](10) NULL,
	[PrereqNum] [varchar](10) NULL,
	[Grading] [text] NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempPreReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempPreR__rdr__7C8F6DA6]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblTempPr__conse__57B2EEB2]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblTempPr__pendi__5F54107A]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbltempPrograms]    Script Date: 06/14/2012 14:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbltempPrograms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tbltempPrograms](
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[type] [char](3) NOT NULL,
	[seq] [decimal](18, 0) NULL,
	[progress] [varchar](20) NULL,
	[degreeid] [numeric](18, 0) NOT NULL,
	[divisionid] [numeric](18, 0) NULL,
	[effectivedate] [varchar](20) NULL,
	[title] [varchar](50) NULL,
	[descr] [text] NULL,
	[outcomes] [text] NULL,
	[functions] [text] NULL,
	[organized] [text] NULL,
	[enroll] [text] NULL,
	[resources] [text] NULL,
	[efficient] [text] NULL,
	[effectiveness] [text] NULL,
	[proposed] [text] NULL,
	[rationale] [text] NULL,
	[substantive] [text] NULL,
	[articulated] [text] NULL,
	[additionalstaff] [text] NULL,
	[requiredhours] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[hid] [decimal](18, 0) NULL,
	[proposer] [varchar](50) NULL,
	[votefor] [varchar](10) NULL,
	[voteagainst] [varchar](10) NULL,
	[voteabstain] [varchar](10) NULL,
	[reviewdate] [smalldatetime] NULL,
	[comments] [text] NULL,
	[datedeleted] [smalldatetime] NULL,
	[dateapproved] [smalldatetime] NULL,
	[regents] [bit] NOT NULL,
	[regentsdate] [smalldatetime] NULL,
	[route] [int] NULL,
	[subprogress] [varchar](20) NULL,
	[edit] [bit] NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL,
	[edit2] [varchar](500) NULL,
	[reason] [text] NULL,
	[p14] [text] NULL,
	[p15] [text] NULL,
	[p16] [text] NULL,
	[p17] [text] NULL,
	[p18] [text] NULL,
	[p19] [text] NULL,
	[p20] [text] NULL,
 CONSTRAINT [PK_tbltempPrograms] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[historyid] ASC,
	[type] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTempXRef]    Script Date: 06/14/2012 14:52:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTempXRef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTempXRef](
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [char](3) NULL,
	[Id] [numeric](10, 0) NULL,
	[CourseAlphaX] [varchar](10) NULL,
	[CourseNumX] [varchar](10) NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
	[pending] [bit] NULL CONSTRAINT [DF__tblTempXR__pendi__5B837F96]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTest]    Script Date: 06/14/2012 14:52:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTest](
	[id] [int] NULL CONSTRAINT [DF_tblTest_id]  DEFAULT (0),
	[tabo] [varchar](50) NULL,
	[historyid] [varchar](18) NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL,
	[id1] [int] NULL,
	[id2] [int] NULL,
	[text1] [text] NULL,
	[text2] [text] NULL,
	[dte] [smalldatetime] NULL CONSTRAINT [DF_tblTest_dte]  DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblText]    Script Date: 06/14/2012 14:52:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblText]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblText](
	[historyid] [varchar](18) NOT NULL,
	[seq] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](100) NULL,
	[edition] [varchar](20) NULL,
	[author] [varchar](100) NULL,
	[publisher] [varchar](100) NULL,
	[yeer] [char](4) NULL,
	[isbn] [varchar](30) NULL,
 CONSTRAINT [PK_tblBooks] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUploads]    Script Date: 06/14/2012 14:52:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUploads]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUploads](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[userid] [varchar](20) NULL,
	[uploadid] [numeric](18, 0) NULL,
	[type] [varchar](20) NULL,
	[filename] [varchar](250) NULL,
 CONSTRAINT [PK_tblUploads] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUserLog]    Script Date: 06/14/2012 14:52:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUserLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUserLog](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[userid] [varchar](50) NULL,
	[script] [varchar](50) NULL,
	[action] [varchar](500) NULL,
	[alpha] [varchar](50) NULL,
	[num] [varchar](50) NULL,
	[datetime] [smalldatetime] NULL CONSTRAINT [DF_tblUserLog_datetime]  DEFAULT (getdate()),
	[campus] [varchar](10) NULL,
	[historyid] [varchar](20) NULL,
 CONSTRAINT [PK_tblUserLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblUserLog]') AND name = N'PK_tblUserLog_Campus')
CREATE NONCLUSTERED INDEX [PK_tblUserLog_Campus] ON [dbo].[tblUserLog] 
(
	[campus] ASC,
	[id] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblUserLog]') AND name = N'pk_user')
CREATE NONCLUSTERED INDEX [pk_user] ON [dbo].[tblUserLog] 
(
	[userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 06/14/2012 14:52:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUsers](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](50) NOT NULL,
	[userid] [varchar](30) NOT NULL,
	[password] [varchar](15) NULL CONSTRAINT [DF_tblUsers_password]  DEFAULT ('c0mp1ex'),
	[uh] [int] NULL,
	[firstname] [varchar](30) NULL,
	[lastname] [varchar](30) NULL,
	[fullname] [varchar](50) NULL,
	[status] [varchar](20) NULL,
	[userlevel] [int] NULL,
	[department] [varchar](10) NULL,
	[division] [varchar](10) NULL,
	[email] [varchar](50) NULL,
	[title] [varchar](100) NULL,
	[salutation] [varchar](50) NULL,
	[location] [varchar](50) NULL,
	[hours] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[check] [char](1) NULL,
	[position] [varchar](50) NULL,
	[lastused] [smalldatetime] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblUsers_auditdate]  DEFAULT (getdate()),
	[alphas] [varchar](250) NULL,
	[sendnow] [int] NULL CONSTRAINT [DF__tblusers__sendno__3469B275]  DEFAULT (1),
	[attachment] [int] NULL,
	[website] [varchar](100) NULL,
	[weburl] [varchar](100) NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[tblUsers] ADD [college] [char](2) NULL
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND name = N'PK_tblUsers')
ALTER TABLE [dbo].[tblUsers] ADD  CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND name = N'PK_tblUsers_UserID')
CREATE NONCLUSTERED INDEX [PK_tblUsers_UserID] ON [dbo].[tblUsers] 
(
	[userid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSearch]    Script Date: 06/14/2012 14:50:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSearch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSearch](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[src] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUsersX]    Script Date: 06/14/2012 14:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUsersX]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUsersX](
	[id] [int] NOT NULL,
	[campus] [varchar](50) NULL,
	[userid] [varchar](15) NULL,
	[password] [varchar](15) NULL,
	[uh] [int] NULL,
	[firstname] [varchar](30) NULL,
	[lastname] [varchar](30) NULL,
	[fullname] [varchar](50) NULL,
	[status] [varchar](20) NULL,
	[userlevel] [int] NULL,
	[department] [char](4) NULL,
	[division] [varchar](6) NULL,
	[email] [varchar](50) NULL,
	[title] [varchar](50) NULL,
	[salutation] [varchar](50) NULL,
	[location] [varchar](50) NULL,
	[hours] [varchar](30) NULL,
	[phone] [varchar](20) NULL,
	[check] [char](1) NULL,
	[position] [varchar](50) NULL,
	[lastused] [smalldatetime] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblValues]    Script Date: 06/14/2012 14:52:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblValues](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[topic] [varchar](50) NULL,
	[subtopic] [varchar](50) NULL,
	[shortdescr] [varchar](1000) NULL,
	[longdescr] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[valueid] [int] NULL,
	[seq] [int] NULL,
	[src] [varchar](50) NULL,
 CONSTRAINT [PK_tblValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblValues]') AND name = N'PK_tblValues_Seq')
CREATE NONCLUSTERED INDEX [PK_tblValues_Seq] ON [dbo].[tblValues] 
(
	[campus] ASC,
	[topic] ASC,
	[subtopic] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblValuesdata]    Script Date: 06/14/2012 14:52:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblValuesdata]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblValuesdata](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursetype] [char](3) NULL,
	[X] [varchar](20) NULL,
	[XID] [varchar](50) NULL,
	[Y] [varchar](20) NULL,
	[YID] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblValuesdata]') AND name = N'PK_ValuesData')
CREATE NONCLUSTERED INDEX [PK_ValuesData] ON [dbo].[tblValuesdata] 
(
	[historyid] ASC,
	[X] ASC,
	[XID] ASC,
	[Y] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblValuesdata]') AND name = N'PK_ValuesData2')
CREATE NONCLUSTERED INDEX [PK_ValuesData2] ON [dbo].[tblValuesdata] 
(
	[historyid] ASC,
	[X] ASC,
	[Y] ASC,
	[XID] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblXRef]    Script Date: 06/14/2012 14:52:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblXRef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblXRef](
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NOT NULL,
	[Id] [numeric](10, 0) NOT NULL,
	[CourseAlphaX] [varchar](10) NULL,
	[CourseNumX] [varchar](10) NULL,
	[auditdate] [smalldatetime] NOT NULL CONSTRAINT [DF_tblXRef_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[pending] [bit] NULL CONSTRAINT [DF__tblXRef__pending__5A8F5B5D]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblXRef] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC,
	[Id] ASC,
	[auditdate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblXRef]') AND name = N'PK_XRefDB_Main')
CREATE NONCLUSTERED INDEX [PK_XRefDB_Main] ON [dbo].[tblXRef] 
(
	[campus] ASC,
	[CourseAlpha] ASC,
	[CourseNum] ASC,
	[CourseType] ASC,
	[CourseAlphaX] ASC,
	[CourseNumX] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BANNER]    Script Date: 06/14/2012 14:45:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BANNER]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BANNER](
	[id] [int] NOT NULL,
	[INSTITUTION] [varchar](10) NULL,
	[CRSE_ALPHA] [varchar](10) NULL,
	[CRSE_NUMBER] [varchar](10) NULL,
	[EFFECTIVE_TERM] [varchar](10) NULL,
	[CRSE_TITLE] [varchar](255) NULL,
	[CRSE_LONG_TITLE] [varchar](255) NULL,
	[CRSE_DIVISION] [varchar](10) NULL,
	[CRSE_DEPT] [varchar](10) NULL,
	[CRSE_COLLEGE] [varchar](10) NULL,
	[MAX_RPT_UNITS] [varchar](10) NULL,
	[REPEAT_LIMIT] [varchar](10) NULL,
	[CREDIT_HIGH] [varchar](10) NULL,
	[CREDIT_LOW] [varchar](10) NULL,
	[CREDIT_IND] [varchar](10) NULL,
	[CONT_HIGH] [varchar](10) NULL,
	[CONT_LOW] [varchar](10) NULL,
	[CONT_IND] [varchar](10) NULL,
	[LAB_HIGH] [varchar](10) NULL,
	[LAB_LOW] [varchar](10) NULL,
	[LAB_IND] [varchar](10) NULL,
	[LECT_HIGH] [varchar](10) NULL,
	[LECT_LOW] [varchar](10) NULL,
	[LECT_IND] [varchar](10) NULL,
	[OTH_HIGH] [varchar](10) NULL,
	[OTH_LOW] [varchar](10) NULL,
	[OTH_IND] [varchar](10) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannerCollege]    Script Date: 06/14/2012 14:45:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BannerCollege]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BannerCollege](
	[COLLEGE_CODE] [varchar](10) NULL,
	[COLL_DESCRIPTION] [varchar](255) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblJobname]    Script Date: 06/14/2012 14:49:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblJobname]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblJobname](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[jobname] [varchar](50) NULL,
	[jobtitle] [varchar](50) NULL,
	[jobdescr] [varchar](250) NULL,
	[frequency] [char](10) NULL,
	[parm1] [varchar](50) NULL,
	[parm2] [varchar](50) NULL,
	[starttime] [datetime] NULL,
	[endtime] [datetime] NULL,
	[counter] [int] NULL,
	[total] [int] NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [varchar](50) NULL,
	[firetime] [varchar](50) NULL,
	[jobruntime] [numeric](18, 0) NULL,
	[result] [text] NULL,
	[SS] [bit] NULL,
	[MM] [bit] NULL,
	[HH] [bit] NULL,
	[DD] [bit] NULL,
	[MN] [bit] NULL,
	[DW] [bit] NULL,
	[YY] [bit] NULL,
	[CMPS] [bit] NULL,
	[KIX] [bit] NULL,
	[ALPHA] [bit] NULL,
	[NUM] [bit] NULL,
	[TYPE] [bit] NULL,
	[TASK] [bit] NULL,
	[IDX] [bit] NULL,
 CONSTRAINT [PK_tblJobname] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannerDept]    Script Date: 06/14/2012 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BannerDept]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BannerDept](
	[DEPT_CODE] [varchar](10) NOT NULL,
	[DEPT_DESCRIPTION] [varchar](80) NULL,
 CONSTRAINT [PK_BannerDept] PRIMARY KEY CLUSTERED 
(
	[DEPT_CODE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannerDivision]    Script Date: 06/14/2012 14:45:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BannerDivision]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BannerDivision](
	[DIVISION_CODE] [varchar](10) NULL,
	[DIVS_DESCRIPTION] [varchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BannerTerms]    Script Date: 06/14/2012 14:45:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BannerTerms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BannerTerms](
	[TERM_CODE] [varchar](10) NULL,
	[TERM_DESCRIPTION] [varchar](255) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CCCM6100]    Script Date: 06/14/2012 14:45:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CCCM6100]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CCCM6100](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[type] [varchar](10) NULL,
	[Question_Number] [smallint] NULL,
	[CCCM6100] [text] NULL,
	[Question_Friendly] [varchar](50) NULL,
	[Question_Len] [smallint] NULL CONSTRAINT [DF__CCCM6100__Questi__727BF387]  DEFAULT (0),
	[Question_Max] [smallint] NULL,
	[Question_Type] [varchar](20) NULL,
	[Question_Ini] [varchar](20) NULL,
	[Question_Explain] [varchar](5) NULL,
	[Comments] [varchar](250) NULL,
	[rules] [bit] NULL,
	[rulesform] [varchar](50) NULL,
	[extra] [char](1) NULL,
	[permanent] [char](1) NULL,
	[append] [char](1) NULL,
	[len] [int] NULL,
	[counttext] [char](1) NULL,
 CONSTRAINT [aaaaaCCCM6100_PK] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CCCM6100]') AND name = N'PK_cccm6100_campus_qn')
CREATE NONCLUSTERED INDEX [PK_cccm6100_campus_qn] ON [dbo].[CCCM6100] 
(
	[campus] ASC,
	[Question_Number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CCCM6100]') AND name = N'PK_CCCM6100_Main')
CREATE NONCLUSTERED INDEX [PK_CCCM6100_Main] ON [dbo].[CCCM6100] 
(
	[campus] ASC,
	[type] ASC,
	[Question_Number] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jdbclog]    Script Date: 06/14/2012 14:45:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[jdbclog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[jdbclog](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[date] [datetime] NULL CONSTRAINT [DF_jdbclog_date]  DEFAULT (getdate()),
	[logger] [varchar](200) NULL,
	[priority] [varchar](50) NULL,
	[message] [text] NULL,
 CONSTRAINT [PK_jdbclog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[jdbclog]') AND name = N'PK_jdbclog_date')
CREATE NONCLUSTERED INDEX [PK_jdbclog_date] ON [dbo].[jdbclog] 
(
	[date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[jdbclog]') AND name = N'PK_jdbclog_logger')
CREATE NONCLUSTERED INDEX [PK_jdbclog_logger] ON [dbo].[jdbclog] 
(
	[logger] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  View [dbo].[zvw_AnnBerner]    Script Date: 06/14/2012 14:54:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[zvw_AnnBerner]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[zvw_AnnBerner]
AS
SELECT     *
FROM         (SELECT     campus, historyid, coursealpha, coursenum, MAX(approver_seq) AS approver_seq, approved
                       FROM          tblApprovalHist
                       GROUP BY campus, historyid, coursealpha, coursenum, approved
                       HAVING      (campus = ''LEE'') AND (MAX(approver_seq) = 2) AND (approved = 0)
                       UNION
                       SELECT     campus, historyid, coursealpha, coursenum, MAX(approver_seq) AS approver_seq, approved
                       FROM         tblApprovalHist
                       GROUP BY campus, historyid, coursealpha, coursenum, approved
                       HAVING      (campus = ''LEE'') AND (MAX(approver_seq) = 1) AND (approved = 1)) Tbl
'
GO
/****** Object:  View [dbo].[vw_CourseLastDisapprover]    Script Date: 06/14/2012 14:53:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseLastDisapprover]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CourseLastDisapprover]
AS
SELECT     campus, coursealpha, coursenum, MAX(seq) AS MaxOfseq
FROM         dbo.tblApprovalHist
GROUP BY campus, coursealpha, coursenum, approved
HAVING      (campus = ''LEECC'') AND (coursealpha = ''ICS'') AND (coursenum = ''241'') AND (approved = 1)
'
GO
/****** Object:  View [dbo].[vw_CourseLastApprover]    Script Date: 06/14/2012 14:53:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseLastApprover]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CourseLastApprover]
AS
SELECT     campus, coursealpha, coursenum, MAX(seq) AS MaxOfseq
FROM         dbo.tblApprovalHist
GROUP BY campus, coursealpha, coursenum, approved
HAVING      (campus = ''LEECC'') AND (coursealpha = ''ICS'') AND (coursenum = ''241'') AND (approved = - 1)
'
GO
/****** Object:  View [dbo].[vw_ApproverHistory]    Script Date: 06/14/2012 14:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ApproverHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ApproverHistory]
AS
SELECT     a1.historyid, a1.campus, a1.coursealpha, a1.coursenum, a1.dte, a1.approver_seq, a1.approver, a1.approved, CAST(a1.comments AS varchar(500)) 
                      AS comments
FROM         tblApprovalHist a1
UNION
SELECT     a2.historyid, a2.campus, a2.coursealpha, a2.coursenum, a2.dte, a2.approver_seq, a2.approver, a2.approved, CAST(a2.comments AS varchar(500)) 
                      AS comments
FROM         tblApprovalHist2 a2
'
GO
/****** Object:  View [dbo].[vw_ApprovalHistory]    Script Date: 06/14/2012 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ApprovalHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ApprovalHistory]
AS
SELECT     ta.campus, ta.coursealpha, ta.coursenum, ta.seq, ta.historyid, ta.approver, tu.title, tu.[position], ta.dte, ta.approved, tu.department, ta.inviter, ta.role,ta.approver_seq, ta.progress
FROM         dbo.tblApprovalHist ta, dbo.tblUsers tu
WHERE     ta.approver = tu.userid AND progress <> ''RECALLED''
UNION
SELECT     campus, coursealpha, coursenum, seq, historyid, approver, ''DISTRIBUTION LIST'', ''DISTRIBUTION LIST'', dte, approved, '''', '''', '''',0,''''
FROM         dbo.tblApprovalHist ta
WHERE     approver LIKE ''%]''
'
GO
/****** Object:  View [dbo].[vw_Incomplete_Assessment_2]    Script Date: 06/14/2012 14:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Incomplete_Assessment_2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Incomplete_Assessment_2]
AS
SELECT DISTINCT accjcid
FROM         dbo.tblAssessedData
'
GO
/****** Object:  View [dbo].[vw_AttachedLatestVersion]    Script Date: 06/14/2012 14:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_AttachedLatestVersion]'))
EXEC dbo.sp_executesql @statement = N'/*
	do not include id column in this view. This view contains the highest version 
	number for each file attached
*/
CREATE VIEW [dbo].[vw_AttachedLatestVersion]
AS
SELECT     TOP (100) PERCENT campus, category, MAX(version) AS version, historyid, fullname, filename
FROM         dbo.tblAttach
GROUP BY fullname, campus, historyid, category, historyid, campus, filename
ORDER BY campus, category, version
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_AttachedLatestVersion', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblAttach"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_AttachedLatestVersion'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vw_AttachedLatestVersion', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_AttachedLatestVersion'
GO
/****** Object:  View [dbo].[vw_WriteSyllabus]    Script Date: 06/14/2012 14:54:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_WriteSyllabus]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_WriteSyllabus]
AS
SELECT     TOP 100 PERCENT c.campus, c.CourseAlpha, c.CourseNum, dbo.BannerDept.DEPT_DESCRIPTION AS division, c.coursetitle AS title, c.credits, 
                      c.X17 AS recprep, c.coursedescr, dbo.tblCampusData.C25 AS prereq, dbo.tblCampusData.C26 AS coreq, c.X15 AS CoursePreReq, 
                      c.X16 AS CourseCoReq
FROM         dbo.tblCourse c INNER JOIN
                      dbo.BannerDept ON c.dispID = dbo.BannerDept.DEPT_CODE INNER JOIN
                      dbo.tblCampusData ON c.historyid = dbo.tblCampusData.historyid
WHERE     (c.CourseType = ''CUR'')
ORDER BY c.campus, c.CourseAlpha, c.CourseNum
'
GO
/****** Object:  View [dbo].[vw_programquestions]    Script Date: 06/14/2012 14:53:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_programquestions]'))
EXEC dbo.sp_executesql @statement = N'
/****** [dbo].[vw_programquestions]  ******/
CREATE VIEW [dbo].[vw_programquestions]
AS
SELECT TOP (100) PERCENT p.campus, p.questionseq, cc.Question_Number, p.question, cc.Question_Friendly, p.help, p.headertext
FROM dbo.tblProgramQuestions AS p INNER JOIN
dbo.CCCM6100 cc ON p.questionnumber = cc.Question_Number
AND p.type = cc.type
WHERE (p.type = N''Program'') AND (p.include = ''Y'') AND (cc.campus <> ''TTG'')
ORDER BY p.campus, p.questionseq
'
GO
/****** Object:  View [dbo].[vw_programitems]    Script Date: 06/14/2012 14:53:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_programitems]'))
EXEC dbo.sp_executesql @statement = N'
/* vw_programitems */
CREATE VIEW [dbo].[vw_programitems]
AS
SELECT     TOP (100) PERCENT c.id, c.campus, c61.Question_Number, c.questionseq AS Seq, c.question, c61.Question_Friendly AS Field_Name,
                      c61.Question_Len AS Length, c61.Question_Max AS Maximum, c.include, c.change, c.required, c.help, c61.Comments, c61.Question_Type,
                      c.len, c.counttext, c.extra
FROM         dbo.tblProgramQuestions AS c INNER JOIN
                      dbo.CCCM6100 AS c61 ON c.questionnumber = c61.Question_Number AND c.type = c61.type
WHERE     (c.type = ''Program'')
ORDER BY c.campus, Seq
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_programitems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "course"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c61"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_programitems'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vw_programitems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_programitems'
GO
/****** Object:  View [dbo].[vw_CCCM6100ByIDProgramItems]    Script Date: 06/14/2012 14:53:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CCCM6100ByIDProgramItems]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------- vw_CCCM6100ByIDProgramItems */
CREATE VIEW [dbo].[vw_CCCM6100ByIDProgramItems]
AS
SELECT     TOP (100) PERCENT c.id, c.campus, c.questionnumber, c.questionseq, c.question, c.include, c61.Question_Friendly, c61.Question_Type, c61.Question_Len,
                      c61.Question_Max, c61.Question_Ini, c61.Question_Explain, c.auditby, c.auditdate, c.help, c.change, c.required, c.helpfile, c.audiofile, c61.rules, c61.rulesform,
                      c.defalt, c.comments, c.len, c.counttext, c.extra, c.[permanent], c.append, c.headertext
FROM         dbo.tblProgramQuestions AS c INNER JOIN
                      dbo.CCCM6100 AS c61 ON c.questionnumber = c61.Question_Number AND c.type = c61.type
WHERE     (c.type = ''Program'')
ORDER BY c.id, c.campus, c.questionnumber
'
GO
/****** Object:  View [dbo].[vw_CCCM6100_Program]    Script Date: 06/14/2012 14:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CCCM6100_Program]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------- vw_CCCM6100_Program */
CREATE VIEW [dbo].[vw_CCCM6100_Program]
AS
SELECT     TOP (100) PERCENT c.campus, c.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Friendly,
                      c61.Question_Explain, c.question, c.include, c.change, c.required, c.helpfile, c.audiofile, c61.rules, c61.rulesform, c.defalt, c.comments, c.len, c.counttext, c.extra,
                      c.[permanent], c.append, c.headertext
FROM         dbo.CCCM6100 AS c61 INNER JOIN
                      dbo.tblProgramQuestions AS c ON c61.Question_Number = c.questionnumber AND c61.type = c.type
WHERE     (c61.campus = ''SYS'') AND (c.type = ''Progream'')
ORDER BY c.campus, c.questionseq, c61.campus
'
GO
/****** Object:  View [dbo].[vw_SLOByProgress_1]    Script Date: 06/14/2012 14:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SLOByProgress_1]'))
EXEC dbo.sp_executesql @statement = N'/*
	listing of SLOs with progress
 */
CREATE VIEW [dbo].[vw_SLOByProgress_1]
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.historyid, tcc.CourseAlpha, tcc.CourseNum, tc.coursetitle
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourse tc ON tcc.historyid = tc.historyid
WHERE     (tcc.CourseType = ''PRE'') OR
                      (tcc.CourseType = ''CUR'')
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum
'
GO
/****** Object:  View [dbo].[zz_Duplicates]    Script Date: 06/14/2012 14:54:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[zz_Duplicates]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[zz_Duplicates]
AS
SELECT     TOP 100 PERCENT campus, CourseAlpha, CourseNum
FROM         (SELECT     historyid, campus, CourseAlpha, CourseNum, CourseType, Progress, auditdate
                       FROM          tblCourse
                       WHERE      (CourseType = ''CUR'') AND (Progress = ''APPROVED'')) q2
GROUP BY campus, CourseAlpha, CourseNum
HAVING      (COUNT(campus) > 1)
ORDER BY campus, CourseAlpha, CourseNum
'
GO
/****** Object:  View [dbo].[vw_EffectiveTerms]    Script Date: 06/14/2012 14:53:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_EffectiveTerms]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_EffectiveTerms]
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
tc.coursetype=''CUR''
'
GO
/****** Object:  View [dbo].[vw_ApprovalsWithoutTasks]    Script Date: 06/14/2012 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ApprovalsWithoutTasks]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_ApprovalsWithoutTasks]
AS
SELECT     TOP 100 PERCENT outline, campus
FROM         (SELECT     campus, rtrim(coursealpha) + rtrim(coursenum) AS outline
                       FROM          tblCourse
                       WHERE      (progress = ''APPROVAL'' OR
                                              subprogress = ''REVIEW_IN_APPROVAL'') AND coursetype = ''PRE'') tblOutlines
WHERE     (outline NOT IN
                          (SELECT     tasks
                            FROM          (SELECT     campus, rtrim(coursealpha) + rtrim(coursenum) AS tasks
                                                    FROM          tblTasks
                                                    WHERE      (message = ''Approve outline'' OR
                                                                           message = ''Review outline'') AND coursetype = ''PRE'') AS tblTasks))
ORDER BY campus, outline

'
GO
/****** Object:  View [dbo].[vw_ApprovalStatus]    Script Date: 06/14/2012 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ApprovalStatus]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------------------------------------*/
/* approvalstatus										*/
/* ------------------------------------------*/
CREATE VIEW [dbo].[vw_ApprovalStatus]
AS
SELECT     TOP (100) PERCENT C_1.campus, C_1.id, C_1.historyid, C_1.CourseAlpha, C_1.CourseNum, C_1.coursetitle, C_1.route, C_1.proposer, C_1.Progress, C_1.subprogress,
                      C_1.dateproposed, C_1.auditdate, I_1.kid, C_1.CourseType
FROM         (SELECT     id, historyid, campus, CourseAlpha, CourseNum, Progress, coursetitle, route, proposer, subprogress, dateproposed, auditdate, CourseType
                       FROM          dbo.tblCourse AS c
                       WHERE      (CourseType = ''PRE'') AND (NOT (CourseAlpha IS NULL)) AND (CourseAlpha <> '''')) AS C_1 LEFT OUTER JOIN
                          (SELECT     campus, id, kid
                            FROM          dbo.tblINI AS i
                            WHERE      (category = ''ApprovalRouting'')) AS I_1 ON C_1.campus = I_1.campus AND I_1.id = C_1.route
WHERE     (C_1.route > 0)
ORDER BY C_1.campus, C_1.CourseAlpha, C_1.CourseNum
'
GO
/****** Object:  View [dbo].[vw_ReviewStatus]    Script Date: 06/14/2012 14:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ReviewStatus]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_ReviewStatus]
AS
SELECT  
	r.campus, c.CourseAlpha, c.CourseNum, r.userid, c.reviewdate, c.proposer, c.historyid, r.inviter, c.progress, c.subprogress
FROM 
	dbo.tblCourse AS c RIGHT OUTER JOIN
	dbo.tblReviewers AS r ON c.CourseAlpha = r.coursealpha 
	AND c.CourseNum = r.coursenum 
	AND c.campus = r.campus
WHERE
(c.coursetype=''PRE'' AND c.Progress = ''REVIEW'') 
OR
(c.coursetype=''PRE'' AND c.Progress = ''APPROVAL'' AND c.subprogress = ''REVIEW_IN_APPROVAL'')
'
GO
/****** Object:  View [dbo].[vw_SLO]    Script Date: 06/14/2012 14:53:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_SLO]
AS
SELECT     c.Campus, c.CourseAlpha, c.CourseNum, c.CourseType, a.id, c.Comp, a.AssessedBy, a.AssessedDate
FROM         dbo.tblCourseACCJC a INNER JOIN
                      dbo.tblCourseComp c ON a.CourseType = c.CourseType AND a.Campus = c.Campus AND a.CompID = c.CompID AND a.CourseNum = c.CourseNum AND 
                      a.CourseAlpha = c.CourseAlpha
GROUP BY c.Campus, c.CourseAlpha, c.CourseNum, c.CourseType, a.id, c.Comp, a.AssessedBy, a.AssessedDate
'
GO
/****** Object:  View [dbo].[vw_Incomplete_Assessment_1]    Script Date: 06/14/2012 14:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Incomplete_Assessment_1]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Incomplete_Assessment_1]
AS
SELECT     dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id AS accjcid
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseACCJC ON dbo.tblCourseComp.CompID = dbo.tblCourseACCJC.CompID
GROUP BY dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id, dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum,
                       dbo.tblCourseComp.CourseType, dbo.tblCourseComp.historyid
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionWOA]    Script Date: 06/14/2012 14:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionWOA]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionWOA]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''WOA'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionWIN]    Script Date: 06/14/2012 14:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionWIN]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionWIN]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''WIN'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionMAU]    Script Date: 06/14/2012 14:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionMAU]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionMAU]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''MAU'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionMAN]    Script Date: 06/14/2012 14:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionMAN]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionMAN]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''MAN'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionLEE]    Script Date: 06/14/2012 14:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionLEE]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionLEE]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''LEE'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescription]    Script Date: 06/14/2012 14:53:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescription]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescription]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionKAU]    Script Date: 06/14/2012 14:53:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionKAU]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionKAU]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''KAU'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionKAP]    Script Date: 06/14/2012 14:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionKAP]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionKAP]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''KAP'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionHON]    Script Date: 06/14/2012 14:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionHON]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionHON]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''HON'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionHIL]    Script Date: 06/14/2012 14:53:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionHIL]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionHIL]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''HIL'')
'
GO
/****** Object:  View [dbo].[vw_ACCJCDescriptionHAW]    Script Date: 06/14/2012 14:53:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJCDescriptionHAW]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJCDescriptionHAW]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     ('''' = ''HAW'')
'
GO
/****** Object:  View [dbo].[vw_Assessments]    Script Date: 06/14/2012 14:53:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Assessments]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Assessments]
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid, tca.assessment
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourseCompAss tcca ON tcc.CompID = tcca.compid INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid
'
GO
/****** Object:  View [dbo].[vw_CompsByAlphaNum]    Script Date: 06/14/2012 14:53:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CompsByAlphaNum]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CompsByAlphaNum]
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid, tcc.Comp
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourseCompAss tcca ON tcc.CompID = tcca.compid INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum
'
GO
/****** Object:  View [dbo].[vw_CompsByID]    Script Date: 06/14/2012 14:53:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CompsByID]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CompsByID]
AS
SELECT DISTINCT TOP 100 PERCENT tca.campus, tca.assessmentid, tcc.CourseAlpha + '' '' + tcc.CourseNum AS outline
FROM         dbo.tblCourseCompAss tcca INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid INNER JOIN
                      dbo.tblCourseComp tcc ON tcca.compid = tcc.CompID
ORDER BY tca.campus, tca.assessmentid
'
GO
/****** Object:  View [dbo].[vw_CompsByAlphaNumID]    Script Date: 06/14/2012 14:53:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CompsByAlphaNumID]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CompsByAlphaNumID]
AS
SELECT     TOP 100 PERCENT tca.campus, tcc.CourseAlpha, tcc.CourseNum, tca.assessmentid, tcc.CompID, tcc.Comp
FROM         dbo.tblCourseCompAss tcca INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid INNER JOIN
                      dbo.tblCourseComp tcc ON tcca.compid = tcc.CompID
ORDER BY tca.campus, tcc.CourseAlpha, tcc.CourseNum, tca.assessmentid
'
GO
/****** Object:  View [dbo].[vw_SLO2Assessment]    Script Date: 06/14/2012 14:53:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SLO2Assessment]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_SLO2Assessment]
AS
SELECT tcc.historyid, tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcc.CompID, tcca.assessmentid, tca.assessment
FROM tblCourseComp tcc, tblCourseCompAss tcca, tblCourseAssess tca
WHERE tcc.historyid = tcca.historyid AND 
tcc.CompID = tcca.compid AND
tcc.Campus = tca.campus AND 
tcca.assessmentid = tca.assessmentid
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency2Assessment]    Script Date: 06/14/2012 14:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency2Assessment]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency2Assessment]
AS
SELECT DISTINCT    TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tca.assessment AS Content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblCourseAssess tca ON tl2.item = tca.assessmentid
WHERE     (tl.src = ''X43'') AND (tl.dst = ''Assess'')
'
GO
/****** Object:  View [dbo].[vw_LinkedSLO2Assessment]    Script Date: 06/14/2012 14:53:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedSLO2Assessment]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedSLO2Assessment]
AS
SELECT DISTINCT    dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseCompAss.assessmentid, dbo.tblCourseAssess.assessment
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseCompAss ON dbo.tblCourseComp.historyid = dbo.tblCourseCompAss.historyid AND 
                      dbo.tblCourseComp.CompID = dbo.tblCourseCompAss.compid INNER JOIN
                      dbo.tblCourseAssess ON dbo.tblCourseCompAss.assessmentid = dbo.tblCourseAssess.assessmentid
'
GO
/****** Object:  View [dbo].[vw_Linked2SLO]    Script Date: 06/14/2012 14:53:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Linked2SLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Linked2SLO]
AS
SELECT DISTINCT tl.campus, tl.historyid, tl.src, tl.dst, tl.seq AS linkedseq, tl.id AS linkedid, tl2.item AS compid, tl2.item2, tc.Comp, tc.rdr AS comprdr
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.historyid = tl2.historyid AND tl.id = tl2.id INNER JOIN
                      dbo.tblCourseComp tc ON tl2.historyid = tc.historyid AND tl.campus = tc.Campus AND tl2.item = tc.CompID
WHERE     (tl.src = ''X43'') AND (tl.dst = ''SLO'' OR
                      tl.dst = ''Objectives'')
'
GO
/****** Object:  View [dbo].[vw_ACCJC_1]    Script Date: 06/14/2012 14:53:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJC_1]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJC_1]
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
'
GO
/****** Object:  Trigger [MoveToBackup]    Script Date: 06/14/2012 14:54:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[MoveToBackup]'))
EXEC dbo.sp_executesql @statement = N'
/* MoveToBackup */
CREATE TRIGGER [dbo].[MoveToBackup]
   ON  [dbo].[tblUserLog]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO tblUserLog2
	SELECT userid,script,[action],alpha,num,[datetime],campus,historyid
	FROM tblUserLog
	WHERE id = (SELECT MIN(id)FROM tblUserLog );

	DELETE FROM tblUserLog
	WHERE id = (SELECT MIN(id)FROM tblUserLog );

END
'
GO
/****** Object:  View [dbo].[vw_LinkedContent2Compentency]    Script Date: 06/14/2012 14:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedContent2Compentency]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedContent2Compentency]
AS
SELECT  DISTINCT   content.historyid, content.Campus, content.CourseAlpha, content.CourseNum, content.ContentID, tcl.id AS LinkedID, tcl2.item AS Linked2Item, 
                      comp.content
FROM         dbo.tblCourseContent content INNER JOIN
                      dbo.tblCourseLinked tcl ON content.historyid = tcl.historyid AND content.ContentID = tcl.seq INNER JOIN
                      dbo.tblCourseLinked2 tcl2 ON tcl.id = tcl2.id INNER JOIN
                      dbo.tblCourseCompetency comp ON content.historyid = comp.historyid AND tcl2.item = comp.seq
WHERE     (tcl.src = ''X19'') AND (tcl.dst = ''Competency'')
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency2PSLO]    Script Date: 06/14/2012 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency2PSLO]
AS
SELECT     tl.campus, tgc.src, tgc.historyid, tl.src AS fromSrc, tgc.src AS toSrc, tl.dst, tgc.id AS tgcID, tl.seq, tl.id, tl2.id AS [2tlID], tl2.item, tcc.seq AS [2tl2Item], 
							 tcc.rdr AS comprdr
FROM         dbo.tblGenericContent tgc INNER JOIN
							 dbo.tblCourseLinked tl ON tgc.historyid = tl.historyid INNER JOIN
							 dbo.tblCourseLinked2 tl2 ON tgc.historyid = tl2.historyid AND tl.id = tl2.id INNER JOIN
							 dbo.tblCourseCompetency tcc ON tgc.historyid = tcc.historyid AND tl2.item = tcc.seq
WHERE     (tgc.src = ''X72'') AND (tl.src = ''X72'') AND (tl.dst = ''Competency'')
'
GO
/****** Object:  View [dbo].[vw_LinkingContent2Competency]    Script Date: 06/14/2012 14:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingContent2Competency]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingContent2Competency]
AS
SELECT DISTINCT    dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq AS contentid, dbo.tblCourseLinked.dst, 
                      dbo.tblCourseLinked2.item AS competencyseq, dbo.tblCourseCompetency.content, dbo.tblCourseLinked.id AS LinkedID, 
                      dbo.tblCourseCompetency.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblCourseCompetency ON dbo.tblCourseLinked.historyid = dbo.tblCourseCompetency.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblCourseCompetency.seq
WHERE     (dbo.tblCourseLinked.src = ''X19'')
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency2Content]    Script Date: 06/14/2012 14:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency2Content]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency2Content]
AS
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tcc.LongContent AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblCourseContent tcc ON tl2.item = tcc.ContentID
WHERE     (tl.src = ''X43'') AND (tl.dst = ''Content'')
'
GO
/****** Object:  View [dbo].[vw_Approvers2]    Script Date: 06/14/2012 14:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Approvers2]'))
EXEC dbo.sp_executesql @statement = N'
/* vw_Approvers2 */
CREATE VIEW [dbo].[vw_Approvers2]
AS
SELECT     TOP (100) PERCENT approverid, approver_seq, approver, title, position, department, division, delegated, campus, experimental, route, startdate, enddate
FROM         (SELECT     a.approverid, a.approver_seq, a.approver, u.title, u.position, u.department, u.division, a.delegated, a.campus, a.experimental, a.route, a.startdate,
                                              a.enddate
                       FROM          dbo.tblUsers AS u RIGHT OUTER JOIN
                                              dbo.tblApprover AS a ON u.userid = a.approver AND u.campus = a.campus
                       UNION
                       SELECT     approverid, approver_seq, approver, ''DISTRIBUTION LIST'' AS Expr1, ''DISTRIBUTION LIST'' AS Expr2, '''' AS Expr3, '''' AS Expr4, '''' AS Expr5, campus,
                                             ''0'' AS experimental, route, startdate, enddate
                       FROM         dbo.tblApprover
                       WHERE     (approver LIKE ''%]'')) AS X
ORDER BY campus, approver_seq'
GO
/****** Object:  View [dbo].[vw_Linked2PSLO]    Script Date: 06/14/2012 14:53:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Linked2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Linked2PSLO]
AS
SELECT     dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.dst, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblGenericContent.src AS GenericSource, dbo.tblGenericContent.comments, 
                      dbo.tblGenericContent.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblGenericContent ON dbo.tblCourseLinked2.historyid = dbo.tblGenericContent.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblGenericContent.id
WHERE     (dbo.tblCourseLinked.dst = ''PSLO'')
'
GO
/****** Object:  View [dbo].[vw_GenericContent2Linked]    Script Date: 06/14/2012 14:53:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_GenericContent2Linked]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_GenericContent2Linked]
AS
SELECT     tl.historyid, tl.src, tl.seq, tl.id, tl2.item
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblGenericContent tg ON tl.historyid = tg.historyid AND tl.seq = tg.id AND tl.src = tg.src INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id
'
GO
/****** Object:  View [dbo].[vw_LinkedCountItems]    Script Date: 06/14/2012 14:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCountItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCountItems]
AS
SELECT  DISTINCT   tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, COUNT(tl2.item) AS counter
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id
GROUP BY tl.seq, tl.historyid, tl.src, tl.dst, tl.campus, tl.historyid, tl.src, tl.dst
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency2MethodEval]    Script Date: 06/14/2012 14:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency2MethodEval]
AS
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.id AS iniID
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''MethodEval'') AND (dbo.tblINI.category = ''MethodEval'')
'
GO
/****** Object:  View [dbo].[vw_LinkedSLO2GESLO]    Script Date: 06/14/2012 14:53:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedSLO2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedSLO2GESLO]
AS
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X18'') AND (tl.dst = ''GESLO'') AND (dbo.tblINI.category = ''GESLO'')
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency2GESLO]    Script Date: 06/14/2012 14:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency2GESLO]
AS
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''GESLO'') AND (dbo.tblINI.category = ''GESLO'')
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency]    Script Date: 06/14/2012 14:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency]
AS
SELECT  DISTINCT   campus, historyid, src,seq,
sum(CASE WHEN dst=''Assess'' THEN id ELSE 0 END) As Assess,
sum(CASE WHEN dst=''Content'' THEN id ELSE 0 END) As Content,
sum(CASE WHEN dst=''MethodEval'' THEN id ELSE 0 END) As MethodEval,
sum(CASE WHEN dst=''GESLO'' THEN id ELSE 0 END) As GESLO
FROM         tblCourseLinked
GROUP BY campus, historyid, src,seq
'
GO
/****** Object:  View [dbo].[vw_LinkingCompetency2PSLO]    Script Date: 06/14/2012 14:53:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingCompetency2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingCompetency2PSLO]
AS
SELECT     TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblGenericContent.comments, dbo.tblGenericContent.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblGenericContent ON dbo.tblCourseLinked.historyid = dbo.tblGenericContent.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblGenericContent.id
WHERE     (dbo.tblCourseLinked.src = ''X43'') AND (dbo.tblCourseLinked.dst = ''PSLO'') AND (dbo.tblGenericContent.src = ''X72'')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq
'
GO
/****** Object:  View [dbo].[vw_LinkingCompetency2MethodEval]    Script Date: 06/14/2012 14:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingCompetency2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingCompetency2MethodEval]
AS
SELECT   DISTINCT  TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''MethodEval'') AND (dbo.tblINI.category = ''MethodEval'')
'
GO
/****** Object:  View [dbo].[vw_LinkingCompetency2GESLO]    Script Date: 06/14/2012 14:53:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingCompetency2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingCompetency2GESLO]
AS
SELECT DISTINCT    TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''GESLO'') AND (dbo.tblINI.category = N''GESLO'')
'
GO
/****** Object:  View [dbo].[vw_LinkedSLO2MethodEval]    Script Date: 06/14/2012 14:53:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedSLO2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedSLO2MethodEval]
AS
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.id AS iniID
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X18'') AND (tl.dst = ''MethodEval'') AND (dbo.tblINI.category = ''MethodEval'')
'
GO
/****** Object:  View [dbo].[vw_LinkingSLO2PSLO]    Script Date: 06/14/2012 14:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingSLO2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingSLO2PSLO]
AS
SELECT     TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblGenericContent.comments, dbo.tblGenericContent.rdr
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblGenericContent ON dbo.tblCourseLinked.historyid = dbo.tblGenericContent.historyid AND 
                      dbo.tblCourseLinked2.item = dbo.tblGenericContent.id
WHERE     (dbo.tblCourseLinked.src = ''X18'') AND (dbo.tblCourseLinked.dst = ''PSLO'') AND (dbo.tblGenericContent.src = ''X72'')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq
'
GO
/****** Object:  View [dbo].[vw_LinkingSLO2MethodEval]    Script Date: 06/14/2012 14:53:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingSLO2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingSLO2MethodEval]
AS
SELECT  DISTINCT   TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblINI.category, dbo.tblINI.kdesc, dbo.tblINI.kid
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblINI ON dbo.tblCourseLinked.campus = dbo.tblINI.campus AND dbo.tblCourseLinked2.item = dbo.tblINI.id
WHERE     (dbo.tblCourseLinked.src = ''X18'') AND (dbo.tblCourseLinked.dst = ''MethodEval'') AND (dbo.tblINI.category = N''MethodEval'')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq
'
GO
/****** Object:  View [dbo].[vw_LinkingSLO2GESLO]    Script Date: 06/14/2012 14:53:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkingSLO2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkingSLO2GESLO]
AS
SELECT  DISTINCT  TOP 100 PERCENT dbo.tblCourseLinked.campus, dbo.tblCourseLinked.historyid, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq, 
                      dbo.tblCourseLinked.dst, dbo.tblCourseLinked.id, dbo.tblCourseLinked2.item, dbo.tblINI.kdesc, dbo.tblINI.kid
FROM         dbo.tblCourseLinked INNER JOIN
                      dbo.tblCourseLinked2 ON dbo.tblCourseLinked.historyid = dbo.tblCourseLinked2.historyid AND 
                      dbo.tblCourseLinked.id = dbo.tblCourseLinked2.id INNER JOIN
                      dbo.tblINI ON dbo.tblCourseLinked.campus = dbo.tblINI.campus AND dbo.tblCourseLinked2.item = dbo.tblINI.id
WHERE     (dbo.tblCourseLinked.src = ''X18'') AND (dbo.tblCourseLinked.dst = ''GESLO'') AND (dbo.tblINI.category = N''GESLO'')
ORDER BY dbo.tblCourseLinked.campus, dbo.tblCourseLinked.src, dbo.tblCourseLinked.seq
'
GO
/****** Object:  View [dbo].[vw_LinkedMatrix]    Script Date: 06/14/2012 14:53:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedMatrix]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_LinkedMatrix]
AS
SELECT DISTINCT TOP 100 PERCENT tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, tl.id, tl2.item, dbo.tblINI.kid AS shortdescr, dbo.tblINI.kdesc AS longdescr
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id LEFT OUTER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id AND tl.campus = dbo.tblINI.campus
ORDER BY tl.campus, tl.historyid, tl.src, tl.dst, tl.seq
'
GO
/****** Object:  View [dbo].[vw_ReviewerHistory]    Script Date: 06/14/2012 14:53:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ReviewerHistory]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_ReviewerHistory]
AS
SELECT     historyid, source, seq, item, acktion, dte, reviewer, campus, coursealpha, coursenum, comments, question
FROM         (SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                              CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM          tblReviewHist r INNER JOIN
                                              tblCourseQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = ''1'')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist r INNER JOIN
                                             tblCampusQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE  (r.source = ''2'')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist r INNER JOIN
                                             tblProgramQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE  (r.source = ''-1'')
		) ReviewHistory
UNION
SELECT     historyid, source, seq, item,acktion, dte, reviewer, campus, coursealpha, coursenum, comments, question
FROM         (SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                              CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM          tblReviewHist2 r INNER JOIN
                                              tblCourseQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE      (r.source = ''1'')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist2 r INNER JOIN
                                             tblCampusQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = ''2'')
                       UNION
                       SELECT     r.historyid, r.source, r.item, q.questionseq AS seq, r.acktion, r.dte, r.reviewer, r.campus, r.coursealpha, r.coursenum, 
                                             CAST(r.comments AS varchar(500)) AS comments, CAST(q.question AS varchar(500)) AS question
                       FROM         tblReviewHist2 r INNER JOIN
                                             tblProgramQuestions q ON r.campus = q.campus AND r.item = q.questionnumber
                       WHERE     (r.source = ''-1'')
		) ReviewHistory2

'
GO
/****** Object:  View [dbo].[vw_CCCM6100ByIDCampusItems]    Script Date: 06/14/2012 14:53:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CCCM6100ByIDCampusItems]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------- vw_CCCM6100ByIDCampusItems */
CREATE VIEW [dbo].[vw_CCCM6100ByIDCampusItems]
AS
SELECT     TOP (100) PERCENT c.campus, c.id, c.questionnumber, c.questionseq, c.question, c.include, c61.Question_Friendly, c61.Question_Type, c61.Question_Len,
                      c61.Question_Max, c61.Question_Ini, c61.Question_Explain, c.auditby, c.auditdate, c.help, ''N'' AS change, c.required, c.helpfile, c.audiofile, c61.rules, c61.rulesform,
                      c.defalt, c.comments, c.len, c.counttext, c.extra, c.append, c.[permanent], c.headertext
FROM         dbo.tblCampusQuestions AS c INNER JOIN
                      dbo.CCCM6100 AS c61 ON c.campus = c61.campus AND c.type = c61.type AND c.questionnumber = c61.Question_Number
WHERE     (c61.type = ''Campus'')
ORDER BY c.campus, c.id, c.questionnumber
'
GO
/****** Object:  View [dbo].[vw_CCCM6100_Campus]    Script Date: 06/14/2012 14:53:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CCCM6100_Campus]'))
EXEC dbo.sp_executesql @statement = N'/* ------------- vw_CCCM6100_Campus */
CREATE VIEW [dbo].[vw_CCCM6100_Campus]
AS
SELECT     TOP (100) PERCENT c.campus, c.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Friendly,
                      c61.Question_Explain, c.question, ''N'' AS change, c.required, c.helpfile, c.audiofile, c61.rules, c61.rulesform, c.defalt, c.comments, c.len, c.counttext, c.extra,
                      c.[permanent], c.append, c.headertext
FROM         dbo.CCCM6100 AS c61 INNER JOIN
                      dbo.tblCampusQuestions AS c ON c61.Question_Number = c.questionnumber AND c61.type = c.type AND c61.campus = c.campus
WHERE     (c61.type = ''Campus'') AND (c.type = ''Campus'')
ORDER BY c.campus, c.questionseq, c61.campus, c61.type
'
GO
/****** Object:  View [dbo].[vw_CampusQuestionsYN]    Script Date: 06/14/2012 14:53:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CampusQuestionsYN]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------------------------------------*/
/* vw_CampusQuestionsYN								*/
/* ------------------------------------------*/
CREATE VIEW [dbo].[vw_CampusQuestionsYN]
AS
SELECT     TOP (100) PERCENT campus.campus, campus.questionseq, CCCM6100.Question_Number, campus.question, CCCM6100.Question_Friendly,
                      campus.comments, CCCM6100.Question_Type, campus.headertext
FROM         CCCM6100 INNER JOIN
                      tblCampusQuestions AS campus ON CCCM6100.type = campus.type AND CCCM6100.campus = campus.campus AND
                      CCCM6100.Question_Number = campus.questionnumber
WHERE     (campus.type = ''Campus'')
ORDER BY campus.campus, campus.questionseq
'
GO
/****** Object:  View [dbo].[vw_CampusItems]    Script Date: 06/14/2012 14:53:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CampusItems]'))
EXEC dbo.sp_executesql @statement = N'
/* vw_CampusItems */
CREATE VIEW [dbo].[vw_CampusItems]
AS
SELECT     TOP (100) PERCENT c.id, c.campus, c61.Question_Number, c.questionseq AS Seq, c61.Question_Friendly AS Field_Name,
                      c.question, c61.Question_Len AS Length, c61.Question_Max AS Maximum, c.include, ''N'' AS change, c61.type, c.required,
                      c.help, c61.Comments, c61.Question_Type, c.len, c.counttext, c.extra
FROM         dbo.tblCampusQuestions AS c INNER JOIN
                      dbo.CCCM6100 AS c61 ON c.questionnumber = c61.Question_Number AND c.type = c61.type AND c.campus = c61.campus
ORDER BY c.campus, Seq
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_CampusItems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "campus"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c61"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_CampusItems'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vw_CampusItems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_CampusItems'
GO
/****** Object:  View [dbo].[vw_CampusQuestions]    Script Date: 06/14/2012 14:53:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CampusQuestions]'))
EXEC dbo.sp_executesql @statement = N'
/* vw_CampusQuestions */
CREATE VIEW [dbo].[vw_CampusQuestions]
AS
SELECT TOP (100) PERCENT c.campus, c.questionseq, cc.Question_Number, c.question, cc.Question_Friendly, c.comments, c.help, c.headertext
FROM dbo.CCCM6100 cc INNER JOIN
dbo.tblCampusQuestions AS c
ON cc.type = c.type AND cc.campus = c.campus
AND cc.Question_Number = c.questionnumber
WHERE (c.type = ''Campus'') AND (c.include = ''Y'')
ORDER BY c.campus, c.questionseq
'
GO
/****** Object:  View [dbo].[vw_SystemQuestionsInUse]    Script Date: 06/14/2012 14:54:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SystemQuestionsInUse]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_SystemQuestionsInUse]
AS
SELECT     DERIVEDTBL.questionnumber, DERIVEDTBL.In_Use, dbo.CCCM6100.CCCM6100 AS Question
FROM         (SELECT     questionnumber AS questionnumber, COUNT(questionnumber) AS In_Use
                       FROM          (SELECT     tc.questionnumber
                                               FROM          tblCourseQuestions tc INNER JOIN
                                                                      CCCM6100 ON tc.questionnumber = CCCM6100.Question_Number
                                               WHERE      (CCCM6100.campus = ''SYS'') AND (tc.include = ''Y'') AND (CCCM6100.type = ''Course'')
                                               GROUP BY tc.questionnumber, tc.campus
                                               HAVING      (tc.campus IN (''HIL'', ''LEE'', ''KAP'', ''UHMC''))) DERIVEDTBL
                       GROUP BY questionnumber) DERIVEDTBL INNER JOIN
                      dbo.CCCM6100 ON DERIVEDTBL.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.campus = ''SYS'') AND (dbo.CCCM6100.type = ''Course'')
'
GO
/****** Object:  View [dbo].[vw_CourseItems]    Script Date: 06/14/2012 14:53:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseItems]'))
EXEC dbo.sp_executesql @statement = N'/* vw_CourseItems */
CREATE VIEW [dbo].[vw_CourseItems]
AS
SELECT TOP (100) PERCENT c.id, c.campus, c61.Question_Number, c.questionseq AS Seq, c.question,
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, c.include, c.change, c.required,
                       c61.campus AS C61Campus, c.help, c61.Comments, c61.Question_Type, c.len, c.counttext, c.extra
FROM         dbo.tblCourseQuestions AS c INNER JOIN
                      dbo.CCCM6100 AS c61 ON c.questionnumber = c61.Question_Number AND c.type = c61.type
WHERE     (c.type = ''Course'') AND (c61.campus = ''SYS'')
ORDER BY c.campus, Seq
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_CourseItems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "course"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c61"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_CourseItems'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vw_CourseItems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_CourseItems'
GO
/****** Object:  View [dbo].[vw_CourseQuestionsYN]    Script Date: 06/14/2012 14:53:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseQuestionsYN]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------------------------------------*/
/* vw_CourseQuestionsYN								*/
/* ------------------------------------------*/
CREATE VIEW [dbo].[vw_CourseQuestionsYN]
AS
SELECT     TOP (100) PERCENT course.campus, course.questionseq, CCCM6100.Question_Number, course.question, CCCM6100.Question_Friendly,
                      CCCM6100.Question_Type, course.headertext
FROM         tblCourseQuestions AS course INNER JOIN
                      CCCM6100 ON course.questionnumber = CCCM6100.Question_Number AND course.type = CCCM6100.type
WHERE     (course.type = ''Course'')
ORDER BY course.campus, course.questionseq
'
GO
/****** Object:  View [dbo].[vw_CourseQuestions]    Script Date: 06/14/2012 14:53:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseQuestions]'))
EXEC dbo.sp_executesql @statement = N'
/* vw_CourseQuestions */
CREATE VIEW [dbo].[vw_CourseQuestions]
AS
SELECT TOP (100) PERCENT c.campus, c.questionseq, cc.Question_Number, c.question, cc.Question_Friendly, c.help, c.headertext
FROM dbo.tblCourseQuestions AS c INNER JOIN
dbo.CCCM6100 cc ON c.questionnumber = cc.Question_Number
AND c.type = cc.type
WHERE (c.type = ''Course'') AND (c.include = ''Y'')
ORDER BY c.campus, c.questionseq
'
GO
/****** Object:  View [dbo].[vw_CCCM6100ByIDCampusCourse]    Script Date: 06/14/2012 14:53:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CCCM6100ByIDCampusCourse]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------- vw_CCCM6100ByIDCampusCourse */
CREATE VIEW [dbo].[vw_CCCM6100ByIDCampusCourse]
AS
SELECT     TOP (100) PERCENT c.id, c.campus, c.questionnumber, c.questionseq, c.question, c.include, c61.Question_Friendly, c61.Question_Type, c61.Question_Len,
                      c61.Question_Max, c61.Question_Ini, c61.Question_Explain, c.auditby, c.auditdate, c.help, c.change, c.required, c.helpfile, c.audiofile, c61.rules, c61.rulesform,
                      c.defalt, c.comments, c.len, c.counttext, c.extra, c.[permanent], c.append, c.headertext
FROM         dbo.tblCourseQuestions AS c INNER JOIN
                      dbo.CCCM6100 AS c61 ON c.questionnumber = c61.Question_Number AND c.type = c61.type
WHERE     (c.type = ''Course'')
ORDER BY c.id, c.campus, c.questionnumber
'
GO
/****** Object:  View [dbo].[vw_CCCM6100_Sys]    Script Date: 06/14/2012 14:53:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CCCM6100_Sys]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------- vw_CCCM6100_Sys */
CREATE VIEW [dbo].[vw_CCCM6100_Sys]
AS
SELECT     TOP (100) PERCENT c.campus, c.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Friendly,
                      c61.Question_Explain, c.question, c.include, c.change, c.required, c.helpfile, c.audiofile, c61.rules, c61.rulesform, c.defalt, c.comments, c.len, c.counttext, c.extra,
                      c.[permanent], c.append, c.headertext
FROM         dbo.CCCM6100 AS c61 INNER JOIN
                      dbo.tblCourseQuestions AS c ON c61.Question_Number = c.questionnumber AND c61.type = c.type
WHERE     (c61.campus = ''SYS'') AND (c.type = ''Course'')
ORDER BY c.campus, c.questionseq, c61.campus
'
GO
/****** Object:  View [dbo].[vw_ProgramDepartmentChairs]    Script Date: 06/14/2012 14:53:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ProgramDepartmentChairs]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_ProgramDepartmentChairs]
AS
SELECT     TOP 100 PERCENT dbo.tblDivision.campus, dbo.tblDivision.divisionname, dbo.tblChairs.coursealpha, dbo.tblDivision.chairname, 
                      dbo.tblChairs.programid, dbo.tblDivision.delegated
FROM         dbo.tblDivision INNER JOIN
                      dbo.tblChairs ON dbo.tblDivision.divid = dbo.tblChairs.programid
ORDER BY dbo.tblDivision.campus, dbo.tblChairs.coursealpha

'
GO
/****** Object:  View [dbo].[vw_ProgramForViewing]    Script Date: 06/14/2012 14:53:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ProgramForViewing]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_ProgramForViewing]
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
'
GO
/****** Object:  View [dbo].[vw_Mode2]    Script Date: 06/14/2012 14:53:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Mode2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Mode2]
AS
SELECT dbo.tblMode.id, dbo.tblMode.campus, dbo.tblMode.mode, dbo.tblMode.item, dbo.tblMode.override, dbo.tblMode2.seq, 
		dbo.tblMode2.item AS requireditem
FROM dbo.tblMode INNER JOIN
dbo.tblMode2 ON dbo.tblMode.id = dbo.tblMode2.id
'
GO
/****** Object:  View [dbo].[vw_Mode]    Script Date: 06/14/2012 14:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Mode]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Mode]
AS
SELECT     tm.id, tm.campus, tm.mode, tm.item, tcq.questionnumber, tcq.questionseq, tcq.question, tm.override
FROM         dbo.tblCourseQuestions tcq INNER JOIN
                      dbo.CCCM6100 c61 ON tcq.questionnumber = c61.Question_Number INNER JOIN
                      dbo.tblMode tm ON tcq.campus = tm.campus AND c61.Question_Friendly = tm.item
WHERE     (c61.campus = ''SYS'') AND (c61.type = ''Course'')
'
GO
/****** Object:  View [dbo].[vw_ReviewerComments]    Script Date: 06/14/2012 14:53:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ReviewerComments]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ReviewerComments]
AS
SELECT     tr2.historyid, tr2.campus, tr2.coursealpha, tr2.coursenum, tr2.item, tcq.questionseq, tr2.dte, tr2.reviewer, tr2.comments, tr2.acktion
FROM         dbo.tblReviewHist2 tr2 INNER JOIN
                      dbo.tblCourseQuestions tcq ON tr2.campus = tcq.campus AND tr2.item = tcq.questionnumber
'
GO
/****** Object:  View [dbo].[vw_Approvers]    Script Date: 06/14/2012 14:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Approvers]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Approvers]
AS
SELECT TOP 100 PERCENT u.campus, a.approver_seq, a.approver, a.delegated, u.[position], u.division
FROM dbo.tblApprover a, dbo.tblUsers u
WHERE a.approver = u.userid
ORDER BY a.approver_seq
'
GO
/****** Object:  View [dbo].[vw_ApproversNoDivisionChair]    Script Date: 06/14/2012 14:53:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ApproversNoDivisionChair]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ApproversNoDivisionChair]
AS
SELECT     ta.approver_seq AS Sequence, ta.approver, tu.title, tu.[position], tu.department, tu.campus, ta.route
FROM         dbo.tblApprover ta INNER JOIN
                      dbo.tblUsers tu ON ta.approver = tu.userid
WHERE     (tu.[position] NOT LIKE ''D% CHAIR'')
UNION
SELECT     approver_seq AS Sequence, approver, ''DISTRIBUTION LIST'', ''DISTRIBUTION LIST'', '''', campus, route
FROM         dbo.tblApprover
WHERE     approver LIKE ''%]''
'
GO
/****** Object:  View [dbo].[vw_ApproversDivisionChair]    Script Date: 06/14/2012 14:53:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ApproversDivisionChair]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ApproversDivisionChair]
AS
SELECT     ta.approver_seq AS Sequence, ta.approver, tu.title, tu.[position], tu.department, tu.campus, ta.route
FROM         dbo.tblApprover ta INNER JOIN
                      dbo.tblUsers tu ON ta.approver = tu.userid
WHERE     (tu.[position] LIKE ''D% CHAIR'')
'
GO
/****** Object:  View [dbo].[vw_OutlineValidation]    Script Date: 06/14/2012 14:53:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_OutlineValidation]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_OutlineValidation]
AS
SELECT 	tc.campus, tc.questionnumber, tc.questionseq, c.Question_Friendly
FROM 		tblCourseQuestions tc INNER JOIN
		CCCM6100 c ON tc.questionnumber = c.Question_Number
WHERE 	(tc.include = ''Y'') AND 
		(tc.required = ''Y'') AND 
		(c.campus = ''SYS'') AND 
		(c.type = ''Course'')
'
GO
/****** Object:  View [dbo].[vw_ResequenceCourseItems]    Script Date: 06/14/2012 14:53:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ResequenceCourseItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ResequenceCourseItems]
AS
SELECT     TOP 100 PERCENT tcc.campus, tcc.questionseq, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions tcc INNER JOIN
                      dbo.CCCM6100 ON tcc.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.type = ''Course'') AND (tcc.include = ''Y'')
ORDER BY tcc.campus, tcc.questionseq
'
GO
/****** Object:  View [dbo].[vw_ResequenceCampusItems]    Script Date: 06/14/2012 14:53:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ResequenceCampusItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ResequenceCampusItems]
AS
SELECT     TOP 100 PERCENT dbo.tblCampusQuestions.campus, dbo.tblCampusQuestions.questionseq, dbo.CCCM6100.Question_Friendly, 
                      dbo.tblCampusQuestions.type, dbo.tblCampusQuestions.include
FROM         dbo.tblCampusQuestions INNER JOIN
                      dbo.CCCM6100 ON dbo.tblCampusQuestions.type = dbo.CCCM6100.type AND dbo.tblCampusQuestions.campus = dbo.CCCM6100.campus AND 
                      dbo.tblCampusQuestions.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.tblCampusQuestions.type = ''Campus'') AND (dbo.tblCampusQuestions.include = ''Y'')
ORDER BY dbo.tblCampusQuestions.campus, dbo.tblCampusQuestions.questionseq
'
GO
/****** Object:  View [dbo].[vw_ResequenceProgramItems]    Script Date: 06/14/2012 14:53:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ResequenceProgramItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ResequenceProgramItems]
AS
SELECT     TOP 100 PERCENT tcc.campus, tcc.questionseq, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblProgramQuestions tcc INNER JOIN
                      dbo.CCCM6100 ON tcc.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.type = ''Program'') AND (tcc.include = ''Y'') AND (dbo.CCCM6100.campus <> ''TTG'')
ORDER BY tcc.campus, tcc.questionseq
'
GO
/****** Object:  View [dbo].[vw_CourseLastDisapproverX]    Script Date: 06/14/2012 14:53:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseLastDisapproverX]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CourseLastDisapproverX]
AS
SELECT     dbo.vw_CourseLastDisapprover.campus, dbo.vw_CourseLastDisapprover.coursealpha, dbo.vw_CourseLastDisapprover.coursenum, 
                      dbo.tblApprovalHist.approver
FROM         dbo.vw_CourseLastDisapprover INNER JOIN
                      dbo.tblApprovalHist ON dbo.vw_CourseLastDisapprover.campus = dbo.tblApprovalHist.campus AND 
                      dbo.vw_CourseLastDisapprover.coursealpha = dbo.tblApprovalHist.coursealpha AND 
                      dbo.vw_CourseLastDisapprover.coursenum = dbo.tblApprovalHist.coursenum AND 
                      dbo.vw_CourseLastDisapprover.MaxOfseq = dbo.tblApprovalHist.seq
'
GO
/****** Object:  View [dbo].[vw_CourseLastApproverX]    Script Date: 06/14/2012 14:53:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CourseLastApproverX]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_CourseLastApproverX]
AS
SELECT     dbo.vw_CourseLastApprover.campus, dbo.vw_CourseLastApprover.coursealpha, dbo.vw_CourseLastApprover.coursenum, 
                      dbo.tblApprovalHist.approver
FROM         dbo.vw_CourseLastApprover INNER JOIN
                      dbo.tblApprovalHist ON dbo.vw_CourseLastApprover.MaxOfseq = dbo.tblApprovalHist.seq AND 
                      dbo.vw_CourseLastApprover.coursenum = dbo.tblApprovalHist.coursenum AND 
                      dbo.vw_CourseLastApprover.coursealpha = dbo.tblApprovalHist.coursealpha AND dbo.vw_CourseLastApprover.campus = dbo.tblApprovalHist.campus
'
GO
/****** Object:  View [dbo].[vw_ACCJC_2]    Script Date: 06/14/2012 14:53:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ACCJC_2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_ACCJC_2]
AS
SELECT     TOP 100 PERCENT dbo.vw_ACCJC_1.Campus, dbo.vw_ACCJC_1.CourseAlpha, dbo.vw_ACCJC_1.CourseNum, dbo.vw_ACCJC_1.CourseType, 
                      dbo.vw_ACCJC_1.CompID, dbo.vw_ACCJC_1.assessmentid, dbo.vw_ACCJC_1.Comp, dbo.tblCourseAssess.assessment
FROM         dbo.vw_ACCJC_1 INNER JOIN
                      dbo.tblCourseAssess ON dbo.vw_ACCJC_1.assessmentid = dbo.tblCourseAssess.assessmentid AND 
                      dbo.vw_ACCJC_1.Campus = dbo.tblCourseAssess.campus
ORDER BY dbo.vw_ACCJC_1.Campus, dbo.vw_ACCJC_1.CourseAlpha, dbo.vw_ACCJC_1.CourseNum, dbo.vw_ACCJC_1.CourseType, dbo.vw_ACCJC_1.CompID, 
                      dbo.vw_ACCJC_1.assessmentid
'
GO
/****** Object:  View [dbo].[vw_Incomplete_Assessment_4]    Script Date: 06/14/2012 14:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Incomplete_Assessment_4]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Incomplete_Assessment_4]
AS
SELECT DISTINCT dbo.tblAssessedData.accjcid
FROM         dbo.vw_Incomplete_Assessment_2 INNER JOIN
                      dbo.tblAssessedData ON dbo.vw_Incomplete_Assessment_2.accjcid = dbo.tblAssessedData.accjcid
WHERE     (dbo.tblAssessedData.question IS NULL)
'
GO
/****** Object:  View [dbo].[vw_LinkedCompetency2]    Script Date: 06/14/2012 14:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_LinkedCompetency2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_LinkedCompetency2]
AS
SELECT  DISTINCT     vw.campus, vw.historyid, vw.src, vw.seq, vw.Assess, vw.GESLO, vw.Content, vw.MethodEval, tcc.content AS Competency
FROM         dbo.vw_LinkedCompetency vw INNER JOIN
                      dbo.tblCourseCompetency tcc ON vw.historyid = tcc.historyid AND vw.seq = tcc.seq
'
GO
/****** Object:  View [dbo].[vw_AllQuestions]    Script Date: 06/14/2012 14:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_AllQuestions]'))
EXEC dbo.sp_executesql @statement = N'
/* ------------------------------------------*/
/* vw_AllQuestions				              */
/* ------------------------------------------*/
CREATE VIEW [dbo].[vw_AllQuestions]
AS
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(2000)) AS question, cast(headertext AS varchar(2000)) AS headertext
FROM         vw_CourseQuestionsYN
WHERE     questionseq > 0
UNION
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(2000)) AS question, cast(headertext AS varchar(2000)) AS headertext
FROM         vw_CampusQuestionsYN
WHERE     questionseq > 0
'
GO
/****** Object:  View [dbo].[vw_Incomplete_Assessment_3]    Script Date: 06/14/2012 14:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Incomplete_Assessment_3]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Incomplete_Assessment_3]
AS
SELECT     historyid, accjcid
FROM         dbo.vw_Incomplete_Assessment_1
WHERE     (accjcid NOT IN
                          (SELECT     ACCJCID
                            FROM          vw_Incomplete_Assessment_2))
'
GO
/****** Object:  View [dbo].[vw_SLOByProgress_2]    Script Date: 06/14/2012 14:54:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SLOByProgress_2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_SLOByProgress_2]
AS
SELECT     TOP 100 PERCENT dbo.vw_SLOByProgress_1.historyid, dbo.vw_SLOByProgress_1.Campus, dbo.vw_SLOByProgress_1.CourseAlpha, 
                      dbo.vw_SLOByProgress_1.CourseNum, dbo.vw_SLOByProgress_1.coursetitle, dbo.tblSLO.progress, dbo.tblSLO.auditby AS Proposer
FROM         dbo.vw_SLOByProgress_1 INNER JOIN
                      dbo.tblSLO ON dbo.vw_SLOByProgress_1.historyid = dbo.tblSLO.hid
ORDER BY dbo.vw_SLOByProgress_1.Campus, dbo.vw_SLOByProgress_1.CourseAlpha, dbo.vw_SLOByProgress_1.CourseNum
'
GO
/****** Object:  View [dbo].[vw_Incomplete_Assessment_5]    Script Date: 06/14/2012 14:53:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Incomplete_Assessment_5]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Incomplete_Assessment_5]
AS
SELECT     accjcid
FROM         dbo.vw_Incomplete_Assessment_3
UNION
SELECT     accjcid
FROM         vw_Incomplete_Assessment_4
'
GO
/****** Object:  View [dbo].[vw_Incomplete_Assessment_6]    Script Date: 06/14/2012 14:53:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Incomplete_Assessment_6]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vw_Incomplete_Assessment_6]
AS
SELECT     dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum, dbo.tblCourseComp.CourseType, 
                      dbo.vw_Incomplete_Assessment_1.CompID, dbo.vw_Incomplete_Assessment_1.accjcid, dbo.tblCourseComp.Comp
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.vw_Incomplete_Assessment_5 INNER JOIN
                      dbo.vw_Incomplete_Assessment_1 ON dbo.vw_Incomplete_Assessment_5.accjcid = dbo.vw_Incomplete_Assessment_1.accjcid ON 
                      dbo.tblCourseComp.CompID = dbo.vw_Incomplete_Assessment_1.CompID
'
GO
