<%@ page import="javax.mail.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.naming.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Process Mail";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	//<meta http-equiv="refresh" content="300" >
	/**
	*	ASE
	*	sndmlx.jsp
	*	2007.09.01	manually process mail file
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?

	boolean processPage = true;
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String chkTestRun = website.getRequestParameter(request,"chkTestRun","0");
	String user = website.getRequestParameter(request,"aseUserName","",true);

	boolean testRun = false;

	String[] rtn = new String[2];

	if (processPage && Skew.confirmEncodedValue(request)){
		if (formName != null && formName.equals("aseForm")){
			if (chkTestRun.equals(Constant.ON)){
				testRun = true;
			}
			else{
				testRun = false;
			}

			rtn = MailerDB.sendMailOnce(conn,session,testRun);

			out.println("Daily notification sent: " + rtn[0] + Html.BR() + Html.BR());
			out.println(rtn[1] + Html.BR());
		}
		else{
			out.println("Invalid Form Request: " + formAction + " - " + formName);
		}
	}
	else{
		out.println("Invalid kapcha or processing of this page is not allowed.");
	}

	asePool.freeConnection(conn,"sndmlx",user);
%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

