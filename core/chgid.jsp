<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

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

	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campus = website.getRequestParameter(request,"cps","");
	String fid = website.getRequestParameter(request,"fid","");
	String tid = website.getRequestParameter(request,"tid","");

	out.println("Start<br/><br/>This page renames user ID.<br><br>");

	if (processPage){

		try{
			if(campus != "" && fid != "" && tid != ""){
				out.println(UserDB.changeUserId(conn,campus,fid,tid) + "<br>");
			}
			else{
				out.println("Invalid rename request. Provide cps, fid, and tid to process page.");
			}

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	out.println("<br><br>return to <a href=\"ccutil.jsp\" class=\"linkcolumn\">CC</a>");

	out.println("<br><br/>End");

	asePool.freeConnection(conn,"chgid",user);
%>

</form>
		</td>
	</tr>
</table>

</body>
</html
