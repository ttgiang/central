SELECT     tblCourse.CourseAlpha, tblCourse.CourseNum, tblCourse.dispID, tblCourse.Division, tblCourse.coursetitle, tblCourse.credits, tblCourse.effectiveterm, 
                      tblCourse.coursedescr, tblCourse.X15 AS prereq, tblCourse.X16 AS coreq, tblCourse.X17 AS recprep
FROM         tblCourse INNER JOIN
                      BANNER ON tblCourse.CourseNum = BANNER.CRSE_NUMBER AND tblCourse.CourseAlpha = BANNER.CRSE_ALPHA AND 
                      tblCourse.campus = BANNER.INSTITUTION
WHERE     (tblCourse.campus = 'KAP')
ORDER BY tblCourse.CourseAlpha, tblCourse.CourseNum