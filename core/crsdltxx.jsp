<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdltxx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String message = "";
	boolean valid = true;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	if (CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"PRE")){
		message = "You may not delete an outline while modification is in progress";
		valid = false;
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete Outline";

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsdlt.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<form method="post" action="crsdltxy.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<%=message%>
					<br />
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
				</TD>
			</TR>
			<%
				if (valid) {
			%>
				<tr>
					<td>
						<table cellspacing=0 cellpadding=0 width="100%" border=0>
							<tbody>
								<tr>
									<td class="textblackth">Comments:</td>
									<td>
										<%
											String ckName = "comments";
											String ckData = "";
										%>

										<%@ include file="ckeditor02.jsp" %>

									</td>
								</tr>
								<tr>
									<td class="textblackth">&nbsp;</td>
									<td>
										<br />
										<input title="continue with request" type="submit" value=" Continue " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
										<input title="end requested operation" type="submit" value=" Cancel " class="inputsmallgray" onClick="return cancelForm()">
										<input type="hidden" value="c" name="formAction">
										<input type="hidden" value="aseForm" name="formName">
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			<%
				}
			%>
		</TBODY>
	</TABLE>
</form>
<br>
<%
	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
