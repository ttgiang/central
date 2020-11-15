<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rstrctns.jsp - class restrictions
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Class Restrictions";
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

		session.setAttribute("aseReport","bannerTerms");

%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>Code</th>
							  <th>Description</th>
						 </tr>
					</thead>
					<tbody>
					  <tr>
						 <td>&nbsp;</td>
						 <td>&nbsp;</td>
					  </tr>
					</tbody>
			  </table>

		 </div>
	  </div>
<%
	}

	asePool.freeConnection(conn,"rstrctns",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

