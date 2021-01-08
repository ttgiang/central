/* CHNS */
update tblapprovalhist set  approver_seq=1 WHERE historyid = 'V42k8f11194' and approver='KOMENAKA';
update tblapprovalhist set  approver_seq=2 WHERE historyid = 'V42k8f11194' and approver='YF83';

/* HIST 352 */
update tblapprovalhist set  approver_seq=1 WHERE historyid = 'M51k10f11182' and approver='KOMENAKA';
update tblapprovalhist set  approver_seq=2 WHERE historyid = 'M51k10f11182' and approver='BITTER';

/* KES 340 */
delete from tblapprovalhist WHERE historyid = '623d13b11233' and approver='MATULL' and approver_seq=2;

select max(seq) from tblapprovalhist;
insert into tblapprovalhist(historyid, campus, coursealpha, coursenum, seq, dte, approver, approved, comments, approver_seq, votesfor, votesagainst, votesabstain, inviter, role, progress)
values('623d13b11233', 'HIL', 'KES', '340', 16077, getdate(), 'KOMENAKA', 1, '', 2, 0, 0, 0, 'GOTSHALK', 'APPROVER', 'APPROVED');

update tblapprovalhist set  approver_seq=2 WHERE historyid = '623d13b11233' and approver='TAKAHASH';
update tblapprovalhist set  approver_seq=1 WHERE historyid = '623d13b11233' and approver='KOMENAKA';


/* KES 350 */
delete from tblapprovalhist WHERE historyid = 'o49b15b11178' and approver='MATULL' and approver_seq=2;
update tblapprovalhist set  approver_seq=1 WHERE historyid = 'o49b15b11178' and approver='TAKAHASH';

insert into tblapprovalhist(historyid, campus, coursealpha, coursenum, seq, dte, approver, approved, comments, approver_seq, votesfor, votesagainst, votesabstain, inviter, role, progress)
values('o49b15b11178', 'HIL', 'KES', '340', seq, dte, approver, approved, comments, approver_seq, votesfor, votesagainst, votesabstain, inviter, role, progress);
