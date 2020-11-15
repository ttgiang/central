<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

		String campus = "LEE";
		String alpha = "ICS";
		String num = "241";
		String type = "PRE";
		int comp = 8;

		boolean hasData = false;
		String sql = "SELECT count(compid) FROM tblCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND compid=?";
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			preparedStatement.setInt(5, comp);
			ResultSet rs = preparedStatement.executeQuery();
			if (rs.next() && rs.getInt(1) > 0) {
				hasData = true;
			}
			rs.close();
			preparedStatement.close();
		} catch (Exception e) {
			hasData = false;
		}

		out.println(hasData);
%>