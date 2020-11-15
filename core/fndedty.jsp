<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndedty.jsp
	*	2013.12.18	create the html for foundation course
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String kix = website.getRequestParameter(request,"kix","");

	if(kix != null && !kix.equals("")){
		com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();
		fnd.createFoundation(campus,user,kix);
		fnd = null;
	}

	response.sendRedirect("fndvwedit.jsp");

%>
