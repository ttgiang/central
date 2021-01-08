/****** Object:  Table [tblTempCourseACCJC]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseACCJC]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseACCJC](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCourseAssess]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseAssess]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseAssess](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCourseComp]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseComp]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseComp](
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
/****** Object:  Table [tblTempCourseCompAss]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseCompAss]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseCompAss](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCourseCompetency]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseCompetency]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseCompetency](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCourseContent]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseContent](
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
/****** Object:  Table [tblTempCourseContentSLO]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseContentSLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseContentSLO](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCourseLinked]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseLinked]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseLinked](
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
/****** Object:  Table [tblTempCourseLinked2]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourseLinked2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourseLinked2](
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
/****** Object:  Table [tblTempExtra]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempExtra]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempExtra](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempGenericContent]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempGenericContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempGenericContent](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempGESLO]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempGESLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempGESLO](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTemplate]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTemplate](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tbltempPrograms]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tbltempPrograms]') AND type in (N'U'))
BEGIN
CREATE TABLE [tbltempPrograms](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempPreReq]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempPreReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempPreReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblTempPreReq_id]  DEFAULT (0),
	[PrereqAlpha] [char](4) NULL,
	[PrereqNum] [char](4) NULL,
	[Grading] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempPreReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempPreR__rdr__7C8F6DA6]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblTempPr__conse__57B2EEB2]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblTempPr__pendi__5F54107A]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempXRef]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempXRef]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempXRef](
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
/****** Object:  Table [tblTest]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTest]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTest](
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
/****** Object:  Table [tblText]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblText]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblText](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblUploads]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblUploads]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblUploads](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblUserLog]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblUserLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblUserLog](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblValues]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblValues]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblValues](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[topic] [varchar](50) NULL,
	[subtopic] [varchar](50) NULL,
	[shortdescr] [varchar](500) NULL,
	[longdescr] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[valueid] [int] NULL,
	[seq] [int] NULL,
	[src] [varchar](50) NULL,
 CONSTRAINT [PK_tblValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblValuesdata]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblValuesdata]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblValuesdata](
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
/****** Object:  Table [tblXRef]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblXRef]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblXRef](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [BannerDept]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BannerDept]') AND type in (N'U'))
BEGIN
CREATE TABLE [BannerDept](
	[DEPT_CODE] [varchar](10) NOT NULL,
	[DEPT_DESCRIPTION] [varchar](80) NULL,
 CONSTRAINT [PK_BannerDept] PRIMARY KEY CLUSTERED 
(
	[DEPT_CODE] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblUsersX]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblUsersX]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblUsersX](
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
/****** Object:  Table [BannerTerms]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BannerTerms]') AND type in (N'U'))
BEGIN
CREATE TABLE [BannerTerms](
	[TERM_CODE] [varchar](10) NULL,
	[TERM_DESCRIPTION] [varchar](255) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [CCCM6100]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[CCCM6100]') AND type in (N'U'))
BEGIN
CREATE TABLE [CCCM6100](
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
 CONSTRAINT [aaaaaCCCM6100_PK] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblApprovalHist]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblApprovalHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblApprovalHist](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblApprovalHist2]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblApprovalHist2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblApprovalHist2](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblAssessedData]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblAssessedData]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblAssessedData](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblAttach]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblAttach]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblAttach](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCampusData]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCampusData]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCampusData](
	[id] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblCampusData_id]  DEFAULT ((0)),
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
 CONSTRAINT [PK_tblCampusData] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCampusQuestions]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCampusQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCampusQuestions](
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
 CONSTRAINT [PK_tblCampusQuestions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblChairs]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblChairs]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblChairs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[programid] [int] NOT NULL,
	[coursealpha] [varchar](10) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourse]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourse]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourse](
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
	[articulation] [varchar](50) NULL,
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
	[MESSAGEPAGE05] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseACCJC]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseACCJC]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseACCJC](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseAssess]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseAssess]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseAssess](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseComp]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseComp]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseComp](
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
/****** Object:  Table [tblCourseCompAss]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseCompAss]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseCompAss](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseCompetency]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseCompetency]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseCompetency](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseContent]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseContent](
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
/****** Object:  Table [tblCourseLinked]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseLinked]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseLinked](
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
/****** Object:  Table [tblCourseLinked2]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseLinked2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseLinked2](
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
/****** Object:  Table [tblCourseQuestions]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseQuestions](
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
 CONSTRAINT [PK_tblCourseQuestions] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[campus] ASC,
	[type] ASC,
	[questionnumber] ASC,
	[questionseq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblDivision]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblDivision]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblDivision](
	[divid] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[divisioncode] [varchar](20) NULL,
	[divisionname] [varchar](100) NULL,
	[chairname] [varchar](50) NULL,
	[delegated] [varchar](50) NULL,
 CONSTRAINT [PK_tblDivision] PRIMARY KEY CLUSTERED 
(
	[divid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblGenericContent]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblGenericContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblGenericContent](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblINI]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblINI]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblINI](
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
	[note] [text] NULL,
 CONSTRAINT [PK_tblINI] PRIMARY KEY CLUSTERED 
(
	[category] ASC,
	[campus] ASC,
	[kid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblMode]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblMode]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblMode](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[mode] [char](20) NULL,
	[item] [char](20) NULL,
	[override] [bit] NULL CONSTRAINT [DF_tblMode_override]  DEFAULT (0),
 CONSTRAINT [PK_tblMode] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblHtml]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblHtml]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblHtml](
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[category] [varchar](20) NULL,
	[html] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblMode2]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblMode2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblMode2](
	[id] [numeric](18, 0) NOT NULL,
	[seq] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[item] [char](20) NULL,
	[questionnumber] [numeric](18, 0) NULL,
 CONSTRAINT [PK_tblMode2] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblprogramdegree]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblprogramdegree]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblprogramdegree](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblProgramQuestions]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblProgramQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblProgramQuestions](
	[id] [numeric](18, 0) NOT NULL,
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
 CONSTRAINT [PK_tblProgramQuestions] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[type] ASC,
	[questionnumber] ASC,
	[questionseq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblPrograms]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblPrograms]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblPrograms](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblReviewHist2]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblReviewHist2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblReviewHist2](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [forums]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[forums]') AND type in (N'U'))
BEGIN
CREATE TABLE [forums](
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
 CONSTRAINT [PK_forums] PRIMARY KEY CLUSTERED 
(
	[forum_id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblSLO]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblSLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblSLO](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblTasks]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTasks]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTasks](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[submittedfor] [varchar](20) NULL,
	[submittedby] [varchar](20) NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[coursetype] [char](3) NULL,
	[message] [varchar](30) NULL,
	[dte] [smalldatetime] NULL CONSTRAINT [DF_tblTasks_dte]  DEFAULT (getdate()),
	[inviter] [varchar](20) NULL,
	[role] [varchar](20) NULL,
	[category] [varchar](20) NULL,
	[historyid] [varchar](18) NULL,
 CONSTRAINT [PK_tblTasks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblUsers]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblUsers](
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
	[department] [char](4) NULL,
	[division] [varchar](6) NULL,
	[email] [varchar](50) NULL,
	[title] [varchar](50) NULL,
	[salutation] [varchar](50) NULL,
	[location] [varchar](50) NULL,
	[hours] [varchar](50) NULL,
	[phone] [varchar](20) NULL,
	[check] [char](1) NULL,
	[position] [varchar](50) NULL,
	[lastused] [smalldatetime] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblUsers_auditdate]  DEFAULT (getdate()),
	[alphas] [varchar](250) NULL,
	[sendnow] [int] NULL CONSTRAINT [DF__tblusers__sendno__3469B275]  DEFAULT (1),
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[campus] ASC,
	[userid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [BANNER]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BANNER]') AND type in (N'U'))
BEGIN
CREATE TABLE [BANNER](
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
/****** Object:  Table [BannerAlpha]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BannerAlpha]') AND type in (N'U'))
BEGIN
CREATE TABLE [BannerAlpha](
	[COURSE_ALPHA] [varchar](10) NULL,
	[ALPHA_DESCRIPTION] [varchar](255) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTaskMsg]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTaskMsg]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTaskMsg](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[category] [char](10) NULL,
	[aktion] [char](20) NULL,
	[progress] [char](20) NULL,
	[subprogress] [char](20) NULL,
	[status] [char](20) NULL,
	[initmenu] [varchar](50) NULL,
	[submenu] [varchar](50) NULL,
	[mytask] [varchar](50) NULL,
	[descr] [char](100) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [BannerCollege]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BannerCollege]') AND type in (N'U'))
BEGIN
CREATE TABLE [BannerCollege](
	[COLLEGE_CODE] [varchar](10) NULL,
	[COLL_DESCRIPTION] [varchar](255) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [BannerDivision]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[BannerDivision]') AND type in (N'U'))
BEGIN
CREATE TABLE [BannerDivision](
	[DIVISION_CODE] [varchar](10) NULL,
	[DIVS_DESCRIPTION] [varchar](30) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [jdbclog]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[jdbclog]') AND type in (N'U'))
BEGIN
CREATE TABLE [jdbclog](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[date] [datetime] NULL CONSTRAINT [DF_jdbclog_date]  DEFAULT (getdate()),
	[logger] [varchar](200) NULL,
	[priority] [varchar](50) NULL,
	[message] [text] NULL,
 CONSTRAINT [PK_jdbclog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [messages]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[messages]') AND type in (N'U'))
BEGIN
CREATE TABLE [messages](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[forum_id] [int] NULL,
	[item] [int] NULL,
	[thread_id] [int] NULL,
	[thread_parent] [int] NULL,
	[thread_level] [int] NULL,
	[message_author] [varchar](50) NULL,
	[message_author_notify] [bit] NULL,
	[message_timestamp] [datetime] NULL,
	[message_subject] [varchar](50) NULL,
	[message_body] [text] NULL,
	[message_Approved] [bit] NULL,
 CONSTRAINT [PK_messages] PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblApproval]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblApproval]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblApproval](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblApprover]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblApprover]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblApprover](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblArchivedProgram]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblArchivedProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblArchivedProgram](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblArea]    Script Date: 01/11/2011 11:53:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblArea]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblArea](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[area] [char](10) NULL,
	[code] [varchar](10) NULL,
	[codedescr] [varchar](50) NULL,
 CONSTRAINT [PK_tblArea] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblAssessedDataARC]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblAssessedDataARC]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblAssessedDataARC](
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
/****** Object:  Table [tblAssessedQuestions]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblAssessedQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblAssessedQuestions](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblcampus]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblcampus]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblcampus](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[campusdescr] [varchar](50) NULL,
	[courseitems] [text] NULL,
	[campusitems] [text] NULL,
	[programitems] [text] NULL,
 CONSTRAINT [PK_tblcampus] PRIMARY KEY CLUSTERED 
(
	[campus] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCampusDataCC2]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCampusDataCC2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCampusDataCC2](
	[id] [int] NOT NULL,
	[historyid] [nvarchar](18) NULL,
	[campus] [nvarchar](10) NULL,
	[CourseAlpha] [nvarchar](10) NULL,
	[CourseNum] [nvarchar](10) NULL,
	[CourseType] [nvarchar](10) NULL,
	[edit0] [nvarchar](50) NULL,
	[edit1] [nvarchar](250) NULL,
	[edit2] [nvarchar](250) NULL,
	[C1] [ntext] NULL,
	[C2] [ntext] NULL,
	[C3] [ntext] NULL,
	[C4] [ntext] NULL,
	[C5] [ntext] NULL,
	[C6] [ntext] NULL,
	[C7] [ntext] NULL,
	[C8] [ntext] NULL,
	[C9] [ntext] NULL,
	[C10] [ntext] NULL,
	[C11] [ntext] NULL,
	[C12] [ntext] NULL,
	[jsid] [nvarchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[auditby] [nvarchar](10) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblReviewers]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblReviewers]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblReviewers](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblReviewHist]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblReviewHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblReviewHist](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCampusDataMAU]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCampusDataMAU]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCampusDataMAU](
	[id] [numeric](10, 0) NOT NULL CONSTRAINT [DF_tblCampusDataMAU_id]  DEFAULT (0),
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL CONSTRAINT [DF_tblCampusDataMAU_CourseType]  DEFAULT ('PRE'),
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](250) NULL CONSTRAINT [DF_tblCampusDataMAU_edit1]  DEFAULT (1),
	[edit2] [varchar](250) NULL CONSTRAINT [DF_tblCampusDataMAU_edit2]  DEFAULT (1),
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
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblCampusDataMAU_auditdate]  DEFAULT (getdate()),
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
 CONSTRAINT [PK_tblCampusDataMAU] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCampusOutlines]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCampusOutlines]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCampusOutlines](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblccowiq]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblccowiq]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblccowiq](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCoReq]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCoReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCoReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NOT NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NOT NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblCoReq_id]  DEFAULT (0),
	[CoreqAlpha] [varchar](10) NULL,
	[CoreqNum] [varchar](10) NULL,
	[Grading] [varchar](50) NULL,
	[auditdate] [smalldatetime] NOT NULL CONSTRAINT [DF_tblCoReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblCoReq__rdr__7B9B496D]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblCoReq__consen__58A712EB]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblCoReq__pendin__5C77A3CF]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseARC]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseARC]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseARC](
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
	[articulation] [varchar](50) NULL,
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
 CONSTRAINT [PK_tblCourseArc] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseCAN]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseCAN]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseCAN](
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
	[articulation] [varchar](50) NULL,
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
 CONSTRAINT [PK_tblCourseCan] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseCC2]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseCC2]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseCC2](
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
/****** Object:  Table [tblCourseContentSLO]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseContentSLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseContentSLO](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseMAU]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseMAU]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseMAU](
	[id] [varchar](18) NULL,
	[historyid] [varchar](18) NOT NULL,
	[campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NULL,
	[CourseNum] [varchar](10) NULL,
	[CourseType] [varchar](10) NULL CONSTRAINT [DF_tblCourseMAU_CourseType_1]  DEFAULT ('PRE'),
	[edit] [bit] NULL CONSTRAINT [DF_tblCourseMAU_edit_1]  DEFAULT (1),
	[Progress] [varchar](10) NULL CONSTRAINT [DF_tblCourseMAU_Progress_1]  DEFAULT ('MODIFY'),
	[proposer] [varchar](50) NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL CONSTRAINT [DF_tblCourseMAU_edit1_1]  DEFAULT (1),
	[edit2] [varchar](500) NULL CONSTRAINT [DF_tblCourseMAU_edit2_1]  DEFAULT (1),
	[dispID] [char](4) NULL,
	[Division] [char](4) NULL,
	[coursetitle] [varchar](100) NULL,
	[credits] [varchar](20) NULL,
	[repeatable] [bit] NULL,
	[maxcredit] [varchar](20) NULL,
	[articulation] [varchar](50) NULL,
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
	[subprogress] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCourseReport]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCourseReport]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCourseReport](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblCurrentProgram]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblCurrentProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblCurrentProgram](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblDebug]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblDebug]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblDebug](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[page] [varchar](50) NULL,
	[debug] [bit] NULL CONSTRAINT [DF_tblDebug_debug]  DEFAULT (0),
 CONSTRAINT [PK_tblDebug] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblDiscipline]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblDiscipline]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblDiscipline](
	[dispid] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[coursealpha] [char](10) NULL,
	[discipline] [varchar](80) NULL,
 CONSTRAINT [PK_tblDiscipline] PRIMARY KEY CLUSTERED 
(
	[dispid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblDistribution]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblDistribution]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblDistribution](
	[seq] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[title] [varchar](30) NOT NULL,
	[members] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblDistribution_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblDistribution] PRIMARY KEY CLUSTERED 
(
	[seq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblDocs]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblDocs]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblDocs](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[type] [char](1) NULL CONSTRAINT [DF_tblDocs_type]  DEFAULT ('C'),
	[filename] [varchar](30) NULL,
	[show] [char](1) NULL CONSTRAINT [DF_tblDocs_show]  DEFAULT ('Y'),
	[campus] [varchar](10) NULL,
 CONSTRAINT [PK_tblDocs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblDegree]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblDegree]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblDegree](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblEmailList]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblEmailList]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblEmailList](
	[seq] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[title] [varchar](30) NOT NULL,
	[members] [text] NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblEmailList_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblEmailList] PRIMARY KEY CLUSTERED 
(
	[seq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblExtended]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblExtended]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblExtended](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tab] [varchar](30) NULL,
	[friendly] [varchar](15) NULL,
	[key1] [varchar](15) NULL,
	[key2] [varchar](15) NULL,
 CONSTRAINT [PK_tblExtended] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblExtra]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblExtra]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblExtra](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblFDProgram]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblFDProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblFDProgram](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[degree] [varchar](10) NOT NULL,
	[seq] [int] NOT NULL,
	[program] [varchar](50) NULL,
 CONSTRAINT [PK_tblFD] PRIMARY KEY CLUSTERED 
(
	[degree] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblFDCategory]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblFDCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblFDCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[degree] [varchar](10) NOT NULL,
	[seq] [int] NOT NULL,
	[category] [varchar](50) NULL,
 CONSTRAINT [PK_tblFDCategory] PRIMARY KEY CLUSTERED 
(
	[degree] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblForms]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblForms]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblForms](
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
/****** Object:  Table [tblGESLO]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblGESLO]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblGESLO](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblHelp]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblHelp]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblHelp](
	[id] [numeric](10, 0) NOT NULL,
	[content] [text] NULL,
 CONSTRAINT [PK_tblHelp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblHelpidx]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblHelpidx]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblHelpidx](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblInfo]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblInfo](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblINIKey]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblINIKey]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblINIKey](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[kid] [varchar](50) NOT NULL,
	[options] [varchar](200) NULL,
	[descr] [varchar](1000) NULL,
	[valu] [varchar](20) NULL,
	[html] [varchar](20) NULL,
 CONSTRAINT [PK_tblINIKey] PRIMARY KEY CLUSTERED 
(
	[kid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tbljobs]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tbljobs]') AND type in (N'U'))
BEGIN
CREATE TABLE [tbljobs](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[job] [varchar](50) NULL,
	[historyid] [varchar](18) NULL,
	[campus] [varchar](10) NULL,
	[alpha] [varchar](50) NULL,
	[num] [varchar](50) NULL,
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
	[t3] [text] NULL,
 CONSTRAINT [PK_tbljobs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblJSID]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblJSID]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblJSID](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblLinkedItem]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblLinkedItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblLinkedItem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[linkeditem] [varchar](30) NULL,
	[linkedkey] [varchar](10) NULL,
	[linkeddst] [varchar](10) NULL,
	[linkedtable] [varchar](30) NULL,
 CONSTRAINT [PK_tblLinkedItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblLinkedKeys]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblLinkedKeys]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblLinkedKeys](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[linkedsrc] [char](10) NULL,
	[linkeddst] [varchar](30) NULL,
	[level] [int] NULL,
 CONSTRAINT [PK_tblLinkedKeys] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblLists]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblLists]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblLists](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblLevel]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblLevel](
	[levelid] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[levelname] [varchar](10) NULL,
 CONSTRAINT [PK_tblLevel] PRIMARY KEY CLUSTERED 
(
	[levelid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblMail]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblMail]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblMail](
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
 CONSTRAINT [PK_tblMail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblMisc]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblMisc]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblMisc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NOT NULL,
	[historyid] [varchar](18) NOT NULL,
	[coursealpha] [varchar](50) NULL,
	[coursenum] [varchar](50) NULL,
	[coursetype] [varchar](10) NOT NULL,
	[descr] [varchar](50) NULL,
	[val] [text] NULL,
	[userid] [varchar](50) NULL,
 CONSTRAINT [PK_tblMisc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblPageHelp]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblPageHelp]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblPageHelp](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[page] [varchar](10) NULL,
	[campus] [varchar](10) NULL,
	[filename] [varchar](50) NULL,
 CONSTRAINT [PK_tblPageHelp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblPDF]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblPDF]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblPDF](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblPosition]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblPosition]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblPosition](
	[posid] [decimal](18, 0) NOT NULL,
	[posname] [varchar](50) NULL,
	[campus] [varchar](10) NULL,
 CONSTRAINT [PK_tblPosition] PRIMARY KEY CLUSTERED 
(
	[posid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblProposedProgram]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblProposedProgram]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblProposedProgram](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblPreReq]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblPreReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblPreReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NOT NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NOT NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblPreReq_id]  DEFAULT (0),
	[PrereqAlpha] [varchar](10) NULL,
	[PrereqNum] [varchar](10) NULL,
	[Grading] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblPreReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblPreReq__rdr__7AA72534]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblPreReq__conse__56BECA79]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblPreReq__pendi__5E5FEC41]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblProps]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblProps]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblProps](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblRpt]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblRpt]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblRpt](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblSalutation]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblSalutation]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblSalutation](
	[salid] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[saldescr] [varchar](6) NULL,
 CONSTRAINT [PK_tblSalutation] PRIMARY KEY CLUSTERED 
(
	[salid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblRequest]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblRequest]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblRequest](
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
/****** Object:  Table [tblSLOARC]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblSLOARC]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblSLOARC](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblStatement]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblStatement]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblStatement](
	[id] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NULL,
	[statement] [text] NULL,
	[campus] [varchar](10) NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblStatement_auditdate]  DEFAULT (getdate()),
 CONSTRAINT [PK_tblStatement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblsyllabus]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblsyllabus]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblsyllabus](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblSystem]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblSystem]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblSystem](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[named] [varchar](50) NULL,
	[valu] [varchar](100) NULL,
	[descr] [varchar](250) NULL,
 CONSTRAINT [PK_tblSystem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTabs]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTabs]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTabs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tab] [varchar](30) NULL,
	[alpha] [varchar](15) NULL,
	[num] [varchar](15) NULL,
 CONSTRAINT [PK_tblTabs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempAttach]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempAttach]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempAttach](
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
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCampusData]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCampusData]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCampusData](
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
 CONSTRAINT [PK_tblTempCampusData] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCoReq]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCoReq]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCoReq](
	[historyid] [varchar](18) NOT NULL,
	[Campus] [varchar](10) NULL,
	[CourseAlpha] [varchar](10) NOT NULL,
	[CourseNum] [varchar](10) NOT NULL,
	[CourseType] [char](3) NULL,
	[id] [numeric](10, 0) NULL CONSTRAINT [DF_tblTempCoReq_id]  DEFAULT (0),
	[CoreqAlpha] [char](4) NULL,
	[CoreqNum] [char](4) NULL,
	[Grading] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL CONSTRAINT [DF_tblTempCoReq_auditdate]  DEFAULT (getdate()),
	[auditby] [varchar](20) NULL,
	[rdr] [numeric](18, 0) NULL CONSTRAINT [DF__tblTempCoRe__rdr__7D8391DF]  DEFAULT (0),
	[consent] [bit] NULL CONSTRAINT [DF__tblTempCo__conse__599B3724]  DEFAULT (0),
	[pending] [bit] NULL CONSTRAINT [DF__tblTempCo__pendi__5D6BC808]  DEFAULT (0),
	[approvedby] [varchar](50) NULL,
	[approveddate] [smalldatetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [tblTempCourse]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[tblTempCourse]') AND type in (N'U'))
BEGIN
CREATE TABLE [tblTempCourse](
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
	[articulation] [varchar](50) NULL,
	[semester] [varchar](50) NULL,
	[crosslisted] [bit] NULL,
	[coursedate] [smalldatetime] NULL,
	[effectiveterm] [varchar](12) NULL,
	[gradingoptions] [varchar](50) NULL,
	[coursedescr] [text] NULL,
	[hoursperweek] [varchar](250) NULL,
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
 CONSTRAINT [PK_tblTempCourse] PRIMARY KEY CLUSTERED 
(
	[historyid] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  View [vw_WriteSyllabus]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_WriteSyllabus]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_WriteSyllabus]
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
/****** Object:  View [vw_EffectiveTerms]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_EffectiveTerms]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_EffectiveTerms]
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
/****** Object:  View [vw_CourseQuestionsYN]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseQuestionsYN]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseQuestionsYN]
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, dbo.CCCM6100.Question_Number, course.question, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 ON course.questionnumber = dbo.CCCM6100.Question_Number AND course.type = dbo.CCCM6100.type
WHERE     (course.type = ''Course'')
ORDER BY course.campus, course.questionseq
' 
GO
/****** Object:  View [vw_CourseQuestions]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseQuestions]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseQuestions]
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, dbo.CCCM6100.Question_Number, course.question, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 ON course.questionnumber = dbo.CCCM6100.Question_Number AND course.type = dbo.CCCM6100.type
WHERE     (course.type = ''Course'') AND (course.include = ''Y'')
ORDER BY course.campus, course.questionseq
' 
GO
/****** Object:  View [vw_CourseItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseItems]
AS
SELECT     TOP 100 PERCENT course.id, course.campus, c61.Question_Number, course.questionseq AS Seq, course.question, 
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, course.include, course.change, course.required,
                       c61.campus AS C61Campus
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = ''Course'') AND (c61.campus = ''SYS'')
ORDER BY course.campus, course.questionseq
' 
GO
/****** Object:  View [vw_CCCM6100ByIDProgramItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CCCM6100ByIDProgramItems]'))
EXEC dbo.sp_executesql @statement = N'--
-- vw_CCCM6100ByIDProgramCourse
--
CREATE VIEW [vw_CCCM6100ByIDProgramItems]
AS
SELECT     TOP 100 PERCENT program.id, program.campus, program.questionnumber, program.questionseq, program.question, program.include, c61.Question_Friendly, 
                      c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, program.auditby, program.auditdate, program.help, 
                      program.change, program.required, program.helpfile, program.audiofile,rules,rulesform,defalt
FROM         dbo.tblprogramQuestions program INNER JOIN
                      dbo.CCCM6100 c61 ON program.questionnumber = c61.Question_Number AND program.type = c61.type
WHERE     (program.type = ''Program'')
ORDER BY program.id, program.campus, program.questionnumber
' 
GO
/****** Object:  View [vw_CCCM6100ByIDCampusItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CCCM6100ByIDCampusItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CCCM6100ByIDCampusItems]
AS
SELECT     TOP 100 PERCENT campus.campus, campus.id, campus.questionnumber, campus.questionseq, campus.question, campus.include, 
                      c61.Question_Friendly, c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, campus.auditby, 
                      campus.auditdate, campus.help, ''N'' AS change, campus.required, campus.helpfile, campus.audiofile,rules,rulesform,defalt
FROM         dbo.tblCampusQuestions campus INNER JOIN
                      dbo.CCCM6100 c61 ON campus.campus = c61.campus AND campus.type = c61.type AND campus.questionnumber = c61.Question_Number
WHERE     (c61.type = ''Campus'')
ORDER BY campus.campus, campus.id, campus.questionnumber
' 
GO
/****** Object:  View [vw_CCCM6100ByIDCampusCourse]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CCCM6100ByIDCampusCourse]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CCCM6100ByIDCampusCourse]
AS
SELECT     TOP 100 PERCENT course.id, course.campus, course.questionnumber, course.questionseq, course.question, course.include, c61.Question_Friendly, 
                      c61.Question_Type, c61.Question_Len, c61.Question_Max, c61.Question_Ini, c61.Question_Explain, course.auditby, course.auditdate, course.help, 
                      course.change, course.required, course.helpfile, course.audiofile,rules,rulesform,defalt
FROM         dbo.tblCourseQuestions course INNER JOIN
                      dbo.CCCM6100 c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = ''Course'')
ORDER BY course.id, course.campus, course.questionnumber
' 
GO
/****** Object:  View [vw_CCCM6100_Sys]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CCCM6100_Sys]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CCCM6100_Sys]
AS
SELECT     TOP 100 PERCENT course.campus, course.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, course.question, course.include, course.change, course.required, course.helpfile, course.audiofile,
	c61.rules,c61.rulesform,defalt
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblCourseQuestions course ON c61.Question_Number = course.questionnumber AND c61.type = course.type
WHERE     (c61.campus = ''SYS'') AND (course.type = ''Course'')
ORDER BY course.campus, course.questionseq, c61.campus
' 
GO
/****** Object:  View [vw_CCCM6100_Program]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CCCM6100_Program]'))
EXEC dbo.sp_executesql @statement = N'--
-- vw_CCCM6100_Program
--
CREATE VIEW [vw_CCCM6100_Program]
AS
SELECT     TOP 100 PERCENT program.campus, program.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, program.question, program.include, program.change, program.required, program.helpfile, program.audiofile,
	c61.rules,c61.rulesform,defalt
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblprogramQuestions program ON c61.Question_Number = program.questionnumber AND c61.type = program.type
WHERE     (c61.campus = ''SYS'') AND (program.type = ''Progream'')
ORDER BY program.campus, program.questionseq, c61.campus
' 
GO
/****** Object:  View [vw_CampusQuestionsYN]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CampusQuestionsYN]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CampusQuestionsYN]
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, dbo.CCCM6100.Question_Number, campus.question, 
                      dbo.CCCM6100.Question_Friendly
FROM         dbo.CCCM6100 INNER JOIN
                      dbo.tblCampusQuestions campus ON dbo.CCCM6100.type = campus.type AND dbo.CCCM6100.campus = campus.campus AND 
                      dbo.CCCM6100.Question_Number = campus.questionnumber
WHERE     (campus.type = ''Campus'')
ORDER BY campus.campus, campus.questionseq
' 
GO
/****** Object:  View [vw_CCCM6100_Campus]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CCCM6100_Campus]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CCCM6100_Campus]
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, c61.Question_Ini, c61.Question_Type, c61.Question_Len, c61.Question_Max, 
                      c61.Question_Friendly, c61.Question_Explain, campus.question, ''N'' AS change, campus.required, campus.helpfile, campus.audiofile,c61.rules,c61.rulesform,defalt
FROM         dbo.CCCM6100 c61 INNER JOIN
                      dbo.tblCampusQuestions campus ON c61.Question_Number = campus.questionnumber AND c61.type = campus.type AND 
                      c61.campus = campus.campus
WHERE     (c61.type = ''Campus'') AND (campus.type = ''Campus'')
ORDER BY campus.campus, campus.questionseq, c61.campus, c61.type
' 
GO
/****** Object:  View [vw_CampusQuestions]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CampusQuestions]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CampusQuestions]
AS
SELECT     TOP 100 PERCENT campus.campus, campus.questionseq, dbo.CCCM6100.Question_Number, campus.question, 
                      dbo.CCCM6100.Question_Friendly
FROM         dbo.CCCM6100 INNER JOIN
                      dbo.tblCampusQuestions campus ON dbo.CCCM6100.type = campus.type AND dbo.CCCM6100.campus = campus.campus AND 
                      dbo.CCCM6100.Question_Number = campus.questionnumber
WHERE     (campus.type = ''Campus'') AND (campus.include = ''Y'')
ORDER BY campus.campus, campus.questionseq
' 
GO
/****** Object:  View [vw_CampusItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CampusItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CampusItems]
AS
SELECT     TOP 100 PERCENT campus.id, campus.campus, c61.Question_Number, campus.questionseq AS Seq, c61.Question_Friendly AS Field_Name, 
                      campus.question, c61.Question_Len AS Length, c61.Question_Max AS Maximum, campus.include, ''N'' AS change, c61.type, campus.required
FROM         dbo.tblCampusQuestions campus INNER JOIN
                      dbo.CCCM6100 c61 ON campus.questionnumber = c61.Question_Number AND campus.type = c61.type AND campus.campus = c61.campus
ORDER BY campus.campus, campus.questionseq
' 
GO
/****** Object:  View [vw_SystemQuestionsInUse]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_SystemQuestionsInUse]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [vw_SystemQuestionsInUse]
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
/****** Object:  View [vw_ResequenceProgramItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ResequenceProgramItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ResequenceProgramItems]
AS
SELECT     TOP 100 PERCENT tcc.campus, tcc.questionseq, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblProgramQuestions tcc INNER JOIN
                      dbo.CCCM6100 ON tcc.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.type = ''Program'') AND (tcc.include = ''Y'') AND (dbo.CCCM6100.campus <> ''TTG'')
ORDER BY tcc.campus, tcc.questionseq
' 
GO
/****** Object:  View [vw_ResequenceCourseItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ResequenceCourseItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ResequenceCourseItems]
AS
SELECT     TOP 100 PERCENT tcc.campus, tcc.questionseq, dbo.CCCM6100.Question_Friendly
FROM         dbo.tblCourseQuestions tcc INNER JOIN
                      dbo.CCCM6100 ON tcc.questionnumber = dbo.CCCM6100.Question_Number
WHERE     (dbo.CCCM6100.type = ''Course'') AND (tcc.include = ''Y'')
ORDER BY tcc.campus, tcc.questionseq
' 
GO
/****** Object:  View [vw_ResequenceCampusItems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ResequenceCampusItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ResequenceCampusItems]
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
/****** Object:  View [vw_programquestions]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_programquestions]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_programquestions]
AS
SELECT     TOP 100 PERCENT program.campus, program.questionseq, dbo.CCCM6100.Question_Number, program.question, 
                      dbo.CCCM6100.Question_Friendly
FROM         dbo.tblProgramQuestions program INNER JOIN
                      dbo.CCCM6100 ON program.questionnumber = dbo.CCCM6100.Question_Number AND program.type = dbo.CCCM6100.type
WHERE     (program.type = N''Program'') AND (program.include = ''Y'') AND (dbo.CCCM6100.campus <> ''TTG'')
ORDER BY program.campus, program.questionseq
' 
GO
/****** Object:  View [vw_programitems]    Script Date: 01/11/2011 11:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_programitems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_programitems]
AS
SELECT     TOP (100) PERCENT course.id, course.campus, c61.Question_Number, course.questionseq AS Seq, course.question, 
                      c61.Question_Friendly AS Field_Name, c61.Question_Len AS Length, c61.Question_Max AS Maximum, course.include, course.change, 
                      course.required
FROM         dbo.tblProgramQuestions AS course INNER JOIN
                      dbo.CCCM6100 AS c61 ON course.questionnumber = c61.Question_Number AND course.type = c61.type
WHERE     (course.type = ''Program'')
ORDER BY course.campus, Seq
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_programitems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[34] 2[20] 3) )"
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
               Bottom = 154
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 2
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
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
/****** Object:  View [vw_OutlineValidation]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_OutlineValidation]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_OutlineValidation]
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
/****** Object:  View [vw_Mode]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Mode]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Mode]
AS
SELECT     tm.id, tm.campus, tm.mode, tm.item, tcq.questionnumber, tcq.questionseq, tcq.question, tm.override
FROM         dbo.tblCourseQuestions tcq INNER JOIN
                      dbo.CCCM6100 c61 ON tcq.questionnumber = c61.Question_Number INNER JOIN
                      dbo.tblMode tm ON tcq.campus = tm.campus AND c61.Question_Friendly = tm.item
WHERE     (c61.campus = ''SYS'') AND (c61.type = ''Course'')
' 
GO
/****** Object:  View [zvw_AnnBerner]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[zvw_AnnBerner]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [zvw_AnnBerner]
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
/****** Object:  View [vw_CourseLastDisapprover]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseLastDisapprover]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseLastDisapprover]
AS
SELECT     campus, coursealpha, coursenum, MAX(seq) AS MaxOfseq
FROM         dbo.tblApprovalHist
GROUP BY campus, coursealpha, coursenum, approved
HAVING      (campus = ''LEECC'') AND (coursealpha = ''ICS'') AND (coursenum = ''241'') AND (approved = 1)
' 
GO
/****** Object:  View [vw_CourseLastApprover]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseLastApprover]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseLastApprover]
AS
SELECT     campus, coursealpha, coursenum, MAX(seq) AS MaxOfseq
FROM         dbo.tblApprovalHist
GROUP BY campus, coursealpha, coursenum, approved
HAVING      (campus = ''LEECC'') AND (coursealpha = ''ICS'') AND (coursenum = ''241'') AND (approved = - 1)
' 
GO
/****** Object:  View [vw_ApprovalHistory]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ApprovalHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ApprovalHistory]
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
/****** Object:  View [vw_ApproverHistory]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ApproverHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ApproverHistory]
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
/****** Object:  View [vw_Incomplete_Assessment_2]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Incomplete_Assessment_2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Incomplete_Assessment_2]
AS
SELECT DISTINCT accjcid
FROM         dbo.tblAssessedData
' 
GO
/****** Object:  View [vw_AttachedLatestVersion]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_AttachedLatestVersion]'))
EXEC dbo.sp_executesql @statement = N'/*
	do not include id column in this view. This view contains the highest version 
	number for each file attached
*/
CREATE VIEW [vw_AttachedLatestVersion]
AS
SELECT     TOP 100 PERCENT campus, category, MAX(version) AS version, historyid, fullname
FROM         dbo.tblAttach
GROUP BY fullname, campus, historyid, category, historyid, campus
ORDER BY campus, category, MAX(version)
' 
GO
/****** Object:  View [vw_ReviewerHistory]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ReviewerHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ReviewerHistory]
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
/****** Object:  View [vw_ProgramDepartmentChairs]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ProgramDepartmentChairs]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ProgramDepartmentChairs]
AS
SELECT     TOP 100 PERCENT dbo.tblDivision.campus, dbo.tblDivision.divisionname, dbo.tblChairs.coursealpha, dbo.tblDivision.chairname, 
                      dbo.tblChairs.programid, dbo.tblDivision.delegated
FROM         dbo.tblDivision INNER JOIN
                      dbo.tblChairs ON dbo.tblDivision.divid = dbo.tblChairs.programid
ORDER BY dbo.tblDivision.campus, dbo.tblChairs.coursealpha
' 
GO
/****** Object:  View [vw_SLOByProgress_1]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_SLOByProgress_1]'))
EXEC dbo.sp_executesql @statement = N'/*
	listing of SLOs with progress
 */
