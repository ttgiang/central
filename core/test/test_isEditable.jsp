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
	String jsid = "E7EDF1A293200B397074B1EE18D9CA9D";

		boolean editable = false;
		String proposer = "";
		String progress = "";

		try {
			String sql = "SELECT edit, proposer, progress FROM tblCourse WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				editable = results.getBoolean(1);
				proposer = results.getString(2);
				progress = results.getString(3);
			}
			results.close();

out.println("1<br>");
out.println("editable: " + editable + "<br>");
out.println("proposer: " + proposer + "<br>");
out.println("progress: " + progress + "<br>");

			if (editable && user.equals(proposer) && "MODIFY".equals(progress))
				editable = true;
			else
				editable = false;

out.println("2<br>");

out.println("editable: " + editable + "<br>");

out.println("jsid: " + jsid + "<br>");

			if (editable && !"".equals(jsid)) {
out.println("3<br>");
				sql = "UPDATE tblCourse SET jsid=? WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype='PRE' ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, jsid);
				ps.setString(2, campus);
				ps.setString(3, alpha);
				ps.setString(4, num);
				int rowsAffected = ps.executeUpdate();
			}

			ps.close();

		} catch (SQLException e) {
			out.println("CourseDB: isEditable\n" + e.toString());
		} catch (Exception ex) {
			out.println("CourseDB: isEditable\n" + ex.toString());
		}

		out.println(editable);
%>

</body>
</html>