<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgdlt.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Delete Program";
	fieldsetTitle = pageTitle;

	String type = "CUR";

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
					{ sWidth: '40%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
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

		int degree = website.getRequestParameter(request,"degree",0);
		String sql = aseUtil.getPropertySQL(session,"prgdegrees");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_campus_", campus);
		}

		out.println("<form name=\"aseForm\" action=\"?\" method=\"post\" >");
		out.println("<p align=\"left\"><font class=\"textblackth\">Select from program to delete:&nbsp;&nbsp;</font>" + aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false));
		out.println("<input type=\"submit\" name=\"cmdSubmit\" value=\"Go\" class=\"input\"></p>");
		out.println("</form>");

		if (degree > 0){
			paging = new com.ase.paging.Paging();
			sql = aseUtil.getPropertySQL(session,"prgdlt1");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
				sql = aseUtil.replace(sql, "_id_", ""+degree);
			}

			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"/central/core/prgdltx.jsp"));
			jqPaging = null;

		}
	}

	paging = null;

	asePool.freeConnection(conn,"prgdlt",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>