<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%
		String alpha = "ICS";
		String num = "241";
		String campus = "LEECC";
		String user = "THANHG";

		out.println(CourseACCJCDB.getACCJCID(conn,campus,alpha,num,"PRE",21,40,2));

%>