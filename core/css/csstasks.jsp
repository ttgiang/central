<%@ include file="ase.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "tasks";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Task Listing";
	fieldsetTitle = pageTitle;
%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<%@ include file="./js/modal/modalnews.jsp" %>

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

	<link rel="stylesheet" type="text/css" href="./css/csslayout.css">

	<%@ include file="ase2.jsp" %>

</head>

<body topmargin="0" leftmargin="0" background="images/stripes.png">

<div id="ASEcontainer">

	<div id="ASEheader">
		<%@ include file="./css/cssheader.jsp" %>
	</div>

	<div id="ASEcontent">

		<fieldset class="FIELDSET100">

		<legend><%=fieldsetTitle%></legend>

		<%
			String campus = Util.getSessionMappedKey(session,"aseCampus");
			String user = Util.getSessionMappedKey(session,"aseUserName");

			if (processPage){
				if (!user.equals(Constant.BLANK) && processPage){
					out.println(TaskDB.showUserTasksJQ(conn,campus,user));

		%>
				  <div id="container90">
						<div id="demo_jui">
						  <table id="jquery" class="display">
								<thead>
									 <tr>
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
			}

			asePool.freeConnection(conn,"tasks",user);
		%>

		</fieldset>

	</div>

	<%@ include file="tasksx.jsp" %>

	<p align="left">
		<a href="#dialogTaskDescription" name="modal" class="linkcolumn">View detail task description</a>
	</p>

	<%@ include file="./js/modal/taskdescr2.jsp" %>

	<%@ include file="./css/cssfooter.jsp" %>

</div>

</body>
</html>
