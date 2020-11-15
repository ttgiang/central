<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgvw.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "80%";
	String pageTitle = "View Program";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");

	String type = website.getRequestParameter(request,"type", "");
	int cln = website.getRequestParameter(request,"cln", 0);

	String proposer = "";
	String progress = "";

	String kix = website.getRequestParameter(request,"kix", "");

	Programs program = new Programs();
	if (!"".equals(kix)){
		program = ProgramsDB.getProgramToModify(conn,campus,kix);
		if ( program != null ){
			proposer = program.getProposer();
			progress = program.getProgress();
		}
	}

	String printerFriendly = "/central/core/vwhtml.jsp?cps="+campus+"&kix="+kix;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p align="center">

<a href="prgvwidx.jsp" class="linkcolumn">view another program</a>
<font class="copyright">&nbsp;|&nbsp;</font>
<a href="<%=printerFriendly%>" target="_blank" class="linkcolumn">printer friendly</a>

<%
	String enableCCLab = Util.getSessionMappedKey(session,"EnableCCLab");
	if (enableCCLab.equals(Constant.ON)){
%>
		<font class="copyright">&nbsp;|&nbsp;</font>
		<a href="vwpdf.jsp?kix=<%=kix%>" class="linkcolumn" target="_blank"><img src="../images/ext/pdf.gif" alt="view in pdf format" title="view in pdf format"></a>
<%
	}
%>

<%
	if (proposer.equals(user) && progress.equals(Constant.PROGRAM_MODIFY_PROGRESS)){
%>
		<font class="copyright">&nbsp;|&nbsp;</font>
		<a href="prgedt.jsp?kix=<%=kix%>" class="linkcolumn">modify program</a>
<%
	} // show modify for proposer
%>

</p>

<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{
		if (processPage){
			out.println(ProgramsDB.viewProgram(conn,campus,kix,type));

			if (type.equals("CAN") || type.equals("ARC")){
				out.println("<br/><div class=\"hr\"></div><img src=\"../images/restore.gif\" border=\"0\" alt=\"restore program\" title=\"restore program\">&nbsp;<a href=\"prgrtr.jsp?kix="+kix+"&type="+type+"\" class=\"linkcolumn\">restore program</a>");
			}
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"prgvw",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
