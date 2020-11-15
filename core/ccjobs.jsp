<%@ include file="ase.jsp" %>
<%@ page import="org.quartz.JobDetail"%>
<%@ page import="org.quartz.JobDataMap"%>
<%@ page import="org.quartz.Scheduler"%>
<%@ page import="org.quartz.SchedulerMetaData"%>
<%@ page import="org.quartz.Trigger"%>

<%
	/**
	*	ASE
	*	ccjobs.jsp
	*	2009.12.20
	*
	* TO DO - we have progress of idle set up. need to determine when a job is running and ends
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Curriculum Central Jobs";
	fieldsetTitle = pageTitle;

	String sysMessage = aseUtil.nullToBlank((String)session.getAttribute("aseApplicationJobMessage"));
	if (sysMessage == null)
		sysMessage = "&nbsp;";

	String schedulerName = "aseScheduler";
	String schedulerStatus = "OFF";
	Scheduler scheduler = (Scheduler)session.getAttribute(schedulerName);
	if (scheduler != null){
		schedulerStatus = "ON";
	} // scheduler

	String triggers = com.ase.aseutil.jobs.AseJob.getScheduledJobs(session);

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

	<META HTTP-EQUIV="REFRESH" CONTENT="60">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%=sysMessage%>

<form name="aseForm" method="post" action="?">
<p align="left">

<font class="textblackth">Current time:</font>
<font class="datacolumn"><% out.println(aseUtil.getCurrentDateTimeString()); %></font>
<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<font class="textblackth">Scheduler is:</font>
<font class="datacolumn">
<%

	// scheduler status with kill option
	if (schedulerStatus.equals("ON")){
		out.println("&nbsp;&nbsp;<a href=\"ccjobsZ.jsp\" class=\"linkcolumn\">ON</a>");
	}
	else{
		out.println("&nbsp;&nbsp;OFF");
	}

	if (triggers != null && triggers.length() > 0){
		out.println("<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>");
		out.println("<font class=\"textblackth\">Running triggers:</font>");
		out.println("&nbsp;&nbsp;" + triggers);
	}

%></font>
</p>

<div id="container90">
	<div id="demo_jui">
	  <table id="jquery" class="display">
			<thead>
				 <tr>
					  <th align="left">System Jobs</th>
					  <th align="left">Status</th>
					  <th align="left">Frequency</th>
					  <th align="left">Start Time</th>
					  <th align="left">Counter</th>
					  <th align="left">Last Run Date</th>
				 </tr>
			</thead>
			<tbody>
<%
	if (processPage && SQLUtil.isSysAdmin(conn,user)){

		int i = 0;
		int j = 0;
		String rowColor = "";

		String jobGroup = "ASE Job Group";

		String status = "";

		// determine whether jobs are scheduled and show on screen

		ArrayList list = com.ase.aseutil.jobs.JobNameDB.getJobNames(conn);

		if (list != null){

			com.ase.aseutil.jobs.JobName jobName = null;

			for (i = 0; i<list.size(); i++){

				jobName = (com.ase.aseutil.jobs.JobName)list.get(i);

				int id = jobName.getId();
				String job = jobName.getJobName();
				String jobTitle = jobName.getJobTitle();
				String auditDate = jobName.getAuditDate();
				String auditBy = jobName.getAuditBy();

				String startTime = jobName.getStartTime();
				String endTime = jobName.getEndTime();
				String frequency = jobName.getFrequency();
				int counter = jobName.getCounter();
				int total = jobName.getTotal();
				String fireTime = jobName.getFireTime();

				if (scheduler != null){

					Trigger trigger = scheduler.getTrigger(job,jobGroup);
					if (trigger != null){
						status = Constant.ON;
					}
					else{
						status = Constant.OFF;
					}

				} // scheduler != null

				if (i % 2 == 0)
					rowColor = Constant.EVEN_ROW_BGCOLOR;
				else
					rowColor = Constant.ODD_ROW_BGCOLOR;

				out.println("<tr>"
								+ "<td>"
								+ "<a href=\"ccjobsY.jsp?j="+job+"\">"
								+ "<img src=\"../images/jobs.gif\" border=\"0\">"
								+ "</a> "
								+ jobTitle
								+ "...</td>");

				out.println("<td>");

				if (status.equals(Constant.ON)){

					counter = (int)JobsDB.countNumberInJob(conn,job);

					out.println("<a href=\"ccjobsY.jsp?j=" + job + "&k=1\" class=\"linkcolumn\">ON</a>");
				}
				else{
					out.println("<a href=\"ccjobsX.jsp?j=" + job + "&job=" + id + "\" class=\"linkcolumnhighlights\">OFF</a>");
				}

				out.println("</td>");

				out.println(
								"<td>" + frequency  + "</td>"
								+ "<td>" + startTime  + "</td>"
								+ "<td>" + counter + "</td>"
								+ "<td>" + fireTime + "</td>"
								);

				out.println("</tr>");

			} // for

			// end all jobs
			out.println("<tr>"
							+ "<td><a href=\"ccjobsY.jsp?j=EndJob&k=99\" class=\"linkcolumn\"><img src=\"../images/jobs.gif\" border=\"0\"></a>End all jobs...</td>"
							+ "<td><a href=\"ccjobsY.jsp?j=EndJob&job=99&k=99\" class=\"linkcolumn\">OFF</a></td>"
							+ "<td>&nbsp;</td>"
							+ "<td>&nbsp;</td>"
							+ "<td>&nbsp;</td>"
							+ "<td>&nbsp;</td>"
							+ "</tr> "
							);

		} // if

	} // processPage

%>
			</tbody>
	  </table>

 </div>
</div>

</form>

<p>
<table align="left" width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td valign="top" height="30">
			<ul>
				<li>Create Outlines job executes Campus Outlines Refresh before running</li>
			</ul>
		</td>
	</tr>
</table>
</p>

<%
	session.setAttribute("aseApplicationJobMessage","");

	asePool.freeConnection(conn,"ccjobs",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
