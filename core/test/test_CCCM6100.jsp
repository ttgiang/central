<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	qslo.jsp	- quick SLO entry
	*	2007.09.01	course edit
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "100";
	String kix = "n1b2g9187";
	String message = "";
	int i = 0;

	out.println("Start<br/>");

	try{
		//out.println(CCCM6100DB.getQuestionTypeColumnValue(conn,"X43"));
		//out.println(CCCM6100DB.getExplainColumnValue(conn,"X43"));
		//out.println(CCCM6100DB.getCCCMQuestionNumber(conn,campus,"Campus","X43"));
		//out.println(CCCM6100DB.getCCCM6100s(conn));
		//out.println(CCCM6100DB.getCCCM6100ByIDCampusCourse(conn,1,campus,"X43"));
		//out.println(CCCM6100DB.getCCCM6100ByID(conn,1));
		//out.println(CCCM6100DB.getCCCM6100(conn,1,campus,1));
		//out.println(CCCM6100DB.getCCCM6100ByFriendlyName(conn,"X43"));

	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

