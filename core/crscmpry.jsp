<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpry.jsp	compare outlines (without header)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Compare Outlines";
	fieldsetTitle = pageTitle;

	String kixSource = website.getRequestParameter(request,"kix","");
	String kixArchived = website.getRequestParameter(request,"arc","");

	String[] info = helper.getKixInfo(conn,kixSource);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];
	String type = info[Constant.KIX_TYPE];
	campus = info[Constant.KIX_CAMPUS];

	// display in compress mode
	boolean compressed = false;
	int comp = website.getRequestParameter(request,"comp",0);
	if (comp==1){
		compressed = true;
	}

	// show or not show all items
	boolean showed = false;
	int show = website.getRequestParameter(request,"show",1);
	if (show==1){
		showed = true;
	}

	// which type are we looking at
	if (type.equals("CUR")){
		type = "PRE";
	}
	else{
		type = "CUR";
	}

	// if we send in an archived KIX, use it
	String kixDestination = "";
	if(!kixArchived.equals(Constant.BLANK)){
		kixDestination = kixArchived;
	}
	else{
		kixDestination = helper.getKix(conn,campus,alpha,num,type);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage){

		out.println("<p align=\"left\">");

		if (comp==1){
			out.println("View:&nbsp;&nbsp;"
				+ "<font class=\"copyright\">Compressed&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
				+ "<a href=\"crscmpry.jsp?kix="+kixSource+"&arc="+kixDestination+"&comp=0&show="+show+"\" class=\"linkColumn\">Expanded</a>");
		}
		else{
			out.println("View:&nbsp;&nbsp;"
				+ "<a href=\"crscmpry.jsp?kix="+kixSource+"&arc="+kixDestination+"&comp=1&show="+show+"\" class=\"linkColumn\">Compressed</a>"
				+ "<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;Expanded</font>");
		}

		if (show==1){
			out.println("&nbsp;&nbsp;Show:&nbsp;&nbsp;"
				+ "<font class=\"copyright\">All items&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
				+ "<a href=\"crscmpry.jsp?kix="+kixSource+"&arc="+kixDestination+"&comp="+comp+"&show=0\" class=\"linkColumn\">Changed items</a>");
		}
		else{
			out.println("&nbsp;&nbsp;Show:&nbsp;&nbsp;"
				+ "<a href=\"crscmpry.jsp?kix="+kixSource+"&arc="+kixDestination+"&comp="+comp+"&show=1\" class=\"linkColumn\">All items</a>"
				+ "<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;Changed items</font>");
		}

		out.println("</p>");

		if (kixSource.length() > 0){

			msg = TempOutlines.compareOutline(conn,kixSource,kixDestination,user,compressed,showed);
			out.println(msg.getErrorLog());
		}
		else{
			out.println("Invalid outline selection.<br/><br/>"
				+ "Click <a href=\"cmpr.jsp\" class=\"linkcolumn\">here</a> to try again.");
		}
	}

	asePool.freeConnection(conn,"crscmpry",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

