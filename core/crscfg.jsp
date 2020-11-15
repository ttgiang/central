<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<%
	/**
	*	ASE
	*	crscfg.jsp 	display configurable item
	*	2007.09.01
	**/

	String pageTitle = "Curriculum Central (CC) Configurable Item";
	String fieldsetTitle = pageTitle;
	String aseConfigMessage = (String)session.getAttribute("aseConfigMessage");
%>

<title>Curriculum Central: Course Questions</title>
<link rel="stylesheet" type="text/css" href="/central/inc/style.css">
<link rel="stylesheet" type="text/css" href="/central/inc/site.css" />
	<%@ include file="ase2.jsp" %>
</head>
<%@ include file="../inc/header3.jsp" %>

<body topmargin="0" leftmargin="0">
<table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
	<tbody>
		<tr>
			<td bgcolor="#ffffff" valign="top" height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					<tr>
						<td class="intd" height="90%" align="center" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="" valign="top">
										<!-- PAGE CONTENT GOES HERE -->
										The form you're on contains configurable items. Such items can be modified by editing system values.
										<br><br>
										<font class="datacolumn"><%=aseConfigMessage%></font>
										<br><br>
										Utilities > System Settings > System
										<br><br>
										<!-- PAGE CONTENT ENDS HERE -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</tbody>
</table>

</body>
</html>