<%
	response.setDateHeader("Expires", 0); // date in the past
	response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	response.addHeader("Pragma", "no-cache"); // HTTP/1.0
	Locale locale = Locale.getDefault();
	response.setLocale(locale);
	session.setMaxInactiveInterval(30*60);
%>

<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	notified.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String user = Util.getSessionMappedKey(session,"aseUserName");
	String div = website.getRequestParameter(request,"div","");

	if (processPage && div != null && div.length()>0){
		String[] divs = div.replace("notified_id_","").split("_");
		if (divs.length==2){
			int fid = NumericUtil.stringToInt(divs[0]);
			int mid = NumericUtil.stringToInt(divs[1]);
			ForumDB.setNotified(conn,fid,mid,Constant.OFF);
		}
	}

	asePool.freeConnection(conn,"notified",user);
%>

