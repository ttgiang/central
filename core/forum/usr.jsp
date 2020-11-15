<%@ include file="../ase.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	auto.jsp - create
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Create Message";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<%@ include file="../fckeditor.jsp" %>
	<script language="JavaScript" src="inc/usr.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>

<%
	if (processPage){
%>

 <FORM NAME="aseForm" ACTION="usrx.jsp" METHOD="post">
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width="100%" align="left">

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Title:&nbsp;</TD>
			<TD width="85%" class="datacolumn"><input type="text" name="forumName" size="70" maxlength="50" class="input"></TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Description:&nbsp;</TD>
			<TD width="85%" class="datacolumn"><input type="text" name="forumDescr" size="70" maxlength="50" class="input"></TD>
		</TR>

		<TR height="40">
			<TD width="15%"  class="textblackth">&nbsp;</TD>
			<TD width="85%"  valign="bottom" ALIGN="left">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="aseForm" name="formName">
				<INPUT  TYPE="submit" VALUE="Create Board" id=cmdSubmit name=cmdSubmit class="input" onClick="return checkForm('s')">&nbsp;
				<INPUT  TYPE="submit" VALUE="Cancel" id=cmdCancel name=cmdCancel class="input" onClick="return cancelForm()">&nbsp;
				<INPUT  TYPE="reset" VALUE="Reset Form" id=cmdReset name=cmdReset class="input">&nbsp;&nbsp;
			</TD>
		</TR>

	</TABLE>
</form>

<%
	}
%>

<%
	asePool.freeConnection(conn,"usr",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
