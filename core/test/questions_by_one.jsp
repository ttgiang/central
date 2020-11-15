<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	String chromeWidth = "60%";
	String pageTitle = "Question Maintenance";
	session.setAttribute("aseApplicationMessage","");
%>

<%@ include file="ase.jsp" %>

<%
	String[] sTabs = new String[3];
	String[] sTabBg = new String[3];
	String temp;
	int currentTab = 0;

	String[] ini = new String[3];
	String questions = "";
	String questionType = "";
	int questionCount = 0;
	int minNo = 1;
	long maxNo = 30;
	int currentNo = 1;
	long displayNo = 0;
	int nextNo = 2;
	long newNo = 0;

	// determine tab to highligh
	if ( request.getParameter("ts") != null )
		currentTab = Integer.parseInt(request.getParameter("ts"));
	else
		currentTab = 0;

	// turn them all off by default then turn on the one that
	// was selected
	sTabs = "taboff,taboff,taboff".split(",");
	sTabs[currentTab] = "tabon";

	sTabBg = "bgtaboff,bgtaboff,bgtaboff".split(",");
	sTabBg[currentTab] = "bgtabon";

	// no exists either as a weblink or a form submission. either way
	// it represents the question to retrieve
	if ( request.getParameter("no") != null ){
		currentNo = Integer.parseInt(request.getParameter("no"));
		nextNo = currentNo + 1;
	}

	// get the question to work on
	com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

	ini = "Banner,Course,Campus".split(",");
	questionType = ini[currentTab];

	// look up total number of questions by type and campus
	maxNo = aseUtil.dCountRecords(conn, "tblCourseQuestions",
		"WHERE type = " + aseUtil.toSQL(ini[currentTab],1) + " AND " +
		"campus = " + aseUtil.toSQL((String)session.getAttribute("aseCampus"),1) );

	// prevent overflow/out of bounds
	if ( nextNo > maxNo )
		nextNo = minNo;

	// this is used for adding a new question; stored for moving forward;
	// could easily request from the database the max and add 1 to it.
	// this is less work on the db side.
	newNo = maxNo + 1;

	// when adding, display the next number to be added
	// look up question by type and campus only when question is valid number (1 or greater)
	if ( currentNo > 0 ) {
		temp = "questionnumber = " + aseUtil.toSQL(String.valueOf(currentNo),1) + " AND " +
			"type = " + aseUtil.toSQL(ini[currentTab],1) + " AND " +
			"campus = " + aseUtil.toSQL((String)session.getAttribute("aseCampus"),1);

		questions = aseUtil.dLookUp(conn, "tblCourseQuestions", "question", temp );

		displayNo = currentNo;
	}
	else
		displayNo = newNo;

	// return resources
	aseUtil = null;
	asePool.freeConnection(conn);
%>

<html>
<head>
	<title><%=session.getAttribute("aseApplicationTitle")%>: <%=pageTitle%></title>
	<script language="JavaScript" src="js/questions.js"></script>
	<link type=text/css rel=stylesheet href="styles/tabs.css">
	<link type=text/css rel=stylesheet href="../inc/style.css">
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form method="post" action="/central/servlet/kuri" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" summary="the tabs of the page" border=0>
		<TBODY>
			<TR>
				<TD>
					<TABLE id=tabs_tda cellSpacing=0 cellPadding=0 summary="the tabs" border=0>
						<TBODY>
							<TR>
								<TD class="<%=sTabs[0]%>" noWrap height=20>
									<A  href="?ts=0" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Banner
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[0]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[1]%>" noWrap height=20>
									<A  href="?ts=1" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Course
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[1]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[2]%>" noWrap height=20>
									<A  href="?ts=2" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Campus
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[2]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR><TD class=bgtabon width="100%"><IMG height=3 alt="" src="../images/tab.gif" width=0></TD></TR>
			<tr>
				<td>
					<br/><% out.println( displayNo + ". " + questions ); %><br/><br/>
				</td>
			</tr>
			<tr>
				<td>
					<textarea class="input" id="content" name="questions">
						<% out.println( questions ); %>
					</textarea>
					<script language="javascript1.2">
						generate_wysiwyg("content");
					</script>
				</td>
			</tr>
			<tr>
				<td align="right"><hr size="1" />
					<input type="hidden" value="<%=nextNo%>" name="no">
					<input type="hidden" value="<%=currentNo%>" name="lastNo">
					<input type="hidden" value="<%=newNo%>" name="newNo">
					<input type="hidden" value="<%=currentTab%>" name="currentTab">

					<%
						if ( currentNo == 0 )
							out.println( "<input type=\"submit\" value=\"insert\" class=\"inputsmallgray\" onClick=\"return checkForm('i')\">" );
						else
							out.println( "<input type=\"submit\" value=\"submit\" class=\"inputsmallgray\" onClick=\"return checkForm('s')\">" );
					%>

					<input type="submit" value="finish" class="inputsmallgray" onClick="return checkForm('f')">
					<input type="submit" value="cancel" class="inputsmallgray" onClick="return checkForm('c')">
					<input type="hidden" value="q" name="formAction">
					<input type="hidden" value="<%=questionType%>" name="questionType">
				</td>
			</tr>
			<tr>
				<td><hr size="1" /><br />
					<%
						int i = 0;
						for ( i = 1; i <= maxNo; i++ ){
							if ( i == currentNo )
								out.print("<b>" + i + "</b>&nbsp;|&nbsp;");
							else
								out.print("<a href=\"?ts=" + currentTab + "&no=" + i + "\">" + i + "</a>&nbsp;|&nbsp;");
						}
						out.print("<a href=\"?ts=" + currentTab + "&no=0\">[+]</a>&nbsp;");

					%>
				</td>
			</tr>
		</TBODY>
	</TABLE>
</form>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
