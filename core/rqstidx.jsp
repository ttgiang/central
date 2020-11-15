<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rqstidx.jsp
	*	2007.09.01	requests
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "User Requests";
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
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '45%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);
		boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);

		String sql = "";

		if (isSysAdmin){
			sql = aseUtil.getPropertySQL(session, "requestidx2");
		}
		else{
			sql = aseUtil.getPropertySQL(session, "requestidx");
		}

		if (sql != null && sql.length() > 0){
			if (isCampusAdmin || isSysAdmin){
				sql = sql.replace("_userid_", "%%");
			}
			else{
				sql = sql.replace("_userid_", user);
			}

			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"/central/core/rqst.jsp"));
			jqPaging = null;

		}
	}

%>

	<br><a href="rqst.jsp?lid=0" class="button"><span>Add request</span></a>

<%

	paging = null;

	asePool.freeConnection(conn,"rqstidx",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
