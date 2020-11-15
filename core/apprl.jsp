<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprl.jsp
	*	2007.09.01	approval names and sequence
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Approval Status";
	fieldsetTitle = pageTitle;
	String alpha;
	String num;

	alpha = website.getRequestParameter(request,"alpha");
	num = website.getRequestParameter(request,"num");;

	if ((alpha==null || alpha.length()==0) && (num==null || num.length()==0)){
		response.sendRedirect("sltcrs.jsp?cp=apprl");
	}
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
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	paging = null;

	String sql = aseUtil.getPropertySQL(session,"approval");
	if ( sql != null && sql.length() > 0 ){
		sql = aseUtil.replace(sql, "%%", campus);
		sql = aseUtil.replace(sql, "'_alpha_'", aseUtil.toSQL(alpha,1));
		sql = aseUtil.replace(sql, "'_num_'", aseUtil.toSQL(num,1));

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,""));
		jqPaging = null;
	}

	asePool.freeConnection(conn,"apprl",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>