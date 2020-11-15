<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	maillog.jsp
	*	2007.09.01	display mail log
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Mail Log";
	fieldsetTitle = pageTitle;

	String from = website.getRequestParameter(request,"from","");
	String to = website.getRequestParameter(request,"to","");
	String cc = website.getRequestParameter(request,"cc","");
	String subject = website.getRequestParameter(request,"subject","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String activity = website.getRequestParameter(request,"activity","");

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
	<%@ include file="highslide.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#maillog").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true,
				 "aaSorting": [[0, "asc"]],
				 "bJQueryUI": true,
				 "bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' }
				]
			});

		});

	</script>

	<script language="JavaScript" src="js/maillog.js"></script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table width="100%" border="0">
	<tr>
		<td width="88%" class="textblackth" bgcolor="#abcdef">
			<form method="post" name="aseForm" action="?">
			&nbsp;From:&nbsp;<input type="text" name="from" value="<%=from%>" size="10" class="input">
			&nbsp;To:&nbsp;<input type="text" name="to" value="<%=to%>" size="10" class="input">
			&nbsp;CC:&nbsp;<input type="text" name="cc" value="<%=cc%>" size="10" class="input">
			&nbsp;Subject:&nbsp;<input type="text" name="subject" value="<%=subject%>" size="20" class="input">
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
	</tr>
</table>

<%
	if (processPage){
%>

	  <div id="container90">
			<div id="demo_jui">
			  <table id="maillog" class="display">
					<thead>
						 <tr>
							  <th align="left">&nbsp;</th>
							  <th align="left">From</th>
							  <th align="left">To</th>
							  <th align="left">CC</th>
							  <th align="left">Subject</th>
							  <th align="left">Alpha</th>
							  <th align="left">Num</th>
							  <th align="right">Date</th>
						 </tr>
					</thead>
					<tbody>
					<%
						String temp = activity+from+to+subject+alpha+num;

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
							 <td align="right">&nbsp;</td>
						  </tr>
					<%
						}
						else{
							for(com.ase.aseutil.Generic g: com.ase.aseutil.MailerDB.showMailLog(conn,campus,from,to,cc,subject,alpha,num,activity)){
					%>
							  <tr>
								 <td align="left"><%=g.getString1()%></td>
								 <td align="left"><%=g.getString2()%></td>
								 <td align="left"><%=g.getString3()%></td>
								 <td align="left"><%=g.getString4()%></td>
								 <td align="left"><%=g.getString5()%></td>
								 <td align="left"><%=g.getString6()%></td>
								 <td align="left"><%=g.getString7()%></td>
								 <td align="right"><%=g.getString8()%></td>
							  </tr>
					<%
							} // for
						} // if
					%>
					</tbody>
			  </table>
		 </div>
	  </div>
<%
		out.println("<p align=\"left\">NOTE: DAILY in the CC column indicates that the intended recipient (TO) wishes to receive "
			+ "Curriculum notifications only once per day.");

	}

	asePool.freeConnection(conn,"maillog",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

