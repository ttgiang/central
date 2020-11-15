<%@ include file="ase.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page errorPage="exception.jsp" %>
<%@ page import="java.net.URLEncoder" %>

<jsp:useBean id="kookie" scope="application" class="com.ase.aseutil.CookieManager" />

<%
	/**
	*	ASE
	*	lo.jsp
	*	2007.09.01	log out
	**/

	String pageTitle = "Log Out";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String aseServer = (String)session.getAttribute("aseServer");

	aseUtil.logAction(conn,
							user,
							"LOGOUT",
							"Log out",
							session.getId(),
							Constant.BLANK,
							campus,
							Constant.BLANK);

	JSIDDB.endJSID(conn,session.getId(),campus,user);

	log.turnOff();

	HashMap sessionMap = new HashMap();
	sessionMap = (HashMap)session.getAttribute("aseSessionMap");
	sessionMap.clear();
	session.setAttribute("aseSessionMap", null);
	session.setAttribute("aseScheduledJobs", null);

	session.setAttribute("aseApplicationMessage", "You have been logged out of Curriculum Central.");
	session.setAttribute("aseUserName", null);

 %>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/headerli.jsp" %>

<%
	session.removeAttribute("CC_User");
	session.removeAttribute("CC_Campus");

 	session.invalidate();

	kookie.setCookie(response,"CC_User",null,0);
	kookie.invalidateCookie(request,response,"CC_User");
	kookie.setCookie(response,"CC_Campus",null,0);
	kookie.invalidateCookie(request,response,"CC_Campus");

	request.getSession().setAttribute("CC_User", null);
	request.getSession().setAttribute("CC_Campus", null);
	request.getSession().invalidate();

	asePool.freeConnection(conn,"lo",user);
%>

Your session has ended.<br><br>
Click <a href="https://login.its.hawaii.edu/cas/logout?service=http://<%=aseServer%>:8080/central/core/cas.jsp">here</a> to return to Curriculum Central.
<%@ include file="../inc/footerli.jsp" %>
</body>
</html>

