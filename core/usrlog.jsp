<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usrlog.jsp
	*	2007.09.01	user log of actions
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","usrlog");

	String pageTitle = "Activity Log";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String activity = website.getRequestParameter(request,"activity","");
	String action = website.getRequestParameter(request,"action","");
	String srch = website.getRequestParameter(request,"srch","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String userid = website.getRequestParameter(request,"userid","");

	String nextDay = "";
	String previousDay = "";

	String aseToday = website.getRequestParameter(request,"aseToday","");
	String asePreviousDay = website.getRequestParameter(request,"asePreviousDay","");
	String aseNextDay = website.getRequestParameter(request,"aseNextDay","");

	// when today or the arrows are clicked, we process this way
	if(aseToday.equals("Today") || asePreviousDay.equals("<") || aseNextDay.equals(">")){

		// set the date
		GregorianCalendar now = new GregorianCalendar();
		int dd = now.get(Calendar.DATE);
		int mm = now.get(Calendar.MONTH)+1;
		int yy = now.get(Calendar.YEAR);
		now = null;

		String sdd = "" + dd;
		String smm = "" + mm;
		String syy = "" + yy;

		if (dd < 10) sdd = "0" + dd;
		if (mm < 10) smm = "0" + mm;
		if (yy < 10) syy = "0" + yy;

		// if no date or asking for today, set it to current
		if(activity.equals(Constant.BLANK) || aseToday.equals("Today")){
			activity = smm + "/" + sdd + "/" + syy;
		}
	}

	if(!activity.equals(Constant.BLANK)){
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(sdf.parse(activity));

		calendar.add(Calendar.DATE, -1);
		previousDay = sdf.format(calendar.getTime());

		calendar.add(Calendar.DATE, 2);
		nextDay = sdf.format(calendar.getTime());
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true,
				 "aaSorting": [[6, "desc"]],
				 "bJQueryUI": true,
				 "bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '40%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' }
				]
			});
		});
	</script>

	<script language="JavaScript" src="js/usrlog.js"></script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table width="100%" border="0">
	<tr>
		<td width="80%" class="textblackth" bgcolor="#abcdef">
			<form method="post" name="aseForm" action="?">
			&nbsp;UserID:&nbsp;<input type="text" name="userid" value="<%=userid%>" size="10" class="input">
			&nbsp;Action:&nbsp;<input type="text" name="action" value="<%=action%>" size="10" class="input">
			&nbsp;Description:&nbsp;<input type="text" name="srch" value="<%=srch%>" size="20" class="input">
			&nbsp;Alpha:&nbsp;<input type="text" name="alpha" value="<%=alpha%>" size="6" class="input">
			&nbsp;Num:&nbsp;<input type="text" name="num" value="<%=num%>" size="4" class="input">
			&nbsp;Date:&nbsp;<input type="text" name="activity" value="<%=activity%>" size="8" class="input">
			<input title="submit search" type="submit" name="aseSubmit" value="Go" class="inputsmallgray">
		</td>
		<td width="12%" bgcolor="#fedbca" align="center">
			&nbsp;&nbsp;&nbsp;<input title="view today" type="submit" name="aseToday" id="aseToday" size="6" value="Today" class="input">
			&nbsp;<input title="view 1 day back" type="submit" name="asePreviousDay" id="asePreviousDay" size="6" value="<" onClick="return setViewDate('<%=previousDay%>'); " class="input">
			&nbsp;<input title="view 1 day forward" type="submit" name="aseNextDay" id="aseNextDay" size="6" value=">"  onClick="return setViewDate('<%=nextDay%>'); " class="input">
			<input type="hidden" value="<%=previousDay%>" name="previousDay" id="previousDay">
			<input type="hidden" value="<%=nextDay%>" name="nextDay" id="nextDay">
			</form>
		</td>
		<td align="right" width="08%" bgcolor="#defabc">
			<a href="/central/servlet/progress?a=<%=alpha%>&n=<%=num%>&u=<%=userid%>&c=<%=campus%>" class="linkcolumn" target="_blank">printer friendly</a>&nbsp;
		</td>
	</tr>
</table>
<%
	if (processPage){
		session.setAttribute("aseReport","activityReport");
%>
	  <div id="container90">
			<div id="demo_jui">
			  <table id="jquery" class="display">
					<thead>
						 <tr>
							  <th>&nbsp;</th>
							  <th align="left">UserID</th>
							  <th align="left">Action</th>
							  <th align="left">Description</th>
							  <th align="left">Alpha</th>
							  <th align="left">Num</th>
							  <th align="right">Date</th>
						 </tr>
					</thead>
					<tbody>
					<%
						String temp = activity+srch+userid+alpha+num;

						if(temp.equals(Constant.BLANK)){
					%>
						  <tr>
							 <td align="left">&nbsp;</td>
							 <td align="left">&nbsp;</td>
							 <td align="left">&nbsp;</td>
							 <td align="left">&nbsp;</td>
							 <td align="left">&nbsp;</td>
							 <td align="left">&nbsp;</td>
							 <td align="left">&nbsp;</td>
						  </tr>
					<%
						}
						else{
							for(com.ase.aseutil.Generic g: UserLog.getActivities(conn,campus,userid,action,srch,alpha,num,activity)){
					%>
							  <tr>
								 <td align="left"><%=g.getString1()%></td>
								 <td align="left"><%=g.getString2()%></td>
								 <td align="left"><%=g.getString3()%></td>
								 <td align="left"><%=g.getString4()%></td>
								 <td align="left"><%=g.getString5()%></td>
								 <td align="left"><%=g.getString6()%></td>
								 <td align="right"><%=g.getString7()%></td>
							  </tr>
					<%
							} // for
						} // if
					%>
					</tbody>
			  </table>
		 </div>
	  </div>

<p align="left">
NOTE: Full date format is MM/DD/YY or wild card using month, day, or year.<br><br>

Examples of date searches:

<ul align="left">
<li align="left">06/06/2012 returns data for month=06 AND day=06 AND year=2012</li>
<li align="left">12 returns data for month=12 OR day=12 OR year=12</li>
<li align="left">2012 returns data for month=ALL AND day=ALL AND year=2012</li>
</ul>

</p>
<%
	}
	asePool.freeConnection(conn,"usrlog",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>