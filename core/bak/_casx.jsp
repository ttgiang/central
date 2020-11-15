<%
	/**
	*	ASE
	*	cas-handler.jsp - see bottom of page for more information.
	**/
%>

<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="org.jasig.cas.client.validation.TicketValidator" %>
<%@ page import="org.jasig.cas.client.validation.Cas20ServiceTicketValidator" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>
<%@ page import="org.jasig.cas.client.validation.Assertion" %>
<%@ page import="java.net.URLEncoder" %>

<%@ page import="org.xml.sax.SAXException" %>
<%@ page import="javax.xml.parsers.ParserConfigurationException" %>
<%@ page import="java.io.IOException" %>

<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page errorPage="exception.jsp" %>

<%!

/*
 *	doWebLogin
 *
 *	Return a netId (a.k.a., username); null if not logged in or
 *	can't validate the service ticket from the Web Login Service.
*/
protected String doWebLogin(Connection conn,
									HttpServletRequest req,
									HttpServletResponse res,
									ServletContext context,
									String weblogin,
									String frontPage,
									String serviceURL) throws IOException, SAXException, ParserConfigurationException {

	String validateURL = weblogin + "/serviceValidate";

	HttpSession sess = req.getSession();

	String sessionId = sess.getId();

	sess.setAttribute("aseApplicationMessage", "");

	String netId = (String)sess.getAttribute("netId");

	// if there's a service ticket, try to validate it.

	try{
		String ticket = req.getParameter("ticket");
		if (ticket != null) {
			TicketValidator validator = new Cas20ServiceTicketValidator(weblogin);
			Assertion assertion = validator.validate(ticket, frontPage);
			AttributePrincipal principal = assertion.getPrincipal();
			String uid = principal.getName();
			sess.setAttribute("netId", uid);
			frontPage = authenticateUser(req,res,conn,context,netId);
			res.sendRedirect(frontPage);
			return netId;
		} // ticket != null
	}
	catch(Exception e){
		System.out.println("CasX - " + e.toString());
		frontPage = authenticateUser(req,res,conn,context,netId);
		res.sendRedirect(frontPage);
		return null;
	}

	return netId;
}

protected String doWebLoginOld(Connection conn,
									HttpServletRequest req,
									HttpServletResponse res,
									ServletContext context,
									String weblogin,
									String frontPage,
									String serviceURL) throws IOException, SAXException, ParserConfigurationException {

	String validateURL = weblogin + "/serviceValidate";

	HttpSession sess = req.getSession();

	String sessionId = sess.getId();

	sess.setAttribute("aseApplicationMessage", "");

	String netId = (String)sess.getAttribute("netId");

	// if there's a service ticket, try to validate it.

	/*

	try{
		String ticket = req.getParameter("ticket");
		if (ticket != null) {
			ServiceTicketValidator validator = new ServiceTicketValidator();
			validator.setCasValidateUrl(validateURL);
			validator.setService(serviceURL);
			validator.setServiceTicket(ticket);
			validator.validate();
			if (validator.isAuthenticationSuccesful()) {
				netId = validator.getUser();
				sess.setAttribute("netId", netId);
				frontPage = authenticateUser(req,res,conn,context,netId);
				res.sendRedirect(frontPage);
				return null;
			}	// validator
		} // ticket != null
	}
	catch(Exception e){
		System.out.println("CasX - " + e.toString());
		frontPage = authenticateUser(req,res,conn,context,netId);
		res.sendRedirect(frontPage);
		return null;
	}

	*/

	return netId;
} // doWebLoginOld

/*
 *	authenticateUser
 *
 *	upong returning from the web service with a valid ticket,
 * we must check to see if this person has an account to CC and if
 * she does, is it active?
 *
 * if active, determine if there are tasks. If yes, show tasks,
 * else show news.
 *
 * if inactive, display not allowed message
*/
public String authenticateUser(HttpServletRequest req,
									HttpServletResponse res,
									Connection conn,
									ServletContext context,
									String netId){
	Msg msg;
	String user = "";
	String campus = "";
	String frontPage = "";
	String central = "";
	String dataType = "";
	String dept = "";
	String div = "";
	String check = "0";
	HttpSession session = req.getSession();
	String sessionId = session.getId();

	try{
		msg = UserDB.authenticateUserX(conn,netId,req,res,context,sessionId);
		if ("Exception".equals(msg.getMsg())) {
			frontPage = central + "denied.jsp";
		}
		else if ("InactiveAccount".equals(msg.getMsg())){
			frontPage = central + "inactive.jsp";
		}
		else{
			campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			if (campus!=null && campus.length()>0){
				session.setAttribute("aseCampusName",CampusDB.getCampusNameOkina(conn,campus));

				dataType = (String)session.getAttribute("aseDataType");
				dept = (String)session.getAttribute("aseDept");
				div = (String)session.getAttribute("aseDivision");

				if (!div.equals(Constant.BLANK) && !dept.equals(Constant.BLANK)){
					central = getRoot(req.getRequestURL().toString());

					long taskCount = TaskDB.countUserTasks(conn,user);
					String startPage = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","StartPage");
					if (startPage != null && "tasks".equals(startPage) && taskCount > 0 )
						frontPage = central + "tasks.jsp";
					else
						frontPage = central + "index.jsp";

					Cookie cookie;
					cookie = new Cookie ("CC_User", user);
					res.addCookie(cookie);

					session.setAttribute("aseBGColor", campus);
					cookie = new Cookie ("CC_Campus", campus);
					res.addCookie(cookie);

					Cron cron = new Cron(conn,session,dataType);
					TaskDB.createAdjustment(campus,user);
				}
				else{
					frontPage = central + "usrprfl.jsp?lid=" + user;
				}

			} // valid campus?
		}
	}
	catch( Exception ex ){
		//System.out.println(ex.toString());
	}

	return frontPage;
}

/*
 *	getRoot
 *
 * given the current URL, determine the root folder
 * use this to get the user to the desired page.
 *
 * this is to avoid hard coding the entire link.
*/
public String getRoot(String url){

	String root = url;
	if (root.lastIndexOf("/") > 0){
		int pos = root.lastIndexOf("/");
		root = root.substring(0,pos+1);
	}

	return root;
}

%>

<%
// cas-handler.jsp - functions for using the CAS Client library to login
//                   users via the Web Login Service.
//                 - 08/21/08, russ@hawaii.edu
//                 - Copyright (c) University of Hawaii 2008
//                   All rights reserved.
//                 - See the end of this file for the LICENSE
//
//--------------------------------------------------------------------
//  Usage:
//    1. Include this file in your front page JSP.
//    2. Set up these URLS:
//       a. Front page - the advertised to users and they bookmark.
//       b. Inside page - where the application does all the work.
//       c. Service URL - the URL-encode form of the inside page.
//       d. Web Login Service - the one that authenticates users; not us.
//    3. Call the doWebLogin() method to get the netId (a.k.a., username)
//       of the user.  The Web Login Service is the only one to handle
//       the user's credentials.  We'll end with the netId if they
//       authenticate successfully with the Web Login Service.
//
//   Example JSP code:
//
//  String front    = request.getRequestURL().toString();
//  String inside   = request.getRequestURL().toString();
//  String service  = URLEncoder.encode(insidePage);
//  String weblogin = "https://russ.mgt.hawaii.edu:8443/cas";
//
//  String netId = doWebLogin(request, response, weblogin, front, service);
//
//--------------------------------------------------------------------
%>
