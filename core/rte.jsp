<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rte.jsp	change routing number
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String kix = website.getRequestParameter(request,"kix","");
	int route = website.getRequestParameter(request,"route",0);
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String rtn = website.getRequestParameter(request,"rtn","");

	String changeType = website.getRequestParameter(request,"t","outlines");

	String campusName = CampusDB.getCampusName(conn,campus);

	String pageTitle = "Change Approval Routing";

	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/rte.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		if (processPage){
			String[] info = helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String proposer = info[Constant.KIX_PROPOSER];
			String courseTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

			String currentRouting = ApproverDB.getRoutingFullNameByID(conn,campus,route);

			String HTMLFormField = Html.drawListBox(conn,"ApprovalRouting","routeX","",campus,false,false);
%>

			<form name="aseForm" method="post" action="rtex.jsp">
				<table width="80%" cellspacing="4" cellpadding="4" align="center"  border="0">
					<tr>
						<td colspan="2" class="textblack">
						<font class="goldhighlightsbold">NOTE</font>: Changing the approval sequence does not alter any completed approval history or send email notifications.
						<br/>
						<div class="hr"></div>
						</td>
					</tr>

					<tr>
						<td width="15%" class="textblackth">Title:</td>
						<td class="datacolumn"><%=courseTitle%></td>
					</tr>

					<tr>
						<td width="15%" class="textblackth">Proposer:</td>
						<td class="datacolumn"><%=proposer%></td>
					</tr>

					<tr>
						<td width="15%" class="textblackth">Current Routing:</td>
						<td class="datacolumn"><%=currentRouting%></td>
					</tr>

					<tr>
						<td width="15%" class="textblackth">New Routing:</td>
						<td class="datacolumn"><%=HTMLFormField%></td>
					</tr>

					<TR>
						<td width="15%" class="textblackth">&nbsp;</td>
						<TD>
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
							<img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...
							</div>
						</td>
					</tr>

					<tr>
						<td width="15%" class="textblackth">&nbsp;</td>
						<td class="datacolumn">
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="<%=rtn%>" name="rtn">
							<input type="hidden" value="<%=changeType%>" name="t">
							<input type="hidden" value="aseForm" name="formName">
							<input type="submit" value="Cancel" id="cmdCancel" name="cmdCancel" class="input" onClick="return cancelForm()">
						</td>
					</tr>
				</table>
			</form>
<%
		}
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"rte",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
