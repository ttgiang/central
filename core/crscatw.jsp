<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscatw.jsp	course catalog  (does not need alpha selection)
	*	TODO: Need to complete this
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crscat");

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Course Catalog";
	fieldsetTitle = "Course Catalog";

	String alpha = website.getRequestParameter(request,"aseList");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscat.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		try{
			String kix = helper.getKix(conn,campus,"ENG","100","CUR");;
			out.println(CourseFieldsDB.getCatalogDesigner(conn,kix));
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	} // processPage

	asePool.freeConnection(conn,"crscatw",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
