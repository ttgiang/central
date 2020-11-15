<%@ page import="com.ase.aseutil.faq.*" errorPage="error.jsp" %>
<html>
<head>
<title>Main Menu</title>
	<script language="JavaScript">
	function setCmd(value) {
	  document.menu.cmd.value = value;
	}
	</script>

	<link rel="stylesheet" type="text/css" href="../../inc/style.css">

</head>
<body bgcolor="white">
<form name="menu" action="/central/servlet/faqtool" method="post">
	<input type="hidden" name="cmd" value="">
	<table border="1" align="center">
		<tr><td>
		<table bgcolor="tan" border="0" align="center" cellpadding="10" cellspacing="0">
			<tr><th>FAQ Administration: Main Menu</th></tr>
			<tr><td align="center">
				<input type="submit" value="Create New FAQ" onClick="setCmd('add')"></td></tr>
			<tr><td align="center">
				<input type="submit" value="Update An Exiting FAQ" onClick="setCmd('update-menu')"></td></tr>
			<tr><td align="center">
				<input type="submit" value="Delete An Existing FAQ" onClick="setCmd('delete-menu')"></td></tr>
			<tr><td bgcolor="white"><font size="-1">
				<% if (request.getAttribute("faqtool.msg") != null) { %>
				<i><%= request.getAttribute("faqtool.msg") %></i>
				<% } %>
				</font></td></tr>
			<tr><td align="center">
				<a href="../tasks.jsp" class="linkcolumn">back to CC</a>
			</td></tr>
		</table>
		</td></tr>
	</table>
</form>
</body>
</html>
