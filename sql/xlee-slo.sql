Drop table tempLEESLO;
Drop table tempLEESLO1;
Drop table tempLEESLO2;

/* create tables - START */
CREATE TABLE [dbo].[tempLEESLO](
	[CrsAlphaNum] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CrsAlpha] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CrsNo] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CrsTitle] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EffectiveTerm] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SLO] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[historyid] [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[lineitem] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tempLEESLO] PRIMARY KEY CLUSTERED 
(
	[CrsAlpha] ASC,
	[CrsNo] ASC,
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE TABLE [dbo].[tempLEESLO1](
	[CrsAlphaNum] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[crsalpha] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[crsno] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CrsTitle] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EffectiveTerm] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SLO] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[historyid] [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lineitem] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE TABLE [dbo].[tempLEESLO2](
	[CrsAlphaNum] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[crsalpha] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[crsno] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CrsTitle] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EffectiveTerm] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SLO] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[historyid] [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lineitem] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/* create tables - END */

/* 1 - start clean */
Delete from tempLEESLO;
Delete from tempLEESLO1;
Delete from tempLEESLO2;

/* 2 - get course and terms */
INSERT INTO templeeslo1
SELECT rtrim(CourseAlpha) + rtrim(CourseNum) AS CrsAlphaNum,CourseAlpha AS CrsAlpha, CourseNum AS CrsNo, coursetitle AS CrsTitle, b.TERM_DESCRIPTION AS EffectiveTerm, CONVERT(varchar,auditdate, 101) AS ModifiedDate, X18 AS SLO,historyid, '0' as lineitem
FROM tblCourse, BannerTerms AS b
WHERE (campus = 'LEE') 
AND (NOT (CourseAlpha IS NULL)) 
AND (CourseAlpha <> '') 
AND (CourseType = 'CUR') 
AND EffectiveTerm = b.TERM_CODE;

/* 3 - get comps */
INSERT INTO templeeslo2
SELECT CrsAlphaNum, CrsAlpha, CrsNo, CrsTitle, b.TERM_DESCRIPTION AS EffectiveTerm, ModifiedDate, SLO, historyid, LineItem
FROM
(
SELECT     RTRIM(c.CourseAlpha) + RTRIM(c.CourseNum) AS CrsAlphaNum, cc.CourseAlpha AS CrsAlpha, cc.CourseNum AS CrsNo, c.coursetitle AS CrsTitle, 
                      c.effectiveterm AS EffectiveTerm, cc.Comp AS SLO, Convert(Varchar,cc.AuditDate,101) AS ModifiedDate, cc.historyid, 1 AS LineItem
FROM         tblCourse AS c RIGHT OUTER JOIN
                      tblCourseComp AS cc ON c.historyid = cc.historyid AND c.campus = cc.Campus
WHERE     (cc.Campus = 'LEE') AND (cc.CourseType = 'CUR')
) AS c, BannerTerms AS b
WHERE c.EffectiveTerm = b.term_code;

/* 5 - combine into main table */
insert
INTO tempLEESLO
SELECT * FROM tempLEESLO2;

/* 4 - combine into main table

for guy's report, he wants single line items only. 

*/
insert
INTO tempLEESLO (CrsAlphaNum, CrsAlpha, CrsNo, CrsTitle, EffectiveTerm, ModifiedDate, SLO, historyid, lineitem)
SELECT CrsAlphaNum, CrsAlpha, CrsNo, CrsTitle, EffectiveTerm, ModifiedDate, SLO, historyid, lineitem
FROM tempLEESLO1
WHERE CrsAlphaNum NOT IN 
(SELECT CrsAlphaNum FROM tempLEESLO);

/* 6 - delete experimental */
delete 
from tempLEESLO
where crsno like '%97';

/* 7 - delete experimental */
delete 
from tempLEESLO
where crsno like '%98';

/* 8 - delete independent study */
delete 
from tempLEESLO
where crsno like '%99';

/* 9 - delete null SLO */
delete 
from tempLEESLO
where slo is null;

