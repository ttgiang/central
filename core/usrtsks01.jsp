<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usrtsks01.jsp
	*	2007.09.01	create user tasks
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Creating User Task";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="bigbox.jsp" %>
	<script language="JavaScript" src="js/usrtsks01.js"></script>
	<script type="text/javascript" src="../inc/ajax.js"></script>
	<script type="text/javascript" src="../inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage && !user.equals(Constant.BLANK)){

		String sid = website.getRequestParameter(request,"sid","");
%>

<form name="aseForm" method="post" action="usrtsks02.jsp">
	<input type="hidden" name="thisOption" value="PRE">
	<input type="hidden" name="thisCampus" value="<%=campus%>">
	<table border="0" cellpadding="2" width="60%" align="center" cellspacing="1">
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">User ID:</td>
			<td width="85%" valign="top" class="datacolumn"><%=sid%></td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">Select Tasks:</td>
			<td class="datacolumn" valign="top">
				<select class="smalltext" name="code">
					<option value=''></option>
					<option value='<%=Constant.APPROVAL%>'><%=Constant.APPROVAL_TEXT%></option>
					<option value='<%=Constant.MODIFY%>'><%=Constant.MODIFY_TEXT%></option>
					<option value='<%=Constant.REVIEW%>'><%=Constant.REVIEW_TEXT%></option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">Outline:</td>
			<td class="datacolumn" valign="top">
				<% out.println(Queries.getDistinctAlpha(conn,campus,true)); %>
				<input type="text" value="" name="num" size="10" maxlength="10" class="input">
			</td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">&nbsp;</td>
			<td width="85%" valign="top" class="datacolumn">&nbsp;</td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top">&nbsp;</td>
			<td width="85%">
				<input type="hidden" name="sid" value="<%=sid%>">
				<input type="submit" name="aseSubmit" value="Continue" class="inputsmallgray" onClick="return checkForm(this.form)">
				<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm(this.form)">
			</td>
		</tr>
	</table>
</form>

<%
	}

	asePool.freeConnection(conn,"usrtsks01",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
