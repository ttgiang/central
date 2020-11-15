<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sysx.jsp	save and return back to sys.jsp after update
	*	2007.09.01
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String type = website.getRequestParameter(request,"type","");
	String id = website.getRequestParameter(request,"id","");
	String value = website.getRequestParameter(request,"value","");

	if (processPage){

		if (type.equals("ini")){
			SysDB.updateSys(conn,id,value.trim());
		}
		else if (type.equals("settings")){
			IniDB.updateIni(conn,Integer.parseInt(id),value.trim(),user) ;
		}
	}

	out.println(value);

	asePool.freeConnection(conn,"sys",user);
%>
</body>
</html>