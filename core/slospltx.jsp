<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	slospltx.jsp - split slo
	*	2007.09.01
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crsassr";
	String pageTitle = "Edit Outline SLO";
	fieldsetTitle = pageTitle;

	String message = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String type = website.getRequestParameter(request,"type");
	String kix = website.getRequestParameter(request,"kix");

	String comp = website.getRequestParameter(request,"comp", "");
	int compID = website.getRequestParameter(request,"compID", 0);

	if (!"".equals(comp.trim())){
		/*
			on successful add, create the accjc entry using the code returned from
			adding the slo
		*/
		boolean debug = false;
		if (debug==false){
			msg = CompDB.addRemoveCourseComp(conn,"a",campus,alpha,num,comp,compID,user,kix);
			if (!"Exception".equals(msg.getMsg())){
				compID = msg.getCode();
				msg = CourseACCJCDB.courseACCJC(conn,"a",user,campus,alpha,num,type,0,compID,0);
				message = "Operation completed successfully";
			}
			else
				message = "Unable to complete requested operation";
		}
		else{
			out.println("kix: " + kix + "<br/>");
			out.println("type: " + type + "<br/>");
		}

	}

	asePool.freeConnection(conn);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header3.jsp" %>

<p align="center"><%=message%></p>
<p align="center">
<a href="/central/core/slosplt.jsp?kix=<%=kix%>" class="linkcolumn">return to previous page</a>&nbsp;&nbsp;|&nbsp;
<a href="/central/core/crsslo.jsp?cps=<%=campus%>&kix=<%=kix%>" class="linkcolumn">return to assessment</a>
</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
