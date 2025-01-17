USE [ccv2]
GO
/****** Object:  Table [dbo].[answers]    Script Date: 03/27/2011 19:45:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[answers]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[answers]
GO
/****** Object:  Table [dbo].[faq]    Script Date: 03/27/2011 19:45:15 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[faq]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[faq]
GO
/****** Object:  Table [dbo].[forums]    Script Date: 03/27/2011 19:45:19 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[forums]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[forums]
GO
/****** Object:  Table [dbo].[tblJobname]    Script Date: 03/27/2011 19:45:25 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[tblJobname]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[tblJobname]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 03/27/2011 19:45:22 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[messages]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[messages]
GO
/****** Object:  Table [dbo].[answers]    Script Date: 03/27/2011 19:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[answers]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[answers](
	[id] [numeric](18, 0) NOT NULL,
	[seq] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[score] [int] NULL,
	[answer] [text] NULL,
	[accepted] [bit] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_faq] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[faq]    Script Date: 03/27/2011 19:45:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[faq]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[faq](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[category] [varchar](30) NULL,
	[question] [varchar](1000) NULL,
	[answeredseq] [int] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_faq_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[forums]    Script Date: 03/27/2011 19:45:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[forums]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[forums](
	[forum_id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[creator] [varchar](50) NULL,
	[requestor] [varchar](50) NULL,
	[forum_name] [varchar](50) NULL,
	[forum_description] [text] NULL,
	[forum_start_date] [datetime] NULL,
	[forum_grouping] [char](20) NULL,
	[src] [varchar](50) NULL,
	[counter] [int] NULL,
	[status] [varchar](20) NULL,
	[priority] [int] NULL,
	[auditdate] [smalldatetime] NULL,
	[createddate] [smalldatetime] NULL,
	[edit] [char](1) NULL,
	[auditby] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblJobname]    Script Date: 03/27/2011 19:45:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[tblJobname]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[tblJobname](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[jobname] [varchar](50) NULL,
	[jobtitle] [varchar](50) NULL,
	[jobdescr] [varchar](250) NULL,
	[frequency] [char](10) NULL,
	[parm1] [varchar](50) NULL,
	[parm2] [varchar](50) NULL,
	[starttime] [smalldatetime] NULL,
	[endtime] [smalldatetime] NULL,
	[counter] [int] NULL,
	[total] [int] NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [varchar](50) NULL,
	[firetime] [varchar](50) NULL,
	[jobruntime] [numeric](18, 0) NULL,
	[result] [text] NULL,
 CONSTRAINT [PK_tblJobname] PRIMARY KEY CLUSTERED 
(
	[id] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[messages]    Script Date: 03/27/2011 19:45:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[messages]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
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
	[message_timestamp] [datetime] NULL,
	[message_subject] [varchar](100) NULL,
	[message_body] [text] NULL,
	[message_Approved] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
