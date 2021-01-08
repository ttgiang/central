select proposer, coursealpha, coursenum, X73 from tblcourse where campus='UHMC' and not x73 is null

select proposer, coursealpha, coursenum, X73 from tblcourse where campus='UHMC' and not x73 is null and x73 like '123,%'

select * from tblvalues where id = 122 or id = 123 or id = 262

delete from tblvalues where id = 261

update tblvalues set shortdescr = 'Liberal Arts' where id = 122

update tblvalues set shortdescr = 'Hawaiian Studies' where id = 123

insert into tblvalues(campus,topic,subtopic,shortdescr,longdescr,auditby,auditdate,valueid,seq,src)
values ('UHMC','FDProgram-LA','LA','Other',null,'THANHG',getdate(),null,8,null)

re-create all HTML
