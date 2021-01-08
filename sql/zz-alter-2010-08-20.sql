ALTER TABLE tblValues ALTER column shortdescr varchar(250);
Go

CREATE 
  INDEX [PK_tblValues_Seq] ON [dbo].[tblValues] ([campus], [topic], [subtopic], [seq])
ON [PRIMARY]
Go

UPDATE tblINI SET KID = 'OtherDepartmentsRequiresApproval' WHERE KID='RequiredOrElectiveRequiresApproval'
Go

UPDATE tblINI SET KID = 'NotifyChairOnOtherDepartments' WHERE KID='NotifyChairOnRequiredOrElective'
Go

UPDATE tblINIKey SET KID = 'OtherDepartmentsRequiresApproval' WHERE KID='RequiredOrElectiveRequiresApproval'
Go

UPDATE tblINIKey SET KID = 'NotifyChairOnOtherDepartments' WHERE KID='NotifyChairOnRequiredOrElective'
Go

UPDATE cccm6100
SET question_type='texthidden'
WHERE campus='SYS' AND type='Course' AND question_number=29
Go

INSERT INTO tblValues (campus,topic,subtopic,shortdescr,seq,auditby,auditdate)
select campus, 'PLO - ' + alpha AS topic, alpha as subtopic, comments as shortdescr, rdr as seq, 'HOTTA', getdate()
from tbllists
Go

ALTER TABLE tblValues ADD src varchar(50);
Go

ALTER TABLE tblApprover ADD availableDate smalldatetime;
Go

ALTER TABLE tblApprover ADD startdate smalldatetime;
Go

ALTER TABLE tblApprover ADD enddate smalldatetime;
Go

