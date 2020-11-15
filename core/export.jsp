<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccrpt.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Curriculum Central Exports";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	asePool.freeConnection(conn,"taskstream",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table align="center" width="90%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td valign="top" colspan="2">
			<h3 class="subheader">Course Exports</h3>
			<ul>
				<li><a href="exportx.jsp?rpt=apphist" class="linkcolumn">Approval History</a></li>
				<li><a href="exportx.jsp?rpt=course" class="linkcolumn">Course Data</a></li>
				<li><a href="exportx.jsp?rpt=comp" class="linkcolumn">Compentencies</a></li>
				<li><a href="exportx.jsp?rpt=content" class="linkcolumn">Content</a></li>
				<li><a href="exportx.jsp?rpt=coreq" class="linkcolumn">Co-Req</a></li>
				<li><a href="exportx.jsp?rpt=explain" class="linkcolumn">Explain</a></li>
				<li><a href="exportx.jsp?rpt=los" class="linkcolumn">Learning Outcomes</a></li>
				<li><a href="exportx.jsp?rpt=prereq" class="linkcolumn">Pre-Req</a></li>
				<li><a href="exportx.jsp?rpt=recprep" class="linkcolumn">Recommended Preparation</a></li>
				<li><a href="exportx.jsp?rpt=revhist" class="linkcolumn">Review History</a></li>
				<li><a href="exportx.jsp?rpt=ini" class="linkcolumn">System Values</a></li>
				<li><a href="exportx.jsp?rpt=text" class="linkcolumn">Textbooks</a></li>
				<li><a href="exportx.jsp?rpt=xref" class="linkcolumn">XRef</a></li>
			</ul>
			<h3 class="subheader">Program Exports</h3>
			<ul>
				<li><a href="exportx.jsp?rpt=HAW&et=P" class="linkcolumn">HAW</a></li>
				<li><a href="exportx.jsp?rpt=HIL&et=P" class="linkcolumn">HIL</a></li>
				<li><a href="exportx.jsp?rpt=LEE&et=P" class="linkcolumn">LEE</a></li>
			</ul>
		</td>
		<td valign="top" width="50%">&nbsp;</td>
	</tr>

	<tr>
		<td valign="top" colspan="2">
			<h3 class="subheader">Others</h3>
			<ul>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_COMPETENCIES%>" class="linkcolumn">Competencies</a> - includes content</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_CONTENT%>" class="linkcolumn">Content</a> - includes short content, long content</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_COREQ%>" class="linkcolumn">Co-Requisites</a> - includes coreq-alpha,coreq-num, comment</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_CROSSLISTED%>" class="linkcolumn">Cross Listed</a> - includes alphax, numx</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_GESLO%>" class="linkcolumn">General Education SLO</a> - includes comments</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_INSTITUTION_LO%>" class="linkcolumn">Instituion SLO</a> - includes comments</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_PREREQ%>" class="linkcolumn">Pre-Requisites</a> - includes prereq-alpha, prereq-num, comment</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_PROGRAM_SLO%>" class="linkcolumn">PSLO</a> - includes comments</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_RECPREP%>" class="linkcolumn">Recommended Preparations</a> - contains alpha, number, comment, SLO</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_OBJECTIVES%>" class="linkcolumn">SLOs</a> - includes SLO</li>
				<li><a href="crscsv.jsp?rpt=<%=Constant.COURSE_TEXTMATERIAL%>" class="linkcolumn">Text & Materials</a> - includes title, edition, author, publisher, year, ISBN </li>
				<li><a href="campuslos.jsp?type=campus" class="linkcolumn">Campus Learning Outcomes</li>
				<li><a href="campuslos.jsp?type=system" class="linkcolumn">System Learning Outcomes</li>
			</ul>

			Note: All exports include coure alpha, number and title of APPROVED outlines.
		</td>
		<td valign="top" width="50%">&nbsp;</td>
	</tr>

</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
