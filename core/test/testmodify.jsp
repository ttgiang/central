<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

<%@ page import="com.ase.aseutil.html.HtmlSanitizer"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HIL";
	String alpha = "ENG";
	String num = "100";
	String type = "PRE";
	String user = "SIMMONS";
	String task = "Modify_outline";
	String kix = "u53c30k11233";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		campus = "KAP";

		out.println(modifyTest(conn,campus));

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	//
	// MODIFICATION TESTING
	//

	public static int modifyTest(Connection conn,String campus) throws Exception {

		// this routine places data into a temp table for a campus
		// then runs through the approval process.if the route exists, it uses it.
		// if not, it will use a default.

		int processed = 0;

		try{
			String sql = "";
			PreparedStatement ps = null;

			// clear before starting
			try{
				sql = "delete from zzzcourses";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();
			}
			catch(Exception e){
				//
			}

			// put data in for testing
			sql = "insert into zzzcourses "
				+ "select campus,historyid,CourseAlpha,CourseNum,proposer,auditdate,route "
				+ "from tblcourse  "
				+ "WHERE campus=? "
				+ "AND coursetype='PRE' "
				+ "AND progress='MODIFY'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.executeUpdate();
			ps.close();

			int i = 0;

			String[] questions = QuestionDB.getCampusColumms(conn,campus).split(",");

			// for each outline found, do the following
			// run through all questions and update where column starts with "X"

			com.ase.aseutil.CourseDB courseDB = new com.ase.aseutil.CourseDB();

			sql = "select historyid, coursealpha,coursenum,proposer,route from zzzcourses order by coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				++processed;

			} // while
			rs.close();
			ps.close();

			courseDB = null;

		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return processed;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>