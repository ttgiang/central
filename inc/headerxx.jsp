<table border="0" width="100%" id="asetable2" cellspacing="0" cellpadding="3">
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
						<li><a href="index.jsp" rel="course">Course</a></li>
						<li><a href="index.jsp" rel="slo">SLO</a></li>
						<li><a href="index.jsp" rel="report">Reports</a></li>
						<li><a href="index.jsp" rel="utilities">Utilities</a></li>
						<li><a href="index.jsp" rel="banner">Banner</a></li>
						<li><a href="https://login.its.hawaii.edu/cas/logout?service=http://166.122.36.251:8080/central/core/lo.jsp">Log Out</a></li>
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
				<b>Maintenance</b>
				<a href="/central/core/crscan.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Proposed Outline</a>
				<a href="/central/core/crscpy.jsp?edt=CUR">&nbsp;&nbsp;&nbsp;&nbsp;Copy an Outline</a>
				<a href="/central/core/crscrt.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Create New Outline</a>
				<!--
				<a href="/central/core/crsxrf.jsp?edt=CUR">&nbsp;&nbsp;&nbsp;&nbsp;Cross Listing</a>
				-->
				<a href="/central/core/crsdlt.jsp?edt=CUR">&nbsp;&nbsp;&nbsp;&nbsp;Delete Outline</a>
				<a href="/central/core/crsedt.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Modify Course Outline</a>
				<a href="/central/core/crsrnm.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Renumber/Rename Outline</a>
				<b>Review</b>
					<a href="/central/core/crsrqstrvw.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Request Outline Review</a>
				<a href="/central/core/crsrvw.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Invite Reviewers</a>
				<a href="/central/core/crsrvwer.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Review Outline</a>
				<a href="/central/core/crsrvwcan.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Review Request</a>
				<b>Approval</b>
				<a href="/central/core/crsappr.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Approve an Outline</a>
				<a href="/central/core/crscanappr.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Approval Request</a>
			</div>

			<%
				if ( aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
			%>
				<div id="slo" class="dropmenudiv">
					<b>Maintenance</b>
					<a href="/central/core/slostrt.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Start SLO Assessment</a>
					<a href="/central/core/crscmp.jsp?kix=mnu&edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Edit SLO</a>
					<a href="/central/core/crsslo.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Assess SLO</a>
					<b>Review</b>
					<a href="/central/core/crscmpzz.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Request SLO Review</a>
					<a href="/central/core/crsrwslo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Review SLO</a>
					<a href="/central/core/crscanslo.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Review Request</a>
					<b>Approval</b>
					<a href="/central/core/crssloappr.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Request Approval</a>
					<a href="/central/core/crssloapprcan.jsp?edt=PRE">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Approval Request</a>
				</div>
			<%
				}
			%>

			<div id="banner" class="dropmenudiv">
				<a href="/central/core/bnr.jsp">Courses & Terms</a>
				<a href="/central/core/alphaidx.jsp">Course Alphas</a>
				<a href="/central/core/cllgidx.jsp">Colleges</a>
				<a href="/central/core/dprtmnt.jsp">Departments</a>
				<a href="/central/core/dvsn.jsp">Divisions</a>
				<a href="/central/core/trms.jsp">Terms</a>
			</div>

			<div id="report" class="dropmenudiv">
				<!--
					<b>Assessment</b>
					<a href="/central/core/crsassrpt0.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Report by Assessment</a>
					<a href="/central/core/crsassrpt1.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Report by Division</a>
				-->
				<b>Outlines</b>
				<a href="/central/core/crscnclled.jsp">&nbsp;&nbsp;&nbsp;&nbsp;List Cancelled/Withdrawn Outline</a>
				<a href="/central/core/crsexp.jsp">&nbsp;&nbsp;&nbsp;&nbsp;List Experimental Outline</a>
				<!--
					<a href="/central/core/crslst.jsp">&nbsp;&nbsp;&nbsp;&nbsp;List Outlines</a>
				-->

				<%
					if ( aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
				%>
					<a href="/central/core/lstprereq.jsp">&nbsp;&nbsp;&nbsp;&nbsp;List Pre-Requisites(*)</a>
				<%
					}
				%>

				<a href="/central/core/crssts.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View Outline Status</a>

				<!-- this is the old way of viewing the outline
				<a href="/central/core/crsvw.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View Core Outline</a>
				-->

				<a href="/central/core/vwoutline.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View Core Outline</a>

				<%
					if ( aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
				%>
					<a href="/central/core/crsinf.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View Outline Detail(*)</a>
				<%
					}
				%>

				<!--
					<a href="/central/core/crsprgrs.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View Outline Progress</a>
				-->

				<b>SLO</b>
				<a href="/central/core/sloinc.jsp">&nbsp;&nbsp;&nbsp;&nbsp;List Incomplete SLO Assessment</a>
				<!--
				<a href="/central/core/vwslo.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View Assessed SLO</a>
				-->
				<a href="/central/core/crsslosts.jsp">&nbsp;&nbsp;&nbsp;&nbsp;View SLO</a>
			</div>

			<div id="programs" class="dropmenudiv">
				<a href="/central/core/prg.jsp">Programs</a>
			</div>

			<div id="utilities" class="dropmenudiv">
				<b>Faculty</b>
				<a href="/central/core/crsassidx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Assessment Methods</a>
				<a href="/central/core/cmps.jsp">&nbsp;&nbsp;&nbsp;&nbsp;UH Campuses</a>
				<a href="/central/core/sylidx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Syllabus Listing</a>
				<a href="/central/core/maillog.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Mail Log</a>
				<a href="/central/core/usrlog.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Activity Log</a>

				<%
					if ( aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
				%>
					<b>Campus Admin</b>
					<a href="/central/core/appridx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Approver Sequence</a>
					<a href="/central/core/dstidx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Distribution List</a>
					<a href="/central/core/crsrss.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Reassign Ownership</a>
					<a href="/central/core/dfqst.jsp?t=c">&nbsp;&nbsp;&nbsp;&nbsp;Campus Item Definition</a>
					<a href="/central/core/dfqst.jsp?t=r">&nbsp;&nbsp;&nbsp;&nbsp;Course Item Definition</a>
					<a href="/central/core/hlpidx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Help Maintenance</a>
					<a href="/central/core/crscat.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Course Catalog</a>
					<a href="/central/core/newsidx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;News</a>
					<a href="/central/core/stmtidx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;General Statements</a>
					<a href="/central/core/ini.jsp">&nbsp;&nbsp;&nbsp;&nbsp;System Settings</a>
					<a href="/central/core/usridx.jsp">&nbsp;&nbsp;&nbsp;&nbsp;User Maintenance</a>
				<%
					}
				%>

				<%
					if ( aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
				%>
					<b>System Admin</b>
					<a href="/central/core/dfqsts.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Course Item Definition</a>
					<a href="/central/core/crttpl.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Create Outline Template</a>
					<a href="/central/core/crsfld.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Display Course Content (raw data)</a>
					<a href="/central/core/jsid.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Session Audit</a>
					<a href="/central/core/verifySQL.jsp">&nbsp;&nbsp;&nbsp;&nbsp;Verify SQL</a>
				<%
					}
				%>

			</div>

			<div id="help" class="dropmenudiv">
				<a href="/central/inc/cccm6100.htm">View CCCM6100</a>
				<a href="/central/core/about.jsp">About Curriculum Central</a>
				<a href="/central/core/hlpidx.jsp">Curriculum Central Help</a>
				<b>Using CC</b>
				<a href="/central/core/docs/CC-Modify.pdf" target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;Modify an Outline</a>
				<a href="/central/core/docs/ReviewingSLO.pdf" target="_blank">&nbsp;&nbsp;&nbsp;&nbsp;Reviewing SLO</a>
			</div>
		</td>
		<td class="<%=(String)session.getAttribute("aseBGColor")%>BGColor" align="right"><font color="#c0c0c0">Welcome: <%=session.getAttribute("aseUserFullName")%>&nbsp;&nbsp;&nbsp;</font></td>
	</tr>
</table>