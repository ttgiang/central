<%@ include file="ase.jsp" %>
<%@ page import="org.owasp.validator.html.*"%>

<%
	/**
	*	ASE
	*	expandx.jsp
	*	2007.09.01	course edit
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
	String col = website.getRequestParameter(request,"col","");
	String dta = website.getRequestParameter(request,"dta","");

	String message = "OK";

	if (processPage && !kix.equals(Constant.BLANK) && !col.equals(Constant.BLANK)){
		dta = AntiSpamy.spamy(kix,col,dta);
		courseDB.setCourseItem(conn,kix,col,dta,"s");
	}
	else{
		message = "ERROR";
	}

	asePool.freeConnection(conn,"expandx",user);

	org.json.simple.JSONObject json = new org.json.simple.JSONObject();
	json.put("result",message);
	String gson = new com.google.gson.Gson().toJson(json);
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(gson);

%>

