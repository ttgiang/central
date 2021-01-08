
delete from tblhelp where id >= (select min(id) from tblhelpidx where category = 'Announcement');

delete from tblhelpidx where category = 'Announcement';

--delete from tblhelpidx where id > 183;
--delete from tblhelp where id > 158;

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Additional alphas', 'usrprfl', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'additionalalphas.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Activity log', 'usrlog', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'activitylog.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Additional forms', 'crsfrmsidx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'additionalforms.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval blackout date', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalblackoutdate.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval blackout date', 'appridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalblackoutdate.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval email', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalemail.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval email', 'appridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalemail.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval by packets', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalroutingaspackets.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval by packets', 'appridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalroutingaspackets.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approve by date', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvebydate.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approve by date', 'appridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvebydate.pdf');

/* --------------------------- */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval instructions', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approverinstructions.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval instructions', 'appridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approverinstructions.pdf');

/* --------------------------- crsedt */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Compare outline items', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'compareitems.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Copy and paste', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'copy-n-paste.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course modifications', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'coursemodification.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Extra buttons', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'extrabuttons.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'General education', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'generaleducation.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Hide/show outline items', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'hideshowitems.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Link outline items', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'linkeditems.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval as packets', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapprovalaspackets.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval & review', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapprovalreview.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Compare outline', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinecompare.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Programs & Courses', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'programsandcourses.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Show GESLO linked to evaluations', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'showgeslolinktoevals.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Text/word counter', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'textwordcounter.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Enable outline items', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'enableoutlineitems.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Message page', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'messagepage.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Cross listing requires approval', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'requisitescrosslistingapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Requisites requires approval', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'requisitescrosslistingapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Requisites requires consent', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'requisitesconsent.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Reasons for modifications', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'ReasonsforModifications.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Contact hours', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'contacthoursdropdownlist.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Deparments', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'departmentdropdownlist.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Number of credits', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'numberofcredits.pdf');

/* --------------------------- crsrvwer */

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Hide/show outline items', 'crsrvwer', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'hideshowitems.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval as packets', 'crsrvwer', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapprovalreview.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Compare outline', 'crsrvwer', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinecompare.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Enable outline items', 'crsrvwer', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'enableoutlineitems.pdf');

/* --------------------------- crsappr */

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Hide/show outline items', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'hideshowitems.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval as packets', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapprovalaspackets.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval as packets', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlineapprovalreview.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Compare outline', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinecompare.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Quick comments', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'QuickComment.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Email approvals to approvers', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'emailnotificationtoapprovers.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Enable outline items', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'enableoutlineitems.pdf');

/* --------------------------- prgedt */

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Programs & Courses', 'prsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'programsandcourses.pdf');

/* --------------------------- prgedt */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Daily notification', 'usrprfl', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'dailynotification.pdf');

/* --------------------------- prgedt */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Create course', 'crscrt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'CreateCourse.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Create course', 'crscrt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinecreate.pdf');

/* --------------------------- vwoutline */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Display course title', 'vwoutline', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'DisplayCourseTitle.pdf');

/* --------------------------- vwoutline */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Email attachment', 'usrprfl', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'emailattachment.pdf');

/* --------------------------- crssts */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline approval status', 'crssts', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'fasttrackapproval.pdf');

/* --------------------------- crscpy */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Copy course outline', 'crscpy', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'copyoutlineitems.pdf');

/* --------------------------- crsrnm */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course rename/renumber', 'crsrnm', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'courserenamerenumber.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course rename/renumber', 'rnm', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'courserenamerenumber.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course rename/renumber', 'rnmcan', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'courserenamerenumber.pdf');

/* --------------------------- dfqst */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Header text', 'dfqst', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'headertext.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course/program item maintenance', 'dfqst', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'itemmaintenance.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Message page', 'dfqst', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'messagepage.pdf');

/* --------------------------- dstidx */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'System notification', 'dfqst', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'notification.pdf');

/* --------------------------- crsrvw */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Select reviewers', 'crsrvw', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'SelectCourseReviewers.pdf');

/* --------------------------- crsrvw */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Select reviewers', 'crsrvw', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'SelectCourseReviewers.pdf');

/* --------------------------- crsfld */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Raw edit', 'crsfld', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'rawedit.pdf');

