<%@ include file="ase.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.quartz.Scheduler"%>
<%@ page import="org.quartz.CronTrigger"%>
<%@ page import="org.quartz.JobDetail"%>
<%@ page import="org.quartz.JobDataMap"%>
<%@ page import="org.quartz.SchedulerMetaData"%>
<%@ page import="com.ase.aseutil.jobs.*"%>

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

	String jobName = website.getRequestParameter(request,"j","DailyJob");
	String k = website.getRequestParameter(request,"k","0");

	boolean kill = false;
	if ((Constant.ON).equals(k))
		kill = true;

	String runTimeSS = website.getRequestParameter(request,"runTimeSS","0");
	String runTimeMM = website.getRequestParameter(request,"runTimeMM","0/3");	// every min
	String runTimeHH = website.getRequestParameter(request,"runTimeHH","14");	// starting from 2pm
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

	if (processPage && SQLUtil.isSysAdmin(conn,user)){

		try{
			message.append("processing started..." + Html.BR());

			message.append("job name is " + jobName + "..." + Html.BR());

			int i = 0;
			int j = 0;

			boolean runJob = true;

			String schedulerName = "aseScheduler";

			// if the job is not already triggered (running), run it
			String[] triggerGroups = null;
			String[] triggersInGroup = null;

			Scheduler scheduler = null;

			GenericJobX genericJobX = new GenericJobX();
			if (genericJobX != null){
				scheduler = (Scheduler)session.getAttribute(schedulerName);
				if (scheduler == null){
					message.append("scheduler is null..." + Html.BR());

					scheduler = genericJobX.getScheduler();

					//session.setAttribute(schedulerName,scheduler);
				} // scheduler

				message.append("got scheduler..." + Html.BR());
			} // genericJobX
			else{
				message.append("genericJobX is null..." + Html.BR());
			}

		}
		catch(java.lang.Error e){
			logger.fatal(e.toString());
		}
		catch(javax.servlet.ServletException e){
			logger.fatal(e.toString());
		}
		catch(Exception e){
			logger.fatal(e.toString());
		}
	}	// processPage

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p align="left"><%=message%></p>

<%
	asePool.freeConnection(conn,"testJobs",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
