<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	bnr.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Banner";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

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
</head>
<!--
<body id="dt_example" topmargin="0" leftmargin="0">
-->
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){

		session.setAttribute("aseReport","bannerCourseTerms");

		int idx = website.getRequestParameter(request,"idx",0);

		out.println(helper.drawAlphaIndex(0,"",true,"","/central/servlet/progress"));
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>Alpha</th>
							  <th>Number</th>
							  <th>Title</th>
							  <th>Term</th>
							  <th>Division</th>
							  <th>Department</th>
							  <th>Repeat Units</th>
							  <th>Repeat Limit</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Banner b: com.ase.aseutil.BannerDB.getBanners(conn,campus,idx)){ %>
						  <tr>
							 <td><%=b.getCRSE_ALPHA()%></td>
							 <td><%=b.getCRSE_NUMBER()%></td>
							 <td><%=b.getCRSE_TITLE()%></td>
							 <td><%=b.getEFFECTIVE_TERM()%></td>
							 <td><%=b.getCRSE_DIVISION()%></td>
							 <td><%=b.getCRSE_DEPT()%></td>
							 <td><%=b.getMAX_RPT_UNITS()%></td>
							 <td><%=b.getREPEAT_LIMIT()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	} // processPage
%>

<%
	asePool.freeConnection(conn,"bnr",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
