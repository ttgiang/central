<%
	/**
	*	ASE
	*	lgn.jsp
	*	2007.09.01	log out
	**/

	String errorMessage = "";
	Cookie cookies[] = request.getCookies();
	String cookieUserName = "";
	String cookieUserCampus = "";

	boolean processPage = true;

	//
	// how many times have we tried to access CC?
	//
	int aseAuthenticationAttempts = 0;

	try{
		aseAuthenticationAttempts = (Integer)session.getAttribute("aseAuthenticationAttempts");
	}
	catch(Exception e){
		aseAuthenticationAttempts = 0;
	}

	if(aseAuthenticationAttempts > 2){
		processPage = false;
	}

	//
	// login message?
	//
	String loginMessage = (String)session.getAttribute("aseApplicationMessage");
	if(loginMessage != null && loginMessage.length() > 0){
		loginMessage = "<img src=\"../images/err_alert.gif\" border=\"\">&nbsp;" + loginMessage;
	}
	else{
		loginMessage = "";
	}

 %>
<html>

<head>
<title>Curriculum Central</title>
	<link rel="stylesheet" type="text/css" href="../inc/style.css">
	<script language="JavaScript" src="js/li.js"></script>
</head>

<body background="../images/background.gif" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

<table border="0" width="100%" id="table1" height="100%">
	<tr>
		<td height="20%">&nbsp;</td>
	</tr>

	<%
		if(processPage){
	%>
			<tr>
				<td height="55%" valign="top" align="center">
					<form method="post" name="aseForm" action="li.jsp">
						<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-style: solid; border-width: 1" bordercolor="#336699" width="40%" height="280">
							<tr>
								<td align="left" bgcolor="#336699" style="color: #FFFFFF" colspan="4">&nbsp;&nbsp;<b><font size="4">Curriculum Central</font></b></td>
							</tr>
							<tr>
								<td align="center" width="25%" rowspan="7" style="color:#336699; border-left-width: 1px; border-right-style: solid; border-right-width: 1px; border-top-width: 1px; border-bottom-width: 1px">
									<img src="../images/logos/logo<%=cookieUserCampus%>.jpg" border="0" width="70" height="68" alt="<%=cookieUserCampus%>" />
								</td>
								<td align="center" class="loginerror" colspan="3"></td>
							</tr>
							<tr>
								<td height="40" align="center" colspan="3"><img src="images/lock.gif" border="0" alt="Secure Access Login">&nbsp;<font class="login">Secure Access Login</font></td>
							</tr>
							<tr>
								<td height="40" align="center" colspan="3"><font color="red"><%=loginMessage%></font></td>
							</tr>
							<tr>
								<td width="5%" height="30" colspan="3" align="center">
									<font color="red"><%=errorMessage%></font>
									<a href="/centraldocs/docs/help/V_AboveLoginScreen.swf" target="_blank"><img src="../images/vol.gif" border="0" alt="login help" title="login help"></a>
								</td>
							</tr>
							<tr>
								<td width="5%" height="30">&nbsp;</td>
								<td width="25%" class="login" height="30">UH Username:</td>
								<td height="30"><input name="user" class="logininput" value="" type="text"></td>
							</tr>
							<tr>
								<td width="5%">&nbsp;</td>
								<td width="25%" class="login">UH Password:</td>
								<td><input name="userpw" class="logininput" value="" type="password"></td>
							</tr>
							<tr>
								<td colspan="3">
									<p align="center">
									<input type="hidden" name="formName" value="aseForm">
									<input type="hidden" name="formAction" value="Login">
									<input type="submit" value="Log In" name="cmdSubmit" class="inputsmallgraybold" onClick="return checkForm();">
									</p>
								</td>
							</tr>
							<tr>
								<td align="left" bgcolor="#336699" style="color: #FFFFFF" colspan="4">
									<font size="1">
									Unauthorized access is prohibited by law in accordance with <a href="http://www.hawaii.edu/infotech/policies/HRS_0708-0895.html" target="_blank" class="copyright">Chapter
									708, Hawaii Revised Statutes</a>; all use is subject to <a href="http://www.hawaii.edu/infotech/policies/itpolicy.html" target="_blank" class="copyright">University of
									Hawaii Executive Policy E2.210.</a></font>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
	<%
		}
		else{
	%>
			<tr>
				<td height="55%" valign="top" align="center">
					<form method="post" name="aseForm" action="li.jsp">
						<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-style: solid; border-width: 1" bordercolor="#336699" width="40%" height="280">
							<tr>
								<td align="left" bgcolor="#336699" style="color: #FFFFFF" colspan="4">&nbsp;&nbsp;<b><font size="4">Curriculum Central</font></b></td>
							</tr>
							<tr>
								<td align="center" width="25%" rowspan="7" style="color:#336699; border-left-width: 1px; border-right-style: solid; border-right-width: 1px; border-top-width: 1px; border-bottom-width: 1px">
									<img src="../images/logos/logo<%=cookieUserCampus%>.jpg" border="0" width="70" height="68" alt="<%=cookieUserCampus%>" />
								</td>
								<td align="center" class="loginerror" colspan="3"></td>
							</tr>
							<tr><td height="40" align="center" colspan="3">&nbsp;</td></tr>
							<tr><td height="40" align="center" colspan="3">&nbsp;</td></tr>
							<tr>
								<td height="40" align="left" colspan="3">
									Curriculum Central (CC) was not able to authenticate your credentials and after 3 failed attempts,
									we have suspended the login page temporarily.<br><br>You may try again in 60 minutes.
								</td>
							</tr>
							<tr><td height="40" align="center" colspan="3">&nbsp;</td></tr>
							<tr><td height="40" align="center" colspan="3">&nbsp;</td></tr>
							<tr><td height="40" align="center" colspan="3">&nbsp;</td></tr>
							<tr>
								<td align="left" bgcolor="#336699" style="color: #FFFFFF" colspan="4">
									<font size="1">
									Unauthorized access is prohibited by law in accordance with <a href="http://www.hawaii.edu/infotech/policies/HRS_0708-0895.html" target="_blank" class="copyright">Chapter
									708, Hawaii Revised Statutes</a>; all use is subject to <a href="http://www.hawaii.edu/infotech/policies/itpolicy.html" target="_blank" class="copyright">University of
									Hawaii Executive Policy E2.210.</a></font>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
	<%
		}
	%>

	<tr>
		<td height="25%" valign="bottom">
			<%
				int yearFooter = 0;

				try{
					java.util.Date todayFooter = new java.util.Date();
					java.sql.Date dateFooter = new java.sql.Date(todayFooter.getTime());
					java.util.GregorianCalendar calFooter = new java.util.GregorianCalendar();
					calFooter.setTime(dateFooter);
					yearFooter = calFooter.get(java.util.Calendar.YEAR);
				}
				catch(Exception z){
				}
			%>
			<p class="copyright" align="center">Copyright &copy; 1997-<%=yearFooter%>. All rights reserved</p><br/>
		</td>
	</tr>
</table>
</body>

<script language="JavaScript" type="text/javascript">
<!--
	document.aseForm.user.focus();
//-->
</script>

</html>
