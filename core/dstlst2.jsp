<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dstlst2.jsp - removed from emaillst.jsp. may not be used
	*	2007.09.01
	**/

	// returns list of names to caller
	// page is used by ajax when called from dstlst.jsp

	String users = "";
	String selectedCampus = website.getRequestParameter(request,"r");
	users = DistributionDB.getCampusUsersNotInListDDL(conn,selectedCampus,0);
	asePool.freeConnection(conn);
	out.println(users);
%>

</body>
</html>

