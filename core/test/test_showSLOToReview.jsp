<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crttpl.jsp
	*	2007.09.01
	**/

	//javax.servlet.jsp.JspWriter out,

	String alpha = "ICS";
	String num = "241";
	String type = "CUR";

	out.println(showSLOToReview(conn,out,"LEE","THANHG","test"));

	asePool.freeConnection(conn);
%>

<%!
	public static String showSLOToReview(Connection conn,
		javax.servlet.jsp.JspWriter out,
		String campus,String reviewer,String caller){

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			boolean isReviewer = DistributionDB.hasMember(conn,campus,"SLOReviewer",reviewer);
			if (isReviewer){
				AseUtil aseUtil = new AseUtil();

				String sql = "SELECT tc.id, tc.CourseAlpha, tc.CourseNum, tc.coursetitle " +
					"FROM tblCourse tc INNER JOIN tblSLO ts ON (tc.campus = ts.campus) AND " +
					"(tc.CourseType = ts.CourseType AND " +
					"tc.CourseNum = ts.CourseNum AND " +
					"tc.CourseAlpha = ts.CourseAlpha) " +
					"WHERE tc.campus=? AND " +
					"tc.Progress='MODIFY' AND " +
					"ts.Progress='REVIEW' " +
					"ORDER BY tc.coursealpha,tc.coursenum";

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
					num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
					title = aseUtil.nullToBlank(rs.getString("coursetitle")).trim();
					kix = aseUtil.nullToBlank(rs.getString("id")).trim();
					link = caller + ".jsp?kix=" + kix;
					listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
					found = true;
				}
				rs.close();
				ps.close();
			}
		}
		catch(Exception ex){
			//logger.fatal("Helper: showSLOToReview\n" + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}
%>