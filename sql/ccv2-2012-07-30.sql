/* ------------------------------------------*/
/* DONE?													*/
/* ------------------------------------------*/

delete from cccm6100 where Question_Number > 98;

delete from tblcoursequestions where cast(question as varchar)='PENDING' and cast(help as varchar)='PENDING';

delete from tblcoursequestions where cast(question as varchar)='Special Approval' and cast(help as varchar)='Special Approval';

delete from tblcoursequestions where cast(question as varchar)='Gen ED requirements' and cast(help as varchar)='Gen ED requirements';

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',99,'Special Approval','X90',50,50,'check','SpecialApproval',null,'Special Approval',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',100,'Gen ED requirements','X91',50,50,'check','GENED',null,'Gen ED requirements',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',101,'PENDING','X92',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',102,'PENDING','X93',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',103,'PENDING','X94',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',104,'PENDING','X95',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',105,'PENDING','X96',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',106,'PENDING','X97',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',107,'PENDING','X98',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',108,'PENDING','X99',0,0,'wysiwyg',null,null,'PENDING',null,null);

INSERT INTO CCCM6100(campus,type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain,Comments,rules,rulesform)
VALUES('SYS','Course',109,'Experimental Date','experimentaldate',10,10,'text',null,null,'experimentaldate',null,null);

Run sys admin >> Fill Missing Questions to Campuses

/* ------------------------------------------*/
/* special approval & gened					  */
/* ------------------------------------------*/

delete from tblini where category='GENED';
insert into tblini (category,campus,kid) values('GENED','HAW','');
insert into tblini (category,campus,kid) values('GENED','HIL','');
insert into tblini (category,campus,kid) values('GENED','KAP','');
insert into tblini (category,campus,kid) values('GENED','KAU','');
insert into tblini (category,campus,kid) values('GENED','LEE','');
insert into tblini (category,campus,kid) values('GENED','MAN','');
insert into tblini (category,campus,kid) values('GENED','UHMC','');
insert into tblini (category,campus,kid) values('GENED','WIN','');
insert into tblini (category,campus,kid) values('GENED','WOA','');

delete from tblini where category='SpecialApproval';
insert into tblini (category,campus,kid) values('SpecialApproval','HAW','');
insert into tblini (category,campus,kid) values('SpecialApproval','HIL','');
insert into tblini (category,campus,kid) values('SpecialApproval','KAP','');
insert into tblini (category,campus,kid) values('SpecialApproval','KAU','');
insert into tblini (category,campus,kid) values('SpecialApproval','LEE','');
insert into tblini (category,campus,kid) values('SpecialApproval','MAN','');
insert into tblini (category,campus,kid) values('SpecialApproval','UHMC','');
insert into tblini (category,campus,kid) values('SpecialApproval','WIN','');
insert into tblini (category,campus,kid) values('SpecialApproval','WOA','');

insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',7,'HON','ASEL','AAS, or ATS Degree Elective (ASEL)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',1,'HON','ASCM','Communications (ASCM)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',4,'HON','ASGB','Functioning Effectively in Society (ASGB)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',2,'HON','ASQL','Quantitative or Logical Reasoning (ASQL)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',3,'HON','ASGA','Understanding the Natural Environment (ASGA)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',5,'HON','ASGC','Understanding the Social Environment (ASGC)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('GENED',6,'HON','ASGD','World Cultures and Values (ASGD)','Y','SYSADM',getdate());

insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('SpecialApproval',1,'HON','I','Instructor Approval (I)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('SpecialApproval',2,'HON','AA','Academic Advisor Approval (AA)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('SpecialApproval',3,'HON','AD','Academic Dean Approval (AD)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('SpecialApproval',4,'HON','CE','Continuing ED Approval (CE)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('SpecialApproval',5,'HON','D','Department Approval (D)','Y','SYSADM',getdate());
insert into tblini(category,seq,campus,kid,kdesc,kedit,klanid,kdate) values('SpecialApproval',6,'HON','PD','Program Director Approval (PD)','Y','SYSADM',getdate());
