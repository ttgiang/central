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
	String text = "//Utilize operating system interfaces to manage computer resources effectively.//Utilize online resources for research and communication.//Define, explain, and demonstrate proper computer terminology usage in areas such as hardware, software, and communications.//Describe ethical issues involved in the use of computer technology.";
	String[] arr;
	String message = "";
	int i = 0;

	out.println("Start<br/>");

	try{
		arr = text.split("//");
		i = arr.length;
		out.println("arr.length: " + i + "<br/>");
		for(int j=1;j<i;j++){
			//msg = CompDB.addRemoveCourseComp(conn,"a",campus,alpha,num,arr[j],0,user,kix);
			if (!"Exception".equals(msg.getMsg()))
				message = "Operation completed successfully";
			else
				message = "Unable to complete requested operation";
			out.println("arr: " + arr[j] + " " + message + "<br/>");
		}
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

