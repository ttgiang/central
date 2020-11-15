<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
	String chromeWidth = "60%";
	String pageTitle = "Course Maintenance";
	session.setAttribute("aseApplicationMessage","");
%>

<%@ include file="ase.jsp" %>

<%
	String questions = "";
	int no = 1;

	if ( request.getParameter("no") != null ){
		no = Integer.parseInt(request.getParameter("no"));
		com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();
		questions = aseUtil.dLookUp(conn, "tblCourseQuestions", "question", "questionnumber = \'" + no + "\'");
		aseUtil = null;
		asePool.freeConnection(conn);
	}

%>

<html>
<head>
	<title><%=session.getAttribute("aseApplicationTitle")%>: <%=pageTitle%></title>
	<link rel="stylesheet" href="../inc/style.css">
	<script language="JavaScript" src="js/news.js"></script>
	<LINK href="styles/tabs.css" type=text/css rel=stylesheet>
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

	<TABLE cellSpacing=0 cellPadding=0 width="100%" summary="the tabs of the page" border=0>
		<TBODY>
			<TR>
				<TD>
					<TABLE id=tabs_tda cellSpacing=0 cellPadding=0 summary="the tabs" border=0>
						<TBODY>
							<TR>
								<TD class=tabon noWrap height=20>
									<A  href="?" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Banner
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class=bgtabon vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class=taboff noWrap height=20>
									<A  href="?" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Course
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class=bgtaboff vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class=taboff noWrap height=20>
									<A  href="?" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Campus
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class=bgtaboff vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
							</TR>
						</TBODY>
					</TABLE>
				</TD>
			</TR>
			<TR><TD class=bgtabon width="100%"><IMG height=3 alt="" src="../images/tab.gif" width=0></TD></TR>
			<tr>
				<td>
					<textarea class="input" id="content" name="infocontent" style="height: 200px; width: 500px;">
						<% out.println( questions ); %>
					</textarea>
					<script language="javascript1.2">
						generate_wysiwyg("content");
					</script>
				</td>
			</tr>
			<tr>
				<td align="right"><hr size="1" />
					<input type="submit" value="submit" class="inputsmallgray">
					<input type="submit" value="approval" class="inputsmallgray">
					<input type="submit" value="cancel" class="inputsmallgray">
				</td>
			</tr>
			<tr>
				<td><hr size="1" />
					<%
						int i = 0;
						for ( i = 1; i < 30; i++ )
							if ( i == 12 )
								out.print("<b>" + i + "</b>&nbsp;|&nbsp;");
							else
								out.print("<a href=\"\">" + i + "</a>&nbsp;|&nbsp;");

					%>
				</td>
			</tr>
		</TBODY>
	</TABLE>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
