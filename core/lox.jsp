<%@ page import="java.sql.*"%>
<%@ page import="com.ase.aseutil.*"%>

<%
	//AsePool.killInstance();

	session.removeAttribute("CC_User");
	session.removeAttribute("CC_Campus");
 	session.invalidate();
	request.getSession().setAttribute("CC_User", null);
	request.getSession().setAttribute("CC_Campus", null);
	request.getSession().invalidate();
%>
