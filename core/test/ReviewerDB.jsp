<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>


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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "MAN";
	String alpha = "VIET";
	String num = "456";
	String type = "ARC";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "a33k22j12188";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{
			out.println("getCourseReviewers" + Html.BR());
			out.println("1. " + ReviewerDB.getCourseReviewers(conn,campus,alpha,num) + Html.BR());
			out.println("2. " + ReviewerDB.getCourseReviewers(conn,campus,alpha,num,user,2) + Html.BR());
			out.println("3. " + ReviewerDB.getCourseReviewers(conn,campus,kix) + Html.BR());
			out.println("4. " + ReviewerDB.getCourseReviewers(conn,campus,kix,user,2) + Html.BR());

			out.println(Html.BR() + "getReviewerNames" + Html.BR());
			out.println("1. " + ReviewerDB.getReviewerNames(conn,campus,alpha,num) + Html.BR());
			out.println("2. " + ReviewerDB.getReviewerNames(conn,campus,kix) + Html.BR());
			out.println("3. " + ReviewerDB.getReviewerNames(conn,kix) + Html.BR());
			out.println("4. " + ReviewerDB.getReviewerNames(conn,campus,alpha,num,user,99) + Html.BR());
			out.println("5. " + ReviewerDB.getReviewerNames(conn,campus,kix,user,99) + Html.BR());
			out.println("6. " + ReviewerDB.getReviewerNames(conn,kix,user,3) + Html.BR());

			out.println(Html.BR() + "hasReviewer" + Html.BR());
			out.println("1. " + ReviewerDB.hasReviewer(conn,campus,alpha,num) + Html.BR());
			out.println("2a. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,user,1) + Html.BR());
			out.println("2b. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,user,2) + Html.BR());
			out.println("2c. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,user,3) + Html.BR());
			out.println("2d. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,user,4) + Html.BR());
			out.println("3. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE") + Html.BR());
			out.println("4a. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,1) + Html.BR());
			out.println("4b. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,2) + Html.BR());
			out.println("4c. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,3) + Html.BR());
			out.println("4d. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,4) + Html.BR());
			out.println("5. " + ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user) + Html.BR());
			out.println("6a. " + ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user,1) + Html.BR());
			out.println("6b. " + ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user,2) + Html.BR());
			out.println("6c. " + ReviewerDB.removeReviewers(conn,campus,kix,alpha,num,user,3) + Html.BR());
			out.println("7. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE") + Html.BR());
			out.println("8a. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,1) + Html.BR());
			out.println("8b. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,2) + Html.BR());
			out.println("8c. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,3) + Html.BR());
			out.println("8d. " + ReviewerDB.hasReviewer(conn,campus,alpha,num,"PRE",user,4) + Html.BR());

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"ReviewerDB",user);
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html
