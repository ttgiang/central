<%
	/**
	*	ASE
	*	cas-handler.jsp - see bottom of page for more information.
	**/
%>

<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="edu.yale.its.tp.cas.client.ServiceTicketValidator" %>
<%@ page import="org.xml.sax.SAXException" %>
<%@ page import="javax.xml.parsers.ParserConfigurationException" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.IOException" %>

<%@ include file="../inc/db.jsp" %>

<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page errorPage="exception.jsp" %>

<%

	String frontPage  = request.getRequestURL().toString();

	String serviceURL = URLEncoder.encode(frontPage);

	String webLogin = "https://login.its.hawaii.edu/cas";

	String netId = doWebLogin(conn,request,webLogin,serviceURL);

	out.println(netId);
%>

<%!

/*
 *	doWebLogin
 *
 *	Return a netId (a.k.a., username); null if not logged in or
 *	can't validate the service ticket from the Web Login Service.
*/
protected String doWebLogin(Connection conn,HttpServletRequest req,String weblogin,String serviceURL)
	throws IOException, SAXException, ParserConfigurationException {

	HttpSession sess = req.getSession();

	String validateURL = weblogin + "/serviceValidate";
	String netId = (String)sess.getAttribute("netId");

	try{
		String ticket = req.getParameter("ticket");
		if (ticket == null){
			ticket = (String)sess.getAttribute("aseCASTicket");
		}

		if (ticket != null) {
			sess.setAttribute("aseCASTicket",ticket);
			ServiceTicketValidator validator = new ServiceTicketValidator();
			validator.setCasValidateUrl(validateURL);
			validator.setService(serviceURL);
			validator.setServiceTicket(ticket);
			validator.validate();
			if (validator.isAuthenticationSuccesful()) {
				netId = validator.getUser();
				sess.setAttribute("netId", netId);
			}
		}
		else{
			netId = null;
		} // ticket != null
	}
	catch(Exception e){
		netId = null;
	}

	return netId;
}

%>