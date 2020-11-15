<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	lstprereq.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "90%";
	String pageTitle = "Pre Requisites";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");;

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=lstprereq&viewOption=CUR");
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String sql = aseUtil.getPropertySQL( session,"prereq" );
	if ( sql != null && sql.length() > 0 ){

		sql = aseUtil.replace(sql, "%%", (String)session.getAttribute("aseCampus"));
		sql = aseUtil.replace(sql, "_alpha_", alpha);
		sql = aseUtil.replace(sql, "_num_", num);

		paging = new com.ase.paging.Paging();
		paging.setSQL(sql);
		paging.setRecordsPerPage(999);
		paging.setSorting(false);
		out.print( paging.showRecords(conn,request,response) );
		paging = null;
	}
	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
