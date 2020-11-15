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

	String pageTitle = "Curriculum Central Reports";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	asePool.freeConnection(conn,"ccrpt",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<fieldset class="FIELDSET90">
	<legend>Outlines</legend>
	<table align="center" width="90%" border="0" id="table2" cellspacing="4" cellpadding="4">
		<tr>
			<td valign="top" width="50%">
				<h3 class="subheader">Outlines</h3>
				<ul>
					<li><a href="crscnclled.jsp" class="linkcolumn">Cancelled/Withdrawn Outlines</a></li>
					<li><a href="crsdltd.jsp" class="linkcolumn">Deleted/Archived Outlines</a></li>
					<li><a href="expdlt.jsp?lnk=0" class="linkcolumn">Deleted Outlines (via Reasons For Modifications)</a></li>
					<li><a href="vwoutline.jsp" class="linkcolumn">Display Outline</a></li>
					<li><a href="crsexc.jsp" class="linkcolumn">Excluded from Catalog</a></li>
					<li><a href="crsexp.jsp" class="linkcolumn">Experimental Outline</a></li>
					<li><a href="crscon.jsp" class="linkcolumn">Linked Outlines Items</a></li>
					<li><a href="crsdtes.jsp" class="linkcolumn">Outline Dates</a></li>
					<li><a href="crsinf.jsp" class="linkcolumn">Outline Detail</a></li>
					<li><a href="crssts.jsp" class="linkcolumn">Outline Approval Status</a></li>
					<li><a href="crsrvwsts.jsp" class="linkcolumn">Outline Review Status</a></li>
					<li><a href="lstcoreq.jsp" class="linkcolumn">Co-Requisites</a></li>
					<li><a href="lstprereq.jsp" class="linkcolumn">Pre-Requisites</a></li>
					<li><a href="rptini.jsp" class="linkcolumn">System Value Report</a></li>
				</ul>
			</td>
			<td valign="top" width="50%">
				<h3 class="subheader">Reports</h3>
				<ul>
					<li><a href="crsrpt.jsp?src=CUR" class="linkcolumn">Display Approved Outline</a></li>
					<li><a href="cmprmtrx.jsp" class="linkcolumn">Display Outline Summary</a></li>
					<li><a href="crsrpt.jsp?src=trms" class="linkcolumn">Display Outlines by Effective Terms</a></li>
					<li><a href="crsrpt.jsp?src=enddate" class="linkcolumn">Display Outlines by End Date</a></li>
					<li><a href="crsrpt.jsp?src=expdate" class="linkcolumn">Display Outlines by Experimental Date</a></li>
					<li><a href="crsrpt.jsp?src=rvwdate" class="linkcolumn">Display Outlines by Review Date</a></li>
					<li><a href="crsrpt.jsp?src=fstrck" class="linkcolumn">Display Outlines Fast Tracked</a></li>
					<li><a href="crsrpt.jsp?src=app" class="linkcolumn">Display Outlines Approved by Calendar Year</a></li>
					<li><a href="crsrpt.jsp?src=del" class="linkcolumn">Display Outlines Archived/Deleted by Calendar Year</a></li>
					<li><a href="crsrpt.jsp?src=mod" class="linkcolumn">Display Outlines Modified by Calendar Year</a></li>
					<li><a href="crsrpt.jsp?src=txt" class="linkcolumn">Display Text & Materials</a></li>
					<li><a href="er16.jsp" class="linkcolumn">Summary of Course/Program Actions</a></li>

					<li>SLO
						<ul>
							<li><a href="crsrpt.jsp?src=showSLO" class="linkcolumn">Display Approved Outlines with SLO</a></li>
							<li><a href="crsrpt.jsp?src=noSLO" class="linkcolumn">Display Approved Outlines without SLO</a></li>
						</ul>
					</li>
					<li>Competencies
						<ul>
							<li><a href="crsrpt.jsp?src=showComp" class="linkcolumn">Display Approved Outlines with Competencies</a></li>
							<li><a href="crsrpt.jsp?src=noComp" class="linkcolumn">Display Approved Outlines without Competencies</a></li>
						</ul>
					</li>
				</ul>
			</td>
		</tr>

		<tr>
			<td valign="top" colspan="2">
				<h3 class="subheader">Exports</h3>
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

		<tr>
			<td valign="top" colspan="2">
				<h3 class="subheader">Campus</h3>
				<ul>
					<li>KAU
						<ul>
							<li><a href="crscsv.jsp?rpt=kau_x18" class="linkcolumn">Course Item #16 in Approval Pipeline</li>
							<li><a href="crscsv.jsp?rpt=kau_x72" class="linkcolumn">Course Item #18 in Approval Pipeline</li>
							<li><a href="crscsv.jsp?rpt=kau_x71" class="linkcolumn">Course Item #19 in Approval Pipeline</li>
						</ul>
					</li>
				</ul>
			</td>
			<td valign="top" width="50%">&nbsp;</td>
		</tr>

	</table>
</fieldset>
<br>
<fieldset class="FIELDSET90">
	<legend>Programs</legend>
	<table align="center" width="90%" border="0" id="table2" cellspacing="4" cellpadding="4">
		<tr>
			<td valign="top" width="50%">
				<h3 class="subheader">Programs</h3>
				<ul>
					<li><a href="prgvwidx.jsp" class="linkcolumn">Display Program</a></li>
					<li><a href="prglo.jsp" class="linkcolumn">Display Program Learning Outcomes</a></li>
					<li><a href="prginf.jsp" class="linkcolumn">Program Detail</a></li>
				</ul>
			</td>
			<td valign="top" width="50%">
				<h3 class="subheader">Reports</h3>
				<ul>
					<li><a href="prgrpt.jsp?src=app" class="linkcolumn">Display Programs Approved by Academic Year</a></li>
					<li><a href="prgdts.jsp" class="linkcolumn">Display Programs Proposed Date</a></li>
				</ul>
			</td>
		</tr>
	</table>
</fieldset>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
