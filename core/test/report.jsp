<%
	String pageTitle = "Reports";
%>
<!-
	@author	ase
	@version	1.0
!>

<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<html>
<head>
	<link rel=stylesheet href="../inc/style.css" type="text/css">
	<title><%=session.getAttribute("applicationTitle")%>: <%=pageTitle%></title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body topmargin="0" leftmargin="0">
<table align="center" width="100%" height="100%" border="0">
  <tr height="25%">
    <td>
      <tags:Header backColor="#C0C0C0" title="Learning JSP" image="images/cc4b.gif" />
    </td>
  </tr>
  <tr height="65%" valign="top">
		<td valign="top" >
			<table width="100%" height="100%" border="0">
				<tr>
					<td valign="top">
					<!-- BODY GOES HERE -->
						<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" valign="top" width="100%">
									<table border="0" width="100%" cellspacing="4" cellpadding="0">
									  <tr><td colspan="3" width="100%">&nbsp;</td></tr>
									  <tr>
										 <td width="33%">&nbsp;</td>
										 <td width="34%">
											<ul>
												<li><a href="rptcourse.asp" class="SiteLink">Courses Progress Report</a></li>
												<li><a href="rptcrsslo.asp" class="SiteLink">Course SLO Progress Report</a></li>
											</ul>
										 </td>
										 <td width="33%">&nbsp;</td>
									  </tr>
									  <tr>
										 <td colspan="3" width="100%" align="center" class="smalltext10"><br>
											<a class="SiteLink" href="stuff.asp?script=crs">log in</a>&nbsp;|&nbsp;<a class="SiteLink" href="index.htm">main menu</a>
										 </td>
									  </tr>
									  <tr><td colspan="3" width="100%">&nbsp;</td></tr>
									</table>
								</td>
							</tr>
						</table>
					<!-- BODY GOES HERE -->
					</td>
				</tr>
			</table>
		</td>
  <tr height="05%" valign="bottom">
    <td>
      <tags:Footer backColor="#C0C0C0"/>
    </td>
  </tr>
</table>
</body>
</html>
