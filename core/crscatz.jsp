<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.BufferedWriter"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.FileReader"%>

<%@ page import="org.quartz.Scheduler"%>
<%@ page import="org.quartz.CronTrigger"%>
<%@ page import="org.quartz.JobDetail"%>
<%@ page import="org.quartz.JobDataMap"%>
<%@ page import="org.quartz.SchedulerMetaData"%>
<%@ page import="com.ase.aseutil.jobs.GenericJobX"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscat.jsp	course catalog  (does not need alpha selection)
	*	TODO: Need to complete this
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crscat";
	String pageTitle = "Course Catalog Processing...";
	fieldsetTitle = pageTitle;

	String alpha = website.getRequestParameter(request,"aseList","");
	String alpha2 = website.getRequestParameter(request,"alpha2","");
	String num = website.getRequestParameter(request,"num","");

	// suppress print of CC linked data
	boolean suppress = website.getRequestParameter(request,"suppress",true);

	// remove embedded HTML from user pasted contents
	boolean parseHtml = website.getRequestParameter(request,"parseHtml",true);

	if (!alpha2.equals(Constant.BLANK) && alpha.equals(Constant.BLANK)){
		alpha = alpha2;
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){

		String output = "";

		if (!alpha.equals(Constant.BLANK) && !num.equals(Constant.BLANK)){

			output = SyllabusDB.writeCatalog(conn,campus,alpha,num,parseHtml,suppress);

			if (output.indexOf("Processing error:") > -1){
				out.println("<span class=\"goldhighlights\">" + output.replace("Processing error:","") + "</span>");
			}
			else{
				out.println("Processed catalog is available <a href=\""
								+ output
								+"\" target=\"_blank\" class=\"linkcolumn\">here</a>.");
			}
		}
		else{

			try{
				Scheduler scheduler = com.ase.aseutil.jobs.AseJob.getScheduler(session,"aseScheduler");
				if (scheduler != null){
					com.ase.aseutil.jobs.RunCatalogTrigger cc = new com.ase.aseutil.jobs.RunCatalogTrigger();
					cc.process(scheduler,campus,user,alpha,num,parseHtml,suppress);
					out.println("Your request has been submitted to CC's job scheduler.<br><br>You'll receive an email notification when the job is ready for review.");
				}
				else{
					out.println("Unable to schedule job.");
				}
			}
			catch(Exception e){
				System.out.println(e.toString());
			}


		} // if alpha

	} // processPage

	asePool.freeConnection(conn,"crscatz",user);

%>

<br><br><a href="crscat.jsp" class="linkcolumn">print another catalog</a>
<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a href="stmtidx.jsp" class="linkcolumn">edit catalog template</a>
<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a href="tasks.jsp" class="linkcolumn">view tasks</a>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

