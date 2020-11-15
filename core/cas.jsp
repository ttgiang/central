<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>

<%@ include file="../inc/db.jsp" %>

<%
// cas-demo.jsp - Demo of using the Web Login Service with JSPs
//              - 08/21/08, russ@hawaii.edu
//              - Copyright (c) University of Hawaii 2008
//                All rights reserved.
//              - See the end of this file for the LICENSE
%>

<%@ include file="casx.jsp" %>
<%
	boolean DEBUG = false;

	//final String casUrl = "https://cas-test.its.hawaii.edu/cas";
	//final String insidePage = "http://cctest.its.hawaii.edu:8080/central/core/cas_index.jsp";
	//final String serviceURL = URLEncoder.encode(insidePage, "UTF-8");
	//final String frontPage  = request.getRequestURL().toString();
	//doCasLogin(request, response, casUrl, frontPage, insidePage, conn, context);
	// webLogin = casUrl

	// https://cas-test.its.hawaii.edu/cas/login?service=http%3A%2F%2Fcctest.its.hawaii.edu%3A8080%2Fcasjspdemo%2Findex.jsp
	// http://cctest.its.hawaii.edu:8080/casjspdemo/index.jsp?logout

	// https://cas-test.its.hawaii.edu/cas/login?service=http%3A%2F%2Fcctest.its.hawaii.edu%3A8080%2Fcentral%2Fcore%2Fcas.jsp
	// http://cctest.its.hawaii.edu:8080/central/core/cas.jsp?logout


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

	// old -->String insidePage = central + "tasks.jsp";
	// new --> String insidePage = central + "cas_index.jsp";

	//
	// the older service didn't have problems with inside and front page being differeint.
	// the new service threw exceptions
	// ticket 'ST-920-ed0fgIjQbZKLVKEDsdts-cas' does not match supplied service.
	//			The original service was 'http://cctest.its.hawaii.edu:8080/central/core/cas_index.jsp'
	//			and
	//			the supplied service was 'http://cctest.its.hawaii.edu:8080/central/core/tasks.jsp'.
	//

	String insidePage = central + "cas.jsp";
	String frontPage  = request.getRequestURL().toString();
	String logOffPage = central + "lo.jsp";
	String serviceURL = URLEncoder.encode(frontPage);

	// String webLogin = "https://login.its.hawaii.edu/cas";	(CAS2)
	// String webLogin = "https://authn.hawaii.edu/cas/";		(CAS3)
	String webLogin = "https://cas-test.its.hawaii.edu/cas";
	String loginLink = webLogin + "/login?service=" + serviceURL;

	String uid = "";

	//
	// request to logoff?
	// Handle logout, if requested.
	//
	// this logout code is for headerx.jps logout - option 2
	// logout - option 1 takes us to lo.jsp
	//
	String logout = request.getParameter("logout");
	if (logout != null) {
		uid = (String)session.getAttribute("uid");
		asePool.freeConnection(conn,"cas - logout ",uid);
		doCasLogout(request, response, webLogin + "/logout");
		return;
	}

	//
	// get user's network id. this is only possible if CAS passes
	//
	uid = (String)session.getAttribute("uid");
	doCasLogin(request, response, webLogin, frontPage, insidePage, conn, context);

	//
	// release connection
	//
	asePool.freeConnection(conn,"cas",uid);

	//
	// login page or front page
	//
	if (uid != null && !uid.equals("")) {
		String frontPagex = (String)session.getAttribute("frontPagex");
		if (frontPagex == null || frontPagex == "") {
			frontPagex = "tasks.jsp";
		}
		try{
			response.sendRedirect(frontPagex);
			return;
		}
		catch(Exception e){
			//response.sendRedirect(frontPagex);
		}
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="../inc/style.css">
  <title>Curriculum Central</title>
</head>

	<body background="../images/background.gif" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
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
  </body>
</html>