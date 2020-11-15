<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = "ICS";
	String num = "101";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String compid = "50";
	Comp comp = new Comp();
	String kix = "F52h22c9127";
	String hid = "F52h22c9127";
	int i = 0;

	Props prop = new Props(campus,"propname","propdescr","subject","content","cc",user);

	out.println("Start<br>");
	out.println("<br>---------------------------------------------deleteProp<br>");
	PropsDB.deleteProp(conn,1);
	out.println("<br>---------------------------------------------insertProp<br>");
	PropsDB.insertProp(conn,prop);
	out.println("<br>---------------------------------------------updateProp<br>");
	prop = new Props(3,campus,"propname","propdescr3","subject3","content3","cc3",user);
	PropsDB.updateProp(conn,prop);
	out.println("End<br>");

	asePool.freeConnection(conn);
%>

