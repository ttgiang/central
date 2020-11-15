<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%

	//need to include outline status when changing term

	/**
	*	ASE
	*	crscmpr.jsp	- course compare
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Outline Summary";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	boolean advanced = website.getRequestParameter(request,"adv",false);

	//
	// adhoc determines whether we show the form or if the data came from another source (url link)
	//
	int adhoc = website.getRequestParameter(request,"adhc",1);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

	<%
		if(adhoc==1){
	%>
		<%@ include file="../inc/header.jsp" %>
	<%
		} // adhoc
	%>

	<%
		if(adhoc==1){
	%>
		<form method="post" action="?" name="aseForm">
			<table width="100%" cellspacing='1' cellpadding='2' class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
				<tr>
					<td class="textblackTHNoAlignment">
						&nbsp;&nbsp;Alpha:&nbsp;&nbsp;
						<%
							String sql = aseUtil.getPropertySQL(session,"alphas3");
							out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,"","",false,"",true,false));
						%>
						&nbsp;&nbsp;
						Number:&nbsp;&nbsp;<input name="num" id="num" class="input" type="text" size="6" maxlength="10" value="<%=num%>">&nbsp;&nbsp;
						&nbsp;&nbsp;
						Advanced compare:&nbsp;&nbsp;<input name="adv" id="adv" value="1" type="checkbox" <% if(advanced) out.println("checked"); %>>&nbsp;&nbsp;
						<input name="aseSubmit" class="inputsmallgray" type="submit" value="Go">
					</td>
				</tr>
			</table>
		</form>
	<%
		} // adhoc
	%>

<%
	try{
		if (processPage && (!alpha.equals(Constant.BLANK) && !num.equals(Constant.BLANK))){
			msg = Outlines.compareMatrix(conn,campus,alpha,num,user,advanced);
			out.println("<br>" + msg.getErrorLog());
		}
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn,"crscmpr",user);
%>

<%
	if(adhoc==1){
%>
	<%@ include file="../inc/footer.jsp" %>
<%
	} // adhoc
%>

</body>
</html>

