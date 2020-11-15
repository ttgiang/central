<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrqstrvw.jsp	- request outline review
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "crsrqstrvw";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	if (	(alpha==null || alpha.length()==0) &&
			(num==null || num.length()==0) &&
			(kix==null || kix.length()==0)){
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}
	else{
		session.setAttribute("aseAlpha", alpha);
		session.setAttribute("aseNum", num);

		session.setAttribute("aseModificationMode", "");
		session.setAttribute("aseWorkInProgress", "0");
		session.setAttribute("aseProgress", "REVIEW");

		response.sendRedirect("crsedt6.jsp?kix=" + kix);
	}

	asePool.freeConnection(conn);
%>