<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	/**
	*	ASE
	*	questions.jsp
	*	2007.09.01
	**/

	com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();
	if ( !aseUtil.checkSecurityLevel(2, session, response, request).equals("") ){
		aseUtil = null;
		return;
	}
%>

<%@ include file="ase.jsp" %>

<%
	String chromeWidth = "80%";
	String pageTitle = "Question Maintenance";
	session.setAttribute("aseApplicationMessage","");

	String[] sTabs = new String[3];
	String[] sTabBg = new String[3];
	int currentTab = 0;

	String[] ini = new String[3];
	String questions = "";
	String questionType = "";
	int questionCount = 0;
	long maxNo = 30;

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

	ini = "Banner,Course,Campus".split(",");
	questionType = ini[currentTab];

	questions = "WHERE type = " + aseUtil.toSQL(ini[currentTab],1) + " AND " +
		"campus = " + aseUtil.toSQL((String)session.getAttribute("aseCampus"),1);

	maxNo = aseUtil.countRecords(conn, "tblCourseQuestions", questions);
%>

<html>
<head>
	<title><%=session.getAttribute("aseApplicationTitle")%>: <%=pageTitle%></title>
	<script language="JavaScript" src="js/questions.js"></script>
	<link type=text/css rel=stylesheet href="styles/tabs.css">
	<link type=text/css rel=stylesheet href="../inc/style.css">
	<script language="JavaScript" type="text/javascript" src="js/questions.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<form method="post" action="questionsx.jsp" name="aseForm">
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
			<%
				for ( int i = 1; i <= maxNo; i++ ){
					questions = aseUtil.lookUp(conn, "tblCourseQuestions", "question", "questionnumber = \'" + aseUtil.toSQL(String.valueOf(i),3) + "\'");
					out.println( "<tr><td class=textblue>" );
					out.println( "<br>" + (i) + ". " + questions + "<br /><br />" );
					out.println( "</td></tr>" );
					out.println( "<tr><td>" );
					out.println( "<textarea cols=\"90\" rows=\"5\" class=\"input\" id=\"content_" + i + "\" name=\"questions_" + i + "\">" );
					out.println( questions.trim() );
					out.println( "</textarea>" );
					out.println( "</td></tr>" );
				}
				aseUtil = null;
				asePool.freeConnection(conn);
			%>
			<tr>
				<td align="right"><hr size="1" />
					<input type="hidden" value="<%=maxNo%>" name="maxNo">
					<input type="hidden" value="<%=currentTab%>" name="currentTab">
					<input type="hidden" value="<%=questionType%>" name="questionType">
					<input type="submit" value="submit" class="inputsmallgray">
					<input type="submit" value="cancel" class="inputsmallgray" onClick="return cancelForm();">
				</td>
			</tr>
		</TBODY>
	</TABLE>
</form>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
