<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	shwprgfld.jsp
	*	2007.09.01	displays fields for selection to edit
	*	TODO what to do with rtn
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "90%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String type = (String)session.getAttribute("aseType");
	String mnu = website.getRequestParameter(request,"mnu");

	/*
		cmnts comes from the approver screen. we hide the comments
		box during the approval process. Comments are provided in the
		process along with enabling of items to modify
	*/
	String cmnts = website.getRequestParameter(request,"cmnts", "1");

	String alpha = "";
	String num = "";
	String progress = "";

	boolean enableProgramItems = false;
	boolean campusAdmin = false;
	boolean sysAdmin = false;

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
		type = info[Constant.KIX_TYPE];
		progress = info[Constant.KIX_PROGRESS];
	}
	else
		response.sendRedirect("sltcrs.jsp?cp=shwprgfld&viewOption=PRE");

	// exists only when desire to change enabled items for editing.
	// not for initial call from sltcrs on CRSEDT
	// this flag determins how processing takes place in EditFieldsServlet.
	// if edit is 1, EditFieldsServlet pushes through as a modify outline
	// if edit is 0, EditFieldsServlet pushes through as either approval or edit
	int edit = website.getRequestParameter(request,"edit",0);

	 // enabling is when approver wishes to enable items for proposer to edit
	 // to be in enabling mode, the following must be true:
	 //	1) the approval process must be on
	 //	2) edit1 and edit2 must have commas to indicate that individual items have been enabled
	boolean enablingDuringApproval = ProgramsDB.enablingDuringApproval(conn,campus,kix);

	String rtn = website.getRequestParameter(request,"rtn");
	String pageTitle = alpha;
	fieldsetTitle = "Enable Editable Items";

	// aseRequestToStartModify set in crsmody.jsp. It signals this is the start of a modification request
	String aseRequestToStartModify = website.getRequestParameter(request,"aseRequestToStartModify","",true);

	// aseApprovalRejection set in crsapprx.jsp. It signals this is where approver enable items
	String aseApprovalRejection = website.getRequestParameter(request,"aseApprovalRejection","",true);

	if (aseRequestToStartModify.equals(Constant.ON)){
		enableProgramItems = true;
	}
	else if (aseApprovalRejection.equals(Constant.ON)){
		enableProgramItems = true;
	}
	else{
		enableProgramItems = ProgramsDB.enableProgramItems(conn,campus,kix,user);
	}

	campusAdmin = SQLUtil.isCampusAdmin(conn,user);
	sysAdmin = SQLUtil.isSysAdmin(conn,user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/shwprgfld.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (!processPage || kix == null) {
		out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
	}
	else{
		if (enableProgramItems || campusAdmin || sysAdmin) {
			String reason = "";
			String screenMessage = "Comments (provide comments concerning this modifications):";

			if (!cmnts.equals(Constant.ON))
				screenMessage = "";

			out.println("<form method=\"post\" name=\"aseForm\" action=\"/central/servlet/noriko\">" );
			out.println("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
			out.println("<tr><td valign=\"top\" class=\"textblackTH\">" + screenMessage + "  "
				+ "<img src=\"images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('crshlp');\">"
				+ "&nbsp;<a href=\"crsrsn.jsp?kix="+kix+"\" class=\"linkColumn\" onclick=\"return hs.htmlExpand(this, { objectType: 'ajax', width: 500})\"><img src=\"../images/doc.jpg\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>"
				+ "</td></tr>");

%>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					<td colspan="2">
						<%
							String helpArg1 = "Programs";
							String helpArg2 = "EnableItems";
						%>
						<%@ include file="crshlpx.jsp" %>
					</td>
				</tr>
<%
			// ttgiang 2010.06.22 per s. pope
			if ((Constant.ON).equals(cmnts))
				out.println("<tr><td><textarea name=\"reason\" cols=\"100\" rows=\"5\" class=\"input\"></textarea></td></tr>");

			out.println("</table>");

			out.println(QuestionDB.showProgramFields(conn,campus,kix,rtn,edit,enablingDuringApproval));

			out.println("</form>" );
		}
	}

	asePool.freeConnection(conn,"shwprgfld",user);

	// clear to avoid trouble
	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
