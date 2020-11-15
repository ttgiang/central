<html>
<head>
	<title>Application Exception</title>
	<link rel="stylesheet" href="../inc/style.css">
	<%@ page isErrorPage="true" import="java.io.*" %>
</head>
<body>
	<table border="0" width="660">
		<tr>
			<td><h4>Application exception occurred</h4></td>
		</tr>
		<tr>
			<td><% out.print( exception.toString() ); %></td>
		</tr>
		<tr>
			<td>
				<pre>
				<%
					PrintWriter pw = response.getWriter();
					exception.printStackTrace(new PrintWriter(out));
				%>
				</pre>
			</td>
		</tr>
	</table>
</body>
</html>
