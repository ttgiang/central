insert into tblusers(campus, userid, password, uh, firstname, lastname, fullname, status, userlevel, department, division, email, title, salutation, location, hours, phone, position, auditby, auditdate, 
alphas, sendnow, attachment, website, weburl, college)
SELECT 'MAN', Userid, 'c0mp1ex', 1, upper(firstname), upper(lastname), upper(firstname + ' ' + lastname), 'Active', userlevel, department, division, email, title, salutation, location, hours, phone, position, 'THANHG', getdate(),
alphas, 1, 0, '', '', college
FROM         Users$
WHERE userid not in ('AES','CLEM','MAUREENS')

