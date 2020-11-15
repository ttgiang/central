<table border="0" width="100%" id="asetable2" >
	<tr class="<%=(String)session.getAttribute("aseBGColor")%>BGColor">
		<td valign="top">
			<div id="menu">
				<ul>
					<li><h2>Home</h2>
						<ul>
							<li><a href="/central/core/index.jsp" id="indexNews">News</a></li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><h2>Tasks</h2>
						<ul>
							<li><a href="/central/core/tasks.jsp" id="tasksMyTask">My Tasks</a></li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><h2>Outline</h2>
						<ul>
							<li><a href="" id="" class="x">Approval</a>
								<ul>
									<li><a href="/central/core/crsappr.jsp?edt=PRE" class="x">Approve Outline</a></li>
									<li><a href="/central/core/crssts.jsp" class="x">Approval Status</a></li>
								</ul>
							</li>

							<li><a href="/central/core/crsassr.jsp?edt=PRE" class="x">Assessment</a></li>
							<li><a href="/central/core/crscan.jsp?edt=PRE">Cancel</a></li>
							<li><a href="/central/core/crscpy.jsp?edt=CUR">Copy</a></li>
							<li><a href="/central/core/crscrt.jsp?edt=PRE">CREATE NEW</a></li>
							<li><a href="/central/core/crsxrf.jsp?edt=CUR">Cross Listing</a></li>
							<li><a href="/central/core/crsdlt.jsp?edt=CUR">Delete</a></li>
							<li><a href="/central/core/crslst.jsp">List</a></li>

							<li><a href="" id="" class="x">Modify</a>
								<ul>
									<li><a href="/central/core/crsedt.jsp?edt=CUR" class="x">Approved</a></li>
									<li><a href="/central/core/crsedt.jsp?edt=PRE" class="x">Proposed</a></li>
								</ul>
							</li>

							<li><a href="/central/core/crsrnm.jsp?edt=PRE">Renumber</a></li>

							<li><a href="" id="" class="x">Review</a>
								<ul>
									<li><a href="/central/core/crsrvwer.jsp?edt=PRE" class="x">Review</a></li>
									<li><a href="/central/core/crsrvw.jsp?edt=PRE" class="x">Invite Reviewers</a></li>
								</ul>
							</li>

							<li><a href="/central/core/crsvw.jsp">View Content</a></li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><h2>Reports</h2>
						<ul>
							<li><a href="">Assessment Report</a>
								<ul>
									<li><a href="/central/core/crsassrpt0.jsp">By Assessment</a></li>
									<li><a href="/central/core/crsassrpt1.jsp">By Division</a></li>
								</ul>
							</li>
							<li><a href="/central/core/crscnclled.jsp">Cancelled Outline</a></li>
							<li><a href="/central/core/crsprgrs.jsp">Progress Report</a></li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><h2>Utilities</h2>
						<ul>
							<li><a href="/central/core/crsassidx.jsp">Assessment Maintenance</a></li>
							<li><a href="/central/core/bnr.jsp">Banner Courses</a></li>
							<li><a href="/central/core/disciplineidx.jsp">College Listing</a></li>
							<li><a href="/central/core/sylidx.jsp">SYLLABUS LISTING</a></li>
							<li><a href="" id="" class="x">Campus Admin</a>
								<ul>
									<li><a href="/central/core/appridx.jsp">Approver Maintenance</a></li>
									<li><a href="/central/core/catidx.jsp">COURSE CATALOG</a></li>
									<li><a href="/central/core/dstidx.jsp">Distribution List</a></li>
									<li><a href="/central/core/stmtidx.jsp">General Statements</a></li>
									<li><a href="/central/core/hlpidx.jsp">Help Maintenance</a></li>
									<li><a href="/central/core/dfqst.jsp">Item Definition (campus)</a></li>
									<li><a href="/central/core/newsidx.jsp">News</a></li>
									<li><a href="/central/core/crsrss.jsp">Reassign Ownership</a></li>
									<li><a href="/central/core/usrlog.jsp">User Activity Log</a></li>
									<li><a href="/central/core/usridx.jsp">User Maintenance</a></li>
									<li><a href="/central/core/maillog.jsp">View Mail Log</a></li>
								</ul>
							</li>
							<li><a href="" id="" class="x">System Admin</a>
								<ul>
									<li><a href="/central/core/crsfld.jsp">Display Raw Data</a></li>
									<li><a href="/central/core/dfqsts.jsp">Item Definition (system)</a></li>
									<li><a href="/central/core/ini.jsp">System Settings</a></li>
									<li><a href="/central/core/cmps.jsp">UH Campuses</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><h2>Help</h2>
						<ul>
							<li><a href="/central/core/cccm6100.jsp" id="helpView">View CCCM6100</a></li>
							<li><a href="/central/core/about.jsp" id="helpAbout">About CC</a></li>
							<li><a href="/central/core/hlpidx.jsp" id="helpHelp">CC Help</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</td>
	</tr>
</table>