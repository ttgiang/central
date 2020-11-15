<%@ page import="java.util.*, java.io.*" %>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	syly.jsp	- display course syllabus
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	try{
		String campus = website.getRequestParameter(request,"aseCampus","",true);
		String user = website.getRequestParameter(request,"aseUserName","",true);
		int sid = website.getRequestParameter(request,"sid",0);

		if (sid == 0){
			out.println( "Unable to produce requested syllabus" );
		}
		else{
			out.println(SyllabusDB.writeSyllabus(conn,sid,campus,user));
		}

	}
	catch( Exception e ){
		out.println( e.toString() );
	}

	asePool.freeConnection(conn);
%>