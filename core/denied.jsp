<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../inc/db.jsp" %>

<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="helper" scope="application" class="com.ase.aseutil.Helper" />
<jsp:useBean id="log" scope="application" class="com.ase.aseutil.ASELogger" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />
<jsp:useBean id="outlines" scope="application" class="com.ase.aseutil.Outlines" />
<jsp:useBean id="paging" scope="application" class="com.ase.paging.Paging" />
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />

<%
	/**
	*	ASE
	*	denied.jsp
	*	2007.09.01
	**/

	String fieldsetTitle = "";
	String chromeWidth = "50%";
	String pageTitle = "Access Denied";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String support = "";

	// if user didn't get past the login screen, campus and user would be empty
	if (campus == null || campus.length() == 0){
		support = DistributionDB.getAllDistributionMembers(conn,"support");
	}
	else{
		support = DistributionDB.getDistributionMembers(conn,campus,"support");
	}

	if (support != null && support.length() > 0){
		support = support + ",";
		support = support.toLowerCase().replace(",","<br>");
	}
%>

<html>
<HEAD>
	<jsp:include page="../exp/includefiles.jsp" />
	<title>Not Authorized</title>
</HEAD>
<body topmargin="0" leftmargin="0" background="../core/images/stripes.png">
	<br/>
	<br/>
	<table border=0 cellspacing=0 cellpadding=0>
	<tr><td>&nbsp;&nbsp;&nbsp;</td><td><h2>Access Error</h2></td></tr>
	<tr><td>&nbsp;&nbsp;&nbsp;</td>
		<td>
			<p>You are not authorized to access Curriculum Central, or your account may have been deactivated due to prolonged periods of inactivity.</p>
			<p>Please contact your Curriculum Central campus administrator(s) for assistance.</p>
			<p>
			<%=support%>
			</p>
		</td>
	</tr>
	</table>

<%
	asePool.freeConnection(conn,"denied",user);
	request.getSession().invalidate();
%>

</BODY>
</html>