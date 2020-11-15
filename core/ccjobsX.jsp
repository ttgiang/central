<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccjobsX.jsp - confirm job run and input a time
	*	2009.12.20
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central Jobs";
	fieldsetTitle = pageTitle;

	int jobId = website.getRequestParameter(request,"job",-1);
	String thisJob = website.getRequestParameter(request,"j","");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/ccjobsX.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage && !(Constant.BLANK).equals(thisJob) && SQLUtil.isSysAdmin(conn,user)){

		String job = "";
		String jobTitle = "";
		String runTime = "";
		String frequency = "";
		String description = "";

		String requiredSS = "input";
		String requiredMM = "input";
		String requiredHH = "input";
		String requiredDD = "input";
		String requiredMN = "input";
		String requiredDW = "input";
		String requiredYY = "input";
		String requiredCMPS = "input";
		String requiredKIX = "input";
		String requiredALPHA = "input";
		String requiredNUM = "input";
		String requiredTYPE = "input";
		String requiredTASK = "input";
		String requiredIDX = "input";

		if (jobId != 99){

			com.ase.aseutil.jobs.JobName jobName = com.ase.aseutil.jobs.JobNameDB.getJobName(conn,jobId);

			if (jobName != null){
				job = jobName.getJobName();
				jobTitle = jobName.getJobTitle();
				frequency = jobName.getFrequency();
				description = jobName.getJobDescr();

				if ((Constant.ON).equals(frequency))
					frequency = "Once";
				else if ("99".equals(frequency))
					frequency = "non stop";

				if (jobName.getSS()) requiredSS = "inputrequired";
				if (jobName.getMM()) requiredMM = "inputrequired";
				if (jobName.getHH()) requiredHH = "inputrequired";
				if (jobName.getDD()) requiredDD = "inputrequired";
				if (jobName.getMN()) requiredMN = "inputrequired";
				if (jobName.getDW()) requiredDW = "inputrequired";
				if (jobName.getYY()) requiredYY = "inputrequired";
				if (jobName.getCMPS()) requiredCMPS = "inputrequired";
				if (jobName.getKIX()) requiredKIX = "inputrequired";
				if (jobName.getALPHA()) requiredALPHA = "inputrequired";
				if (jobName.getNUM()) requiredNUM = "inputrequired";
				if (jobName.getTYPE()) requiredTYPE = "inputrequired";
				if (jobName.getTASK()) requiredTASK = "inputrequired";
				if (jobName.getIDX()) requiredIDX = "inputrequired";

			} // jobName

			jobName = null;

		}
		else{
			jobTitle = "End all jobs";
			job = "End all jobs";
			runTime = "Immediate";
		}

%>

	<form name="aseForm" method="post" action="ccjobsY.jsp">
		<table align="center" width="80%" border="0" id="table2" cellspacing="0" cellpadding="4">
			<tr><td width="15%" class="textblackth">Current Time:</td><td class="datacolumn"><% out.println(aseUtil.getCurrentDateTimeString()); %></td></tr>
			<tr><td width="15%" class="textblackth">Job Number:</td><td class="datacolumn"><%=job%></td></tr>
			<tr><td width="15%" class="textblackth">Job Title:</td><td class="datacolumn"><%=jobTitle%></td></tr>
			<tr><td width="15%" class="textblackth">Job Name:</td><td class="datacolumn"><%=job%></td></tr>
			<tr><td width="15%" class="textblackth">Frequency:</td><td class="datacolumn"><%=frequency%></td></tr>
			<tr><td width="15%" class="textblackth">Description:</td><td class="datacolumn"><%=description%></td></tr>
			<tr><td width="15%" class="textblackth">Run Time:</td><td>

			<%
				// hr and mn comes from header.jsp

				if (jobId != 99){

					// schedule should start on next minute
					mn = mn + 1;

			%>
				&nbsp;SS:&nbsp;&nbsp;<input type="text" id="runTimeSS" name="runTimeSS" class="<%=requiredSS%>" size="2" value="0">
				&nbsp;MM:&nbsp;&nbsp;<input type="text" id="runTimeMM" name="runTimeMM" class="<%=requiredMM%>" size="2" value="<%=mn%>">
				&nbsp;HH:&nbsp;&nbsp;<input type="text" id="runTimeHH" name="runTimeHH" class="<%=requiredHH%>" size="2" value="<%=hr%>">
				&nbsp;DD:&nbsp;&nbsp;<input type="text" id="runTimeDD" name="runTimeDD" class="<%=requiredMN%>" size="2" value="*">
				&nbsp;MN:&nbsp;&nbsp;<input type="text" id="runTimeMN" name="runTimeMN" class="<%=requiredDD%>" size="2" value="*">
				&nbsp;DW:&nbsp;&nbsp;<input type="text" id="runTimeDW" name="runTimeDW" class="<%=requiredDW%>" size="2" value="?">
				&nbsp;YY:&nbsp;&nbsp;<input type="text" id="runTimeYY" name="runTimeYY" class="<%=requiredYY%>" size="2">
			<%
				}
				else{
					out.println(runTime);
				}
			%>

		</td></tr>
		<tr>
			<td width="15%" class="textblackth">Parms:</td>
			<td>
				<table align="center" width="100%" border="0" id="table3" cellspacing="0" cellpadding="4">
					<tr>
						<td>Campus:</td>
						<td><input type="text" id="runCampus" name="runCampus" class="<%=requiredCMPS%>" size="4" value=""></td>
						<td>Kix:</td>
						<td colspan="8"><input type="text" id="runKix" name="runKix" class="<%=requiredKIX%>" size="18" value=""></td>
					</tr>
					<tr>
						<td>Alpha:</td>
						<td><input type="text" id="runAlpha" name="runAlpha" class="<%=requiredALPHA%>" size="4" value=""></td>
						<td>Num:</td>
						<td><input type="text" id="runNum" name="runNum" class="<%=requiredNUM%>" size="4" value=""></td>
						<td>Type:</td>
						<td><input type="text" id="runType" name="runType" class="<%=requiredTYPE%>" size="4" value=""></td>
						<td>Task/P1:</td>
						<td><input type="text" id="runTask" name="runTask" class="<%=requiredTASK%>" size="4" value=""></td>
						<td>IDX:</td>
						<td><input type="text" id="runIDX" name="runIDX" class="<%=requiredIDX%>" size="4" value=""></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td width="15%" class="textblackth">&nbsp;</td>
			<td>
				<br/>
				<input type="submit" name="cmdSubmit" value="Schedule" class="input" onClick="return checkForm(this.form)">&nbsp;&nbsp;
				<input type="submit" name="cmdCancel" value="Cancel" class="input" onClick="return cancelForm()">
				<input type="hidden" value="<%=job%>" name="job">
				<input type="hidden" value="<%=thisJob%>" name="j">
			</td>
		</tr>
		</table>
	</form>
<div class="hr"></div>
<p align="left">
<table cellpadding="3" cellspacing="1" width="70%">
    <tbody>
        <tr>
            <td colspan="4">
					A cron expression is a string comprised of 6 or 7 fields separated by white space. Fields can contain any of the
					allowed values, along with various combinations of the allowed special characters for that field. The fields are as
					follows:
					<br/><br/>
				</td>
        </tr>
        <tr bgcolor="#e5f1f4">
            <td class="textblackth">Field Name</td>
            <td class="textblackth">Mandatory</td>
            <td class="textblackth">Allowed Values</td>
            <td class="textblackth">Allowed Special Characters</td>
        </tr>
        <tr class="datacolumn">
            <td>Seconds</td>
            <td>YES</td>
            <td>0-59</td>
            <td>, - * /</td>
        </tr>
        <tr class="datacolumn">
            <td>Minutes</td>
            <td>YES</td>
            <td>0-59</td>
            <td>, - * /</td>
        </tr>
        <tr class="datacolumn">
            <td>Hours</td>
            <td>YES</td>
            <td>0-23</td>
            <td>, - * /</td>
        </tr>
        <tr class="datacolumn">
            <td>Day of month</td>
            <td>YES</td>
            <td>1-31</td>
            <td>, - * ? / L W<br clear="all" />
            </td>
        </tr>
        <tr class="datacolumn">
            <td>Month</td>
            <td>YES</td>
            <td>1-12 or JAN-DEC</td>
            <td>, - * /</td>
        </tr>
        <tr class="datacolumn">
            <td>Day of week</td>
            <td>YES</td>
            <td>1-7 or SUN-SAT</td>
            <td>, - * ? / L #</td>
        </tr>
        <tr class="datacolumn">
            <td>Year</td>
            <td>NO</td>
            <td>empty, 1970-2099</td>
            <td>, - * /</td>
        </tr>
        <tr>
            <td colspan="4">
					<br/>
					So cron expressions can be as simple as this: <tt>&#42; * * * ? *</tt><br />
					or more complex, like this: <tt>0 0/5 14,18,3-39,52 ? JAN,MAR,SEP MON-FRI 2002-2010</tt>
				</td>
        </tr>
    </tbody>
</table>
<br/>
<table cellpadding="3" cellspacing="1" width="70%">
    <tbody>
        <tr bgcolor="#e5f1f4">
            <td class="textblackth">Expression</td>
            <td class="textblackth">Meaning</td>
        </tr>
        <tr class="datacolumn">
            <td width="30%"><tt>0 0 12 * * ?</tt></td>
            <td width="70%">Fire at 12pm (noon) every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 ? * *</tt></td>
            <td>Fire at 10:15am every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 * * ?</tt></td>
            <td>Fire at 10:15am every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 * * ? *</tt></td>
            <td>Fire at 10:15am every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 * * ? 2005</tt></td>
            <td>Fire at 10:15am every day during the year 2005</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 * 14 * * ?</tt></td>
            <td>Fire every minute starting at 2pm and ending at 2:59pm, every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 0/5 14 * * ?</tt></td>
            <td>Fire every 5 minutes starting at 2pm and ending at 2:55pm, every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 0/5 14,18 * * ?</tt></td>
            <td>Fire every 5 minutes starting at 2pm and ending at 2:55pm, AND fire every 5
            minutes starting at 6pm and ending at 6:55pm, every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 0-5 14 * * ?</tt></td>
            <td>Fire every minute starting at 2pm and ending at 2:05pm, every day</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 10,44 14 ? 3 WED</tt></td>
            <td>Fire at 2:10pm and at 2:44pm every Wednesday in the month of March.</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 ? * MON-FRI</tt></td>
            <td>Fire at 10:15am every Monday, Tuesday, Wednesday, Thursday and Friday</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 15 * ?</tt></td>
            <td>Fire at 10:15am on the 15th day of every month</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 L * ?</tt></td>
            <td>Fire at 10:15am on the last day of every month</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 ? * 6L</tt></td>
            <td>Fire at 10:15am on the last Friday of every month</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 ? * 6L</tt></td>
            <td>Fire at 10:15am on the last Friday of every month</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 ? * 6L 2002-2005</tt></td>
            <td>Fire at 10:15am on every last friday of every month during the years 2002,
            2003, 2004 and 2005</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 15 10 ? * 6#3</tt></td>
            <td>Fire at 10:15am on the third Friday of every month</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 0 12 1/5 * ?</tt></td>
            <td>Fire at 12pm (noon) every 5 days every month, starting on the first day of the
            month.</td>
        </tr>
        <tr class="datacolumn">
            <td><tt>0 11 11 11 11 ?</tt></td>
            <td>Fire every November 11th at 11:11am.</td>
        </tr>
    </tbody>
</table>

</p>

<%
	} // processPage

	asePool.freeConnection(conn,"ccjobsX",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

