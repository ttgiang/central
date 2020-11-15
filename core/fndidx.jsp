<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndidx.jsp
	*	2007.09.01	generic statements used for all reasons
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","fndidx");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String type = website.getRequestParameter(request,"type","");

	String pageTitle = "Foundation Hallmark Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"],[2, "asc"],[3, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '45%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

	<a href="fnd.jsp?lid=0" class="button"><span>Add Hallmark</span></a>
	&nbsp;
	View by type:
	<a href="fndidx.jsp?type=" class="linkcolumn">ALL</a>
	<font class="copyright">&nbsp;|&nbsp;</font>
	<a href="fndidx.jsp?type=FG" class="linkcolumn">FG</a>
	<font class="copyright">&nbsp;|&nbsp;</font>
	<a href="fndidx.jsp?type=FS" class="linkcolumn">FS</a>
	<font class="copyright">&nbsp;|&nbsp;</font>
	<a href="fndidx.jsp?type=FW" class="linkcolumn">FW</a>

	<%
		if(!type.equals("")){
	%>
		<font class="copyright">&nbsp;|&nbsp;</font>
		<a href="fndprvw.jsp?type=<%=type%>" class="linkcolumn">Preview Form</a>
	<%
		}
	%>

	<br/><br/>

<%
	if(processPage){
%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left"></th>
								  <th align="left">Type</th>
								  <th align="left">Seq</th>
								  <th align="left">EN</th>
								  <th align="left">QN</th>
								  <th align="left">Question</th>
								  <th align="left">Campus</th>
								  <th align="left">Audit By</th>
								  <th align="left">Audit Date</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic fd: com.ase.aseutil.fnd.FndDB.getFoundations(conn,type)){ %>
							  <tr>
								 <td><%=fd.getString1()%></td>
								 <td><a href="fnd.jsp?lid=<%=fd.getString1()%>" class="linkcolumn"><%=fd.getString2()%></a></td>
								 <td><%=fd.getString3()%></td>
								 <td><%=fd.getString4()%></td>
								 <td><%=fd.getString5()%></td>
								 <td><%=fd.getString6()%></td>
								 <td><%=fd.getString7()%></td>
								 <td><%=fd.getString8()%></td>
								 <td><%=fd.getString9()%></td>
							  </tr>
						<% } %>
						</tbody>
				  </table>

			 </div>
		  </div>

<%
	}

	paging = null;
	asePool.freeConnection(conn,"fndidx",user);

%>

	<br><a href="fnd.jsp?lid=0" class="button"><span>Add Hallmark</span></a>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

