<%@ page import="java.util.*, java.io.*" %>

<%@ include file="ase.jsp" %>

<%
	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String type = "ARC";
	int tableToUse = 1;

		StringBuilder requisites = new StringBuilder();
		String fields = "";
		String table = "";
		String temp = "";

		try
		{
			if ("ARC".equals(type)){
				if (tableToUse==1) {
					fields = "PrereqAlpha,PrereqNum";
					table = "tblARCPreReq";
				}
				else{
					fields = "CoreqAlpha,CoreqNum";
					table = "tblARCCoReq";
				}
			}
			else{
				if (tableToUse==1) {
					fields = "PrereqAlpha,PrereqNum";
					table = "tblPreReq";
				}
				else{
					fields = "CoreqAlpha,CoreqNum";
					table = "tblCoReq";
				}
			}

			String sql = "SELECT " + fields + ",grading FROM " + table +
				" WHERE campus=? AND courseAlpha=? AND coursenum=? AND coursetype=?";
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setString(2, alpha);
			preparedStatement.setString(3, num);
			preparedStatement.setString(4, type);
			ResultSet results = preparedStatement.executeQuery();
out.println(sql+"<br>");
			while ( results.next() ) {
				alpha = results.getString(1);
				num = results.getString(2);
				requisites.append(alpha + " " + num + " - " +
							courseDB.getCourseDescription(conn,alpha,num,campus) +
							" (" + results.getString(3) + ")<br>");
			}
out.println(sql+"<br>");
			results.close();
			preparedStatement.close();
			temp = requisites.toString();
		}
		catch (SQLException e){
			out.println("CourseDB: getRequisites\n" + e.toString());
		}
		catch (Exception ex){
			out.println("CourseDB: getRequisites\n" + ex.toString());
		}

		out.println(temp);
%>