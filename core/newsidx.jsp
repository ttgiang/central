<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	newsidx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "News Listing";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bRetrieve": false,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bInfo": false,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '40%' },
					{ sWidth: '12%' },
					{ sWidth: '12%' },
					{ sWidth: '12%' },
					{ sWidth: '12%' },
					{ sWidth: '12%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">&nbsp;</th>
							  <th align="left">Title</th>
							  <th align="right">Start Date</th>
							  <th align="right">End Date</th>
							  <th align="right">Date Posted</th>
							  <th align="left">Author</th>
							  <th align="left">Campus</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Generic g: NewsDB.getNews(conn,campus)){ %>
						  <tr>
							 <td align="right"><%=g.getString1()%></td>
							 <td align="left"><a href="news.jsp?lid=<%=g.getString1()%>" class="linkcolumn"><%=g.getString2()%></a></td>
							 <td align="right"><%=g.getString3()%></td>
							 <td align="right"><%=g.getString4()%></td>
							 <td align="right"><%=g.getString5()%></td>
							 <td align="left"><%=g.getString6()%></td>
							 <td align="left"><%=g.getString7()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>

		 </div>
	  </div>
<%
	}

	paging = null;

	asePool.freeConnection(conn,"newsidx",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>