<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcan.jsp - difference between this and prgidx is this is CUR and the other is PRE
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Cancel Foundation Course";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String status = website.getRequestParameter(request,"status","");
	String foundation = website.getRequestParameter(request,"foundation","");

	if (processPage){

		%>

		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">Type</th>
								  <th align="left">Created Date</th>
								  <th align="left">Course</th>
								  <th align="left">Title</th>
								  <th align="left">Proposer</th>
								  <th align="left">Progress</th>
								  <th align="left">Audity By</th>
								  <th align="left">Audit Date</th>
							 </tr>
						</thead>
						<tbody>
							<%for(com.ase.aseutil.Generic fd: com.ase.aseutil.fnd.FndDB.getFoundationToCancel(conn,campus,user)){%>
							  <tr>
								 <td><a href="fndcanx.jsp?id=<%=fd.getString1()%>" class="linkcolumn"><%=fd.getString0()%></a></td>
								 <td><%=fd.getString2()%></td>
								 <td><%=fd.getString3()%></td>
								 <td><%=fd.getString4()%></td>
								 <td><%=fd.getString5()%></td>
								 <td><%=fd.getString6()%></td>
								 <td><%=fd.getString7()%></td>
								 <td><%=fd.getString8()%></td>
							  </tr>
						<% } %>
						</tbody>
				  </table>
			 </div>
		  </div>

		<%
	} // if process

	paging = null;

	asePool.freeConnection(conn,"fndcan",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

<%@ include file="datatables.jsp" %>
<script type="text/javascript">
	$(document).ready(function () {
		$("#jquery").dataTable({
			"sPaginationType": "full_numbers",
			"iDisplayLength": 99,
			"bJQueryUI": true,
			"bFilter": false,
			"bSortClasses": false,
			"bLengthChange": false,
			"bPaginate": false,
			"bInfo": false
		});
	});
</script>

