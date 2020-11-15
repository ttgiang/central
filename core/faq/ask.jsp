<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

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

	String pageTitle = "Curriculum Central Answers!";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<script language="JavaScript" src="inc/faq.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link type="text/css" href="../../inc/buttons.css" rel="Stylesheet" />
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<table class="example_code notranslate" border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table width="100%" cellspacing="1" cellpadding="2" class="code" align="center"  border="0">
				<tr>
					<td>

<%
	if (processPage){

		String value = ",Administrative,Approval,Course,General,Program,Review,Technical,Other";
%>
		<form method="post" action="/central/servlet/faq" name="aseForm" align="left">

			<p align="left">
				<span class="textblackth">Category:</a>&nbsp;&nbsp;
				<%
					out.println(aseUtil.createStaticSelectionBox(value,value,"cat","","input",""," ",""));
				%>
				&nbsp;&nbsp;&nbsp;New Category*:&nbsp;&nbsp;<input id="cat2" class="input" name="cat2" size="30" maxlength="30" value="" type="text">
			<p>

			<p align="left">
				<span class="textblackth">Question:</a>

				<br>

			<%
				String ckName = "faq";
				String ckData = "";
			%>

<%@ include file="../ckeditor02.jsp" %>
			<p>

			<input type="checkbox" name="notify" value="1">&nbsp;&nbsp;Notify me when answers are available.

			<br>

			<p align="left">
				<button title="submit" type="submit" value="Submit" name="cmdSubmit" id="cmdSubmit" class="confirm_button green styled_button"  onClick="return checkForm()">Submit</button>
				<button title="cancel" type="submit" value="Cancel" name="cmdCancel" id="cmdCancel" class="cancel_button red styled_button" onClick="return cancelForm()">Cancel</button>
				<input type="hidden" name="cmd" value="ask">
			</p>

		</form>

		<p>&nbsp;</p>
		<p align="left">
			NOTE: *If your question category does not show in the Category list, enter a new category in the text box located to the right.
		<p>

<%
	} // processPage

	asePool.freeConnection(conn,"ask",user);
%>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
