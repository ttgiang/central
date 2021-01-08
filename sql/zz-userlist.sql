/------------------------------------------------------
/* campus
------------------------------------------------------*/
update tblini set category = 'UserCampusCheckbox1' where category = 'UserCheckbox1'
update tblini set category = 'UserCampusCheckbox2' where category = 'UserCheckbox2'
update tblini set category = 'UserCampusCheckbox3' where category = 'UserCheckbox3'

update tblini set category = 'UserCampusRadioList1' where category = 'UserRadioList1'
update tblini set category = 'UserCampusRadioList2' where category = 'UserRadioList2'
update tblini set category = 'UserCampusRadioList3' where category = 'UserRadioList3'

if((select count(id) from tblini where campus='TTG' and category='UserCampusRadioList1') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCampusRadioList1','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCampusRadioList2') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCampusRadioList2','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCampusRadioList3') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCampusRadioList3','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCampusCheckBox1') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCampusCheckBox1','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCampusCheckBox2') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCampusCheckBox2','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCampusCheckBox3') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCampusCheckBox3','TTG','Example Key','Example Description','Example Value','Y');

-- should be 9, 9, 10
select * from tblcampusquestions where (questionnumber>=37 and questionnumber<=39) and include = 'Y'
update tblcampusquestions set question='UserCampusRadioList1' where questionnumber=37 and include='N';
update tblcampusquestions set question='UserCampusRadioList2' where questionnumber=38 and include='N';
update tblcampusquestions set question='UserCampusRadioList3' where questionnumber=39 and include='N';

-- should be 10, 10, 10
select * from tblcampusquestions where (questionnumber>=47 and questionnumber<=49) and include = 'Y'
update tblcampusquestions set question='UserCampusCheckBox1' where questionnumber=47 and include='N';
update tblcampusquestions set question='UserCampusCheckBox2' where questionnumber=48 and include='N';
update tblcampusquestions set question='UserCampusCheckBox3' where questionnumber=49 and include='N';

/------------------------------------------------------
/* course
------------------------------------------------------*/

if((select count(id) from tblini where campus='TTG' and category='UserCourseCheckBox1') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseCheckBox1','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseCheckBox2') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseCheckBox2','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseCheckBox3') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseCheckBox3','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseRadioList1') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseRadioList1','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseRadioList2') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseRadioList2','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseRadioList3') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseRadioList3','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseRadioList4') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseRadioList4','TTG','Example Key','Example Description','Example Value','Y');

