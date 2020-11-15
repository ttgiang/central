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

	String campus = "KAP";
	String alpha = "ENG";
	String num = "100";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "87l14c11241";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){
		out.println(fixNullNumbers(conn));
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String fixNullNumbers(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		int read = 0;
		int written = 0;

		try{
				String sql = "SELECT * FROM WIN_UHMC_CORRECTED";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					String campus = AseUtil.nullToBlank(rs.getString("campus"));
					String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
					String coursealpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("num"));
					String title = AseUtil.nullToBlank(rs.getString("title"));
					if (!title.equals(Constant.BLANK)){
						System.out.println(campus + " - " + coursealpha + " - " + title);
						sql = "UPDATE tblCourse SET coursenum=? "
								+ "WHERE campus=? "
								+ "AND historyid=? "
								+ "AND coursealpha=? "
								+ "AND coursetitle=? "
								+ "AND coursenum is null";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2 = conn.prepareStatement(sql);
						ps2.setString(1,num);
						ps2.setString(2,campus);
						ps2.setString(3,historyid);
						ps2.setString(4,coursealpha);
						ps2.setString(5,title);
						written += ps2.executeUpdate();
						ps2.close();
					}
					++read;
				} // while
				rs.close();
				ps.close();
		}
		catch(SQLException e){
			logger.fatal("fixNullNumbers: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("fixNullNumbers: " + e.toString());
		}

		return "Read: " + read + "; Written: " + written;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>