<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassr.jsp
	*	2007.09.01	Assess and outline
	**/

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String caller = "crsassr";
	String pageTitle = "Edit Course Level SLO";
	fieldsetTitle = pageTitle;

	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = (String)session.getAttribute("aseAlpha");
	String num = (String)session.getAttribute("aseNum");
	String type = (String)session.getAttribute("aseType");

	String kix = website.getRequestParameter(request,"kix");

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	if (type==null)
		type="PRE";

	if ((alpha==null || alpha.length()==0) && (num==null || num.length()==0)){
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = website.getRequestParameter(request,"type");
	}

	// action is to add or remove (a or r)
	String action = website.getRequestParameter(request,"act", "");
	String sh = website.getRequestParameter(request,"sh", "0");
	// if all the values are in place, add or remove
	if (processPage && action.length() > 0 ){
		String comp = website.getRequestParameter(request,"comp", "");
		int compID = website.getRequestParameter(request,"compID", 0);

		if (action.equals("a") || action.equals("r")){
			msg = CompDB.addRemoveCourseComp(conn,action,campus,alpha,num,comp,compID,user,kix);
			if (!"Exception".equals(msg.getMsg()))
				message = "Operation completed successfully";
			else
				message = "Unable to complete requested operation";
		}
	}

	asePool.freeConnection(conn,"crsassr",user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/crscmp.jsp?kix=<%=kix%>" class="linkcolumn">return to Course Level SLO screen</a>&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;

<%
	caller = aseUtil.getSessionValue(session,"aseCallingPage");

	if(caller.equals("crsfldy")){
%>
		<a href="crsfldy.jsp?cps=<%=campus%>&kix=<%=kix%>" class="linkcolumn">return to raw edit</a>
<%
	}
	else {
%>
		<a href="/central/core/crsedt.jsp?ts=<%=currentTab%>&no=<%=currentNo%>&kix=<%=kix%>" class="linkcolumn">return to outline modification</a>
<%
	} // where to return caller
%>

<!--
&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;<a href="/central/core/vwcrsslo.jsp?kix=<%=kix%>&alpha=<%=alpha%>&num=<%=num%>&cps=<%=campus%>&t=<%=type%>" class="linkcolumn">View Outline SLO</a>
-->
</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
