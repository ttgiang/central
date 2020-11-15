<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ include file="../inc/db.jsp" %>

<%
// cas-demo.jsp - Demo of using the Web Login Service with JSPs
//              - 08/21/08, russ@hawaii.edu
//              - Copyright (c) University of Hawaii 2008
//                All rights reserved.
//              - See the end of this file for the LICENSE
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../inc/style.css">
  <title>Curriculum Central</title>
</head>

<body background="../images/background.gif" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
  <%@ include file="casx.jsp" %>
  <%
  		boolean DEBUG = false;

  		// root
		StringBuffer buf = request.getRequestURL();
		String central = buf.toString();
		if (central.lastIndexOf("/") > 0){
			int pos = central.lastIndexOf("/");
			central = central.substring(0,pos+1);
		}

		String errorMessage = "";
		Cookie cookies[] = request.getCookies();
		String cookieUserName = "";
		String cookieUserCampus = "";
		ServletContext context = getServletContext();

		//  For this demo, we are the front page and inside  protected page.
		//  The service URL is the inside page but URL-encoded.
		String insidePage = central + "tasks.jsp";
		String logOffPage = central + "lo.jsp";

//final String loginLink  = casUrl + "/login?service=" + serviceURL;
//final String logoutLink = frontPage + "?logout";

		String frontPage  = request.getRequestURL().toString();
		String serviceURL = URLEncoder.encode(frontPage);

		String webLogin;
		String loginLink;

		if (DEBUG){
			webLogin = central + "cas2.jsp";
			loginLink = webLogin + "?service=" + serviceURL;
		}
		else{
			webLogin = "https://login.its.hawaii.edu/cas";
webLogin = "https://cas-test.its.hawaii.edu/cas";
			loginLink = webLogin + "/login?service=" + serviceURL;
		}

		String netId = doWebLogin(conn,request,response,context,webLogin,insidePage,serviceURL);

		String logoff = request.getParameter("logoff");

		asePool.freeConnection(conn,"cas",netId);

		if (logoff != null) {
			session.invalidate();
			response.sendRedirect(logOffPage);
			return;  // bail here or get weird results
		}
		else{
			if (netId == null) {
				%>
					<table border="0" width="100%" id="table1" height="100%">
						<tr>
							<td height="20%">&nbsp;</td>
						</tr>
						<tr>
							<td height="55%" valign="top" align="center">
								<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; border-style: solid; border-width: 1" bordercolor="#336699" width="40%" height="280">
									<tr>
										<td align="center" bgcolor="#336699" style="color: #FFFFFF">&nbsp;&nbsp;<b><font size="4">Curriculum Central</font></b></td>
									</tr>
									<tr>
										<td align="center" style="color:#336699; border-left-width: 1px; border-right-style: solid; border-right-width: 1px; border-top-width: 1px; border-bottom-width: 1px">
											<img src="../images/logos/logo<%=cookieUserCampus%>.jpg" border="0" width="70" height="68" alt="<%=cookieUserCampus%>" />
											<p align="center">
												<img src="images/lock.gif" border="0" alt="Secure Access Login">&nbsp;
												<a href="<%=loginLink%>"><font class="login">Secure Access Login</font></a>
											</p>
										</td>
									</tr>
									<tr>
										<td align="left" bgcolor="#336699" style="color: #FFFFFF">
											<table border="0" width="100%">
												<tr>
													<td width="02%">&nbsp</td>
													<td>
														<font size="1">
														Unauthorized access is prohibited by law in accordance with <a href="http://www.hawaii.edu/infotech/policies/HRS_0708-0895.html" target="_blank" class="copyright">Chapter
														708, Hawaii Revised Statutes</a>; all use is subject to <a href="http://www.hawaii.edu/infotech/policies/itpolicy.html" target="_blank" class="copyright">University of
														Hawaii Executive Policy E2.210.</a></font>
														<!--
														<br/><br/>
														<p align="center">
														<a href="https://myuh.hawaii.edu:8888/am-get-account" target="_blank" onmouseover="window.status=''; return true;" class="copyright"><font class="copyright">Get a UH username</font></a><br/>
														<a href="https://myuh.hawaii.edu:8888/am-get-account" target="_blank" onmouseover="window.status=''; return true;" class="copyright"><font class="copyright">Forgot my password</font></a><br/>
														<a href="http://www.hawaii.edu/askus/725" target="_blank" class="copyright"><font class="copyright">Having problems logging in?</font></a>
														</p>
														-->
													</td>
													<td width="02%">&nbsp</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
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
				<%
			}
			else {
				response.sendRedirect(insidePage);
			} // if netId
		}	// if logoff

	%>
  </body>
</html>
