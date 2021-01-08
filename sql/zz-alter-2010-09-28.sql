INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HAW','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HIL','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('HON','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('MAN','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('LEE','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAP','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('KAU','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('UHMC','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WIN','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO TBLINI (campus,category,kid,kdesc,kval1,kval2,kedit,klanid) VALUES('WOA','System','TrackItemChanges','Track changes between the last approved outline with a proposed outline.','0','','Y','THANHG');
INSERT INTO tblINIkey(kid,options,descr,valu,html) VALUES('TrackItemChanges','YESNO','Track changes between the last approved outline with a proposed outline.','','radio')

INSERT INTO tblSystem(campus,named,valu,descr) VALUES('GLOBAL','documents','\\tomcat\\webapps\\central\\docs\\','')

ALTER TABLE tblreviewers ADD historyid varchar(18);

>>>> run testfix.jsp

ALTER TABLE tblreviewers ALTER column coursealpha varchar(50);
ALTER TABLE tblreviewers ALTER column coursenum varchar(50);
ALTER TABLE tblreviewers ALTER column userid varchar(50);

ALTER TABLE tblmisc ALTER column coursealpha varchar(50);
ALTER TABLE tblmisc ALTER column coursenum varchar(50);

-- TLN
-- NLO
-- B64

