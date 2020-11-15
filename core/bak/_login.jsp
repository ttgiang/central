<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ase.aseutil.*"%>
<%@ page errorPage="exception.jsp" %>

<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="courseDB" scope="application" class="com.ase.aseutil.CourseDB" />
<jsp:useBean id="msg" scope="application" class="com.ase.aseutil.Msg" />

<%
	String pageTitle = "Login Securely";
%>
<html>

<head>
<title>Curriculum Central</title>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/li.js"></script>
</head>

<body background="../images/background.gif">
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
<div align="center">
	<center>
		<form action="?" method="post" name="aseForm">
			<table width="32%" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-style: solid; border-width: 1" bordercolor="#336699" id="AutoNumber1" height="152">
				<tr>
					<td colspan="3" align="center" bgcolor="#336699" height="25"><font color="#FFFFFF"><b>Curriculum Central</b></font></td>
				</tr>
				<tr>
					<td colspan="3" height="20">&nbsp;</td>
				</tr>
				<tr>
					<td width="05%">&nbsp;</td>
					<td width="30%" class="textblackTH">User ID:</td>
					<td width="65%"><input name="user" class="input" value="" type="text" tabindex="0"></td>
				</tr>
				<tr>
					<td width="05%">&nbsp;</td>
					<td class="textblackTH">Password:</td>
					<td><input name="userpw" class="input" value="" type="password" tabindex="1"></td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="submit" value="Submit" name="B1" style="border: 1px solid #336699" tabindex="2">
						<input type="reset" value="Reset" name="B2" style="border: 1px solid #336699" tabindex="3">
					</td>
				</tr>
			</table>
		</form>
	</center>
</div>

</body>

</html>

