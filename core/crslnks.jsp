<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnks.jsp	- linking items between items
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String type = "";
	String proposer = "";
	String currentTab = "";
	String currentNo = "";
	String message = "";
	String inputTitle = "";
	String data = "";
	String help = "";

	String thisPage = "crslnks";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String caller = website.getRequestParameter(request,"caller","");

	String sloType = website.getRequestParameter(request,"s",Constant.COURSE_OBJECTIVES);

	/*
		kix exists as mnu when called from by menu. normal process is via
		crsedt screen.

		when kix is a valid number, it's because we have selected an outline
		to operate on.
	*/
	String kix = website.getRequestParameter(request,"kix","");
	String src = website.getRequestParameter(request,"src","");
	String dst = website.getRequestParameter(request,"dst","");

	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
		proposer = info[3];

		// if it's raw edit, don't over ride with crscmp
		// need to return back to raw edit after saving
		caller = aseUtil.getSessionValue(session,"aseCallingPage");
		if(!caller.equals("crsfldy")){
			caller = "crslnks";
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
	if(caller.equals("crsedt") || caller.equals("crsfldy") || caller.equals("crslnks")){
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
	session.setAttribute("aseCallingPage",caller);
	session.setAttribute("aseSloType",sloType);

	// GUI
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	// page title
	if ((Constant.COURSE_OBJECTIVES).equalsIgnoreCase(src)){
		fieldsetTitle = "SLO";
		inputTitle = "SLO";
		help = "SLO";
	}
	else if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(src)){
		fieldsetTitle = "Competencies";
		inputTitle = "Competency";
		help = "Competency";
	}
	else if ((Constant.COURSE_RECPREP).equalsIgnoreCase(src)){
		fieldsetTitle = "Recommended Preparation";
		inputTitle = "Recommended Preparation";
		help = "RecPrep";
	}

	if ("crslnks".equals(caller) && kix.length()>0){
		if (!proposer.equals(user)){
			message = "Only the proposer may edit for " + alpha + " " + num + ".<br><br>";
		}
		else{
			if (!courseDB.isEditable(conn,campus,alpha,num,user,session.getId())){
				message = "Selection is not editable at this time.<br><br>";
			}
		}	// proposer

		if (!"".equals(message)){
			session.setAttribute("aseApplicationMessage",message);
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="js/crslnks.js"></script>
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
	if (processPage && validCaller && message.equals(Constant.BLANK)){
		try{
			String content = "";
			int keyid = website.getRequestParameter(request,"keyid",0);
			if (keyid > 0){
				if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(src)){
					content = CompetencyDB.getContentByID(conn,kix,keyid);
				}
			}

			out.println("	<table width=\'80%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/linker?arg=frm\'>" );

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
%>
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						<td colspan="2">
							<%
								String helpArg1 = "Course";
								String helpArg2 = help;
							%>
							<%@ include file="crshlpx.jsp" %>
<%

			if ((Constant.COURSE_COMPETENCIES).equalsIgnoreCase(src)){
				out.println("<p align=\"right\"><a href=\"qlst1.jsp?rtn2=edt&kix="+kix+"&itm="+src+"\" class=\"linkcolumn\">Quick List Entry</a>&nbsp;</p>");
			}

			out.println("			</tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\'  width=\"10%\" nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + campusName );
			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>" + inputTitle + ":&nbsp;</td>" );
			out.println("				 <td>" );

			//out.println("<textarea class=\'input\' id=\"content\" name=\"content\" cols=90 rows=8>" + content + "</textarea>" );

			String ckName = "content";
			String ckData = content;

%>
			<%@ include file="ckeditor02.jsp" %>
<%

			out.println("			</td></tr>" );

			out.println("			<tr>" );
			out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
			out.println("				<td><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
			out.println("					<input type=\'hidden\' name=\'option\' value=\'PRE\'>" );
			out.println("					<input type=\'hidden\' name=\'act\' value=\'\'>" );
			out.println("					<input type=\'hidden\' name=\'keyid\' value=\'" + keyid + "\'>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'src\' value=\'" + src + "\'>" );
			out.println("					<input type=\'hidden\' name=\'dst\' value=\'" + dst + "\'>" );
			out.println("					<input type=\'hidden\' name=\'ts\' value=\'" + currentTab + "\'>" );
			out.println("					<input type=\'hidden\' name=\'no\' value=\'" + currentNo + "\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );

			out.println("<input title=\'save\' type=\'submit\' name=\'aseSave\' value=\'Save\' class=\'inputsmallgray\' onclick=\"return  aseSubmitClick(\'a\',1000);\">" );
			out.println("<input title=\'abort selected operation\' type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'inputsmallgray\' onClick=\"return cancelForm('"+kix+"','"+currentTab+"','"+currentNo+"','"+caller+"','"+campus+"')\">" );

			out.println("			</td></tr>" );
			out.println("		</form>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=center>" );

			if (src.equalsIgnoreCase(Constant.COURSE_COMPETENCIES)){
				data = CompetencyDB.getCompetenciesForReview(conn,kix,src,"MethodEval");
			}

			if (!"".equals(data))
				out.println(data);

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

	asePool.freeConnection(conn,"crslnks",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>