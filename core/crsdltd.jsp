<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdltd.jsp
	*	2010.01.05	deleted/archived outlines
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crsdltd");

	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String cid = website.getRequestParameter(request,"cid","",false);

	String alpha = "";
	String num = "";

	String pageTitle = "Deleted/Archived Outlines";
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
	String sql = "";
	String urlKeyName = "cid";
	String detailLink = "crsdltd.jsp";

	if (processPage){

		session.setAttribute("aseReport","deletedOutlines");

		if (cid != null && cid.length() > 0){
			String[] aCid = cid.split(",");
			alpha = aCid[0];
			num = aCid[1];
		}


		int idx = website.getRequestParameter(request,"idx",0);

		out.println(helper.drawAlphaIndex(0,"",true,"",""));
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">Alpha</th>
							  <th align="left">Number</th>
							  <th align="left">Title</th>
							 <%
									if (cid != null && cid.length() > 0){
							 %>
									  <th align="left">Proposer</th>
									  <th align="left">Course Date</th>
							 <%
									}
							 %>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Banner b: com.ase.aseutil.Outlines.getDeletedOutlines(conn,campus,alpha,num,idx)){ %>
						  <tr>
							 <%
									if (cid != null && cid.length() > 0){
							 %>
								 <td><a href="vwcrsx.jsp?hid=1&t=CAN&cps=<%=campus%>&cid=<%=b.getCRSE_DEPT()%>" class="linkcolumn" alt="view outline" title="view outline"><%=b.getCRSE_ALPHA()%></a></td>
							 <%
									}
									else{
							 %>
								 <td><a href="crsdltd.jsp?cid=<%=b.getCRSE_ALPHA()%>,<%=b.getCRSE_NUMBER()%>" class="linkcolumn" alt="view outline" title="view outline"><%=b.getCRSE_ALPHA()%></a></td>
							 <%
									}
							 %>

							 <td><%=b.getCRSE_NUMBER()%></td>
							 <td><%=b.getCRSE_TITLE()%></td>
							 <%
									if (cid != null && cid.length() > 0){
							 %>
								 <td><%=b.getEFFECTIVE_TERM()%></td>
								 <td><%=b.getCRSE_DIVISION()%></td>
							 <%
									}
							 %>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%

	} // processPage

	asePool.freeConnection(conn,"crsdltd",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>