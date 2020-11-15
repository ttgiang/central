<%@ include file="../ase.jsp" %>

<%
	String pageTitle = "Convert User Table";
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%
	String sql = "SELECT id,email,lastname,firstname FROM tblUsers WHERE email <> '' ORDER BY id";
	String id = "";
	String email = "";
	String first = "";
	String last = "";
	String fullname = "";
	int pos = 0;
	try {
		PreparedStatement preparedStatement = conn.prepareStatement(sql);
		PreparedStatement ps;
		ResultSet resultSet = preparedStatement.executeQuery();
		ResultSet rs;
		while (resultSet.next()) {
			id = resultSet.getString(1).trim();
			email = resultSet.getString(2).trim();
			last = resultSet.getString(3).trim();
			first = resultSet.getString(4).trim();
			fullname = first + " " + last;
			pos = email.indexOf("@");
			if (pos > 0){
				email = email.substring(0,pos);
				out.println(id + " - " + email + "<br>");
				sql = "UPDATE tblUsers SET userid=?,fullname=? WHERE id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, email.toUpperCase());
				ps.setString(2, fullname);
				ps.setString(3, id);
				int rowsAffected = ps.executeUpdate();
				//out.println("UPDATE tblUsers SET userid=" + email + " WHERE id=" + id + "<br>");
			}
		}
		resultSet.close();
		preparedStatement.close();
	} catch (Exception e) {
		out.println(e.toString());
	}

%>

</body>
</html>