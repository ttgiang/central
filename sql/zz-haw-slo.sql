SELECT     hawlo.CrsAlpha, hawlo.CrsNo, hawlo.SLO, tblCourseComp.Campus
FROM         hawlo INNER JOIN
                      tblCourseComp ON hawlo.CrsAlpha = tblCourseComp.CourseAlpha AND hawlo.CrsNo = tblCourseComp.CourseNum
WHERE     (tblCourseComp.Campus = 'HAW')

