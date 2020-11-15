<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgraw.jsp - raw program edit
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Edit Program Data";
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
					{ sWidth: '05%' },
					{ sWidth: '20%' },
					{ sWidth: '25%' },
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
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String type = website.getRequestParameter(request,"type","");

	if (processPage){
		String sql = "";
		int degree = 0;

		out.println("<form name=\"aseForm\" action=\"?\" method=\"post\" >");

		out.println("<p align=\"left\">");

		out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' border=\'0\'>" );

		out.println("<tr>" );
		out.println("<td class=\"textblackth\" valign=\"top\" width=\"15%\" height=\"30\">Select program type:&nbsp;&nbsp;</td><td valign=\"top\" class=\'dataColumn\'>");

		int thisCounter = 0;
		int thisTotal = 2;

		String[] thisType = new String[thisTotal];
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "CUR"; thisTitle[0] = "Approved";
		thisType[1] = "PRE"; thisTitle[1] = "Proposed";

		for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
			if (type.equals(thisType[thisCounter]))
				out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
			else
				out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
		}

		out.println("<input type=\"hidden\" name=\"type\" value=\""+type+"\"></td></tr>");

		if (!"".equals(type)){
			degree = website.getRequestParameter(request,"degree",0);
			sql = aseUtil.getPropertySQL(session,"prgdegrees");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
			}

			out.println("<tr>" );
			out.println("<td class=\"textblackth\" width=\"15%\" height=\"30\">Select program:&nbsp;&nbsp;</td><td>"
							+ aseUtil.createSelectionBox(conn,sql,"degree",""+degree,false)
							+ "</td></tr>");
		}

		out.println("<tr>" );
		out.println("<td class=\"textblackth\" width=\"15%\" height=\"30\">&nbsp;</td><td>"
						+ "<br/><input type=\"submit\" name=\"cmdSubmit\" value=\"Submit\" class=\"input\">"
						+ "</td></tr>");

		out.println("</table>");
		out.println("</p></form>");

		if (!type.equals("") && degree > 0){
			sql = aseUtil.getPropertySQL(session,"prgidx9");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
				sql = aseUtil.replace(sql, "_type_", type);
				sql = aseUtil.replace(sql, "_id_", ""+degree);
			}
			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			jqPaging.setUrlKeyName("kix");
			out.println(jqPaging.showTable(conn,sql,"/central/core/prgrawedt.jsp?type="+type));
			jqPaging = null;
		}
	}

	paging = null;

	asePool.freeConnection(conn,"prgraw",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
