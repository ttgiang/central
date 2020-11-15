<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usrtsks02.jsp
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
	<script language="JavaScript" src="js/usrtsks02.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"sid", "");
	String alpha = website.getRequestParameter(request,"alpha", "");
	String num = website.getRequestParameter(request,"num", "");
	int code = website.getRequestParameter(request,"code", 0);

	String task = "";
	String proposer = "";
	String progress = "";
	String message = "";

	String submitDisabled = "";
	String submitClass = "";

	if (processPage && !user.equals(Constant.BLANK)){
		switch(code){
			case Constant.APPROVAL:
				task = Constant.APPROVAL_TEXT;
				proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");
				progress = courseDB.getCourseProgress(conn,campus,alpha,num,"PRE");

				if (!(Constant.COURSE_APPROVAL_TEXT).equals(progress) && !(Constant.COURSE_DELETE_TEXT).equals(progress)){
					message = "<font color=\"red\">Outline must be in APPROVAL or DELETE status to create this task. "
						+ "To start the approval process, " + proposer + " must initiate from the outline modification screen.</font>";
					submitDisabled = "disabled";
					submitClass = "off";
				}

				break;
			case Constant.MODIFY:
				task = Constant.MODIFY_TEXT;

				if (!"MODIFY".equals(courseDB.getCourseProgress(conn,campus,alpha,num,"PRE"))){
					message = "<font color=\"red\">Outline must be in MODIFY status to create this task.</font>";
					submitDisabled = "disabled";
					submitClass = "off";
				}

				break;
			case Constant.REVIEW:
				task = Constant.REVIEW_TEXT;

				if (!"REVIEW".equals(courseDB.getCourseProgress(conn,campus,alpha,num,"PRE"))){
					message = "<font color=\"red\">Outline must be in REVIEW status to create this task.</font>";
					submitDisabled = "disabled";
					submitClass = "off";
				}

				break;
		}	// switch
	}

	asePool.freeConnection(conn,"usrtsks02",user);
%>

<form name="aseForm" method="post" action="/central/servlet/usx">
	<table border="0" cellpadding="2" width="60%" align="center" cellspacing="1">
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">User ID:</td>
			<td width="85%" valign="top" class="datacolumn"><%=user%></td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">Task:</td>
			<td width="85%" valign="top" class="datacolumn"><%=task%></td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">Outline:</td>
			<td width="85%" valign="top" class="datacolumn"><%=alpha%> <%=num%></td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top" class="textblackth">&nbsp;</td>
			<td width="85%" valign="top" class="datacolumn"><%=message%></td>
		</tr>
		<tr>
			<td width="15%" height="30" valign="top">&nbsp;</td>
			<td width="85%">
				<input type="hidden" name="user" value="<%=user%>">
				<input type="hidden" name="campus" value="<%=campus%>">
				<input type="hidden" name="code" value="<%=code%>">
				<input type="hidden" name="alpha" value="<%=alpha%>">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="submit" name="aseSubmit" value="Submit" class="inputsmallgray<%=submitClass%>" <%=submitDisabled%> onClick="return checkForm(this.form)">
				<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm(this.form)">
			</td>
		</tr>
	</table>
</form>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
