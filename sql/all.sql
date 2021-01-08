declare	@campus varchar(10)
declare	@fromalpha varchar(10)
declare	@fromnum varchar(10)
declare	@toalpha varchar(10)
declare	@tonum varchar(10)
declare	@user varchar(30)
declare	@type varchar(10)
declare	@history varchar(18)
declare	@date varchar(20)

select @campus = 'LEE'
select @fromalpha = 'ICS'
select @fromnum = '212'
select @toalpha = 'ICS'
select @tonum = '219'
select @user = 'THANHG'
select @type = 'CUR'
select @history = '123456789'
select @date = '11-17-2008'

BEGIN TRANSACTION

DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

DELETE FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

DELETE FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

DELETE FROM tblTempCoreq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

DELETE FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

DELETE FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

DELETE FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

DELETE FROM tblTempCourseCompAss 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum

--////////////

INSERT INTO tblTempCourse 
	SELECT * FROM tblCourse 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'


INSERT INTO tblTempCampusData 
	SELECT * FROM tblCampusData 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'


INSERT INTO tblTempCoreq 
	SELECT * FROM tblCoreq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'


INSERT INTO tblTempPreReq
	SELECT * FROM tblPreReq 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'


INSERT INTO tblTempCourseComp 
	SELECT * FROM tblCourseComp 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'


INSERT INTO tblTempCourseContent 
	SELECT * FROM tblCourseContent 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'


INSERT INTO tblTempCourseCompAss 
	SELECT * FROM tblCourseCompAss 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum AND coursetype='CUR'

--////////////

UPDATE tblTempCoReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum


UPDATE tblTempPreReq 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum


UPDATE tblTempCourseComp 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum


UPDATE tblTempCourseContent 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum



UPDATE tblTempCampusData 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum


UPDATE tblTempCourseCompAss 
	SET historyid=@history,coursetype='PRE',auditdate=@date,coursealpha=@toalpha,coursenum=@tonum 
	WHERE campus=@campus AND coursealpha=@fromalpha AND coursenum=@fromnum

--////////////

INSERT INTO tblCourse 
	SELECT * FROM tblTempCourse 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'


INSERT INTO tblCampusData 
	SELECT * FROM tblTempCampusData 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'


INSERT INTO tblCoReq 
	SELECT * FROM tblTempCoReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'


INSERT INTO tblPreReq 
	SELECT * FROM tblTempPreReq 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'


INSERT INTO tblCourseComp 
	SELECT * FROM tblTempCourseComp 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'


INSERT INTO tblCourseContent 
	SELECT * FROM tblTempCourseContent 
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'


INSERT INTO tblCourseCompAss 
	SELECT * FROM tblTempCourseCompAss
	WHERE campus=@campus AND coursealpha=@toalpha AND coursenum=@tonum AND coursetype='PRE'

COMMIT

