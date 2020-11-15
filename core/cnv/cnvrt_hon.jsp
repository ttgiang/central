<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.supercsv.cellprocessor.ConvertNullTo"%>
<%@ page import="org.supercsv.cellprocessor.ift.CellProcessor"%>
<%@ page import="org.supercsv.io.CsvMapWriter"%>
<%@ page import="org.supercsv.io.ICsvMapWriter"%>
<%@ page import="org.supercsv.prefs.CsvPreference"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HON";
	String user = "THANHG";

	System.out.println("Start<br/>");

	if (processPage){
		out.println(main(conn));
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static int main(Connection conn){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String sql = "SELECT seq FROM tblCourseHON";

		try {
			String kix = SQLUtil.createHistoryID(1);

			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int seq = rs.getInt("seq");
				String historyid = kix + seq;
				System.out.println(historyid + " - " + update(conn,seq,historyid));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	public static int update(Connection conn,int seq,String historyid){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String sql = "UPDATE tblCourseHON SET id=?,historyid=? WHERE seq=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,historyid);
			ps.setString(2,historyid);
			ps.setInt(3,seq);
			rowsAffected  = ps.executeUpdate();
			ps.close();
		} catch (Exception e) {
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

