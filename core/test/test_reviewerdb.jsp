<%@ page import="org.apache.log4j.Logger"%>
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

	String campus = "MAU";
	String user = "THANHG";
	String alpha = "PSY";
	String num = "488";
	String kix = "o8l28i9166";
	String message = "";
	int question = 2;
	String source = "2";
	int acktion = Constant.REVIEW;
	String table = "2";
	int status = Constant.REVIEW;

	int totalSteps = 5;
	int steps = 0;

	out.println("Start<br/>");

	try{
		//out.println("<br/>--->step " + (++steps) + " of " + totalSteps + "<br/>");
		//out.println(getReviewHistory(conn,kix,alpha,num,table,question,campus,source,acktion));
		//out.println("<br/>--->step " + (++steps) + " of " + totalSteps + "<br/>");
		//out.println(ReviewerDB.countReviewerComments(conn,campus,alpha,num,question,acktion,1,acktion));
		//out.println("<br/>--->step " + (++steps) + " of " + totalSteps + "<br/>");
		//out.println(ReviewerDB.getAllReviewHistory(conn,kix,campus,acktion) + "<br/>");
		//out.println("<br/>--->step " + (++steps) + " of " + totalSteps + "<br/>");
		//out.println(ReviewerDB.getAllReviewHistory(conn,kix,campus,"tblReviewHist",acktion));
		//out.println("<br/>--->step " + (++steps) + " of " + totalSteps + "<br/>");
		//out.println(ReviewerDB.reviewerCommentsExists(conn,campus,kix,1,acktion));
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

