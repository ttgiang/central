<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	bb.jsp - create program
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
	String kix = website.getRequestParameter(request,"kix","");
	int item = website.getRequestParameter(request,"qn",0);

	int forumId = website.getRequestParameter(request,"fid",0);
	String status = website.getRequestParameter(request,"status","");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

 <FORM NAME="aseForm" ACTION="addx.jsp" METHOD="post">
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width="700" align="left">
		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Message Type:&nbsp;</TD>
			<TD width="85%" >
				<select class="input" name="src">
					<option value="">-select-</option>
					<option value="user">Personal</option>
					<option value="<%=Constant.COURSE%>">Course</option>
					<option value="<%=Constant.PROGRAM%>">Program</option>
				</select>
			</TD>
		</TR>
		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Message Title:&nbsp;</TD>
			<TD width="85%" ><input type="text" name="forumName" size="50" maxlength="50" class="input"></TD>
		</TR>
		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Description:&nbsp;</TD>
			<TD width="85%" ><input type="text" name="forumDescr" size="50" maxlength="50" class="input"></TD>
		</TR>
		<TR height="40">
			<TD width="10%"  class="textblackth">&nbsp;</TD>
			<TD width="90%"  valign="bottom" ALIGN="left">
				<input type="hidden" name="kix" value="<%=kix%>">
				<input type="hidden" name="item" value="<%=item%>">
				<INPUT  TYPE="submit" VALUE="Post Message" id=cmdSubmit name=cmdSubmit class="input">&nbsp;&nbsp;
				<INPUT  TYPE="reset" VALUE="Reset Form" id=cmdReset name=cmdReset class="input"></TD>
		</TR>
		<TR height="80">
			<TD colspan="2" VALIGN="bottom">
				<A HREF="./display.jsp?fid=<%=forumId%>" class="linkcolumn"><img src="./images/folder_open.gif" border="0" alt="Back to the Folder" title="Back to the Folder">&nbsp;Back to the Folder</A><BR>
			</TD>
		</TR>
	</TABLE>
</form>
</p>

<%
	asePool.freeConnection(conn,"add",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
