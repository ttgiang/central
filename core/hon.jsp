<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

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
		<form method="post" action="testx.jsp" name="aseForm">
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

	String campus = "HON";
	String user = "THANHG";

	System.out.println("Start<br/>");

	if (processPage){

		try{
			// process deletes existing then inserts
			out.println(DocsDB.insertDocs(conn,campus) + " files processed" + Html.BR());
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