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

	out.println(showOutlinesNeedingReview(conn,out,campus,user,"REVIEW"));

	asePool.freeConnection(conn);
%>

<%!
	public static String showOutlinesNeedingReview(Connection conn,javax.servlet.jsp.JspWriter out,String campus,String user,String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT id,CourseAlpha,CourseNum,coursetitle " +
				"FROM tblCourse " +
				"WHERE campus=? AND  " +
				"coursetype='PRE' AND  " +
				"Progress='MODIFY' AND  " +
				"proposer=? " +
				"ORDER BY coursealpha,coursenum";
out.println(sql);
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
				num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
				if (!SLODB.sloProgress(conn,campus,alpha,num,"PRE","REVIEW")){
					title = aseUtil.nullToBlank(rs.getString("coursetitle")).trim();
					kix = aseUtil.nullToBlank(rs.getString("id")).trim();
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			//logger.fatal("Helper: showOutlinesNeedingReview\n" + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline not found";
	}
%>

</body>
</html>
