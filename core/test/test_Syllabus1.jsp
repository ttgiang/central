<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>

<%@ include file="ase.jsp" %>

<%

	try{
		String alpha = "ICS";
		String num = "218";
		String semester = "FALL";
		String year = "2008";
		String user = (String)session.getAttribute("aseUserName");
		String auditDate = null;

		Syllabus syllabus = new Syllabus("",alpha,num,semester,year,user,"textbook","objectives","grading",auditDate);
		out.println( syllabus );

		SyllabusDB.insertSyllabus(conn,syllabus);

		syllabus = new Syllabus("6",alpha,num,"WINTER",year,user,"textbook","objectives","grading",aseUtil.getCurrentDateString());
		SyllabusDB.updateSyllabus(conn,syllabus);

		SyllabusDB.deleteSyllabus(conn,"6");

	}
	catch( Exception e ){
		out.println( e.toString() );
	}

%>