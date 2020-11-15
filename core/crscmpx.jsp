<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%
	String sql = "";
	String message = "";
	sql = aseUtil.getPropertySQL( session,"competencies");
	if ( sql != null && sql.length() > 0 ){
		String alpha = website.getRequestParameter(request,"alpha");
		String num = website.getRequestParameter(request,"num");

		if ( alpha.length() > 0 && num.length() > 0 ){
			String campus = website.getRequestParameter(request,"aseCampus","",true);
			String user = website.getRequestParameter(request,"aseUserName","",true);

			// action is to add or remove (a or r)
			String action = website.getRequestParameter(request,"act", "");
			// if all the values are in place, add or remove
			if ( action.length() > 0 ){
				String comp = website.getRequestParameter(request,"comp", "");
				if (action.equals("a") || action.equals("r") ){
					msg = courseDB.courseComp(conn,action,campus,alpha,num,user);
				}
			}

			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_camp_", campus);

			paging = new com.ase.paging.Paging();
			paging.setRecordsPerPage(99);
			paging.setNavigation( false );
			paging.setSorting( false );
			paging.setSQL(sql);

			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
		}
	}
	asePool.freeConnection(conn);
%>
</body>
</html>
