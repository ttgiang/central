<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsexp.jsp	Experimental outline
	*	TODO when displaying another, must return here and not crsvw
	*	TODO effective date of experiment course when it becomes current
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Experimental Outline Report";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '50%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Returns list of experimental outlines.");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	/*
		String sql = aseUtil.getPropertySQL(session,"getExperimentalOutlines");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "%%",campus);
			sql = aseUtil.replace(sql, "_experimental_","CourseNum LIKE '%97%' OR CourseNum LIKE '%98%'");
		}

		paging = new com.ase.paging.Paging();
		paging.setSQL( sql );
		paging.setScriptName("/central/core/crsexp.jsp");
		paging.setDetailLink("/central/core/vwcrs.jsp?t=CUR");
		paging.setUrlKeyName("cid");
		paging.setRecordsPerPage(99);

		int idx = website.getRequestParameter(request,"x", 0);
		if (idx>0){
			paging.setAlphaIndex(idx);
			paging.setNavigation(false);
		}

		paging.setShowAlphaIndex(true);
		out.print(paging.showRecords(conn, request, response));
	*/
	paging = null;

	String sql = aseUtil.getPropertySQL(session,"getExperimentalOutlines2");
	sql = aseUtil.replace(sql, "%%",campus);
	sql = aseUtil.replace(sql, "_experimental_","CourseNum LIKE '%97%' OR CourseNum LIKE '%98%'");
	sql = sql.replace("%_index_%","%%");

	com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
	jqPaging.setUrlKeyName("kix");
	jqPaging.setTarget("1");
	out.println(jqPaging.showTable(conn,sql,"vwcrsy.jsp","jqpaging"));
	jqPaging = null;

	asePool.freeConnection(conn,"crsexp",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>