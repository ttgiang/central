<table border="0" width="100%" id="asetable2" >
	<tr class="<%=(String)session.getAttribute("aseBGColor")%>BGColor">
		<td valign="top">
			<div id="bluemenu" class="<%=styleSheet%>">
				<ul>
					<%
						if (	(String)session.getAttribute("aseApplicationTitle") != null &&
								(String)session.getAttribute("aseCampus") != null ) {
					%>
						<li><a href="/central/core/index.jsp">Home</a></li>
						<li><a href="/central/core/tasks.jsp">My Tasks</a></li>
						<li><a href="/central/core/crs.jsp" rel="course">Course</a></li>
						<li><a href="/central/core/crsrpt.jsp" rel="report">Reports</a></li>
						<li><a href="/central/core/utilities.jsp" rel="utilities">Utilities</a></li>
						<li><a href="/central/core/lo.jsp">Log Out</a></li>
					<%
						}
						else
						{
					%>
							&nbsp;
					<%
						}
					%>
						<li><a href="/central/core/about.jsp" rel="help">Help</a></li>
				</ul>
			</div>

			<div id="course" class="dropmenudiv">
				<a href="/central/core/crssts.jsp">Approval Status</a>
				<a href="/central/core/crsappr.jsp?edt=PRE">Approve Outline</a>
				<a href="/central/core/crsassr.jsp?edt=PRE">Assess Outline</a>
				<a href="/central/core/crscan.jsp?edt=PRE">Cancel Outline</a>
				<a href="/central/core/crscpy.jsp?edt=CUR">Copy Outline</a>
				<a href="/central/core/crscrt.jsp">Create Outline</a>
				<a href="/central/core/crsxrf.jsp?edt=CUR">Cross Listing</a>
				<a href="/central/core/crsdlt.jsp?edt=CUR">Delete Outline</a>
				<a href="/central/core/crsrvw.jsp?edt=PRE">Invite Reviewers</a>
				<a href="/central/core/crslst.jsp">List Outlines</a>
				<a href="/central/core/crsedt.jsp?edt=CUR">Modify Approved Outline</a>
				<a href="/central/core/crsedt.jsp?edt=PRE">Modify Proposed Outline</a>
				<a href="/central/core/crsrnm.jsp?edt=PRE">Renumber Approved Outline</a>
				<a href="/central/core/crsrvwer.jsp?edt=PRE">Review Outline</a>
				<a href="/central/core/crsvw.jsp">View Outline Content</a>
			</div>

			<div id="report" class="dropmenudiv">
				<a href="/central/core/crsassrpt0.jsp">Assessment Report - Assessment</a>
				<a href="/central/core/crsassrpt1.jsp">Assessment Report - Division</a>
				<a href="/central/core/crscnclled.jsp">Cancelled Outline</a>
				<a href="/central/core/crsexp.jsp">Experimental Outline</a>
				<a href="/central/core/crsinf.jsp">Outline Detail</a>
				<a href="/central/core/crsprgrs.jsp">Progress Report</a>
			</div>

			<div id="programs" class="dropmenudiv">
				<a href="/central/core/prg.jsp">Programs</a>
			</div>

			<div id="utilities" class="dropmenudiv">
				<a href="/central/core/appridx.jsp">Approver Sequence</a>
				<a href="/central/core/crsassidx.jsp">Assessment Maintenance</a>
				<a href="/central/core/dstidx.jsp">Distribution List</a>
				<a href="/central/core/crsrss.jsp">Reassign Ownership</a>
				<a href="/central/core/bnr.jsp">Banner Courses</a>
				<a href="/central/core/dfqst.jsp">Course Item Definition (campus)</a>
				<a href="/central/core/dfqsts.jsp">Course Item Definition (system)</a>
				<a href="/central/core/cmps.jsp">UH Campuses</a>
				<a href="/central/core/hlpidx.jsp">Help Maintenance</a>
				<a href="/central/core/catidx.jsp">COURSE CATALOG</a>
				<a href="/central/core/disciplineidx.jsp">College Listing</a>
				<a href="/central/core/alphaidx.jsp">Course Listing</a>
				<a href="/central/core/newsidx.jsp">News</a>
				<a href="/central/core/stmtidx.jsp">General Statements</a>
				<a href="/central/core/sylidx.jsp">Syllabus Listing</a>
				<a href="/central/core/ini.jsp">System Settings</a>
				<a href="/central/core/usrlog.jsp">User Activity Log</a>
				<a href="/central/core/usridx.jsp">User Maintenance</a>
				<a href="/central/core/crsfld.jsp">Display Course Content (raw data)</a>
				<a href="/central/core/maillog.jsp">Mail Log</a>
			</div>

			<div id="help" class="dropmenudiv">
				<a href="/central/core/cccm6100.jsp">View CCCM6100</a>
				<a href="/central/core/about.jsp">About Curriculum Central</a>
				<a href="/central/core/hlpidx.jsp">Curriculum Central Help</a>
			</div>
		</td>
	</tr>
</table>