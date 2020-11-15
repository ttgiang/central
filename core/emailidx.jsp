<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	emailidx.jsp
	*	2007.09.01	Email list
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","emailidx");

	String pageTitle = "Email Distribution Lists";
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
					{ sWidth: '25%' },
					{ sWidth: '75%' }
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

	if(processPage){
		String sql = aseUtil.getPropertySQL( session,"emaillist" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "%_campus_%", campus);
			sql = aseUtil.replace(sql,"_user_",user);
		}

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"/central/core/emaillst.jsp"));
		jqPaging = null;
	}

	paging = null;

	asePool.freeConnection(conn,"emailidx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>