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
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAP";
	String user = "JWAKABAY";
	String[] users = "THANHG,SPOPE,JWAKABAY,HARRYD,PAGOTTO,LR24".split(",");
	String alpha = "ICS";
	String num = "100";
	String task = "Modify_outline";
	String kix = "e13b7h9187";

	kix = helper.getKix(conn,campus,alpha,num,"PRE");

	int t = 0;
	boolean approval = true;
	String comments = "";

	out.println("Start<br/>");

	int nStart = 0;
	int nEnd = users.length;

	try{
		for (t=nStart;t<nEnd;t++){
			user = users[t];
			//comments = user + " - " + aseUtil.getCurrentDateTimeString();
			//out.println(CourseApproval.approveOutlineX(conn,campus,alpha,num,user,approval,comments,t,t*t+1,t*t+2));
			//out.println(msg.getUserLog());
		}

		//out.println(isNextApprover(conn,campus,alpha,num,user));

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

