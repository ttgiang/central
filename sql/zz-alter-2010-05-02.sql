--
-- tblCampusOutlines
--
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tblCampusOutlines]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tblCampusOutlines]
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
	[MAU] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WIN] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WOA] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCampusOutlines] WITH NOCHECK ADD 
	CONSTRAINT [PK_tblCampusOutlines] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

--
-- vw_ApprovalsWithoutTasks
--
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

