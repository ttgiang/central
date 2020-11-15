<%@ include file="ase.jsp" %>

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

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./js/modal/modalnews.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);

	if (processPage && !user.equals(Constant.BLANK)){
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
						<%
							String enableCCLab = Util.getSessionMappedKey(session,"EnableCCLab");

							for(com.ase.aseutil.report.ReportingStatus o: com.ase.aseutil.report.ReportingStatusDB.getReportingStatus(conn,Constant.COURSE,user)){

								String taskCampus = o.getDateProposed();

								String kix = o.getHistoryid();
								if (enableCCLab.equals(Constant.ON) && kix != null && !kix.equals(Constant.BLANK)){
									if(taskCampus != null){
										kix = taskCampus + "&nbsp;&nbsp;<a href=\"vwpdf.jsp?kix="+kix+"\" target=\"_blank\"><img src=\"../images/ext/pdf.gif\" alt=\"view in pdf format\" title=\"view in pdf format\"></a>";
									}
								}
								else{
									kix = taskCampus;
								}

						%>
						  <tr>
							 <td align="left"><%=o.getLinks()%></td>
							 <td align="left">
								<a href="http://localhost:8080/<%=o.getOutline()%>" rel="tasks_qtip.jsp?p=<%=o.getOutline()%>&kix=<%=o.getHistoryid()%>&for=<%=o.getLinks()%>" class="linkcolumn"><%=o.getOutline()%></a>
							 </td>
							 <td align="left"><%=o.getProgress()%></td>
							 <td align="left"><%=o.getProposer()%></td>
							 <td align="left"><%=o.getCurrent()%></td>
							 <td align="left"><%=o.getNext()%></td>
							 <td align="left"><%=kix%></td>
						  </tr>
					<% } %>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
	} // processPage

	asePool.freeConnection(conn,"tasks",user);
%>

<%@ include file="datatables.jsp" %>

<%
	int displayLength = 99;
%>

<%@ include file="qtip.jsp" %>

<%@ include file="tasksx.jsp" %>

<p align="left">
	<a href="#dialogTaskDescription" name="modal" class="linkcolumn">View detail task description</a>
</p>

<%@ include file="./js/modal/taskdescr2.jsp" %>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

