<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	jsid.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Session Usage";

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

	if (processPage){

		int idx = website.getRequestParameter(request,"idx",0);

		out.println(helper.drawAlphaIndex(0,"",true,"","/central/servlet/progress"));
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">UserID</th>
							  <th align="left">Page</th>
							  <th align="left">Alpha</th>
							  <th align="left">Num</th>
							  <th align="right">Last Action</th>
							  <th align="right">Session Start</th>
							  <th align="right">Session End</th>
							  <th align="right">Time Online (mins)</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Generic g: com.ase.aseutil.session.SessionCheck.getSessionUsage(conn,campus,idx)){ %>
						  <tr>
							 <td align="left"><%=g.getString9()%> (<%=g.getString1()%>)</td>
							 <td align="left"><%=g.getString2()%></td>
							 <td align="left"><%=g.getString3()%></td>
							 <td align="left"><%=g.getString4()%></td>
							 <td align="right"><%=g.getString5()%></td>
							 <td align="right"><%=g.getString6()%></td>
							 <td align="right"><%=g.getString7()%></td>
							 <td align="right"><%=g.getString8()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	}

	asePool.freeConnection(conn,"jsid",user);
%>
