IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='RenameRenumberRequiresApproval') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','RenameRenumberRequiresApproval','Does course rename/renumber require approval?','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('RenameRenumberRequiresApproval','YESNO','Does course rename/renumber require approval?','','radio')
END

IF (SELECT COUNT(*) FROM TBLINI WHERE category='System' AND kid='RenameRenumberAuthority') = 0 BEGIN
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('TTG','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','RenameRenumberAuthority','Person with overall authority on rename/renumber process (user ID in Value2)','0','','Y','THANHG');
	INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('RenameRenumberAuthority','YESNO','Person with overall authority on rename/renumber process (user ID in Value2)','','radio')
END

CREATE TABLE [dbo].[tblRename](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[campus] [varchar](10) NULL,
	[historyid] [varchar](18) NULL,
	[proposer] [varchar](50) NULL,
	[fromalpha] [varchar](10) NULL,
	[fromnum] [varchar](10) NULL,
	[toalpha] [varchar](10) NULL,
	[tonum] [varchar](10) NULL,
	[progress] [varchar](50) NULL,
	[justification] [text] NULL,
	[approvers] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF

CREATE TABLE [dbo].[tblRenamex](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[historyid] [varchar](18) NULL,
	[approver] [varchar](50) NULL,
	[approved] [bit] NULL,
	[comments] [text] NULL,
	[auditdate] [smalldatetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
