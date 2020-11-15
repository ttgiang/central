<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnmx.jsp - rename
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String caller = "crsrnm";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	String thisPage = "crsrnm";
	session.setAttribute("aseThisPage",thisPage);

	int idx = website.getRequestParameter(request,"idx",0);
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String type = website.getRequestParameter(request,"type","");

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage){

		// if campus admin or faculty can rename/renumber

		String facultyCanRenameRenumber = Util.getSessionMappedKey(session,"FacultyCanRenameRenumber");

		if(	SQLUtil.isCampusAdmin(conn,user)
			|| SQLUtil.isSysAdmin(conn,user)
			|| facultyCanRenameRenumber.equals(Constant.ON)){

			out.println(helper.listOutlineForRename(conn,campus,"crsrnmxx",idx,type));

		}
		else{

			out.println("Rename/renumber is not permitted at this time.");

		}
		// rename is allowed

	}

	asePool.freeConnection(conn,"crsrnmx",user);
%>

</body>
</html>
