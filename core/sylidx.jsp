<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sylidx.jsp
	*	2007.09.01	syllbus index
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Syllabus Listing";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
	<link href="./js/datatable/media/dataTables/demo_page.css" rel="stylesheet" type="text/css" />
	<link href="./js/datatable/media/dataTables/demo_table.css" rel="stylesheet" type="text/css" />
	<link href="./js/datatable/media/dataTables/demo_table_jui.css" rel="stylesheet" type="text/css" />
	<link href="./js/datatable/media/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
	<link href="./js/datatable/media/themes/smoothness/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" media="all" />
	<script src="./js/datatable/scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
	<script src="./js/datatable/scripts/jquery.dataTables.min.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function () {
		$("#jquery").dataTable({
			 "sPaginationType": "full_numbers",
			 "iDisplayLength": 99,
			 "bJQueryUI": true
		});
	});
	</script>
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String useJquery = SysDB.getSys(conn,"useJQUERY");

	if (processPage){

		int idx = website.getRequestParameter(request,"idx",0);
		out.println(helper.drawAlphaIndex(0,"",true,"",null));
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">&nbsp;</th>
							  <th align="left">Alpha</th>
							  <th align="left">Number</th>
							  <th align="left">Year</th>
							  <th align="left">Semester</th>
							  <th align="left">Audit Date</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Syllabus o: com.ase.aseutil.SyllabusDB.getSyllabi(conn,user,idx)){ %>
						  <tr>
							 <td align="left"><a href="syly.jsp?sid=<%=o.getSyllabusID()%>" class="linkcolumn" target="_blank"><img src="../images/viewcourse.gif" border="0" alt="preview syllabus" title="preview syllabus"></a></td>
							 <td align="left"><a href="sylx.jsp?lid=<%=o.getSyllabusID()%>" class="linkcolumn"><%=o.getAlpha()%></a></td>
							 <td align="left"><%=o.getNum()%></td>
							 <td align="left"><%=o.getYear()%></td>
							 <td align="left"><%=o.getSemester()%></td>
							 <td align="left"><%=o.getAuditDate()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>

		 </div>
	  </div>
<%
	} // processPage

	paging = null;

	asePool.freeConnection(conn,"sylidx",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>