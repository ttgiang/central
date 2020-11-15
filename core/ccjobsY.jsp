<%@ include file="ase.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.quartz.Scheduler"%>
<%@ page import="org.quartz.CronTrigger"%>
<%@ page import="org.quartz.JobDetail"%>
<%@ page import="org.quartz.JobDataMap"%>
<%@ page import="org.quartz.SchedulerMetaData"%>
<%@ page import="com.ase.aseutil.jobs.GenericJobX"%>

<%
	/**
	*	ASE
	*	ccjobsY.jsp
	*	2009.12.20
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	Logger logger = Logger.getLogger("test");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central Jobs";
	fieldsetTitle = pageTitle;

	String k = website.getRequestParameter(request,"k","0");

	// don't permit execution if there are not job names
	String jobName = website.getRequestParameter(request,"j","");
	if (jobName.equals(Constant.BLANK))
		processPage = false;

	String job = website.getRequestParameter(request,"job","0");

	boolean kill = false;
	if (k.equals(Constant.ON)){
		kill = true;
	}

	String runTimeSS = website.getRequestParameter(request,"runTimeSS","0");
	String runTimeMM = website.getRequestParameter(request,"runTimeMM","0");	// every min
	String runTimeHH = website.getRequestParameter(request,"runTimeHH","0");	// starting from 2pm
	String runTimeDD = website.getRequestParameter(request,"runTimeDD","*");	// ending at 2:59
	String runTimeMN = website.getRequestParameter(request,"runTimeMN","*");
	String runTimeDW = website.getRequestParameter(request,"runTimeDW","?");

	StringBuffer message = new StringBuffer();

	// combined all components to create run time (see crsjobx for details)
	String runTime = runTimeSS + Constant.SPACE
						+ runTimeMM + Constant.SPACE
						+ runTimeHH + Constant.SPACE
						+ runTimeDD + Constant.SPACE
						+ runTimeMN + Constant.SPACE
						+ runTimeDW;

	String runCampus = website.getRequestParameter(request,"runCampus","");
	String runKix = website.getRequestParameter(request,"runKix","");
	String runAlpha = website.getRequestParameter(request,"runAlpha","");
	String runNum = website.getRequestParameter(request,"runNum","");
	String runType = website.getRequestParameter(request,"runType","");
	String runTask = website.getRequestParameter(request,"runTask","");
	String runIDX = website.getRequestParameter(request,"runIDX","");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage && SQLUtil.isSysAdmin(conn,user)){

		try{
			message.append("starting..." + Html.BR() + Html.BR());

			int i = 0;
			int j = 0;

			boolean runJob = true;

			String schedulerName = "aseScheduler";

			// if the job is not already triggered (running), run it
			String jobNames = null;

			GenericJobX genericJobX = new GenericJobX();

			Scheduler scheduler = com.ase.aseutil.jobs.AseJob.getScheduler(session,"aseScheduler");
			if (scheduler == null){
				scheduler = genericJobX.getScheduler();
				session.setAttribute(schedulerName,scheduler);
			} // scheduler

			message.append("scheduler created..." + Html.BR());

			// run the job only if the trigger does not exist
			runJob = !com.ase.aseutil.jobs.AseJob.doesTriggerExist(scheduler,jobName);

			// list of names used to determine kill or run
			jobNames = com.ase.aseutil.jobs.AseJob.getScheduledJobs(scheduler);

			// list of names formated for display
			message.append(com.ase.aseutil.jobs.AseJob.printScheduledJobs(scheduler));

			// do we schedule or kill the job
			if (job.equals("99")){

				message.append(Html.BR() + "Ending jobs..." + Html.BR());

				if (jobNames != null){
					message.append("<ul>");
					String[] endJobs = jobNames.split(",");
					for (i = 0; i < endJobs.length; i++) {
						genericJobX.endJob(scheduler,endJobs[i],user);

						message.append("<li>job <span class=\"textblackth\">" + endJobs[i] + "</span> ended</li>");

					}
					message.append("</ul>");
				} // jobNames

				message.append(Html.BR() + "<span class=\"textblackth\">All jobs ended...</span>" + Html.BR());

				message.append(Html.BR()
									+ " <a href=\"ccjobs.jsp\" class=\"linkcolumn\">return to system jobs</a>"
									+ Html.BR());

			}
			else if (runJob){

				message.append("job <span class=\"textblackth\">"
									+ jobName
									+ "</span> scheduled at <span class=\"textblackth\">"
									+ runTime
									+ "</span>"
									+ Html.BR());

				com.ase.aseutil.jobs.AseJobParms jobParms =
									new com.ase.aseutil.jobs.AseJobParms(
																					jobName,
																					runCampus,
																					user,
																					runKix,
																					runAlpha,
																					runNum,
																					runType,
																					runTask);

				genericJobX.startJob(scheduler,jobName,runTime,user,jobParms);

				message.append(Html.BR()
									+ " <a href=\"ccjobs.jsp\" class=\"linkcolumn\">return to system jobs</a>"
									+ Html.BR());
			}
			else{
				if (kill){
					genericJobX.endJob(scheduler,jobName,user);

					message.append("ended " + jobName + "..." + Html.BR());

					message.append(Html.BR()
										+ " <a href=\"ccjobs.jsp\" class=\"linkcolumn\">return to job listing</a>"
										+ Html.BR());
				}
				else{
					message.append("requested job is already running..." + Html.BR());

					message.append(Html.BR()
										+ "would you like to end the job?"
										+ " <a href=\"?j="+jobName+"&k=1\" class=\"linkcolumn\">Yes</a>"
										+ " <font class=\"\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>"
										+ " <a href=\"ccjobs.jsp\" class=\"linkcolumn\">No</a>"
										+ Html.BR());
				} // kill
			} // runJob

		}
		catch(Exception e){
			logger.fatal("ccjobsY - " + e.toString());
		}
	}	// processPage

	asePool.freeConnection(conn,"testJobs",user);
%>

<table border="0" width="100%">
	<tr>
		<td>
			<p align="left"><%=message%></p>
		</td>
	</tr>
</table>


<%@ include file="../inc/footer.jsp" %>
</body>
</html>
