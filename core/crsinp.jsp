<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*
	*	crsinp.jsp - input form
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	boolean debug = false;
	boolean required = false;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "ENG";
	String num = "100";
	String type = "CUR";

	if(campus.equals("MAN")){
		alpha = "NURS";
		num = "210";
		type = "CUR";
	}

	String kix = helper.getKix(conn,campus,alpha,num,type);

	// GUI
	String chromeWidth = "80%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Course Outline Form";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<form name="aseForm" method="post">
<table width="100%" border="0">

<h3 class="subheader">This page displays your campus outline form in its entirety.</h3>

<%
	if (processPage && !kix.equals(Constant.BLANK)){
		out.println(AseUtil2.showForm(conn,campus));
	}

	asePool.freeConnection(conn,"crsinp",user);
%>

</table>
</form>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

