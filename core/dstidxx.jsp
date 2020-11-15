<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dstidxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","dstidxx");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int id = website.getRequestParameter(request,"id",0);
	String value = website.getRequestParameter(request,"value","");

	if (processPage){

		value = value.trim().replace(" ","");

		int rowsAffected = DistributionDB.updateMembers(conn,id,value,campus,user);
	}

	out.println(value);

	asePool.freeConnection(conn,"dstidxx",user);
%>
</body>
</html>