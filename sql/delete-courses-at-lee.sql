SELECT DISTINCT tblCourseARC.CourseAlpha, tblCourseARC.CourseNum, tblCourseARC.coursetitle, CONVERT(varchar, tblCourseARC.coursedate, 101) AS coursedate
FROM         tblCourseARC LEFT OUTER JOIN
                      tblCourse ON tblCourseARC.campus = tblCourse.campus AND tblCourseARC.CourseAlpha = tblCourse.CourseAlpha AND 
                      tblCourseARC.CourseNum = tblCourse.CourseNum
WHERE     (tblCourseARC.campus = 'LEE') AND (tblCourse.campus IS NULL) AND (NOT (tblCourseARC.CourseNum IS NULL))
ORDER BY tblCourseARC.CourseAlpha, tblCourseARC.CourseNum, tblCourseARC.coursetitle, coursedate