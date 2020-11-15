<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	//javax.servlet.jsp.JspWriter out,

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%

	String alpha = "ICS";
	String num = "241";
	String campus = "LEE";
	String user = "THANHG";
	String type = "PRE";
	String message = "";

	out.println(showOutlinesByUserReview(conn,out,campus,user));
	asePool.freeConnection(conn);
%>

<%!
	public static String showOutlinesByUserReview(Connection conn,
	javax.servlet.jsp.JspWriter out,
	String campus,String user){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			boolean isReviewer = DistributionDB.hasMember(conn,campus,"SLOReviewer",user);
			if (isReviewer){
				AseUtil aseUtil = new AseUtil();

				String sql = "SELECT tc.id, tc.CourseAlpha, tc.CourseNum, tc.coursetitle " +
					"FROM tblCourse tc INNER JOIN tblSLO ts ON (tc.campus = ts.campus) AND  " +
					"(tc.CourseType = ts.CourseType AND  " +
					"tc.CourseNum = ts.CourseNum AND  " +
					"tc.CourseAlpha = ts.CourseAlpha) " +
					"WHERE tc.campus=? AND  " +
					"tc.Progress='MODIFY' AND  " +
					"tc.proposer=? " +
					"ORDER BY tc.coursealpha,tc.coursenum";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
					title = aseUtil.nullToBlank(rs.getString("coursetitle")).trim();
					kix = aseUtil.nullToBlank(rs.getString("id")).trim();
					link = "crsrwslo.jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
				rs.close();
				ps.close();

				if (found)
					listing.append("<ul>" + listing.toString() + "</ul>");
				else
					listing.append("Outline not found");
			}
		}
		catch(Exception ex){
			//logger.fatal("Helper: showOutlinesByUserReview\n" + ex.toString());
			listing.setLength(0);
		}

		return listing.toString();
	}
%>

</body>
</html>
