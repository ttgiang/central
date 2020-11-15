<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	attchst.jsp - attachment versions
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "attchst";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	int id = website.getRequestParameter(request,"id",0);

	String alpha = "";
	String num = "";
	String message = "";
	String category = "";

	boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

	String[] info = helper.getKixInfo(conn,kix);
	if (info != null){
		if (isAProgram){
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			num = info[Constant.KIX_PROGRAM_DIVISION];
			category = Constant.PROGRAM;
		}
		else{
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			category = Constant.COURSE;
		}
	}

	// this page is called by tasks or prgidx.jsp. make sure cancel goes back to the right place.
	String previousPage = "";
	String caller = (String)session.getAttribute("aseCallingPage");
	if (caller != null && caller.indexOf(".") < 0){
		previousPage = caller + ".jsp";
	}

	// GUI
	String chromeWidth = "90%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Attachment Versions";

	asePool.freeConnection(conn,"attchst",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/attchst.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/kuri" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center" colspan="2">
					<%
						if (processPage)
							out.println(AttachDB.listAttachmentsVersions(conn,campus,kix,id,category,thisPage));
					%>
					<br/>
					<a href="<%=previousPage%>?kix=<%=kix%>" class="linkcolumn">return to previous page</a>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
