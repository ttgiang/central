/------------------------------------------------------
/* ER16
------------------------------------------------------*/

/* ARC */
SELECT     TOP (100) PERCENT LTRIM(campus) + LTRIM(CourseAlpha) + LTRIM(CourseNum) AS kee, campus, CourseAlpha, CourseNum, coursetitle, proposer, coursedate, 
                      auditdate, historyid, CourseType, Progress
FROM         dbo.tblCourseARC
WHERE     (CourseAlpha <> '') AND (NOT (CourseAlpha IS NULL)) AND (CourseNum <> '') AND (NOT (CourseNum IS NULL)) AND (proposer <> '') AND (NOT (proposer IS NULL)) AND 
                      (NOT (coursedate IS NULL))
ORDER BY campus, CourseAlpha, CourseNum

/* CUR */
SELECT     TOP (100) PERCENT LTRIM(campus) + LTRIM(CourseAlpha) + LTRIM(CourseNum) AS kee, campus, CourseAlpha, CourseNum, coursetitle, proposer, coursedate, 
                      auditdate, historyid, CourseType, Progress
FROM         dbo.tblCourse
WHERE     (CourseType = 'CUR') AND (CourseAlpha <> '') AND (NOT (CourseAlpha IS NULL)) AND (CourseNum <> '') AND (NOT (CourseNum IS NULL)) AND (proposer <> '') AND 
                      (NOT (proposer IS NULL)) AND (Progress = 'APPROVED') AND (NOT (coursedate IS NULL))
ORDER BY campus, CourseAlpha, CourseNum

/* PRE */
SELECT     TOP (100) PERCENT LTRIM(campus) + LTRIM(CourseAlpha) + LTRIM(CourseNum) AS kee, campus, CourseAlpha, CourseNum, coursetitle, proposer, coursedate, 
                      auditdate, historyid, CourseType, Progress
FROM         dbo.tblCourse
WHERE     (CourseType = 'PRE') AND (CourseAlpha <> '') AND (NOT (CourseAlpha IS NULL)) AND (CourseNum <> '') AND (NOT (CourseNum IS NULL)) AND (proposer <> '') AND 
                      (NOT (proposer IS NULL)) AND (Progress <> 'APPROVED') AND (NOT (auditdate IS NULL))
ORDER BY campus, CourseAlpha, CourseNum
