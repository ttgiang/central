<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>FCKeditor - JSP Sample</title>
		<script type="text/javascript">
			function FCKeditor_OnComplete(editorInstance) {
				window.status = editorInstance.Description;
			}
		</script>
	</head>
	<%
		out.println("1");
		FCKeditor fckEditor = new FCKeditor(request,"comments","650","300","ASE","","");
		out.println("2");
	%>
	<body>
		<form action="sampleposteddata.jsp" method="post" target="_blank">
		<%
			out.println("3");
			fckEditor.setValue("FCKeditor</a>.");
			out.println(fckEditor);
			out.println("4");
		%>
		<br />

<div>
	<input value="This is a test."
	type="hidden"
	name="EditorDefault"
	id="EditorDefault" />
	<iframe
		frameborder="0"
		width="100%"
		height="200"
		scrolling="no"
		src="/central/fckeditor/editor/fckeditor.html?InstanceName=EditorDefault&amp;Toolbar=Basic"
		id="EditorDefault___Frame">
	</iframe>
</div>

<div>
	<input value="This is a test."
	type="hidden"
	name="EditorDefault"
	id="EditorDefault" />

	<iframe
		frameborder="0"
		width="100%"
		height="200"
		scrolling="no"
		src="/fckeditor-java-demo-2.6/fckeditor/editor/fckeditor.html?InstanceName=EditorDefault&amp;Toolbar=Default"
		id="EditorDefault___Frame">
	</iframe>
</div>

		<input type="submit" value="Submit" /></form>

	</body>
</html>