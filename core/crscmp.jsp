<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmp.jsp	course competency (many different versions)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String type = "";
	String proposer = "";
	String currentTab = "";
	String currentNo = "";
	String caller = "";

	String thisPage = "crscmp";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean showComments = false;

	String sloType = website.getRequestParameter(request,"s",Constant.COURSE_OBJECTIVES);

	/*
		kix exists as mnu when called from by menu. normal process is via
		crsedt screen.

		when kix is a valid number, it's because we have selected an outline
		to operate on.
	*/
	String kix = website.getRequestParameter(request,"kix","");
	if (kix.equals("mnu")){
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}
	else if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		proposer = info[3];

		// if it's raw edit, don't over ride with crscmp
		// need to return back to raw edit after saving
		caller = aseUtil.getSessionValue(session,"aseCallingPage");
		if(!caller.equals("crsfldy")){
			caller = "crscmp";
			session.setAttribute("aseCallingPage",caller);
		}
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
		type = (String)session.getAttribute("aseType");
		proposer = courseDB.getCourseProposer(conn,campus,alpha,num,type);
		caller = aseUtil.getSessionValue(session,"aseCallingPage");
	}

	boolean validCaller = false;
	caller = aseUtil.getSessionValue(session,"aseCallingPage");
	if(caller.equals("crsedt") || caller.equals("crsfldy") || caller.equals("crscmp")){
		validCaller = true;
	}

	currentTab = (String)session.getAttribute("aseCurrentTab");
	currentNo = (String)session.getAttribute("asecurrentSeq");

	if (!type.equals(""))
		type = "PRE";

	session.setAttribute("aseAlpha",alpha);
	session.setAttribute("aseNum",num);
	session.setAttribute("aseCurrentTab",currentTab);
	session.setAttribute("asecurrentSeq",currentNo);
	session.setAttribute("aseSloType",sloType);

	// this vaule is used in crsassr but has to be picked up from here
	// since crsassr is an ajax page
	String sh = website.getRequestParameter(request,"sh", "0");

	// GUI
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Course Level SLO";

	String message = "";

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether SLO Review Request button should be displayed.");

	String showSLOReviewRequestButton = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ShowSLOReviewRequestButton");

	if (caller.equals("crscmp") && kix.length()>0){
		if (!proposer.equals(user)){
			message = "Only the proposer may edit SLO for " + alpha + " " + num + ".<br><br>";
		}
		else{
			if (!courseDB.isEditable(conn,campus,alpha,num,user,session.getId())){
				message = "SLOs are not editable at this time.<br><br>";
			}
		}	// proposer

		if (!message.equals("")){
			session.setAttribute("aseApplicationMessage",message);
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="tooltip/tooltip.jsp" %>
	<script type="text/javascript" src="js/crscmp.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%
	if ("crsedt".equals(caller)) {
%>
	<%@ include file="../inc/header3.jsp" %>
<%
	}
	else {
%>
	<%@ include file="../inc/header.jsp" %>
<%
	}

	// can only get here from crsedt
	if (validCaller && message.equals("")){
		try{

			String content = "";

			int compID = website.getRequestParameter(request,"id",0);
			if (compID > 0){
				Comp comp = CompDB.getCompByID(conn,compID,Constant.COURSE_OBJECTIVES);
				if (comp!=null){
					content = comp.getComp();
				}
			}

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crsassr.jsp\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td colspan=\"2\">");
			out.println("					<table width=\'100%\' cellspacing='1' cellpadding='2' border=\'0\'>" );
			out.println("						<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 			<td class=\'textbrownTH\' width=\"10%\">&nbsp;</td>" );
			out.println("				 			<td class=\'textbrownTH\' width=\"80%\">" + pageTitle + "</td>" );
			out.println("				 			<td class=\'textbrownTH\' width=\"10%\">"
					+ "<a href=\"vwcrsy.jsp?pf=1&kix="+kix+"&comp=0\" target=\"_blank\"><img src=\"../images/viewcourse.gif\" border=\"0\" alt=\"view outline\" title=\"view outline\"></a>&nbsp;&nbsp;"
					+ "<img src=\"images/helpicon.gif\" border=\"0\" alt=\"show help\" title=\"show help\" onclick=\"switchMenu('crshlp');\"></td>");

			out.println("						</tr>" );
			out.println("					</table>" );

			out.println("<p align=\"right\">"
					+ "<a href=\"slctlst.jsp?rtn=crscmp&kix="+kix+"&src="+Constant.COURSE_OBJECTIVES+"&dst="+Constant.COURSE_OBJECTIVES+"\" class=\"linkcolumn\">Select SLO</a>&nbsp;&nbsp;"
					+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
					+ "<a href=\"qlst1.jsp?rtn2=edtslo&kix="+kix+"&itm="+Constant.COURSE_OBJECTIVES+"\" class=\"linkcolumn\">Quick List Entry</a>&nbsp;&nbsp;"
					+ "</p></td>" );

			out.println("			</tr>" );

%>

					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						<td colspan="2">
							<%
								String helpArg1 = "Course";
								String helpArg2 = "SLO";
							%>
							<%@ include file="crshlpx.jsp" %>
						</td>
					</tr>

<%

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + campusName );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>Course SLO:&nbsp;</td>" );
			out.println("				 <td><textarea class=\'input\' id=\"comp\" name=\"comp\" cols=100 rows=10>" + content + "</textarea>" );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
			out.println("				<td><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
			out.println("					<input type=\'hidden\' name=\'option\' value=\'PRE\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'compID\' value=\'" + compID + "\'>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'src\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'dst\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'keyid\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );

			// during the review/approval process, we disable the save button and review request
			String sloList = "";
			boolean isReviewing = SLODB.sloProgress(conn,campus,alpha,num,type,Constant.COURSE_REVIEW_TEXT);
			boolean isApproving = SLODB.sloProgress(conn,campus,alpha,num,type,Constant.COURSE_APPROVAL_TEXT);
			boolean isAssessing = SLODB.sloProgress(conn,campus,alpha,num,type,Constant.COURSE_ASSESS_TEXT);
			if (isReviewing)
				sloList = "SLOReviewer";
			else if (isApproving)
				sloList = "SLOApprover";

			boolean isReviewerApprover = DistributionDB.hasMember(conn,campus,sloList,user);

			String enable = "";
			String disabled = "";
			if (isReviewing || isApproving || isAssessing){
				enable = "off";
				disabled = "disabled";
			}

			out.println("<input title=\'save SLO\' type=\'submit\' " + disabled + " name=\'aseSubmit\' value=\'Save\' class=\'input" + enable + "\' onclick=\"return  aseSubmitClick(\'a\');\">" );

			if (showSLOReviewRequestButton.equals(Constant.ON)){
				out.println("<input title=\'request SLO review by committee\' type=\'submit\' " + disabled + " name=\'aseApproval\' value=\'Request Review\' class=\'input" + enable + "\' onclick=\"return aseReviewClick(\'r\');\">" );
			}

			out.println("<input title=\'abort selected operation\' type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'input\' onClick=\"return cancelForm('"+kix+"','"+currentTab+"','"+currentNo+"','"+caller+"','"+campus+"')\">" );

			if ((isReviewing || isApproving) && !isReviewerApprover){
				out.println("<p class=\"textblackTH\">SLO review is in progress. You will not have access to add/delete SLOs until the review process is completed.</p>");
			}

			out.println("			</td></tr>" );
			out.println("		</form>" );
			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=center>" );

			if (sh.equals("") || sh.equals("0"))
				showComments = false;
			else
				showComments = true;

			// in edit mode, we use PRE
			String thisType = "PRE";
			if(!caller.equals("crsedt")){
				String[] kixInfo = helper.getKixInfo(conn,kix);
				thisType = kixInfo[Constant.KIX_TYPE];
			}

			String comp = CompDB.getCompsByType(conn,alpha,num,campus,thisType,user,currentTab,currentNo,showComments,enable,Constant.COURSE_OBJECTIVES);
			if (comp!=null){
				out.println("<p><br/><a href=\"crscmp.jsp?kix="+kix+"&sh=1\" class=\"linkcolumn\">show</a>&nbsp;|&nbsp;<a href=\"crscmp.jsp?kix="+kix+"&sh=0\" class=\"linkcolumn\">hide reviewer comments</a></p>");
				out.println(comp);
			}

			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
	else{
		out.println(message);
	}

	asePool.freeConnection(conn,"crscmp",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
