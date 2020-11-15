<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	shwfld.jsp
	*	2007.09.01	displays fields for selection to edit
	*	TODO what to do with rtn
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "shwfld";
	session.setAttribute("aseThisPage",thisPage);

	String chromeWidth = "90%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String type = website.getRequestParameter(request,"aseType","PRE",true);
	String mnu = website.getRequestParameter(request,"mnu");

	//
	//	cmnts comes from the approver screen. we hide the comments
	//	box during the approval process. Comments are provided in the
	//	process along with enabling of items to modify
	//
	String cmnts = website.getRequestParameter(request,"cmnts", "1");

	String alpha = "";
	String num = "";
	String progress = "";

	boolean enableOutlineItems = false;
	boolean campusAdmin = false;
	boolean sysAdmin = false;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		progress = info[7];
	}
	else{
		if (!mnu.equals(Constant.ON)){
			alpha = (String)session.getAttribute("aseAlpha");
			num = (String)session.getAttribute("aseNum");
			kix = helper.getKix(conn,campus,alpha,num,type);
		}
	}

	if (kix==null || kix.length()==0){
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
	}

	//
	// ER00009 - ttg - 2012.08.12
	// remember where user comments so we can place check marks on this page
	//
	String enabledForEdits = ParkDB.getApproverCommentedItems(conn,kix,user);

	if ((alpha==null || alpha.length()==0) && (num==null || num.length()==0)){
		response.sendRedirect("sltcrs.jsp?cp=shwfld&viewOption=PRE");
	}

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
	boolean enablingDuringApproval = outlines.enablingDuringApproval(conn,kix);

	String rtn = website.getRequestParameter(request,"rtn");
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Enable Editable Outline Items";

	// aseRequestToStartModify set in crsmody.jsp. It signals this is the start of a modification request
	String aseRequestToStartModify = website.getRequestParameter(request,"aseRequestToStartModify","",true);

	// aseApprovalRejection set in crsapprx.jsp. It signals this is where approver enable items
	String aseApprovalRejection = website.getRequestParameter(request,"aseApprovalRejection","",true);

	if (aseRequestToStartModify.equals(Constant.ON)){
		enableOutlineItems = true;
	}
	else if (aseApprovalRejection.equals(Constant.ON)){
		enableOutlineItems = true;
	}
	else{
		enableOutlineItems = courseDB.enableOutlineItems(conn,campus,alpha,num,user);
	}

	campusAdmin = SQLUtil.isCampusAdmin(conn,user);
	sysAdmin = SQLUtil.isSysAdmin(conn,user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/shwfld.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (!processPage || kix == null) {
		out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
	}
	else{
		if (enableOutlineItems || campusAdmin || sysAdmin) {
			String reason = "";

			out.println("<form method=\"post\" name=\"aseForm\" action=\"/central/servlet/sng\">" );
			//out.println("<form method=\"post\" name=\"aseForm\" action=\"shwfldx.jsp\">" );
			out.println("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
			out.println("<tr><td valign=\"top\" class=\"textblackTH\">Comments (provide comments concerning this modifications): "
				+ "<img src=\"images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('crshlp');\">"
				+ "&nbsp;<a href=\"crsrsn.jsp?kix="+kix+"\" class=\"linkColumn\" onclick=\"return hs.htmlExpand(this, { objectType: 'ajax', width: 500})\"><img src=\"../images/doc.jpg\" border=\"0\" alt=\"view comments\" title=\"view comments\"></a>"
				+ "</td></tr>");

%>
				<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
					<td colspan="2">
						<%
							String helpArg1 = "Course";
							String helpArg2 = "EnableItems";
						%>
						<%@ include file="crshlpx.jsp" %>
					</td>
				</tr>
<%
			// ttgiang 2010.06.22 per s. pope. no point in showing comments after the initial display
			// during add
			if (cmnts.equals(Constant.ON)){
				out.println("<tr><td><textarea name=\"reason\" cols=\"100\" rows=\"5\" class=\"input\"></textarea></td></tr>");
			}

			out.println("</table>");

			out.println(QuestionDB.showFields(conn,campus,alpha,num,rtn,edit,enablingDuringApproval,enableOutlineItems,enabledForEdits));

			out.println("</form>" );

			String outlineItemDependencies = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutlineItemDependencies");
			if(outlineItemDependencies != null && outlineItemDependencies.length() > 0){
				out.println("The following are grouped items for course modifications: " + outlineItemDependencies);
			}

		}
		else{
			%>
				<p align="center">
						<table width="80%" cellspacing='1' border="0">
							<tr><td>
								<br>Outline items may not be enabled at this time. Possible reasons are:<br/>
								<ul>
									<li>The outline is going through the approval process<br></li>
									<li>You are not authorized to enable items for this outline</li>
								</ul>
							</td></tr>
						</table>
				</p>
			<%
		}
	}

	asePool.freeConnection(conn,"shwfld",user);

	// clear to avoid trouble
	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
