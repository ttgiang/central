<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Course Question Listing";
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%
	String user = "THANHG";
	String campus = "KAP";
	String alpha = "ICS";
	String num = "241";
	String type = "PRE";
	String jsid = "E7EDF1A293200B397074B1EE18D9CA9D";

		boolean courseType = false;

		try {
			String sql = "SELECT coursetype FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ResultSet results = ps.executeQuery();
			courseType = results.next();
			results.close();
			ps.close();
		} catch (SQLException e) {
			out.println("CourseDB: courseExistByTypeCampus\n" + e.toString());
		}

		out.println(courseType);
%>

</body>
</html>