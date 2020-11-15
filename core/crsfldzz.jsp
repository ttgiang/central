<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*
	*	crsfldzz.jsp	- regenerate outline
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String thisPage = "crsfldzz";

	session.setAttribute("aseCallingPage","crsfldy");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "90%";
	String pageTitle = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	}
	else{
		processPage = false;
	}

	fieldsetTitle = "Re-generate Course Outline";

	asePool.freeConnection(conn,thisPage,user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>
		<p>
		<br/>
		Course outline re-generated successfully.
		<br/>
		<br/>
		 Click <a href="/centraldocs/docs/outlines/<%=campus%>/<%=kix%>.html" class="linkcolumn" target="_blank">here</a>
		to view course outline or <a href="crsfldy.jsp?kix=<%=kix%>" class="linkcolumn">here</a> to return to raw edit.
		<br/>
		</p>
<%
	}
	else{
%>
		Error occured while processing outline.
<%
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
