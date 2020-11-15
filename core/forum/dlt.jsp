<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	dlt.jsp - delete a post
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String status = website.getRequestParameter(request,"status","");

	// check to prevent reposting
	session.setAttribute("aseProcessed","NO");

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<script type="text/javascript" src="inc/edit.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>

<p align="left">
<%
	if (processPage){
		int emid = website.getRequestParameter(request,"emid",0);
		int rmid = website.getRequestParameter(request,"rmid",0);
		int fid = website.getRequestParameter(request,"fid",0);
		int item = website.getRequestParameter(request,"item",0);

		String notify = "";
		String subject = "";
		String message = "";

		String[] brd = Board.getMessageForEdit(conn,fid,emid);

		if (brd != null){
			subject = brd[0];
			message = brd[1];
			notify = brd[2];
		}

		String checked = "";
		if (notify.equals(Constant.ON)){
			checked = "checked";
		}


%>
		<FORM NAME="aseForm" ACTION="dltx.jsp" METHOD="post">
		<INPUT TYPE="hidden" NAME="emid" VALUE="<%=emid%>">
		<INPUT TYPE="hidden" NAME="fid" VALUE="<%=fid%>">
		<INPUT TYPE="hidden" NAME="rmid" VALUE="<%=rmid%>">
		<INPUT TYPE="hidden" NAME="item" VALUE="<%=item%>">
		<BR>
		<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="4" width="700" align="left">
			<TR >
				<TD width="10%" class="textblackth">Name:&nbsp;</TD>
				<TD width="90%" class="datacolumn"><%=user%></TD>
			</TR>
			<TR >
				<TD width="10%" class="textblackth">Subject:&nbsp;</TD>
				<TD width="90%" class="datacolumn"><%=subject%></TD>
			</TR>
			<TR >
				<TD width="10%" class="textblackth">Message:&nbsp;</TD>
				<TD width="90%"><textarea cols="80" id="message" name="message" rows="10"><%=message%></textarea></TD>
					<script type="text/javascript">
					//<![CDATA[
						CKEDITOR.replace( 'message',
							{
								toolbar : [ [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ],
												[ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ],
												[ 'NumberedList','BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ]
											],
								enterMode : CKEDITOR.ENTER_BR,
								shiftEnterMode: CKEDITOR.ENTER_P,
								readOnly: true
							});
					//]]>
					</script>
			</TR>

			<TR height="40">
			<TD width="10%" class="textblackth">&nbsp;</TD>
			<TD width="90%"  valign="bottom" ALIGN="left">
				<INPUT class="input" TYPE="submit" VALUE="Delete Post" id="cmdSubmit" name="cmdSubmit" onClick="return validateForm();">&nbsp;&nbsp;
				<INPUT class="input" TYPE="submit" VALUE="Cancel Form" id="cmdCancel" name="cmdCancel" onClick="return cancelForm();"></TD>
			</TR>
			<TR height="40" valign="bottom"><TD colspan="2" VALIGN="bottom"></TD></TR>
		</TABLE>
		</FORM>
<%
	}

	asePool.freeConnection(conn,"dlt",user);
%>
</p>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