/* --------------------------- ini */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Cross listing requires approval', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'requisitescrosslistingapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Requisites requires approval', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'requisitescrosslistingapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Requisites requires consent', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'requisitesconsent.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Reasons for modifications', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'ReasonsforModifications.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Send mail from CC TEST', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'sendmailfromtest.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Reasons for modifications', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'ReasonsforModifications.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Contact hours', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'contacthoursdropdownlist.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Deparments', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'departmentdropdownlist.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Number of credits', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'numberofcredits.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Show description', 'ini', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'showkeydescsription.pdf');

/* --------------------------- stmtidx */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course catalog', 'stmtidx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'coursecatalog.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Course catalog', 'crscat', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'coursecatalog.pdf');

/* --------------------------- val */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'PLO maintenance', 'val', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'pslomaintenance.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'System list report', 'val', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'systemlistreport.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'System list', 'val', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'systemlist.pdf');

/* --------------------------- emailidx */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Personal email list', 'emailidx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'personalemaillist.pdf');

/* --------------------------- usrtsks */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Task maintenance', 'usrtsks', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'taskmaintenance.pdf')

/* --------------------------- crsdltd */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline recall', 'crsdltd', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinerecall.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline recall', 'vwcrsx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinerecall.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline restore', 'crsdltd', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinerestore.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Outline restore', 'vwcrsx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinerestore.pdf');

/* --------------------------- lstmprt */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'List import', 'lstmprt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'import.pdf');

/* --------------------------- crsgen */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Quick entries', 'crsgen', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'quickpsloentry.pdf');

/* --------------------------- index */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Flex tables', 'index', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'flextable.pdf');

/* --------------------------- usrbrd */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Message board', 'usrbrd', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'messageboard.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Message board', 'msgbrd', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'messageboard.pdf');

/* --------------------------- tasks */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Task maintenance', 'tasks', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'taskmaintenance.pdf')

/* ---------------------------  */
/* approvals						  */
/* ---------------------------  */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval Routing', 'crsedt', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalrouting.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval Routing', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalrouting.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approval Routing', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'approvalrouting.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approver Requence', 'crsappr', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'resequenceapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approver Requence', 'appridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'resequenceapproval.pdf');

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Approver Requence', 'apprreseq', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'resequenceapproval.pdf');

/* ---------------------------  */
/* tasks								  */
/* ---------------------------  */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Task maintenance', 'usridx', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'taskmaintenance.pdf')

/* ---------------------------  */
/* shwfld								  */
/* ---------------------------  */
insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Enable requied items', 'shwfld', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinemodification.pdf')

insert into tblHelpidx (campus, category, title, subtitle, auditby, auditdate)
values ('SYS', 'Announcement', 'Enable grouped items', 'shwfld', 'SYSADM', getdate());
insert into tblhelp (id,content) values(@@IDENTITY,'outlinemodificationgrouped.pdf')

/* ---------------------------  */

session.setAttribute("aseThisPage","crsrvwer");
session.setAttribute("aseThisPage","crsappr");
session.setAttribute("aseThisPage","crsedt");
session.setAttribute("aseThisPage","usrprfl");
session.setAttribute("aseThisPage","crscrt");
session.setAttribute("aseThisPage","vwoutline");
session.setAttribute("aseThisPage","crssts");
session.setAttribute("aseThisPage","crscpy");
session.setAttribute("aseThisPage","dfqst");
session.setAttribute("aseThisPage","dstidx");
session.setAttribute("aseThisPage","crsrvw");
session.setAttribute("aseThisPage","crsfld");
session.setAttribute("aseThisPage","stmtidx");
session.setAttribute("aseThisPage","val");
session.setAttribute("aseThisPage","emailidx");
session.setAttribute("aseThisPage","usrtsks");
session.setAttribute("aseThisPage","crsdltd");
session.setAttribute("aseThisPage","vwcrsx");
session.setAttribute("aseThisPage","lstmprt");
session.setAttribute("aseThisPage","crsgen");
session.setAttribute("aseThisPage","tasks");
session.setAttribute("aseThisPage","index");
session.setAttribute("aseThisPage","usrbrd");
session.setAttribute("aseThisPage","msgbrd");
session.setAttribute("aseThisPage","crscat");
session.setAttribute("aseThisPage","rnmcan");
session.setAttribute("aseThisPage","rnm");
session.setAttribute("aseThisPage","usridx");
session.setAttribute("aseThisPage","shwfld");
