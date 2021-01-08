SELECT     campus, historyid, type, seq, progress, degreeid, divisionid, effectivedate, title, descr, outcomes, functions, organized, enroll, resources, efficient, effectiveness, 
                      proposed, rationale, substantive, articulated, additionalstaff, requiredhours, auditby, auditdate, hid, proposer, votefor, voteagainst, voteabstain, reviewdate, 
                      comments, datedeleted, dateapproved, regents, regentsdate, route, subprogress, edit, edit0, edit1, edit2, reason, p14, p15, p16, p17, p18, p19, p20
FROM         tblPrograms
WHERE     (campus = 'LEE') AND (title LIKE '%Acc%') AND (degreeid = 4) AND (divisionid = 2)

SELECT     id, campus, submittedfor, submittedby, coursealpha, coursenum, coursetype, progress, message, dte, inviter, role, category, historyid
FROM         tblTasks
WHERE     (historyid = 'v49c7d12234')