<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usrtsks.jsp
	*	2007.09.01	manage user tasks
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","usrtsks");

	String pageTitle = "User Task Listing";
	fieldsetTitle = pageTitle
		+	"&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/taskmaintenance.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>";

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
				 "bJQueryUI": true
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = website.getRequestParameter(request,"sid", "");

	//out.println("<p align=\"left\"><a href=\"usrtsks01.jsp?sid="+user+"\" class=\"linkcolumn\">create tasks</a>&nbsp;</p>");

	if (processPage && !user.equals(Constant.BLANK)){
		out.println(TaskDB.showUserTasksJQ(conn,campus,user,true));

%>
		  <div id="container90">
				<div id="demo_jui">
				  <table id="jquery" class="display">
						<thead>
							 <tr>
								  <th align="left">&nbsp;</th>
								  <th align="left">Submitted For</th>
								  <th align="left">Submitted By</th>
								  <th align="left">Progress</th>
								  <th align="left">Outline/Program</th>
								  <th align="left">Task</th>
								  <th align="left">Date</th>
								  <th align="left">Campus</th>
							 </tr>
						</thead>
						<tbody>
							<% for(com.ase.aseutil.report.ReportingStatus o: com.ase.aseutil.report.ReportingStatusDB.getReportingStatus(conn,Constant.COURSE,user)){ %>
							  <tr>
								 <td align="left"><%=o.getLastUpdated()%></td>
								 <td align="left"><%=o.getLinks()%></td>
								 <td align="left"><%=o.getOutline()%></td>
								 <td align="left"><%=o.getProgress()%></td>
								 <td align="left"><%=o.getProposer()%></td>
								 <td align="left"><%=o.getCurrent()%></td>
								 <td align="left"><%=o.getNext()%></td>
								 <td align="left"><%=o.getDateProposed()%></td>
							  </tr>
						<% } %>
						</tbody>
				  </table>
			 </div>
		  </div>

<%

	}

	asePool.freeConnection(conn,"usrtsks",user);

%>

<%@ include file="../inc/footer.jsp" %>


</body>
</html>
