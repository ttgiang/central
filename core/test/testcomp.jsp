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

	out.println("Start<br>");

	out.println("<br>---------------------------------------------getComp<br>");
	out.println(CompDB.getComp(conn,alpha,num,compid,campus));
	out.println("<br>---------------------------------------------getCompByID<br>");
	out.println(CompDB.getCompByID(conn,50,"X50"));
	out.println("<br>---------------------------------------------getComps<br>");
	out.println(CompDB.getComps(conn,alpha,num,campus));
	out.println("<br>---------------------------------------------getCompsByKix<br>");
	out.println(CompDB.getCompsByKix(conn,kix));
	out.println("<br>---------------------------------------------getCompsAsHTMLOptions<br>");
	out.println(CompDB.getCompsAsHTMLOptions(conn,alpha,num,campus,type));
	out.println("<br>---------------------------------------------getCompsAsHTMLOptionsByKix<br>");
	out.println(CompDB.getCompsAsHTMLOptionsByKix(conn,kix));
	out.println("<br>---------------------------------------------getCompsToReview<br>");
	out.println(CompDB.getCompsToReview(conn,alpha,num,campus,type,user,"","",true));
	out.println("<br>---------------------------------------------getCompsByType<br>");
	out.println(CompDB.getCompsByType(conn,alpha,num,campus,type,user,"","",true,"","X18"));
	out.println("<br>---------------------------------------------getCompsByTypeX<br>");
	out.println(CompDB.getCompsByTypeX(conn,alpha,num,campus,type));
	out.println("<br>---------------------------------------------getCompsAsHTMLList<br>");
	out.println(CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,hid,true,"X18"));
	out.println("<br>---------------------------------------------getCompsByID<br>");
	out.println(CompDB.getCompsByID(conn,campus,"50"));
	out.println("<br>---------------------------------------------getCompsByAlphaNum<br>");
	out.println(CompDB.getCompsByAlphaNum(conn,campus,alpha,num,"4"));
	out.println("<br>---------------------------------------------getCompsByAlphaNumID<br>");
	out.println(CompDB.getCompsByAlphaNumID(conn,alpha,num,campus,"50"));
	out.println("<br>---------------------------------------------getCompsByTypeCampusID<br>");
	out.println(CompDB.getCompsByTypeCampusID(conn,campus,"50"));
	out.println("<br>---------------------------------------------setCompApproval<br>");
	out.println(CompDB.setCompApproval(conn,campus,alpha,num,type,"","",user,50));
	out.println("<br>---------------------------------------------hasSLOsToReview<br>");
	out.println(CompDB.hasSLOsToReview(conn,kix));
	out.println("<br>---------------------------------------------addRemoveCourseComp<br>");
	out.println(CompDB.addRemoveCourseComp(conn,"a",campus,alpha,num,"",50,user,kix));
	out.println("<br>---------------------------------------------isCompAdded<br>");
	out.println(CompDB.isCompAdded(conn,campus,alpha,num,"50"));
	out.println("<br>---------------------------------------------isCompAdded<br>");
	out.println(CompDB.isCompAdded(conn,kix));
	out.println("<br>---------------------------------------------getNextCompID<br>");
	out.println(CompDB.getNextCompID(conn));
	out.println("<br>---------------------------------------------getObjectives<br>");
	out.println(CompDB.getObjectives(conn,kix));
	out.println("<br>---------------------------------------------<br>");
	out.println("End<br>");

	asePool.freeConnection(conn);
%>

