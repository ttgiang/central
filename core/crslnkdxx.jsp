<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnkdxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String type = "PRE";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	boolean validCaller = false;
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy")){
		validCaller = true;
	}

	// GUI
	String chromeWidth = "90%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Link Outline Items";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crslnkr.js"></script>
	<%@ include file="stickytooltip.jsp" %>
	<%@ include file="highslide.jsp" %>
	<%@ include file="bigbox.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && validCaller){
		if (LinkedUtil.getLinkedItemCount(conn,campus) > 0){
			out.println(LinkedUtil.getLinkedMaxtrixContent(request,conn,kix,user,false,true));
		}
		else
			out.println("<br/><p align=\"center\">Linked item not yet defined for your campus.<br/><br/>Click <a href=\"crslnkdz.jsp\" class=\"linkcolumn\">here</a> to define linked items.</p>");
	}

	asePool.freeConnection(conn,"crslnkdxx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

