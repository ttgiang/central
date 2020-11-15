<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvwstsp.jsp - program reviewers
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Program Reviewers";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String helpButton = website.getRequestParameter(request,"help");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		route = NumericUtil.nullToZero(info[6]);
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}

%>
<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
	<tr><td align="center" class="textblackthcenter">
		<%
			out.println(pageTitle + "<br>");
			out.println(courseDB.setPageTitle(conn,"",alpha,num,campus));
		%>
	</td></tr>
</table>
<p>
NOTE: The following reviewers have not finished reviewing <%=alpha%>&nbsp;<%=num%>.
<p/>

<%
	String reviewers = ReviewerDB.getReviewerNames(conn,campus,kix);
	if (reviewers != null && reviewers.length() > 0){
		reviewers = reviewers.replace(",","<br/>");
		out.println("<font class=\"datacolumn\">" + reviewers + "</font>");
	}

	asePool.freeConnection(conn);

	if (helpButton.equals("1")){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>

</body>
</html>