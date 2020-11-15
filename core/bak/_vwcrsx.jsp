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

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String alpha = "";
	String num = "";
	String cps = "";
	String kix = website.getRequestParameter(request,"kix","");
	String type = website.getRequestParameter(request,"t","");

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		cps = (String)session.getAttribute("aseCampus");
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		cps = website.getRequestParameter(request,"cps","");
	}

	String chromeWidth = "90%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,cps);
	fieldsetTitle = "View Outline";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="highslide/highslide.js"></script>
	<script type="text/javascript" src="highslide/highslide-html.js"></script>
	<script type="text/javascript" src="highslide/highslide2.js"></script>
	<link rel="stylesheet" type="text/css" href="highslide/highslide.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	String hid = website.getRequestParameter(request,"hid","");
	String cid = website.getRequestParameter(request,"cid","");
	int lid = website.getRequestParameter(request,"lid",0);
	String historyID = "";

	/* it's possible to get here with a campus in the URL to say that
		we want to view another campus outline (crsinfx - outline detail)
		when empty or null, we use our own campus
	*/
	if (cps==null || cps.length()==0)
		cps = (String)session.getAttribute("aseCampus");

	if ( (alpha != null && num != null) || (lid > 0) || (hid != null) || (cid != null)){
		int section= 0;

		if ( type == null || type == "" ) type = "CUR";

		if (lid > 0){section= 1;}
		else if (hid!=null && hid.length()> 0){section=2; type="ARC";}
		else if (cid!=null && cid.length()> 0){section=3;}
		else if (cps!=null && cps.length()> 0){section=4;}
		else{section= 5;}

		session.setAttribute("asePrtSection", String.valueOf(section));
		session.setAttribute("asePrtLid", String.valueOf(lid));
		session.setAttribute("asePrtHid", hid);
		session.setAttribute("asePrtCid", cid);
		session.setAttribute("aseAlpha", alpha);
		session.setAttribute("aseNum", num);
		session.setAttribute("aseType", type);

		boolean debug = false;
		if ( !debug ){
			msg = courseDB.viewOutline(conn,section,cps,lid,hid,cid,alpha,num,type);
			out.println(msg.getErrorLog());
		}
		else{
			out.println("<br>section: " + section+ "<br>");
			out.println("cps: " + cps+ "<br>");
			out.println("lid: " + lid+ "<br>");
			out.println("hid: " + hid+ "<br>");
			out.println("cid: " + cid+ "<br>");
			out.println("alpha: " + alpha+ "<br>");
			out.println("num: " + num+ "<br>");
			out.println("type: " + type+ "<br>");
		}

		out.println( "<br><hr size=\'1\'>");
		out.print( "<p align=\'center\'>");
		if ( historyID != null )
		%>
			<!--
			<a href="crshst.jsp?hid=<%=historyID%>&t=<%=type%>" class="linkColumn" onclick="return hs.htmlExpand(this, { contentId: 'highslide-html', objectType: 'ajax'} )">approval history</a>&nbsp;&nbsp;|&nbsp;
			<a href="crsrvwcmnts.jsp?hid=<%=historyID%>&hst=2" class="linkColumn" onclick="return hs.htmlExpand(this, { contentId: 'highslide-html', objectType: 'ajax'} )">reviewer comments</a>&nbsp;&nbsp;|&nbsp;
			-->
		<%
		out.println( "<a href=\'vwcrsy.jsp\' class=\'linkColumn\' target=\"_blank\">printer friendly</a></p>");
	}	// if alpha and num not null
%>

<div class="highslide-html-content" id="highslide-html" style="width: 680px">
	<div class="highslide-move" style="border: 0; height: 18px; padding: 2px; cursor: default">
		 <a href="#" onclick="return hs.close(this)" class="control">Close</a>
	</div>
	<div class="highslide-body"></div>
</div>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
