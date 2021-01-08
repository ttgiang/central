/* ------------------------------------------*/
/* df00126												*/
/* ------------------------------------------*/

// check for approved outlines not having approved progress

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
GO
SET ANSI_PADDING OFF


/* ------------------------------------------*/
/* things to do - START								*/
/* ------------------------------------------*/

cnv00 (readProps - included)

/* ------------------------------------------*/
/* things to do - END								*/
/* ------------------------------------------*/

/* ------------------------------------------*/
/* PENDING (FOR THANH ONLY ) - start			*/
/* ------------------------------------------*/

/* hide/show incomplete linked items */
IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='HideIncompleteLinkedItems') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','HideIncompleteLinkedItems','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('HideIncompleteLinkedItems','YESNO','Hide linked grid when there are no items selected (the destination or Y-axis is missing).','','radio')
END

/* ------------------------------------------*/
/* PENDING - end										*/
/* ------------------------------------------*/

/* ------------------------------------------*/
/* notifications DO NOT USE */
/* ------------------------------------------*/

IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='NotifyDivisionChairOnPrereqAddWithApproval') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','NotifyDivisionChairOnPrereqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('NotifyDivisionChairOnPrereqAddWithApproval','YESNO','Whether division chair approval is necessary. ','','radio')
END

IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='NotifyDivisionChairOnCoreqAddWithApproval') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','NotifyDivisionChairOnCoreqAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('NotifyDivisionChairOnCoreqAddWithApproval','YESNO','Whether division chair approval is necessary. ','','radio')
END

IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='NotifyDivisionChairOnCrossListAddWithApproval') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','NotifyDivisionChairOnCrossListAddWithApproval','Whether division chair approval is necessary. ','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('NotifyDivisionChairOnCrossListAddWithApproval','YESNO','Whether division chair approval is necessary. ','','radio')
END

===================================================================

SELECT id, historyid, campus, CourseAlpha, CourseNum, CourseType, edit, Progress, proposer, edit0, edit1, edit2, dispID, Division, coursetitle, credits,
repeatable, maxcredit, articulation, semester, crosslisted, coursedate, effectiveterm, gradingoptions, coursedescr, hoursperweek, reviewdate,
auditdate, excluefromcatalog, dateproposed, assessmentdate, X15, X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31,
X32, X33, X34, X35, X36, X37, X38, X39, X40, X41, X42, X43, X44, X45, X46, X47, X48, X49, X50, X51, X52, X53, X54, X55, X56, X57, X58, X59, X60,
X61, X62, X63, X64, X65, X66, X67, X68, X69, X70, X71, X72, X73, X74, X75, X76, X77, X78, X79, X80, jsid, reason, votesfor, votesagainst,
votesabstain, route, subprogress, MESSAGEPAGE01, MESSAGEPAGE02, MESSAGEPAGE03, MESSAGEPAGE04, MESSAGEPAGE05
FROM  tblCourse
WHERE     ((RTRIM(CourseAlpha) + '' + RTRIM(CourseNum)) IN
                          (SELECT     RTRIM(CourseAlpha) + '' + RTRIM(CourseNum) AS alpha
                            FROM          tblCourse AS tblCourse_1
                            WHERE      (campus = 'LEE') AND (CourseType = 'CUR')
                            GROUP BY CourseAlpha, CourseNum
                            HAVING      (SUM(1) > 1)))
ORDER BY CourseAlpha, CourseNum, CourseType

=================================================================== MORTON

SELECT z.ID, z.Campus, z.Alpha, z.Number, z.Title,z.Credits,  z.ContactHours, z.ContactHours2, c.coursedate
INTO zmorton
FROM zn28k16i11199 AS z INNER JOIN tblCourse AS c ON
z.Campus = c.campus
AND z.Alpha = c.CourseAlpha
AND z.Number = c.CourseNum
WHERE     (c.CourseType = 'CUR')
AND not coursedate is null

/* T-SQL */

alter table authors
add author_type varchar(20)
default "primary_author" not null,
au_publisher varchar(40) null

/* find column by name */
SELECT TABLE_NAME,COLUMN_NAME,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME like '%arti%'

SELECT TABLE_NAME,COLUMN_NAME,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'campus'
AND TABLE_NAME like 'tbl%'

// MAINTENANCE

/* ------------------------------------------*/
/* space used		                            */
/* ------------------------------------------*/
CREATE TABLE [dbo].[zzzTableSpaceUsed01](
	[name] [varchar](50) NULL,
	[dte] [smalldatetime] NULL,
	[reserved] [varchar](18) NULL,
	[data] [varchar](18) NULL,
	[index_size] [varchar](18) NULL,
	[unused] [varchar](18) NULL,
	[rows] [int] NULL,
	[reserved_int] [int] NULL,
	[data_int] [int] NULL,
	[index_size_int] [int] NULL,
	[unused_int] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[zzzTableSpaceUsed02](
	[name] [varchar](50) NULL,
	[dte_last] [smalldatetime] NULL,
	[rows_last] [int] NULL,
	[reserved_int_last] [int] NULL,
	[data_int_last] [int] NULL,
	[index_size_int_last] [int] NULL,
	[unused_int_last] [int] NULL,
	[dte_diff] [int] NULL,
	[rows_diff] [int] NULL,
	[reserved_int_diff] [int] NULL,
	[data_int_diff] [int] NULL,
	[index_size_int_diff] [int] NULL,
	[unused_int_diff] [int] NULL
) ON [PRIMARY]

GO


/*
	update table 01
*/

delete from zzzTableSpaceUsed01;

exec sp_msforeachtable
@command1 = "insert into zzzTableSpaceUsed01([name],[rows],[reserved],[data],[index_size],[unused]) EXEC sp_spaceused '?'"

update zzzTableSpaceUsed01 SET
	[reserved_int] = cast(substring([reserved],1,charindex(' ', [reserved])) as int),
	[data_int] = cast(substring([data],1,charindex(' ', [data])) as int),
	[index_size_int] = cast(substring([index_size],1,charindex(' ', [index_size])) as int),
	[unused_int] = cast(substring([unused],1,charindex(' ', [unused])) as int),
	[dte] = getdate()


/*
	update table 02
*/
delete from zzzTableSpaceUsed02;

insert into zzzTableSpaceUsed02([name],[rows_last],[reserved_int_last],[data_int_last],[index_size_int_last],[unused_int_last],dte_last)
select [name],[rows],[reserved_int],[data_int],[index_size_int],[unused_int],getdate()
from zzzTableSpaceUsed01