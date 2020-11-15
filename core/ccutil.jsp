<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccutil.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central Utilities";
	fieldsetTitle = pageTitle;

	boolean isCampAdm = SQLUtil.isCampusAdmin(conn,user);
	boolean isSysAdm = SQLUtil.isSysAdmin(conn,user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table align="center" width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">

	<tr>
		<td valign="top" width="33%">
			<h3 class="subheader">Faculty</h3>
			<ul>
				<li><a href="usrlog.jsp" class="linkcolumn">Activity Log</a></li>
				<li><a href="crscmpr.jsp" class="linkcolumn">Compare Outlines</a></li>
				<li><a href="mailq.jsp" class="linkcolumn">Daily Notifications</a></li>
				<li><a href="emailidx.jsp" class="linkcolumn">Email List</a></li>
				<li><a href="shwfrms.jsp" class="linkcolumn">Forms</a></li>
				<li><a href="maillog.jsp" class="linkcolumn">Mail Log</a></li>
				<%
					if(Util.getSessionMappedKey(session,"EnableMessageBoard").equals(Constant.ON)){
				%>
					<li><a href="msgbrd.jsp" class="linkcolumn">Message Board</a></li>
				<%
					}
				%>
				<li><a href="usrprfl.jsp" class="linkcolumn">My Profile</a></li>
				<li><a href="qlst.jsp" class="linkcolumn">Quick List Entry</a></li>
				<li><a href="srch.jsp" class="linkcolumn">Search Course Outlines</a>
				<li><a href="sylidx.jsp" class="linkcolumn">Syllabus Listing</a></li>
				<li><a href="cmps.jsp" class="linkcolumn">UH Campuses</a></li>
			</ul>
		</td>
		<td valign="top" width="34%">
			<%
				if (SQLUtil.isCampusAdmin(conn,user) || SQLUtil.isSysAdmin(conn,user)){
			%>
				<h3 class="subheader">Campus Admin</h3>
				<ul>
					<li><a href="crsfrmsidx.jsp" class="linkcolumn">Additional Forms</a></li>
					<li><a href="appridx.jsp?pageClr=1" class="linkcolumn">Approver Sequence</a></li>
					<li><a href="crscat.jsp" class="linkcolumn">Course Catalog</a></li>
					<li><a href="dfqst.jsp?t=c" class="linkcolumn">Campus Item Definition</a></li>
					<li><a href="dfqst.jsp?t=r" class="linkcolumn">Course Item Definition</a></li>
					<li><a href="dgridx.jsp" class="linkcolumn">Degree Maintenance</a></li>
					<li><a href="dividx.jsp" class="linkcolumn">Dept/Division Maintenance*</a></li>
					<li><a href="dstidx.jsp" class="linkcolumn">Distribution List</a></li>
					<li><a href="ntfidx.jsp" class="linkcolumn">Email Notification</a></li>
					<li><a href="crsinp.jsp" class="linkcolumn">Form View</a></li>
					<li><a href="hlpidx.jsp" class="linkcolumn">Help Maintenance</a></li>
					<li><a href="newsidx.jsp" class="linkcolumn">News Maintenance</a></li>
<!-- TO DO
<li><a href="ntfidx.jsp" class="linkcolumn">Notification Maintenance</a></li>
-->
					<li><a href="stats.jsp" class="linkcolumn">Outline at a glance</a></li>
					<li><a href="val.jsp?pageClr=1" class="linkcolumn">Program SLO Maintenance</a></li>
<!--
<li><a href="crspslo.jsp" class="linkcolumn">Quick List Program SLO Entry</a></li>
-->
					<li><a href="ini.jsp?pageClr=1" class="linkcolumn">System Settings</a></li>
					<li><a href="val.jsp?pageClr=1" class="linkcolumn">System Tables</a></li>
					<li><a href="usridx.jsp" class="linkcolumn">User Maintenance</a></li>
					<li><a href="jsid.jsp" class="linkcolumn">User Session</a></li>
				</ul>
			<%
				}
			%>
		</td>
		<td valign="top" width="33%">
			<%
				if (SQLUtil.isSysAdmin(conn,user)){
			%>
				<h3 class="subheader">System Admin</h3>
				<ul>
					<li><a href="crstst.jsp" class="linkcolumn">Approval Watch</a></li>
					<li><a href="apprseq.jsp" class="linkcolumn">Approver Routing</a></li>
					<li><a href="ccconfig.jsp" class="linkcolumn">Configure CC</a></li>
					<li><a href="../javadoc/asedoc.htm" class="linkcolumn">Javadoc</a></li>
					<li><a href="sndr.jsp" class="linkcolumn">Send Mail (form)</a></li>
					<li><a href="sndml.jsp" class="linkcolumn">Send Once (daily notification)</a></li>
					<li><a href="logs.jsp" class="linkcolumn">View Log</a></li>
					<li><a href="ccjobs.jsp" class="linkcolumn">System Jobs...</a></li>
					<li><a href="crsqlst.jsp" class="linkcolumn">List Import...</a></li>
					<li><a href="lstmprt.jsp?mnu=1" class="linkcolumn">List Import 2...</a></li>
					<li><a href="stck.jsp" class="linkcolumn">Stock Teaser...</a></li>
					<li><a href="cql.jsp" class="linkcolumn">CQL...</a></li>
					<li><a href="sa.jsp" class="linkcolumn">System Admin...</a>
					<li><a href="sysspc.jsp" class="linkcolumn">System Space...</a>
					<li><a href="/central/servlet/sa?c=props" class="linkcolumn">Verify Property File...</a>
						<ul>
							<li><a href="/central/core/dbg.jsp" class="linkcolumn">System Debug Settings</a></li>
							<li><a href="/central/core/sys.jsp" class="linkcolumn">System Global Settings</a></li>
						</ul>
					</li>
					<li><a href="cleaner.jsp" class="linkcolumn">Program Script Cleaner...</a>
					<li><a href="tsql.jsp" class="linkcolumn">Count Rows...</a>
					<li><a href="chgid.jsp" class="linkcolumn">Change User ID...</a>
				</ul>
			<%
				}
			%>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<ul>
				<%
					if (campus.equals(Constant.CAMPUS_LEE)){
				%>
						<li><a href="cmpr.jsp" class="linkcolumn">Copy from Old CC</a></li>
				<%
					}

					boolean sloGlobalUpdate = DistributionDB.hasMember(conn,campus,"SLOGlobalUpdate",user);

					if (sloGlobalUpdate || isCampAdm || isSysAdm)
						out.println("<li><a href=\"ccslo.jsp\" class=\"linkcolumn\">Quick SLO Entry</a> (applicable to approved course outlines only)</li>");

				%>
			</ul>
		</td>
	</tr>

	<tr>
		<td colspan="3">
			<h3 class="subheader">System Wide</h3>
			<ul>
				<li><a href="cccm.jsp" class="linkcolumn">Available Questions in Curriculum Central</a></li>
				<li><a href="cccm.jsp" class="linkcolumn">CCCM6100 Questions Used</a> (applicable to approved outlines only)</li>
				<li><a href="dsprpt.jsp?src=DEFECT" class="linkcolumn" target="_blank">Defect Report</a></li>
				<li><a href="dsprpt.jsp?src=ENHANCEMENT" class="linkcolumn" target="_blank">Enhancement Report</a></li>
				<li><a href="cccmh.jsp" class="linkcolumn">Outline Help Text</a></li>
				<li>
					<a href="ccsetup.jsp" class="linkcolumn">Review CC Setup</a>
					<%
						if (SQLUtil.isSysAdmin(conn,user)){
					%>
							<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
							<a href="/central/servlet/sa?c=sync" class="linkcolumn">Synch campuses INI</a>
					<%
						}
					%>
				</li>

				<%
					if (Util.getSessionMappedKey(session,"CreateDefects").equals(Constant.ON)){
				%>
						<li><a href="./forum/dsplst.jsp" class="linkcolumn">Log a CC Defect</a></li>
				<%
					}
				%>

			</ul>
		</td>
	</tr>

	<%
		if (isSysAdm){
	%>
	<tr>
		<td colspan="3">
			<h3 class="subheader">Developer's Sandbox**</h3>
			<ul>
				<li><a href="faq/faq.jsp" class="linkcolumn">CC Answers!</a></li>
				<li><a href="ccsetup.jsp" class="linkcolumn">CC Setup<a></li>
				<li><a href="forum/dsplst.jsp" class="linkcolumn">Message Board</a></li>
				<li><a href="ntfidx.jsp" class="linkcolumn">Email Properties</a></li>
				<li><a href="srch.jsp" class="linkcolumn">Search...</a></li>
			</ul>
			NOTE: **This is the developer's sandbox and is shared AS-IS. Issues or problems resulting from using sandbox functions will not be addressed or fixed. The sandbox may be turned off or remove without notice.
		</td>
	</tr>
	<%
		}
	%>

</table>

<br/>
NOTE: *Depending on your campus, Department and/or Division refers to the same entity.

<%
	asePool.freeConnection(conn,"ccutil",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
