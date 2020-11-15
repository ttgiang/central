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
	*	ccjobsZ.jsp
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

	String schedulerName = "aseScheduler";

	String message = "";

	if (processPage && SQLUtil.isSysAdmin(conn,user)){

		try{
			Scheduler scheduler = null;
			scheduler = (Scheduler)session.getAttribute(schedulerName);
			if (scheduler != null){

				GenericJobX genericJobX = new GenericJobX();

				genericJobX.endScheduler(scheduler);

				genericJobX = null;

				session.setAttribute(schedulerName,null);

				message = Html.BR()
							+ "Scheduler shutdown successfully."
							+ Html.BR();
			} // scheduler
			else{
				message = Html.BR()
							+ "Scheduler shutdown successfully."
							+ Html.BR();
			}
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

<p align="center"><%=message%></p>

<a href="ccjobs.jsp" class="linkcolumn">return to system jobs</a>

<%
	asePool.freeConnection(conn,"ccjobsZ",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
