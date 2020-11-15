<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rtey.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String num = "";
	String proposer = "";
	String message = "";
	String rtnMsg = "return to routing screen";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = website.getRequestParameter(request,"kix","");
	String rtn = website.getRequestParameter(request,"rtn","");
	String changeType = website.getRequestParameter(request,"t","outlines");

	if ((Constant.BLANK).equals(rtn)){
		rtn = "appridx";
		rtnMsg = "return to routing screen";
	}
	else if ("rpt".equals(rtn)){
		rtn = "crssts";
		rtnMsg = "return to approval status report";
	}

	int routeX = website.getRequestParameter(request,"routeX",0);
	int route = 0;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		proposer = info[Constant.KIX_PROPOSER];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Change Approval Routing";

	if (processPage){
		String skew = "0";

		if (Skew.confirmEncodedValue(request))
			skew = "1";
	}

	String courseTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	String currentRouting = "";

	if (route != routeX){
		currentRouting = ApproverDB.getRoutingFullNameByID(conn,campus,routeX);

		if(changeType.equals("outlines")){
			ApproverDB.updateRouting(conn,kix,user,routeX);
		}
		else{
			ApproverDB.updateRoutingForProgram(conn,campus,kix,user,routeX);
		}
	}
	else{
		currentRouting = ApproverDB.getRoutingFullNameByID(conn,campus,route);
	}

	asePool.freeConnection(conn,"rtey",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table width="80%" cellspacing="4" cellpadding="4" align="center"  border="0">
	<tr>
		<td width="15%" class="textblackth">Title:</td>
		<td class="datacolumn"><%=courseTitle%></td>
	</tr>

	<tr>
		<td width="15%" class="textblackth">Proposer:</td>
		<td class="datacolumn"><%=proposer%></td>
	</tr>

	<tr>
		<td width="15%" class="textblackth">New Routing:</td>
		<td class="datacolumn"><%=currentRouting%></td>
	</tr>

	<tr>
		<td width="15%" class="textblackth">&nbsp;</td>
		<td class="datacolumn"><br/><br/><a href="<%=rtn%>.jsp" class="linkcolumn"><%=rtnMsg%></a></td>
	</tr>

</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