if((select count(id) from tblini where campus='TTG' and category='UserCourseRadioList5') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('UserCourseRadioList5','TTG','Example Key','Example Description','Example Value','Y');

-- should be all 10s
select * from tblcoursequestions where (questionnumber>=101 and questionnumber<=108)
update tblcoursequestions set question='UserWYSIWYG01' where questionnumber=101 and include='N';
update tblcoursequestions set question='UserWYSIWYG02' where questionnumber=102 and include='N';
update tblcoursequestions set question='UserWYSIWYG03' where questionnumber=103 and include='N';
update tblcoursequestions set question='UserCourseCheckBox1' where questionnumber=104 and include='N';
update tblcoursequestions set question='UserCourseCheckBox2' where questionnumber=105 and include='N';
update tblcoursequestions set question='UserCourseCheckBox3' where questionnumber=106 and include='N';
update tblcoursequestions set question='UserCourseRadioList1' where questionnumber=107 and include='N';
update tblcoursequestions set question='UserCourseRadioList2' where questionnumber=108 and include='N';
update tblcoursequestions set question='UserCourseRadioList3' where questionnumber=86 and include='N';
update tblcoursequestions set question='UserCourseRadioList4' where questionnumber=87 and include='N';
update tblcoursequestions set question='UserCourseRadioList5' where questionnumber=88 and include='N';

/------------------------------------------------------
/* cccm
------------------------------------------------------*/
update CCCM6100 set Question_Type='wysiwyg', CCCM6100='UserWYSIWYG01',Question_Ini='UserWYSIWYG01',comments='User WYSIWYG 01'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X92' and Question_Number = 101

update CCCM6100 set Question_Type='wysiwyg', CCCM6100='UserWYSIWYG02',Question_Ini='UserWYSIWYG02',comments='User WYSIWYG 02'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X93' and Question_Number = 102

update CCCM6100 set Question_Type='wysiwyg', CCCM6100='UserWYSIWYG03',Question_Ini='UserWYSIWYG03',comments='User WYSIWYG 03'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X94' and Question_Number = 103

update CCCM6100 set Question_Type='check', CCCM6100='UserCourseCheckBox1',Question_Ini='UserCourseCheckBox1',comments='User defined check box 1', question_explain='C62',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X95' and Question_Number = 104

update CCCM6100 set Question_Type='check', CCCM6100='UserCourseCheckBox2',Question_Ini='UserCourseCheckBox2',comments='User defined check box 2', question_explain='C63',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X96' and Question_Number = 105

update CCCM6100 set Question_Type='check', CCCM6100='UserCourseCheckBox3',Question_Ini='UserCourseCheckBox3',comments='User defined check box 3', question_explain='C64',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X97' and Question_Number = 106

update CCCM6100 set Question_Type='radio', CCCM6100='UserCourseRadioList1',Question_Ini='UserCourseRadioList1',comments='User defined Radio list 1', question_explain='C65',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X98' and Question_Number = 107

update CCCM6100 set Question_Type='radio', CCCM6100='UserCourseRadioList2',Question_Ini='UserCourseRadioList2',comments='User defined Radio list 2', question_explain='C66',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X99' and Question_Number = 108

update CCCM6100 set Question_Type='radio', CCCM6100='UserCourseRadioList3',Question_Ini='UserCourseRadioList3',comments='User defined Radio list 3', question_explain='C67',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X82' and Question_Number = 86

update CCCM6100 set Question_Type='radio', CCCM6100='UserCourseRadioList4',Question_Ini='UserCourseRadioList4',comments='User defined Radio list 4', question_explain='C68',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X83' and Question_Number = 87

update CCCM6100 set Question_Type='radio', CCCM6100='UserCourseRadioList5',Question_Ini='UserCourseRadioList5',comments='User defined Radio list 5', question_explain='C69',extra='N'
WHERE campus='SYS' and type='Course' and  Question_Friendly='X84' and Question_Number = 88

update CCCM6100 set Question_Type='check', CCCM6100='UserCampusCheckbox1',Question_Ini='UserCampusCheckbox1',comments='User defined check box 1', question_explain='C56'
WHERE campus='TTG' and type='Campus' and  Question_Friendly='C47' and Question_Number = 47

update CCCM6100 set Question_Type='check', CCCM6100='UserCampusCheckbox2',Question_Ini='UserCampusCheckbox2',comments='User defined check box 2', question_explain='C57'
WHERE campus='TTG' and type='Campus' and  Question_Friendly='C48' and Question_Number = 48

update CCCM6100 set Question_Type='check', CCCM6100='UserCampusCheckbox3',Question_Ini='UserCampusCheckbox3',comments='User defined check box 3', question_explain='C58'
WHERE campus='TTG' and type='Campus' and  Question_Friendly='C49' and Question_Number = 49

update CCCM6100 set Question_Type='radio', CCCM6100='UserCampusRadioList1',Question_Ini='UserCampusRadioList1',comments='User defined radio 1', question_explain='C59'
WHERE campus='TTG' and type='Campus' and  Question_Friendly='C37' and Question_Number = 37

update CCCM6100 set Question_Type='radio', CCCM6100='UserCampusRadioList2',Question_Ini='UserCampusRadioList2',comments='User defined radio 2', question_explain='C60'
WHERE campus='TTG' and type='Campus' and  Question_Friendly='C38' and Question_Number = 38

update CCCM6100 set Question_Type='radio', CCCM6100='UserCampusRadioList3',Question_Ini='UserCampusRadioList3',comments='User defined radio 3', question_explain='C61'
WHERE campus='TTG' and type='Campus' and  Question_Friendly='C39' and Question_Number = 39

//
// ttg for campus
//
insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 56, 'Do Not Use - reserved for campus defined checkbox 1', 'C56', 0, 0, 'wysiwyg', NULL, NULL, 'Question 56', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 57, 'Do Not Use - reserved for campus defined checkbox 2', 'C57', 0, 0, 'wysiwyg', NULL, NULL, 'Question 57', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 58, 'Do Not Use - reserved for campus defined checkbox 3', 'C58', 0, 0, 'wysiwyg', NULL, NULL, 'Question 58', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 59, 'Do Not Use - reserved for campus defined radio 1', 'C59', 0, 0, 'wysiwyg', NULL, NULL, 'Question 59', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 60, 'Do Not Use - reserved for campus defined radio 2', 'C60', 0, 0, 'wysiwyg', NULL, NULL, 'Question 60', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 61, 'Do Not Use - reserved for campus defined radio 3', 'C61', 0, 0, 'wysiwyg', NULL, NULL, 'Question 61', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 62, 'Do Not Use - reserved for course defined checkbox 1', 'C62', 0, 0, 'wysiwyg', NULL, NULL, 'Question 62', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 63, 'Do Not Use - reserved for course defined checkbox 2', 'C63', 0, 0, 'wysiwyg', NULL, NULL, 'Question 63', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 64, 'Do Not Use - reserved for course defined checkbox 3', 'C64', 0, 0, 'wysiwyg', NULL, NULL, 'Question 64', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 65, 'Do Not Use - reserved for course defined radio 1', 'C65', 0, 0, 'wysiwyg', NULL, NULL, 'Question 65', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 66, 'Do Not Use - reserved for course defined radio 2', 'C66', 0, 0, 'wysiwyg', NULL, NULL, 'Question 66', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 67, 'Do Not Use - reserved for course defined radio 3', 'C67', 0, 0, 'wysiwyg', NULL, NULL, 'Question 67', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 68, 'Do Not Use - reserved for course defined radio 4', 'C68', 0, 0, 'wysiwyg', NULL, NULL, 'Question 68', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

insert into CCCM6100 (campus, type, Question_Number, CCCM6100, Question_Friendly, Question_Len, Question_Max, Question_Type, Question_Ini, Question_Explain, Comments, rules, rulesform, extra, [permanent], append, len, counttext)
values('TTG', 'Campus', 69, 'Do Not Use - reserved for course defined radio 5', 'C69', 0, 0, 'wysiwyg', NULL, NULL, 'Question 69', NULL, NULL, 'N', NULL, NULL, NULL, NULL)

//
// alter table structure
//

in main sql file

//
// alter for course table
//
ALTER TABLE tblcourse ADD X100 text;
ALTER TABLE tblcourse ADD X101 text;
ALTER TABLE tblcourse ADD X102 text;
ALTER TABLE tblcourse ADD X103 text;
ALTER TABLE tblcourse ADD X104 text;
ALTER TABLE tblcourse ADD X105 text;
ALTER TABLE tblcourse ADD X106 text;
ALTER TABLE tblcourse ADD X107 text;
ALTER TABLE tblcourse ADD X108 text;
ALTER TABLE tblcourse ADD X109 text;
ALTER TABLE tblcourse ADD X110 text;
ALTER TABLE tblcourse ADD X111 text;
ALTER TABLE tblcourse ADD X112 text;
ALTER TABLE tblcourse ADD X113 text;
ALTER TABLE tblcourse ADD X114 text;
ALTER TABLE tblcourse ADD X115 text;
ALTER TABLE tblcourse ADD X116 text;
ALTER TABLE tblcourse ADD X117 text;
ALTER TABLE tblcourse ADD X118 text;
ALTER TABLE tblcourse ADD X119 text;
ALTER TABLE tblcourse ADD X120 text;

ALTER TABLE tblcoursearc ADD X100 text;
ALTER TABLE tblcoursearc ADD X101 text;
ALTER TABLE tblcoursearc ADD X102 text;
ALTER TABLE tblcoursearc ADD X103 text;
ALTER TABLE tblcoursearc ADD X104 text;
ALTER TABLE tblcoursearc ADD X105 text;
ALTER TABLE tblcoursearc ADD X106 text;
ALTER TABLE tblcoursearc ADD X107 text;
ALTER TABLE tblcoursearc ADD X108 text;
ALTER TABLE tblcoursearc ADD X109 text;
ALTER TABLE tblcoursearc ADD X110 text;
ALTER TABLE tblcoursearc ADD X111 text;
ALTER TABLE tblcoursearc ADD X112 text;
ALTER TABLE tblcoursearc ADD X113 text;
ALTER TABLE tblcoursearc ADD X114 text;
ALTER TABLE tblcoursearc ADD X115 text;
ALTER TABLE tblcoursearc ADD X116 text;
ALTER TABLE tblcoursearc ADD X117 text;
ALTER TABLE tblcoursearc ADD X118 text;
ALTER TABLE tblcoursearc ADD X119 text;
ALTER TABLE tblcoursearc ADD X120 text;

ALTER TABLE tblcoursecan ADD X100 text;
ALTER TABLE tblcoursecan ADD X101 text;
ALTER TABLE tblcoursecan ADD X102 text;
ALTER TABLE tblcoursecan ADD X103 text;
ALTER TABLE tblcoursecan ADD X104 text;
ALTER TABLE tblcoursecan ADD X105 text;
ALTER TABLE tblcoursecan ADD X106 text;
ALTER TABLE tblcoursecan ADD X107 text;
ALTER TABLE tblcoursecan ADD X108 text;
ALTER TABLE tblcoursecan ADD X109 text;
ALTER TABLE tblcoursecan ADD X110 text;
ALTER TABLE tblcoursecan ADD X111 text;
ALTER TABLE tblcoursecan ADD X112 text;
ALTER TABLE tblcoursecan ADD X113 text;
ALTER TABLE tblcoursecan ADD X114 text;
ALTER TABLE tblcoursecan ADD X115 text;
ALTER TABLE tblcoursecan ADD X116 text;
ALTER TABLE tblcoursecan ADD X117 text;
ALTER TABLE tblcoursecan ADD X118 text;
ALTER TABLE tblcoursecan ADD X119 text;
ALTER TABLE tblcoursecan ADD X120 text;

ALTER TABLE tblTempCourse ADD X100 text;
ALTER TABLE tblTempCourse ADD X101 text;
ALTER TABLE tblTempCourse ADD X102 text;
ALTER TABLE tblTempCourse ADD X103 text;
ALTER TABLE tblTempCourse ADD X104 text;
ALTER TABLE tblTempCourse ADD X105 text;
ALTER TABLE tblTempCourse ADD X106 text;
ALTER TABLE tblTempCourse ADD X107 text;
ALTER TABLE tblTempCourse ADD X108 text;
ALTER TABLE tblTempCourse ADD X109 text;
ALTER TABLE tblTempCourse ADD X110 text;
ALTER TABLE tblTempCourse ADD X111 text;
ALTER TABLE tblTempCourse ADD X112 text;
ALTER TABLE tblTempCourse ADD X113 text;
ALTER TABLE tblTempCourse ADD X114 text;
ALTER TABLE tblTempCourse ADD X115 text;
ALTER TABLE tblTempCourse ADD X116 text;
ALTER TABLE tblTempCourse ADD X117 text;
ALTER TABLE tblTempCourse ADD X118 text;
ALTER TABLE tblTempCourse ADD X119 text;
ALTER TABLE tblTempCourse ADD X120 text;

if((select count(id) from tblini where campus='TTG' and category='SystemYesNo') = 0)
insert into tblini (category,campus,kid,kdesc,kval1,kedit) values('SystemYesNo','TTG','SystemYesNo','SystemYesNo','SystemYesNo','Y');

insert into tblini(seq, category, campus, kid, kdesc, kval1,kedit, klanid, kdate)
values(1,'SystemYesNo','TTG','Yes','Yes','1','Y','SYSADM',getdate());

insert into tblini(seq, category, campus, kid, kdesc, kval1,kedit, klanid, kdate)
values(2,'SystemYesNo','TTG','No','No','0','Y','SYSADM',getdate())

run prod.jsp

run fill missing questions to campuses

update CCCM6100 set Question_Type='radio', CCCM6100='UserCampusRadioList1',Question_Ini='UserCampusRadioList1',comments='User defined radio 1', question_explain='C59'
WHERE type='Campus' and  Question_Friendly='C37' and Question_Number = 37

update CCCM6100 set Question_Type='radio', CCCM6100='UserCampusRadioList2',Question_Ini='UserCampusRadioList2',comments='User defined radio 2', question_explain='C60'
WHERE type='Campus' and  Question_Friendly='C38' and Question_Number = 38

update CCCM6100 set Question_Type='radio', CCCM6100='UserCampusRadioList3',Question_Ini='UserCampusRadioList3',comments='User defined radio 3', question_explain='C61'
WHERE type='Campus' and  Question_Friendly='C39' and Question_Number = 39
