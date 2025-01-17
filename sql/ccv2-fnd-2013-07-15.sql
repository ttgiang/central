USE [ccv2]
GO
/****** Object:  Table [dbo].[tblfnditems]    Script Date: 07/15/2013 08:15:41 ******/
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
/****** Object:  View [dbo].[vw_fndfilesmaster]    Script Date: 07/15/2013 08:15:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_fndfilesmaster]
AS
SELECT     TOP (100) PERCENT MAX(seq) AS seq, originalname
FROM         dbo.tblfndfiles
GROUP BY originalname
ORDER BY originalname
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[38] 2[20] 3) )"
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
         Begin Table = "tblfndfiles"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 214
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_fndfilesmaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_fndfilesmaster'
GO
/****** Object:  Table [dbo].[tblfndfiles]    Script Date: 07/15/2013 08:15:43 ******/
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
/****** Object:  Table [dbo].[tblfnd]    Script Date: 07/15/2013 08:15:35 ******/
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
	[coproposer] [varchar](50) NULL,
	[type] [char](3) NULL,
	[progress] [varchar](50) NULL,
	[subprogress] [varchar](50) NULL,
	[edit] [bit] NULL,
	[edit0] [varchar](50) NULL,
	[edit1] [varchar](500) NULL,
	[edit2] [varchar](500) NULL,
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
/****** Object:  Table [dbo].[tblfnddata]    Script Date: 07/15/2013 08:15:44 ******/
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
/****** Object:  Table [dbo].[tblfndoutlines]    Script Date: 07/15/2013 08:15:39 ******/
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
GO
