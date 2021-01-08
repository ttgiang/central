/* need to add all campuses */

insert into tblProps(campus, propname, propdescr, subject, [content], cc, auditby, auditdate)
values ('MAN','emailRenameRenumberApprovers','Email rename/renumber requests to approvers',
'Rename/Renumber Course Outline','Please approve rename/renumber for outline [ALPHA] [NUM].','','SYSADM',getdate())

insert into tblProps(campus, propname, propdescr, subject, [content], cc, auditby, auditdate)
values ('MAN','emailRenameRenumberAuthority','Email rename/renumber request to authority',
'Rename/Renumber Course Outline','Please approve rename/renumber for outline [ALPHA] [NUM].','','SYSADM',getdate())

insert into tblProps(campus, propname, propdescr, subject, [content], cc, auditby, auditdate)
values ('MAN','emailRenameRenumberApproved','Notify requestor rename/renumber has been approved',
'Rename/Renumber Course Outline','Course outline rename/renumber has been approved ([ALPHA] [NUM]).','','SYSADM',getdate())

insert into tblProps(campus, propname, propdescr, subject, [content], cc, auditby, auditdate)
values ('MAN','emailRenameRenumberDenied','Notify requestor rename/renumber was denied',
'Rename/Renumber Course Outline','Course outline rename/renumber was denied ([ALPHA] [NUM]).','','SYSADM',getdate())

insert into tblProps(campus, propname, propdescr, subject, [content], cc, auditby, auditdate)
values ('MAN','emailCancelRenameRenumber','Cancels rename/renumber request',
'Rename/Renumber Cancelled','Course outline rename/renumber was cancelled ([ALPHA] [NUM]).','','SYSADM',getdate())

insert into tblProps(campus, propname, propdescr, subject, [content], cc, auditby, auditdate)
values ('MAN','emailFndReviewCompleted','Foundation Course Review Completed ([ALPHA] [NUM])',
'Foundation course review has been completed ([ALPHA] [NUM]).','','SYSADM',getdate())

