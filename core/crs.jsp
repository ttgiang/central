<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crs.jsp
	*	2007.09.01
	**/


	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Course";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	asePool.freeConnection(conn,"crs",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<table align="center" width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">
		<tr>
			<td valign="top">
			</td>
			<td valign="top">
				<h3 class="subheader">Maintenance</h3>
				<ul>
			<%
					// screen has configurable item. setting determines whether
					// users are sent directly to news or task screen after login
					session.setAttribute("aseConfig","1");
					session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

					String deleteOutline = (String)session.getAttribute("aseMenuCourseDelete");
					if (deleteOutline == null || deleteOutline.length() == 0)
						deleteOutline = "0";
			%>
					<li><a href="dspcmnts.jsp" class="linkcolumn">Display Comments</a></li>
					<li><a href="vwoutline.jsp" class="linkcolumn">Display Outline</a></li>

				</ul>
			</td>
			<td valign="top">
				<h3 class="subheader">Review</h3>
				<ul>
					<li><a href="crsrvwsts.jsp" class="linkcolumn">Outline Review Status</a></li>
				</ul>
			</td>
		</tr>

</table>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
