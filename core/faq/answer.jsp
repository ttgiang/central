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

	int id = website.getRequestParameter(request,"id",0);

	String question = "";

	com.ase.aseutil.faq.Faq faq = com.ase.aseutil.faq.FaqDB.getFaq(conn,id);
	if (faq != null){
		question = faq.getQuestion();
	}
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<script language="JavaScript" src="inc/faq.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<table width="100%" border="0">
	<tr>
		<td>
<%
	if (processPage){

		FCKeditor fckEditor = new FCKeditor(request,"faq","650","250","ASE","","");
		fckEditor.setValue("");
		String HTMLFormField = fckEditor.toString();

%>
		<form method="post" action="/central/servlet/faq" name="aseForm">

			<h3 align="left">Question:</h3>
			<p align="left"><%=question%></p>

			<h3 align="left">What's your answer:</h3>

			<%=HTMLFormField%>

			<p>
			<input type="submit" value="Submit" name="cmdSubmit" class="input">
			<input type="submit" value="Cancel" name="cmdCancel" class="input"  onClick="return cancelForm()">
			<input type="hidden" name="cmd" value="ans">
			<input type="hidden" name="id" value="<%=id%>">
			</p>

		</form>

<%
	} // processPage

	session.setAttribute("aseApplicationMessage", "");

	asePool.freeConnection(conn,"ask",user);
%>

		</td>
	</tr>
</table>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
