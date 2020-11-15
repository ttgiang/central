<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

		String userCampus = "LEECC";
		String selectedCampus = "LEECC";
		String alpha = "ICS";
		String num = "241";

		StringBuffer reviewers = new StringBuffer();
		StringBuffer temp = new StringBuffer();
		String junk = "";

		try {
			// default query is to get all users from a campus
			String sql = "SELECT userid FROM tblUsers WHERE campus=? ORDER BY userid";

			// get list of names are ready set as reviewers
			junk = courseDB.getCourseReviewers(conn,userCampus,alpha,num);

			// use the list of names and make sure we don't include in the
			// list of users from the selectedCampus
			if (junk != null && junk.length() > 0) {
				String[] s = new String[100];
				s = junk.split(",");
				temp.append("");
				for (int i = 0; i < s.length; i++) {
					if (temp.length() == 0)
						temp.append("\'" + s[i] + "\'");
					else
						temp.append(",\'" + s[i] + "\'");
				}

				// if temp is available, then make sure to exclude users from selectedCampus
				sql = "SELECT userid FROM tblUsers WHERE campus=? AND userid NOT IN (" + temp.toString() + ") ORDER BY userid";
			}

			reviewers.append("<table border=0><tr><td><select class=\'smalltext\' name=\'fromList\' size=\'10\' id=\'fromList\'>");
			junk = "";
			reviewers.append("");
out.println(sql +"<br>");
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, selectedCampus);
			ResultSet results = preparedStatement.executeQuery();
out.println("1<br>");
			while (results.next()) {
				junk = results.getString(1);
				reviewers.append("<option value=\"" + junk + "\">" + junk + "</option>");
			}
			reviewers.append("</select></td></tr></table>");

			junk = reviewers.toString();

			results.close();
			preparedStatement.close();
		} catch (Exception e) {
			out.println(e.toString());
		}

out.println(junk +"<br>");

%>