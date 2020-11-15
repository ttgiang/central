<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usridx.jsp
	*	2007.09.01	user index. different from banner in that it holds specifics for CC
	**/

	boolean processPage = true;

	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;

	boolean userMaintenance = true;
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String thisUser = Util.getSessionMappedKey(session,"aseUserName");

	String thisPage = "usridx";
	session.setAttribute("aseThisPage",thisPage);

	// admins are allowed to add. If not admins, then check whether this person is
	// part of group allowed to do maintenance

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}
	else{
		userMaintenance = true;
	}

	if (!userMaintenance){
		userMaintenance = DistributionDB.hasMember(conn,campus,"UserMaintenance",thisUser);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="datatables.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String sql = aseUtil.getPropertySQL(session,"useridx");
	String user = website.getRequestParameter(request,"userID", "");
	int aseUserRights = Integer.parseInt((String)session.getAttribute("aseUserRights"));

	int idx = website.getRequestParameter(request,"idx",0);

	if (processPage && sql != null && sql.length() > 0 ) {

		session.setAttribute("aseReport","user");

		out.println(helper.drawAlphaIndex(0,"",true,"","/central/servlet/progress"));
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>&nbsp;</th>
							  <th>User</th>
							  <th>Last Name</th>
							  <th>First Name</th>
							  <th>Title</th>
							  <th>Position</th>
							  <th>Status</th>
							  <th>User Level</th>
							  <th>Department</th>
							  <th>Division</th>
							  <th>College</th>
							  <th>Campus</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.User u: com.ase.aseutil.UserDB.getUsers(conn,campus,idx)){ %>
						  <tr>
							 <td><a href="/central/core/usrtsks.jsp?sid=<%=u.getUserid()%>&idx=<%=idx%>" class="linkcolumn"><img src="../images/insert_table.gif" border="0" alt=""></a></td>
							 <td><a href="/central/core/usr.jsp?lid=<%=u.getUserid()%>&idx=<%=idx%>" class="linkcolumn"><%=u.getUserid()%></a></td>
							 <td><%=u.getLastname()%></td>
							 <td><a href="http://localhost:8080/<%=u.getUserid()%>" rel="usridx_qtip.jsp?p=<%=u.getUserid()%>" class="linkcolumn"><%=u.getFirstname()%></a></td>
							 <td><%=u.getTitle()%></td>
							 <td><%=u.getPosition()%></td>
							 <td><%=u.getStatus()%></td>
							 <td><%=u.getUserLevel()%></td>
							 <td><%=u.getDepartment()%></td>
							 <td><%=u.getDivision()%></td>
							 <td><%=u.getCollege()%></td>
							 <td><%=u.getCampus()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>

		 </div>
	  </div>
<%
	}

	paging = null;

	asePool.freeConnection(conn,"usridx",thisUser);

	int displayLength = 99;
%>

<%@ include file="qtip.jsp" %>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
