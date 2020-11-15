<div id="aseheader">
	<table border="0" width="100%" height="100%" id="asetable1">
		<tr bgcolor="#edf3f3">
			<td height="5%" valign="top">
				<table border="0" width="100%" height="100%" id="asetable2">
					<tr bgcolor="#edf3f3">
						<td height="5%" valign="top">
							<div id="bluemenu" class="<%=styleSheet%>">
								<ul>
									<li><a href="index.jsp">Home</a></li>
									<li><a href="tasks.jsp">My Tasks</a></li>
									<li><a href="crs.jsp" rel="course">Course</a></li>
									<li><a href="prg.jsp" rel="programs">Programs</a></li>
									<li><a href="utilities.jsp" rel="utilities">Utilities</a></li>
									<li><a href="support.jsp">Support</a></li>
									<li><a href="contact.jsp">Contact</a></li>
									<li><a href="hlpidx.jsp" rel="help">Help</a></li>
									<li><a href="lo.jsp">Log Out</a></li>
									<%
										if ( (String)session.getAttribute("aseUserRights") != null &&
											Integer.parseInt((String)session.getAttribute("aseUserRights")) == 3 ){
									%>
										<li><a href="sess.jsp">Session</a></li>
									<%
										}
									%>
								</ul>
							</div>
							<div class="ddcolortabsline">&nbsp;</div>

							<div id="course" class="dropmenudiv">
								<a href="crscan.jsp?edt=PRE">Cancel Proposed Outline</a>
								<a href="crsappr.jsp?edt=PRE">Course Approval</a>
								<a href="crsxrf.jsp?edt=CUR">Course Cross Listing</a>
								<a href="crsdlt.jsp?edt=CUR">Delete Course Outline</a>
								<a href="crsedt.jsp?edt=CUR">Modify Approved Outline</a>
								<a href="crsedt.jsp?edt=PRE">Modify Proposed Outline</a>
								<a href="crsvw.jsp">View Course Content</a>
							</div>

							<div id="programs" class="dropmenudiv">
								<a href="prg.jsp">Programs</a>
							</div>

							<div id="utilities" class="dropmenudiv">
								<a href="appridx.jsp">Approver Sequence Listing</a>
								<a href="apprl.jsp">Approval Status</a>
								<a href="bnr.jsp">Banner Courses</a>
								<a href="dfqst.jsp">Course Item Definition</a>
								<a href="cmps.jsp">UH Campuses</a>
								<a href="catidx.jsp">Course Catalog</a>
								<a href="disciplineidx.jsp">College Listing</a>
								<a href="ini.jsp">Configuration Settings</a>
								<a href="alphaidx.jsp">Course Listing</a>
								<a href="newsidx.jsp">News</a>
								<a href="stmtidx.jsp">General Statements</a>
								<a href="sylidx.jsp">Syllabus Listing</a>
								<a href="tasks.jsp">Tasks</a>
								<a href="usrlog.jsp">User Activity Log</a>
								<a href="usridx.jsp">User Maintenance</a>
								<a href="crsfld.jsp">Display Course Content (raw data)</a>
								<a href="maillog.jsp">View Mail Log</a>
							</div>

							<div id="help" class="dropmenudiv">
								<a href="about.jsp">About Curriculum Central</a>
								<a href="hlpidx.jsp">Curriculum Central Help</a>
							</div>
						</td>
						<td>
							<!--
								<a href="javascript:ts('aseheader',1)">+ Larger Font</a> |
								<a href="javascript:ts('aseheader',-1)">+ Smaller Font</a>
							-->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="90%" valign="top">
				<table valign="top" border="0" width="100%" id="table14" cellspacing="0" cellpadding="0" height="100%">
					<tr height="95%" valign="top">
						<td>
							<div align="center">
								<!-- BODY GOES HERE -->

									<fieldset class="FIELDSET">
										<legend><%=pageTitle%></legend>
											<br/>
