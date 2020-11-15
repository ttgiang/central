<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crssloidx.jsp
	*	2007.09.01	slo list
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Assessment";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '70%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String sql = aseUtil.getPropertySQL( session, "crsxrfidx" );

	if ( sql != null && sql.length() > 0 ){
		// course to x-list to
		String alpha = website.getRequestParameter(request,"alpha");
		String num = website.getRequestParameter(request,"num");

		if ( alpha.length() > 0 && num.length() > 0 ){
			// course to x-list
			String alphaX = website.getRequestParameter(request,"ax","");
			String numX = website.getRequestParameter(request,"nx","");

			// action is to x-list or remove (a or r)
			String action = website.getRequestParameter(request,"act", "");

			// if all the values are in place, add or remove
			if ( action.length() > 0 ){
				if ( alphaX.length() > 0 && numX.length() > 0 ){
					if (action.equals("a") || action.equals("r")){
						courseDB.xListCourse(conn,action,campus,alpha,num,alphaX,numX);
					}
				}
			}

			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_sql_", campus);

			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,""));
			jqPaging = null;

		}

		paging = null;

	}
	asePool.freeConnection(conn);
%>
</body>
</html>
