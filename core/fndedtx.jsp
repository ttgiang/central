<%@ include file="ase.jsp" %>
<%@ page import="org.owasp.validator.html.*"%>

<%
	/**
	*	ASE
	*	fndedtx.jsp
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

	int id = website.getRequestParameter(request,"id",0);
	String col = website.getRequestParameter(request,"col","");
	String dta = website.getRequestParameter(request,"dta","");

	String message = "OK";

	if (processPage && id > 0 && !col.equals(Constant.BLANK)){
		dta = AntiSpamy.spamy((""+id),col,dta);
		com.ase.aseutil.fnd.FndDB.setItem(conn,id,col,dta,user);
	}
	else{
		message = "ERROR";
	}

	asePool.freeConnection(conn,"fndedtx",user);

	org.json.simple.JSONObject json = new org.json.simple.JSONObject();
	json.put("result",message);
	String gson = new com.google.gson.Gson().toJson(json);
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	response.getWriter().write(gson);

%>
