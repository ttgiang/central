<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	vwcrsx.jsp
	*	2007.09.01	view outline.
	*				for PRE and CUR, send directly to vwcrsx since there would always
	*				be only 1 of each. For ARC, show user all the different versions
	*
	**/

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","vwcrs");

	String userCampus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String cps = "";
	String kix = website.getRequestParameter(request,"kix","");

	String urlKix = kix;

	String type = website.getRequestParameter(request,"t","");

	// hid comes from helper routine listing outlines. when dealing with ARC/CAN, hid
	// forces this page to ignore calling helper routine second time.
	String hid = website.getRequestParameter(request,"hid","");
	String cid = website.getRequestParameter(request,"cid","");
	String print = website.getRequestParameter(request,"pf","0");
	int lid = website.getRequestParameter(request,"lid",0);
	int comp = website.getRequestParameter(request,"comp",0);
	int dtl = website.getRequestParameter(request,"dtl",0);

	boolean compressed = false;
	boolean detail = false;

	if (comp==1){
		compressed = true;
	}

	if (dtl==1){
		detail = true;
	}

	if (!cid.equals(Constant.BLANK)){
		kix = cid;
	}

	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
		cps = info[Constant.KIX_CAMPUS];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		cps = website.getRequestParameter(request,"cps","");
		kix = helper.getKix(conn,cps,alpha,num,type);
	}

	if (cps == null){
		cps = "";
	}

	String chromeWidth = "90%";
	String pageTitle = courseDB.getCourseDescriptionByTypePlus(conn,cps,alpha,num,type);
	fieldsetTitle = "View Outline";

	// show the campus this outline belongs to when it's not the user's campus
	if (!cps.equals(userCampus)){
		pageTitle = cps + " - " + pageTitle;
	}

	String outlineView = "";
	String detailView = "";
	String printerFriendly = "";
	long approvalHistory = 0;

	if (processPage){
		session.setAttribute("kix",kix);
		session.setAttribute("rpt","outline");

		String linkForArcCan = "";
		if(hid.equals("1") && !cps.equals(Constant.BLANK) && (type.equals("ARC") || type.equals("CAN"))){
			linkForArcCan = "&hid=1&cps="+cps+"&t"+type;
		}

		if (comp==1){
			outlineView = "View:&nbsp;&nbsp;"
				+ "<font class=\"copyright\">Compressed&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
				+ "<a href=\"vwcrsx.jsp?kix="+kix+"&comp=0&dtl="+dtl+linkForArcCan+"\" class=\"linkColumn\">Expanded</a>";
		}
		else{
			outlineView = "View:&nbsp;&nbsp;"
				+ "<a href=\"vwcrsx.jsp?kix="+kix+"&comp=1&dtl="+dtl+linkForArcCan+"\" class=\"linkColumn\">Compressed</a>"
				+ "<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;Expanded</font>";
		}

		if (dtl==1){
			detailView = "&nbsp;&nbsp;Comments:&nbsp;&nbsp;"
				+ "<font class=\"copyright\">Yes&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
				+ "<a href=\"vwcrsx.jsp?kix="+kix+"&comp="+comp+"&dtl=0"+linkForArcCan+"\" class=\"linkColumn\">No</a>";
		}
		else{
			detailView = "&nbsp;&nbsp;Comments:&nbsp;&nbsp;"
				+ "<a href=\"vwcrsx.jsp?kix="+kix+"&comp="+comp+"&dtl=1"+linkForArcCan+"\" class=\"linkColumn\">Yes</a>"
				+ "<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;No</font>";
		}

		printerFriendly = "<a href=\"vwcrsy.jsp?pf=1&kix="+kix+"&comp="+comp+"&dtl="+dtl+"\" class=\"linkColumn\" target=\"_blank\">Print friendly</a>&nbsp;";

		String enableCCLab = Util.getSessionMappedKey(session,"EnableCCLab");
		if (enableCCLab.equals(Constant.ON)){

			printerFriendly += "<font class=\"copyright\">|</font>&nbsp;<a href=\"vwpdf.jsp?kix="
				+ kix
				+ "\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>";

		}

		approvalHistory = ApproverDB.countApprovalHistory(conn,kix);
	}

	if (type.equals("ARC") && (urlKix == null || urlKix.equals(Constant.BLANK))){
		printerFriendly = "";
		outlineView = "";
		detailView = "";
	}

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<%@ include file="../inc/expand.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheaderprinter.jsp" %>
<%
	/* it's possible to get here with a campus in the URL to say that
		we want to view another campus outline (crsinfx - outline detail)
		when empty or null, we use our own campus
	*/
	if (cps==null || cps.length()==0){
		cps = website.getRequestParameter(request,"aseCampus","",true);
	}

	if (kix != null && processPage){
		int section= 0;

		if ( type == null || type == "" ) type = "CUR";

		if (type.equals("ARC")){
			section = Constant.COURSETYPE_ARC;
		}
		else if (type.equals("CAN")){
			section = Constant.COURSETYPE_CAN;
		}
		else if (type.equals("CUR")){
			section = Constant.COURSETYPE_CUR;
		}
		else if (type.equals("PRE")){
			section = Constant.COURSETYPE_PRE;
		}

		session.setAttribute("asePrtSection", String.valueOf(section));
		session.setAttribute("asePrtLid", String.valueOf(lid));
		session.setAttribute("asePrtHid", kix);
		session.setAttribute("aseAlpha", alpha);
		session.setAttribute("aseNum", num);
		session.setAttribute("aseType", type);

		if (type.equals("ARC") && hid.equals("")){
			// cannot use listoutlinestodisplayx because it has to display all arc outlines first
			out.println(helper.listOutlines(conn,cps,alpha,num,type));
		}
		else{

			msg = outlines.viewOutline(conn,kix,user,compressed,false,false,detail);

			out.println(msg.getErrorLog());

			hid = kix;

		} // type = ARC

		if (print.equals(Constant.OFF) && !hid.equals("")){
			out.println( "<br><hr size=\'1\'>");
			String[] statusTab = null;
			statusTab = courseDB.getCourseDatesByType(conn,kix,type);
	%>
				<fieldset class="FIELDSET">
					<legend>Outline Information</legend>
					<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
						<TBODY>
							<TR>
								<TD class="textblackTH" width="25%">Proposer:</TD>
								<TD class="dataColumn"><%=statusTab[0]%></TD>
								<TD width="25%">&nbsp;</TD>
							</TR>
							<TR>
								<TD class="textblackTH" width="25%">Progress:</TD>
								<TD class="dataColumn"><%=statusTab[1]%></TD>
								<TD width="25%" nowrap>
								<%

									// screen has configurable item. setting determines whether
									// users are sent directly to news or task screen after login
									session.setAttribute("aseConfig","1");
									session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

									String reactivateOutline = (String)session.getAttribute("aseMenuCourseReactivate");
									if (reactivateOutline == null || reactivateOutline.length() == 0)
										reactivateOutline = "0";

									if (reactivateOutline.equals(Constant.ON) && (type.equals("CAN") || type.equals("ARC"))){
										out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"../images/restore.gif\" border=\"0\" alt=\"restore outline\" title=\"restore outline\">&nbsp;<a href=\"crsrtr.jsp?kix="+kix+"&type="+type+"\" class=\"linkcolumn\">restore outline</a>");
										out.println("&nbsp;<a href=\"/centraldocs/docs/faq/outlinerestore.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;");
									}
								%>
								</TD>
							</TR>
							<TR>
								<TD class="textblackTH" width="25%">Modify Date:</TD>
								<TD class="dataColumn"><%=statusTab[2]%></TD>
								<TD width="25%">&nbsp;</TD>
							</TR>
							<TR>
								<TD class="textblackTH" width="25%">Approved Date:</TD>
								<TD class="dataColumn"><%=statusTab[3]%></TD>
								<TD width="25%">&nbsp;</TD>
							</TR>
						</TBODY>
					</TABLE>
				</fieldset>
	<%
		} // print = Constant.OFF

		out.println( "<br><hr size=\'1\'>");

		out.print( "<p align=\'center\'>");

		if (section != Constant.COURSETYPE_CUR && approvalHistory > 0){
	%>
			<a href="crshst.jsp?hid=<%=kix%>&t=<%=type%>" class="linkColumn" onclick="asePopUpWindow(this.href,'aseVWCRSX','800','600','yes','center');return false" onfocus="this.blur()">approval history&nbsp;(<%=approvalHistory%>)</a>&nbsp;&nbsp;|&nbsp;
	<%
		} // section

		out.println(printerFriendly);

	}	// kix && processPage

	asePool.freeConnection(conn,"vwcrsx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

