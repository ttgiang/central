-- tblUsers
delete from tblusers where campus='HAW' and userid<>'THANHG';

insert into tblusers(campus, UH, userlevel, password, status, sendnow, attachment, userid, firstname, lastname, fullname, department, division, email, title, position)
SELECT     campus, UH, userlevel, password, status, sendnow, attachment, userid, firstname, lastname, fullname, substring(department,1,10), substring(division,1,10), email, title, position
FROM         HAW_Users

-- create table with chair names
drop table haw_chairs;

SELECT     HAW_Alphas.Alpha, HAW_Alphas.Description, HAW_Alphas.Chair, HAW_Alphas.Dean, HAW_Users.userid, HAW_Users.division, HAW_Users.department, 
                      BannerDivision.DIVS_DESCRIPTION
into haw_chairs
FROM         BannerDivision RIGHT OUTER JOIN
                      HAW_Users ON BannerDivision.DIVISION_CODE = HAW_Users.division RIGHT OUTER JOIN
                      HAW_Alphas ON HAW_Users.fullname = HAW_Alphas.Chair

-- missing user id
update HAW_chairs set userid='NAHMMIJO',division='LBRT',department='SSCI',DIVS_DESCRIPTION='Liberal Arts' where chair = 'Trina Nahn-Mijo';
update haw_chairs set DIVS_DESCRIPTION='ATE' where division='ATE' and DIVS_DESCRIPTION is null;
update haw_chairs set DIVS_DESCRIPTION='BEAT' where division='BEAT' and DIVS_DESCRIPTION is null;

update haw_chairs set DIVS_DESCRIPTION='HOST/CULN' where division='HOST/CULN' and DIVS_DESCRIPTION is null;
update haw_chairs set DIVS_DESCRIPTION='STUDENT SERVICES' where division='STUDENT SERVICES' and DIVS_DESCRIPTION is null;

-- tblDivision

delete from tblDivision where campus='HAW';

INSERT INTO tblDivision (campus, divisioncode, divisionname, chairname)
SELECT DISTINCT 'HAW' AS campus, division+'-'+userid, DIVS_DESCRIPTION+'-'+userid, userid
FROM HAW_Chairs;

-- tblChairs
INSERT INTO tblChairs
                      (programid, coursealpha)
SELECT     tblDivision.divid, HAW_Chairs.Alpha
FROM         HAW_Chairs INNER JOIN
                      tblDivision ON HAW_Chairs.division + '-' + HAW_Chairs.userid = tblDivision.divisioncode

-- questions
use [ccv2]
delete from tblcampusquestions where campus='HAW';
delete from tblcoursequestions where campus='HAW';

INSERT INTO tblCourseQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append)
SELECT    campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append
FROM         HAW_tblCourseQuestions;

INSERT INTO tblCampusQuestions(campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append)
SELECT    campus, type, questionnumber, questionseq, question, include, change, help, auditby, auditdate, required, helpfile, audiofile, defalt, comments, len, counttext, 
                      extra, [permanent], append
FROM         HAW_tblCampusQuestions;
