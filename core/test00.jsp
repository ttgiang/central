<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>

<%@ page import="com.ase.aseutil.AseUtil"%>


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
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "WOA";
	String alpha = "COM";
	String num = "197F";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "R9a31d12188";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{

			String items = CampusDB.getCourseItems(conn,campus);
			String[] aItems = items.split(",");
			for(int i = 0; i < aItems.length; i++){
				if (aItems[i].indexOf("X")==0){
					String data = CourseDB.getCourseItem(conn,kix,aItems[i]);
					data = (i+1) + ": " + data + aseUtil.getCurrentDateTimeString() + "<br>";
					CourseDB.setCourseItem(conn,kix,aItems[i],data,"s");

					String explain = CCCM6100DB.getExplainColumnValue(conn,aItems[i]);
					if (explain != null && explain.length() > 0){
						CourseDB.setCampusItem(conn,kix,explain,data,"s");
					}
				}
			}

			int maxNo = CourseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);

			items = CampusDB.getCampusItems(conn,campus);
			aItems = items.split(",");
			for(int i = 0; i < aItems.length; i++){
				String data = (i+1+maxNo) + ": " + aseUtil.getCurrentDateTimeString() + "<br>";
				CourseDB.setCampusItem(conn,kix,aItems[i],data,"s");
			}

		}
		catch (Exception e){
			System.err.println ("Error in writing to file");
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html