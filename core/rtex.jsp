<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rtex.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String proposer = "";
	String message = "";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = website.getRequestParameter(request,"kix","");
	String rtn = website.getRequestParameter(request,"rtn","");
	String changeType = website.getRequestParameter(request,"t","outlines");

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

	String oldRoute = ApproverDB.getRoutingFullNameByID(conn,campus,route);

	String newRoute = ApproverDB.getRoutingFullNameByID(conn,campus,routeX);

	boolean proceed = true;

	if (route == routeX || routeX == 0){
		proceed = false;
	}

	asePool.freeConnection(conn,"rtex",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/rtex.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<form name="aseForm" method="post" action="rtey.jsp">
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
			<td width="15%" class="textblackth">Old Routing:</td>
			<td class="datacolumn"><%=oldRoute%></td>
		</tr>

		<tr>
			<td width="15%" class="textblackth">New Routing:</td>
			<td class="datacolumn"><%=newRoute%></td>
		</tr>

<%
		if (proceed){
%>
		<TR>
			<td width="15%" class="textblackth">&nbsp;</td>
			<TD><br/><% out.println(Skew.showInputScreen(request)); %></td>
		</tr>

		<tr>
			<td width="15%" class="textblackth">&nbsp;</td>
			<td>
				<input type="hidden" value="<%=kix%>" name="kix">
				<input type="hidden" value="<%=routeX%>" name="routeX">
				<input type="hidden" value="<%=rtn%>" name="rtn">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="<%=changeType%>" name="t">
				<input type="hidden" value="aseForm" name="formName">
				<input type="submit" value="Submit" id="cmdChange" name="cmdChange" class="input" onClick="return checkForm('s')">
				<input type="submit" value="Cancel" id="cmdCancel" name="cmdCancel" class="input" onClick="return cancelForm()">
			</td>
		</tr>
<%
		}
		else{
%>
		<TR>
			<td width="15%" class="textblackth">&nbsp;</td>
			<TD><br/>Invalid routing selection.<br/><br/><a href="appridx.jsp" class="linkcolumn">try again</a></td>
		</tr>

<%
		}
%>
	</table>
</form>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
