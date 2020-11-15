<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscpyx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String fromAlpha = "";
	String fromNum = "";
	String toAlpha = "";
	String toNum = "";
	boolean valid = true;

	String campus = (String)session.getAttribute("aseCampus");

	fromAlpha = website.getRequestParameter(request,"fromAlpha","");
	fromNum = website.getRequestParameter(request,"fromNum","");
	toAlpha = website.getRequestParameter(request,"alpha_ID","");
	toNum = website.getRequestParameter(request,"toNum","");

	String message = "Do you wish to continue with copy operation?";

	if ( formName != null && formName.equals("aseForm") ){
		if ( "s".equalsIgnoreCase(formAction) ){
			msg = courseDB.isCourseCopyable(conn,campus,toAlpha,toNum);
			if (!"".equals(msg.getMsg())){
				valid = false;
				message = MsgDB.getMsgDetail(msg.getMsg());
			}
		}	// action = s
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",fromAlpha,fromNum,campus);
	fieldsetTitle = "Copy Outline";

	session.setAttribute("aseApplicationMessage","");
	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscpy.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<form method="post" action="crscpyy.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<%=message%>
					<br /><br />
					<TABLE cellSpacing=0 cellPadding=0 width="30%" border=0>
						<TBODY>
							<TR>
								<TD>From:&nbsp;</td>
								<td><%=fromAlpha%>&nbsp;<%=fromNum%></td>
							</tr>
							<tr>
								<td>To:&nbsp;</td>
								<td><%=toAlpha%>&nbsp;<%=toNum%></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" value="<%=fromAlpha%>" name="fromAlpha">
					<input type="hidden" value="<%=fromNum%>" name="fromNum">
					<input type="hidden" value="<%=toAlpha%>" name="toAlpha">
					<input type="hidden" value="<%=toNum%>" name="toNum">
				</TD>
			</TR>
			<%
				if (valid) {
			%>
				<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
				<TR>
					<TD align="center">
						<br />
						<input title="save entered data" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkFormX('s')">&nbsp;
						<input title="abort selected operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>
			<%
				}
			%>
		</TBODY>
	</TABLE>
</form>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