CREATE VIEW [vw_SLOByProgress_1]
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.historyid, tcc.CourseAlpha, tcc.CourseNum, tc.coursetitle
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourse tc ON tcc.historyid = tc.historyid
WHERE     (tcc.CourseType = ''PRE'') OR
                      (tcc.CourseType = ''CUR'')
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum
' 
GO
/****** Object:  View [zz_Duplicates]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[zz_Duplicates]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [zz_Duplicates]
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
/****** Object:  View [vw_ReviewStatus]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ReviewStatus]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [vw_ReviewStatus]
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
/****** Object:  View [vw_ApprovalsWithoutTasks]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ApprovalsWithoutTasks]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [vw_ApprovalsWithoutTasks]
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
/****** Object:  View [vw_ApprovalStatus]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ApprovalStatus]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [vw_ApprovalStatus]
AS
SELECT     TOP 100 PERCENT C.campus, C.id, C.historyid, C.CourseAlpha, C.CourseNum, C.coursetitle, C.route, C.proposer, C.Progress, C.subprogress, 
                      C.dateproposed, C.auditdate, I.kid
FROM         (SELECT     c.id, c.historyid, c.campus, c.CourseAlpha, c.CourseNum, c.Progress, c.coursetitle, c.route, c.proposer, c.subprogress, c.dateproposed, 
                                              c.auditdate
                       FROM          tblCourse c
                       WHERE      c.CourseType = ''PRE'' AND NOT coursealpha IS NULL AND coursealpha <> '''') C LEFT OUTER JOIN
                          (SELECT     campus, id, i.kid
                            FROM          tblINI i
                            WHERE      category = ''ApprovalRouting'') I ON C.campus = I.campus AND I.id = C.route
WHERE     (C.route > 0)
ORDER BY C.campus, C.CourseAlpha, C.CourseNum

' 
GO
/****** Object:  View [vw_ACCJCDescription]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescription]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescription]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
' 
GO
/****** Object:  View [vw_ACCJCDescriptionKAP]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionKAP]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionKAP]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''KAP'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionHON]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionHON]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionHON]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''HON'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionHIL]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionHIL]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionHIL]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''HIL'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionHAW]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionHAW]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionHAW]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     ('''' = ''HAW'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionWOA]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionWOA]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionWOA]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''WOA'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionWIN]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionWIN]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionWIN]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''WIN'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionMAU]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionMAU]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionMAU]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''MAU'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionMAN]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionMAN]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionMAN]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''MAN'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionLEE]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionLEE]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionLEE]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''LEE'')
' 
GO
/****** Object:  View [vw_ACCJCDescriptionKAU]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJCDescriptionKAU]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJCDescriptionKAU]
AS
SELECT     accjc.historyid, accjc.id, accjc.ContentID, '''' AS ShortContent, accjc.CompID, comp.Comp, accjc.Assessmentid, '''' AS assessment, accjc.Campus, 
                      accjc.CourseAlpha, accjc.CourseNum, accjc.CourseType, accjc.AuditDate, accjc.AuditBy
FROM         dbo.tblCourseACCJC accjc INNER JOIN
                      dbo.tblCourseComp comp ON accjc.CourseAlpha = comp.CourseAlpha AND accjc.CourseNum = comp.CourseNum AND 
                      accjc.CompID = comp.CompID AND accjc.Campus = comp.Campus AND accjc.CourseType = comp.CourseType
WHERE     (accjc.Campus = N''KAU'')
' 
GO
/****** Object:  View [vw_Incomplete_Assessment_1]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Incomplete_Assessment_1]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Incomplete_Assessment_1]
AS
SELECT     dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id AS accjcid
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseACCJC ON dbo.tblCourseComp.CompID = dbo.tblCourseACCJC.CompID
GROUP BY dbo.tblCourseComp.CompID, dbo.tblCourseACCJC.id, dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum,
                       dbo.tblCourseComp.CourseType, dbo.tblCourseComp.historyid
' 
GO
/****** Object:  View [vw_SLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_SLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_SLO]
AS
SELECT     c.Campus, c.CourseAlpha, c.CourseNum, c.CourseType, a.id, c.Comp, a.AssessedBy, a.AssessedDate
FROM         dbo.tblCourseACCJC a INNER JOIN
                      dbo.tblCourseComp c ON a.CourseType = c.CourseType AND a.Campus = c.Campus AND a.CompID = c.CompID AND a.CourseNum = c.CourseNum AND 
                      a.CourseAlpha = c.CourseAlpha
GROUP BY c.Campus, c.CourseAlpha, c.CourseNum, c.CourseType, a.id, c.Comp, a.AssessedBy, a.AssessedDate
' 
GO
/****** Object:  View [vw_SLO2Assessment]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_SLO2Assessment]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_SLO2Assessment]
AS
SELECT tcc.historyid, tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcc.CompID, tcca.assessmentid, tca.assessment
FROM tblCourseComp tcc, tblCourseCompAss tcca, tblCourseAssess tca
WHERE tcc.historyid = tcca.historyid AND 
tcc.CompID = tcca.compid AND
tcc.Campus = tca.campus AND 
tcca.assessmentid = tca.assessmentid
' 
GO
/****** Object:  View [vw_LinkedSLO2Assessment]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedSLO2Assessment]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedSLO2Assessment]
AS
SELECT DISTINCT    dbo.tblCourseComp.historyid, dbo.tblCourseComp.CompID, dbo.tblCourseCompAss.assessmentid, dbo.tblCourseAssess.assessment
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.tblCourseCompAss ON dbo.tblCourseComp.historyid = dbo.tblCourseCompAss.historyid AND 
                      dbo.tblCourseComp.CompID = dbo.tblCourseCompAss.compid INNER JOIN
                      dbo.tblCourseAssess ON dbo.tblCourseCompAss.assessmentid = dbo.tblCourseAssess.assessmentid
' 
GO
/****** Object:  View [vw_LinkedCompetency2Assessment]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency2Assessment]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency2Assessment]
AS
SELECT DISTINCT    TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tca.assessment AS Content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblCourseAssess tca ON tl2.item = tca.assessmentid
WHERE     (tl.src = ''X43'') AND (tl.dst = ''Assess'')
' 
GO
/****** Object:  View [vw_CompsByID]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CompsByID]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CompsByID]
AS
SELECT DISTINCT TOP 100 PERCENT tca.campus, tca.assessmentid, tcc.CourseAlpha + '' '' + tcc.CourseNum AS outline
FROM         dbo.tblCourseCompAss tcca INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid INNER JOIN
                      dbo.tblCourseComp tcc ON tcca.compid = tcc.CompID
ORDER BY tca.campus, tca.assessmentid
' 
GO
/****** Object:  View [vw_CompsByAlphaNumID]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CompsByAlphaNumID]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CompsByAlphaNumID]
AS
SELECT     TOP 100 PERCENT tca.campus, tcc.CourseAlpha, tcc.CourseNum, tca.assessmentid, tcc.CompID, tcc.Comp
FROM         dbo.tblCourseCompAss tcca INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid INNER JOIN
                      dbo.tblCourseComp tcc ON tcca.compid = tcc.CompID
ORDER BY tca.campus, tcc.CourseAlpha, tcc.CourseNum, tca.assessmentid
' 
GO
/****** Object:  View [vw_CompsByAlphaNum]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CompsByAlphaNum]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CompsByAlphaNum]
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid, tcc.Comp
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourseCompAss tcca ON tcc.CompID = tcca.compid INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum
' 
GO
/****** Object:  View [vw_Assessments]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Assessments]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Assessments]
AS
SELECT DISTINCT TOP 100 PERCENT tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid, tca.assessment
FROM         dbo.tblCourseComp tcc INNER JOIN
                      dbo.tblCourseCompAss tcca ON tcc.CompID = tcca.compid INNER JOIN
                      dbo.tblCourseAssess tca ON tcca.assessmentid = tca.assessmentid
ORDER BY tcc.Campus, tcc.CourseAlpha, tcc.CourseNum, tcca.assessmentid
' 
GO
/****** Object:  View [vw_ACCJC_1]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJC_1]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJC_1]
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
/****** Object:  View [vw_Linked2SLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Linked2SLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Linked2SLO]
AS
SELECT DISTINCT tl.campus, tl.historyid, tl.src, tl.dst, tl.seq AS linkedseq, tl.id AS linkedid, tl2.item AS compid, tl2.item2, tc.Comp, tc.rdr AS comprdr
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.historyid = tl2.historyid AND tl.id = tl2.id INNER JOIN
                      dbo.tblCourseComp tc ON tl2.historyid = tc.historyid AND tl.campus = tc.Campus AND tl2.item = tc.CompID
WHERE     (tl.src = ''X43'') AND (tl.dst = ''SLO'' OR
                      tl.dst = ''Objectives'')
' 
GO
/****** Object:  View [vw_LinkingContent2Competency]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingContent2Competency]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingContent2Competency]
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
/****** Object:  View [vw_LinkedContent2Compentency]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedContent2Compentency]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedContent2Compentency]
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
/****** Object:  View [vw_LinkedCompetency2PSLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency2PSLO]
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
/****** Object:  View [vw_LinkedCompetency2Content]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency2Content]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency2Content]
AS
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, tcc.LongContent AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblCourseContent tcc ON tl2.item = tcc.ContentID
WHERE     (tl.src = ''X43'') AND (tl.dst = ''Content'')
' 
GO
/****** Object:  View [vw_LinkedCountItems]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCountItems]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCountItems]
AS
SELECT  DISTINCT   tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, COUNT(tl2.item) AS counter
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id
GROUP BY tl.seq, tl.historyid, tl.src, tl.dst, tl.campus, tl.historyid, tl.src, tl.dst
' 
GO
/****** Object:  View [vw_LinkedCompetency2GESLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency2GESLO]
AS
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''GESLO'') AND (dbo.tblINI.category = ''GESLO'')
' 
GO
/****** Object:  View [vw_LinkedCompetency2MethodEval]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency2MethodEval]
AS
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.id AS iniID
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''MethodEval'') AND (dbo.tblINI.category = ''MethodEval'')
' 
GO
/****** Object:  View [vw_LinkingSLO2GESLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingSLO2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingSLO2GESLO]
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
/****** Object:  View [vw_LinkingCompetency2PSLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingCompetency2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingCompetency2PSLO]
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
/****** Object:  View [vw_LinkingCompetency2MethodEval]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingCompetency2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingCompetency2MethodEval]
AS
SELECT   DISTINCT  TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''MethodEval'') AND (dbo.tblINI.category = ''MethodEval'')
' 
GO
/****** Object:  View [vw_LinkedSLO2GESLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedSLO2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedSLO2GESLO]
AS
SELECT  DISTINCT   TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kid AS content
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X18'') AND (tl.dst = ''GESLO'') AND (dbo.tblINI.category = ''GESLO'')
' 
GO
/****** Object:  View [vw_LinkingCompetency2GESLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingCompetency2GESLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingCompetency2GESLO]
AS
SELECT DISTINCT    TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.kid
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X43'') AND (tl.dst = ''GESLO'') AND (dbo.tblINI.category = N''GESLO'')
' 
GO
/****** Object:  View [vw_LinkedSLO2MethodEval]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedSLO2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedSLO2MethodEval]
AS
SELECT DISTINCT TOP 100 PERCENT tl.historyid, tl.seq, tl.id AS keyid, tl2.item AS ContentID, dbo.tblINI.kdesc AS content, dbo.tblINI.id AS iniID
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id INNER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id
WHERE     (tl.src = ''X18'') AND (tl.dst = ''MethodEval'') AND (dbo.tblINI.category = ''MethodEval'')
' 
GO
/****** Object:  View [vw_LinkingSLO2PSLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingSLO2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingSLO2PSLO]
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
/****** Object:  View [vw_LinkingSLO2MethodEval]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkingSLO2MethodEval]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkingSLO2MethodEval]
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
/****** Object:  View [vw_LinkedMatrix]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedMatrix]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [vw_LinkedMatrix]
AS
SELECT DISTINCT TOP 100 PERCENT tl.campus, tl.historyid, tl.src, tl.dst, tl.seq, tl.id, tl2.item, dbo.tblINI.kid AS shortdescr, dbo.tblINI.kdesc AS longdescr
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id LEFT OUTER JOIN
                      dbo.tblINI ON tl2.item = dbo.tblINI.id AND tl.campus = dbo.tblINI.campus
ORDER BY tl.campus, tl.historyid, tl.src, tl.dst, tl.seq

' 
GO
/****** Object:  View [vw_GenericContent2Linked]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_GenericContent2Linked]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_GenericContent2Linked]
AS
SELECT     tl.historyid, tl.src, tl.seq, tl.id, tl2.item
FROM         dbo.tblCourseLinked tl INNER JOIN
                      dbo.tblGenericContent tg ON tl.historyid = tg.historyid AND tl.seq = tg.id AND tl.src = tg.src INNER JOIN
                      dbo.tblCourseLinked2 tl2 ON tl.id = tl2.id
' 
GO
/****** Object:  View [vw_Linked2PSLO]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Linked2PSLO]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Linked2PSLO]
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
/****** Object:  View [vw_LinkedCompetency]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency]
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
/****** Object:  View [vw_ReviewerComments]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ReviewerComments]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ReviewerComments]
AS
SELECT     tr2.historyid, tr2.campus, tr2.coursealpha, tr2.coursenum, tr2.item, tcq.questionseq, tr2.dte, tr2.reviewer, tr2.comments, tr2.acktion
FROM         dbo.tblReviewHist2 tr2 INNER JOIN
                      dbo.tblCourseQuestions tcq ON tr2.campus = tcq.campus AND tr2.item = tcq.questionnumber
' 
GO
/****** Object:  View [vw_ProgramForViewing]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ProgramForViewing]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ProgramForViewing]
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
/****** Object:  View [vw_Mode2]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Mode2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Mode2]
AS
SELECT dbo.tblMode.id, dbo.tblMode.campus, dbo.tblMode.mode, dbo.tblMode.item, dbo.tblMode.override, dbo.tblMode2.seq, 
		dbo.tblMode2.item AS requireditem
FROM dbo.tblMode INNER JOIN
dbo.tblMode2 ON dbo.tblMode.id = dbo.tblMode2.id
' 
GO
/****** Object:  View [vw_ApproversNoDivisionChair]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ApproversNoDivisionChair]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ApproversNoDivisionChair]
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
/****** Object:  View [vw_Approvers]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Approvers]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Approvers]
AS
SELECT TOP 100 PERCENT u.campus, a.approver_seq, a.approver, a.delegated, u.[position], u.division
FROM dbo.tblApprover a, dbo.tblUsers u
WHERE a.approver = u.userid
ORDER BY a.approver_seq
' 
GO
/****** Object:  View [vw_ApproversDivisionChair]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ApproversDivisionChair]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ApproversDivisionChair]
AS
SELECT     ta.approver_seq AS Sequence, ta.approver, tu.title, tu.[position], tu.department, tu.campus, ta.route
FROM         dbo.tblApprover ta INNER JOIN
                      dbo.tblUsers tu ON ta.approver = tu.userid
WHERE     (tu.[position] LIKE ''D% CHAIR'')
' 
GO
/****** Object:  View [vw_Approvers2]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Approvers2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Approvers2]
AS
SELECT     TOP 100 PERCENT *
FROM         (SELECT     a.approverid, a.approver_seq, a.Approver, u.Title, u.Position, u.Department, u.Division, a.delegated, a.campus, a.experimental, a.route, 
                                              a.startdate, a.enddate
                       FROM          tblUsers u, tblApprover a
                       WHERE      u.userid = a.approver
                       UNION
                       SELECT     approverid, approver_seq, approver, ''DISTRIBUTION LIST'', ''DISTRIBUTION LIST'', '''', '''', '''', campus, ''0'' AS experimental, route, startdate, 
                                             enddate
                       FROM         tblApprover
                       WHERE     approver LIKE ''%]'') X
ORDER BY campus, approver_seq
' 
GO
/****** Object:  View [vw_HelpGetContent]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_HelpGetContent]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_HelpGetContent]
AS
SELECT     TOP 100 PERCENT dbo.tblHelpidx.id, dbo.tblHelpidx.category, dbo.tblHelpidx.title, dbo.tblHelpidx.subtitle, dbo.tblHelpidx.auditby, 
                      dbo.tblHelpidx.auditdate, dbo.tblHelp.content, dbo.tblHelpidx.campus
FROM         dbo.tblHelp INNER JOIN
                      dbo.tblHelpidx ON dbo.tblHelp.id = dbo.tblHelpidx.id
ORDER BY dbo.tblHelpidx.category, dbo.tblHelpidx.title
' 
GO
/****** Object:  View [vw_ProgramsApprovalStatus]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ProgramsApprovalStatus]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ProgramsApprovalStatus]
AS
SELECT     TOP 100 PERCENT c.campus, c.historyid, c.Program, c.divisionname, c.proposer, c.progress, c.route, c.subprogress, i.kid, c.title, 
                      c.[Effective Date] AS EffectiveDate, c.divisioncode
FROM         dbo.vw_ProgramForViewing c INNER JOIN
                      dbo.tblINI i ON c.campus = i.campus AND c.route = i.id
WHERE     (i.category = ''ApprovalRouting'') AND (c.route > 0) AND (c.type = ''PRE'')
ORDER BY c.campus, c.Program, c.divisionname
' 
GO
/****** Object:  View [vw_SLOByProgress_2]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_SLOByProgress_2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_SLOByProgress_2]
AS
SELECT     TOP 100 PERCENT dbo.vw_SLOByProgress_1.historyid, dbo.vw_SLOByProgress_1.Campus, dbo.vw_SLOByProgress_1.CourseAlpha, 
                      dbo.vw_SLOByProgress_1.CourseNum, dbo.vw_SLOByProgress_1.coursetitle, dbo.tblSLO.progress, dbo.tblSLO.auditby AS Proposer
FROM         dbo.vw_SLOByProgress_1 INNER JOIN
                      dbo.tblSLO ON dbo.vw_SLOByProgress_1.historyid = dbo.tblSLO.hid
ORDER BY dbo.vw_SLOByProgress_1.Campus, dbo.vw_SLOByProgress_1.CourseAlpha, dbo.vw_SLOByProgress_1.CourseNum
' 
GO
/****** Object:  View [vw_CourseLastDisapproverX]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseLastDisapproverX]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseLastDisapproverX]
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
/****** Object:  View [vw_CourseLastApproverX]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_CourseLastApproverX]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_CourseLastApproverX]
AS
SELECT     dbo.vw_CourseLastApprover.campus, dbo.vw_CourseLastApprover.coursealpha, dbo.vw_CourseLastApprover.coursenum, 
                      dbo.tblApprovalHist.approver
FROM         dbo.vw_CourseLastApprover INNER JOIN
                      dbo.tblApprovalHist ON dbo.vw_CourseLastApprover.MaxOfseq = dbo.tblApprovalHist.seq AND 
                      dbo.vw_CourseLastApprover.coursenum = dbo.tblApprovalHist.coursenum AND 
                      dbo.vw_CourseLastApprover.coursealpha = dbo.tblApprovalHist.coursealpha AND dbo.vw_CourseLastApprover.campus = dbo.tblApprovalHist.campus
' 
GO
/****** Object:  View [vw_Incomplete_Assessment_4]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Incomplete_Assessment_4]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Incomplete_Assessment_4]
AS
SELECT DISTINCT dbo.tblAssessedData.accjcid
FROM         dbo.vw_Incomplete_Assessment_2 INNER JOIN
                      dbo.tblAssessedData ON dbo.vw_Incomplete_Assessment_2.accjcid = dbo.tblAssessedData.accjcid
WHERE     (dbo.tblAssessedData.question IS NULL)
' 
GO
/****** Object:  View [vw_ACCJC_2]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_ACCJC_2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_ACCJC_2]
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
/****** Object:  View [vw_LinkedCompetency2]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_LinkedCompetency2]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_LinkedCompetency2]
AS
SELECT  DISTINCT     vw.campus, vw.historyid, vw.src, vw.seq, vw.Assess, vw.GESLO, vw.Content, vw.MethodEval, tcc.content AS Competency
FROM         dbo.vw_LinkedCompetency vw INNER JOIN
                      dbo.tblCourseCompetency tcc ON vw.historyid = tcc.historyid AND vw.seq = tcc.seq
' 
GO
/****** Object:  View [vw_AllQuestions]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_AllQuestions]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_AllQuestions]
AS
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(1000)) AS question
FROM         dbo.vw_CourseQuestionsYN
WHERE questionseq > 0
UNION
SELECT     campus, questionseq, Question_Number, Question_Friendly, cast(question AS varchar(1000)) AS question
FROM         dbo.vw_CampusQuestionsYN
WHERE questionseq > 0
' 
GO
/****** Object:  View [vw_Incomplete_Assessment_3]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Incomplete_Assessment_3]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Incomplete_Assessment_3]
AS
SELECT     historyid, accjcid
FROM         dbo.vw_Incomplete_Assessment_1
WHERE     (accjcid NOT IN
                          (SELECT     ACCJCID
                            FROM          vw_Incomplete_Assessment_2))
' 
GO
/****** Object:  View [vw_Incomplete_Assessment_5]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Incomplete_Assessment_5]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Incomplete_Assessment_5]
AS
SELECT     accjcid
FROM         dbo.vw_Incomplete_Assessment_3
UNION
SELECT     accjcid
FROM         vw_Incomplete_Assessment_4
' 
GO
/****** Object:  View [vw_Incomplete_Assessment_6]    Script Date: 01/11/2011 11:53:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vw_Incomplete_Assessment_6]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [vw_Incomplete_Assessment_6]
AS
SELECT     dbo.tblCourseComp.Campus, dbo.tblCourseComp.CourseAlpha, dbo.tblCourseComp.CourseNum, dbo.tblCourseComp.CourseType, 
                      dbo.vw_Incomplete_Assessment_1.CompID, dbo.vw_Incomplete_Assessment_1.accjcid, dbo.tblCourseComp.Comp
FROM         dbo.tblCourseComp INNER JOIN
                      dbo.vw_Incomplete_Assessment_5 INNER JOIN
                      dbo.vw_Incomplete_Assessment_1 ON dbo.vw_Incomplete_Assessment_5.accjcid = dbo.vw_Incomplete_Assessment_1.accjcid ON 
                      dbo.tblCourseComp.CompID = dbo.vw_Incomplete_Assessment_1.CompID
' 
