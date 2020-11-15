<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	divdix.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Division Listing";
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
				 "iDisplayLength": 999,
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
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){

%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th align="left">&nbsp;</th>
							  <th align="left">Division Code</th>
							  <th align="left">Division Name</th>
							  <th align="left">Chair Name</th>
							  <th align="left">Delegate Name</th>
						 </tr>
					</thead>
					<tbody>
						<% for(com.ase.aseutil.Division o: com.ase.aseutil.DivisionDB.getChairs(conn,campus)){ %>
						  <tr>
							 <td align="left"><a href="pgrchr.jsp?programid=<%=o.getDivid()%>" class="linkcolumn"><img src="../images/ed_link.gif" border="0"></a></td>
							 <td align="left"><a href="div.jsp?lid=<%=o.getDivid()%>" class="linkcolumn"><%=o.getDivisionCode()%></a></td>
							 <td align="left"><%=o.getDivisionName()%></td>
							 <td align="left"><%=o.getChairName()%></td>
							 <td align="left"><%=o.getDelegated()%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>

		 </div>
	  </div>

		<h3 class="subheaderleftjustify">
			NOTE: This page maintains the division/department chairs and the disciplines which they are responsible for.<br>
			<p>
			For example, John is the department chair of Math and Science and is responsible for disciplines ICS, MATH, PHY, SCI and BIOL.
			<p>
			Once a division/department chair is added, click on the chain-link image to the left of the chair's name to associate disciplines.
			The association of disciplines to division/department chairs is considered the lowers authority level in CC. CC uses this association
			to authorize approvals for specific course outlines.
			</p>
			<p>
			Click <a href="authidx.jsp" class="linkcolumn">here</a> to create additional associations. For example, associate a dean to all the department(s) he/she is responsible for.
			</p>
		</h3>
<%
	}

	asePool.freeConnection(conn,"dividx",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>