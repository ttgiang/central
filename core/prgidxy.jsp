<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgidxy.jsp - modify approved program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Modify Approved Program";

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
					{ sWidth: '55%' },
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
		int division = website.getRequestParameter(request,"division",0);

		String sql = aseUtil.getPropertySQL(session,"prgdegrees");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_campus_", campus);
		}

		out.println("<form name=\"aseForm\" action=\"?\" method=\"post\" >");
		out.println("<p align=\"left\">");

		out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">Select Program:&nbsp;&nbsp;</td><td>"
						+ aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false)
						+ "</td></tr>");

		if (degree > 0){
			sql = aseUtil.getPropertySQL(session,"prgdivision");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
			}

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">Select Division:&nbsp;&nbsp;</td><td>"
							+ aseUtil.createSelectionBox(conn,sql,"division",""+division,false)
							+ "</td></tr>");
		}

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" width=\"20%\" height=\"30\">&nbsp;</td><td>"
						+ "<br/><input type=\"submit\" name=\"cmdSubmit\" value=\"Go\" class=\"input\">"
						+ "</td></tr>");

		out.println("</table>");

		out.println("</form><br/>");

		if (degree > 0 && division > 0){
			sql = aseUtil.getPropertySQL(session,"prgidx2");
			sql = aseUtil.replace(sql, "_campus_", campus);
			sql = aseUtil.replace(sql, "_type_", "CUR");
			sql = aseUtil.replace(sql, "_id_", ""+degree);
			sql = aseUtil.replace(sql, "_divid_", ""+division);

			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			jqPaging.setUrlKeyName("kix");
			out.println(jqPaging.showTable(conn,sql,"/central/core/prgedty.jsp"));
			jqPaging = null;
		}
	}

	paging = null;

	asePool.freeConnection(conn,"prgidxy",user);
%>

</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>