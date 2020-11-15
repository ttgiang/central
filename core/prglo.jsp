<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prglo.jsp - program learnig outcomes
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Display Program Learning Outcomes";
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
					{ sWidth: '25%' },
					{ sWidth: '25%' },
					{ sWidth: '40%' },
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

	String type = website.getRequestParameter(request,"type","");

	if (processPage){
		String sql = "";
		int degree = 0;

		out.println("<form name=\"aseForm\" action=\"?\" method=\"post\" >");

		out.println("<p align=\"left\">");

		out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("<td class=\"textblackth\" valign=\"top\" width=\"20%\" height=\"30\">Select program type:&nbsp;&nbsp;</td><td valign=\"top\" class=\'dataColumn\'>");

		int thisCounter = 0;
		int thisTotal = 4;

		String[] thisType = new String[thisTotal];
		String[] thisTitle = new String[thisTotal];

		thisType[0] = "ARC"; thisTitle[0] = "Archived";
		thisType[1] = "CAN"; thisTitle[1] = "Cancelled";
		thisType[2] = "CUR"; thisTitle[2] = "Approved";
		thisType[3] = "PRE"; thisTitle[3] = "Proposed";

		for(thisCounter=0;thisCounter<thisTotal;thisCounter++){
			if (type.equals(thisType[thisCounter]))
				out.println("&nbsp;<b>" + thisTitle[thisCounter] + "</b>&nbsp;&nbsp;" );
			else
				out.println("&nbsp;<a href=\"?type=" + thisType[thisCounter] + "\" class=\"linkcolumn\">" + thisTitle[thisCounter] + "</a>&nbsp;&nbsp;" );
		}

		out.println("<input type=\"hidden\" name=\"type\" value=\""+type+"\"></td></tr>");

		out.println("</table>");
		out.println("</p></form>");

		if (!type.equals("")){
			sql = aseUtil.getPropertySQL(session,"prglo2");
			if ( sql != null && sql.length() > 0 ){
				sql = aseUtil.replace(sql, "_campus_", campus);
				sql = aseUtil.replace(sql, "_type_", type);
			}

			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			jqPaging.setUrlKeyName("kix");
			out.println(jqPaging.showTable(conn,sql,"/central/core/prgvw.jsp?type="+type));
			jqPaging = null;
		}
	}

	paging = null;

	asePool.freeConnection(conn,"prglo",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>