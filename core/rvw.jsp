<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rvw.jsp - list outlines/programs up for review
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String itm = website.getRequestParameter(request,"itm","");

	String pageTitle = "";

	if (itm.equals(Constant.COURSE)){
		pageTitle = "Review Outline";
	}
	else if (itm.equals(Constant.PROGRAM)){
		pageTitle = "Review Program";
	}
	else if (itm.equals(Constant.FOUNDATION)){
		pageTitle = "Review Foundation Course";
	}

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
				 "bJQueryUI": true
			});
		});
	</script>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%

	if (processPage){
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
			  	<%
					if(itm.equals(Constant.COURSE)){
				%>
						<thead>
							 <tr>
								  <th align="left">Outline</th>
								  <th align="left">Title</th>
								  <th align="left">Proposer</th>
								  <th align="left">Due Date</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic g: ReviewDB.getReviewItems(conn,itm,campus,user)){ %>
						  <tr>
							 <td align="left"><a href="crsrvwer.jsp?kix=<%=g.getString1()%>" class="linkcolumn"><%=g.getString4()%>&nbsp;<%=g.getString5()%></a></td>
							 <td align="left"><%=g.getString3()%></td>
							 <td align="left"><%=g.getString2()%></td>
							 <td align="left"><%=g.getString6()%></td>
						  </tr>
						<% } %>
						</tbody>
				<%
					}
					else if(itm.equals(Constant.PROGRAM)){
				%>
						<thead>
							 <tr>
								  <th align="left">Title</th>
								  <th align="left">Degree</th>
								  <th align="left">Division</th>
								  <th align="left">Proposer</th>
								  <th align="left">Due Date</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic g: ReviewDB.getReviewItems(conn,itm,campus,user)){ %>
						  <tr>
							 <td align="left"><a href="crsrvwer.jsp?kix=<%=g.getString1()%>" class="linkcolumn"><%=g.getString4()%></a></td>
							 <td align="left"><%=g.getString7()%></td>
							 <td align="left"><%=g.getString8()%></td>
							 <td align="left"><%=g.getString2()%></td>
							 <td align="left"><%=g.getString6()%></td>
						  </tr>
						<% } %>
						</tbody>
				<%
					}
					else if(itm.equals(Constant.FOUNDATION)){
				%>
						<thead>
							 <tr>
								  <th align="left">Foundation Course</th>
								  <th align="left">Type</th>
								  <th align="left">Title</th>
								  <th align="left">Proposer</th>
								  <th align="left">Co-Authors</th>
								  <th align="left">Due Date</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.Generic g: ReviewDB.getReviewItems(conn,itm,campus,user)){ %>
						  <tr>
							 <td align="left"><a href="fndrvwer.jsp?kix=<%=g.getString1()%>" class="linkcolumn"><%=g.getString4()%>&nbsp;<%=g.getString5()%></a></td>
							 <td align="left"><%=g.getString9()%></td>
							 <td align="left"><%=g.getString3()%></td>
							 <td align="left"><%=g.getString2()%></td>
							 <td align="left"><%=g.getString0().replace(",","<br>")%></td>
							 <td align="left"><%=g.getString6()%></td>
						  </tr>
						<% } %>
						</tbody>
				<%
					}
			  	%>
			  </table>

		 </div>
	  </div>
<%
	}

	asePool.freeConnection(conn,"rvw",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

