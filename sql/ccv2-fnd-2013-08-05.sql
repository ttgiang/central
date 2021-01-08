USE [foundations]
GO
/****** Object:  Table [dbo].[tblfnd]    Script Date: 08/05/2013 14:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblfnd](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[fndtype] [char](2) NULL,
	[created] [smalldatetime] NULL,
	[coursealpha] [varchar](10) NULL,
	[coursenum] [varchar](10) NULL,
	[coursedate] [smalldatetime] NULL,
	[coursetitle] [varchar](100) NULL,
	[coursedescr] [text] NULL,
	[proposer] [varchar](50) NULL,
	[coproposer] [varchar](500) NULL,
	[type] [char](3) NULL,
	[progress] [varchar](50) NULL,
	[subprogress] [varchar](50) NULL,
	[edit] [bit] NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL,
	[edit2] [varchar](500) NULL,
	[reviewdate] [smalldatetime] NULL,
	[comments] [text] NULL,
	[dateapproved] [smalldatetime] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblfnd] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblfnddata]    Script Date: 08/05/2013 14:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblfnddata](
	[id] [int] NOT NULL,
	[seq] [int] IDENTITY(1,1) NOT NULL,
	[fld] [char](10) NOT NULL,
	[data] [text] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
	[ts] [timestamp] NULL,
 CONSTRAINT [PK_tblfnddata] PRIMARY KEY CLUSTERED 
(
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblfndfiles]    Script Date: 08/05/2013 14:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblfndfiles](
	[id] [int] NOT NULL,
	[seq] [int] IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[kix] [varchar](18) NULL,
	[originalname] [varchar](100) NULL,
	[filename] [varchar](100) NULL,
	[en] [int] NULL,
	[sq] [int] NULL,
	[qn] [int] NULL,
	[auditby] [varchar](50) NULL,
	[auditdate] [smalldatetime] NULL,
 CONSTRAINT [PK_fndattached] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[seq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblfnditems]    Script Date: 08/05/2013 14:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblfnditems](
	[id] [numeric](10, 0) NOT NULL,
	[type] [varchar](50) NULL,
	[fld] [char](10) NULL,
	[seq] [int] NULL,
	[en] [int] NULL,
	[qn] [int] NULL,
	[hallmark] [text] NULL,
	[explanatory] [text] NULL,
	[question] [text] NULL,
	[campus] [varchar](10) NULL,
	[auditby] [varchar](20) NULL,
	[auditdate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblfndoutlines]    Script Date: 08/05/2013 14:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblfndoutlines](
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
	[WOA_2] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF