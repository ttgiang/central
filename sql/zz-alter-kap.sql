ENG 272 count of comments is off

	select * from tblreviewhist where historyid='P57e30e1227'
	select * from tblreviewhist2 where historyid='P57e30e1227'
	

- course content with dup keys?	
	SELECT campus, historyid, CourseType
	FROM         tblCourseContent
	where historyid='Q53k23e12179' or historyid='N2h15f12178'
	or historyid='R23l23e1268'
	or historyid='t15l23e12210'
	order by historyid


SELECT c.Question_Number, c.Question_Friendly, q.include, q.question
FROM CCCM6100 c INNER JOIN
tblCampusQuestions q ON c.campus = q.campus AND c.Question_Number = q.questionnumber
WHERE (c.campus = 'KAP') AND (c.type = 'Campus') AND (q.include = 'Y');

SELECT q.questionseq, c.Question_Number, c.Question_Friendly, q.include, q.question
FROM CCCM6100 c INNER JOIN tblCourseQuestions q ON c.Question_Number = q.questionnumber
WHERE     (c.campus = 'SYS') AND (c.type = 'Course') AND (q.campus = 'KAP') AND (q.include = 'Y')
ORDER BY q.questionseq;