<%@ page import="java.util.*, java.io.*, javax.mail.internet.*" %>

<%@ include file="ase.jsp" %>

<%

	try{
		SyllabusDB syl = new SyllabusDB();
		out.println( syl.writeSyllabus(conn,10,"LEECC") );
	}
	catch( Exception e ){
		out.println( e.toString() );
	}

%>