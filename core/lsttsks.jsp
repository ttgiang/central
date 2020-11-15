<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	lsttsks.jsp - listing of tasks
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "User Tasks";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#lsttsks_1").dataTable({
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
					{ sWidth: '10%' },
					{ sWidth: '90%' }
				]
			});

			$("#lsttsks_2").dataTable({
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
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '50%' },
					{ sWidth: '15%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if(processPage){

		String sql = "";

		int d = website.getRequestParameter(request,"d",0);
		String lid = website.getRequestParameter(request,"lid","");

		com.ase.paging.JQPaging jqPaging = null;

		switch(d){
			case 0:
				sql = aseUtil.getPropertySQL( session, "campus2" );
				jqPaging = new com.ase.paging.JQPaging();
				out.println(jqPaging.showTable(conn,sql,"/central/core/lsttsks.jsp?d=1","lsttsks_1"));
				jqPaging = null;

				break;
			case 1:
				sql = TaskDB.showTaskByCampus(conn,lid,request,response);
				jqPaging = new com.ase.paging.JQPaging();
				out.println(jqPaging.showTable(conn,sql,"/central/core/lsttsks.jsp?d=2","lsttsks_1"));
				jqPaging = null;

				break;
			case 2:
				sql = TaskDB.showTaskByUHID(conn,lid,request,response);
				jqPaging = new com.ase.paging.JQPaging();
				out.println(jqPaging.showTable(conn,sql,"","lsttsks_2"));
				jqPaging = null;

				break;
		}
	}

	paging = null;

	asePool.freeConnection(conn,"lsttsks",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
