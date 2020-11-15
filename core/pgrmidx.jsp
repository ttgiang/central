<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgmidx.jsp - programs
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = website.getRequestParameter(request,"lid","",false);
	String pageTitle = "";

	pageTitle = "Program SLO Listing";

	if (!"".equals(alpha) && !"0".equals(alpha))
		pageTitle = pageTitle + " - " + alpha;

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
					{ sWidth: '80%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){

		// with alpha, show what's currently available
		if (!alpha.equals("") && !alpha.equals("0")){
			out.println("<table width=\"680\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
								+ "<tr><td>"
								+ ValuesDB.getListBySrcSubTopic(conn,campus,Constant.COURSE_PROGRAM_SLO,alpha)
								+ "</td></tr>"
								+ "<tr><td><br/><br/>"
								+ "<a href=\"pgrm.jsp?alpha="+alpha+"\" class=\"linkcolumn\">edit SLO list</a>&nbsp;&nbsp;<font color=\"#c0c0c0\">|</font>&nbsp;&nbsp;"
								+ "<a href=\"pgrmidx.jsp\" class=\"linkcolumn\">return to PSLO index</a>"
								+ "</td></tr>"
								+ "</table>");
		}
		else if ("0".equals(alpha)){
			response.sendRedirect("pgrm.jsp");
		}
		else{
			String sql = aseUtil.getPropertySQL(session,"programSLO");
			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"/central/core/pgrmidx.jsp"));
			jqPaging = null;
		}
	}

	boolean isCampAdm = SQLUtil.isCampusAdmin(conn,user);
	boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

	if (isCampAdm || isSysAdm){
	%>
		<br><a href="pgrmidx.jsp?lid=0" class="button"><span>Add Alpha</span></a>
	<%
	}

	paging = null;

	asePool.freeConnection(conn,"prgmidx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>