<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>FCKeditor - JSP Sample</title>
		<link href="../sample.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
			function FCKeditor_OnComplete(editorInstance) {
				window.status = editorInstance.Description;
			}
		</script>
	</head>
	<%
		//FCKeditor fckEditor = new FCKeditor(request,"Content","800","400","Basic","","");
		FCKeditor fckEditor = new FCKeditor(request,"Content","800","400","ASE","","");
	%>
	<body>
		<form action="sampleposteddata.jsp" method="post">
		<%
			fckEditor.setValue("This is some <strong>sample text</strong>. You are using <a href=\"http://www.fckeditor.net\">FCKeditor</a>.");
			out.println(fckEditor);
		%>
		<br />
		<input type="submit" value="Submit" /></form>
	</body>
</html>