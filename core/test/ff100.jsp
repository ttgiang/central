<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	index.jsp
	*	2007.09.01
	**/

	String pageTitle = "Lastest News & Information";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"></meta>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/help.js"></script>
</head>

<body topmargin="0" leftmargin="0">

<DIV id=container>
	<DIV id=header>
		<div id="menuh-container">
			<div id="menuh">
				<ul>
					<li><a href="#" class="top_parent">Home</a>
						<ul>
							<li><a href="/central/core/index.jsp">News</a></li>
							<li><a href="/central/core/tasks.jsp">My Tasks</a></li>
						</ul>
					</li>
				</ul>
				<ul>
					<li><a href="#" class="top_parent">Outline</a>
						<ul>
							<li><a href="#" class="parent">Approval...</a>
								<ul>
									<li><a href="/central/core/crsappr.jsp?edt=PRE">Approve Outline</a></li>
									<li><a href="/central/core/crssts.jsp">Approval Status</a></li>
								</ul>
							</li>
							<li><a href="/central/core/crsassr.jsp?edt=PRE">Assessment</a></li>
							<li><a href="/central/core/crscan.jsp?edt=PRE">Cancel</a></li>
							<li><a href="/central/core/crscpy.jsp?edt=CUR">Copy</a></li>
							<li><a href="/central/core/crscrt.jsp?edt=PRE">CREATE NEW</a></li>
							<li><a href="/central/core/crsxrf.jsp?edt=CUR">Cross Listing</a></li>
							<li><a href="/central/core/crsdlt.jsp?edt=CUR">Delete</a></li>
							<li><a href="/central/core/crslst.jsp">List</a></li>
							<li><a href="#" class="parent">Modify...</a>
								<ul>
									<li><a href="/central/core/crsedt.jsp?edt=CUR">Approved</a></li>
									<li><a href="/central/core/crsedt.jsp?edt=PRE">Proposed</a></li>
								</ul>
							</li>

							<li><a href="/central/core/crsrnm.jsp?edt=PRE">Renumber</a></li>

							<li><a href="#" class="parent">Review...</a>
								<ul>
									<li><a href="/central/core/crsrvwer.jsp?edt=PRE">Review</a></li>
									<li><a href="/central/core/crsrvw.jsp?edt=PRE">Invite Reviewers</a></li>
								</ul>
							</li>

							<li><a href="/central/core/crsvw.jsp">View Content</a></li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><a href="#" class="top_parent">Reports</a>
						<ul>
							<li><a href="#" class="parent">Assessment...</a>
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
					<li><a href="#" class="top_parent">Utilities</a>
						<ul>
							<li><a href="/central/core/crsassidx.jsp">Assessment</a></li>
							<li><a href="/central/core/bnr.jsp">Banner Courses</a></li>
							<li><a href="/central/core/disciplineidx.jsp">College Listing</a></li>
							<li><a href="/central/core/sylidx.jsp">SYLLABUS LISTING</a></li>
							<li><a href="#" class="parent">Campus Admin...</a>
								<ul>
									<li><a href="/central/core/appridx.jsp">Approver Maint</a></li>
									<li><a href="/central/core/catidx.jsp">COURSE CATALOG</a></li>
									<li><a href="/central/core/dstidx.jsp">Distribution List</a></li>
									<li><a href="/central/core/stmtidx.jsp">General Statements</a></li>
									<li><a href="/central/core/hlpidx.jsp">Help Maintenance</a></li>
									<li><a href="/central/core/dfqst.jsp">Item Definition</a></li>
									<li><a href="/central/core/newsidx.jsp">News</a></li>
									<li><a href="/central/core/crsrss.jsp">Reassign Ownership</a></li>
									<li><a href="/central/core/usrlog.jsp">User Activity Log</a></li>
									<li><a href="/central/core/useridx.jsp">User Maintenance</a></li>
									<li><a href="/central/core/maillog.jsp">View Mail Log</a></li>
								</ul>
							</li>
							<li><a href="#" class="parent">System Admin...</a>
								<ul>
									<li><a href="/central/core/crsfld.jsp">Display Raw Data</a></li>
									<li><a href="/central/core/dfqsts.jsp">Item Definition</a></li>
									<li><a href="/central/core/ini.jsp">System Settings</a></li>
									<li><a href="/central/core/cmps.jsp">UH Campuses</a></li>
								</ul>
							</li>
						</ul>
					</li>
				</ul>

				<ul>
					<li><a href="#" class="top_parent">Help</a>
						<ul>
							<li><a href="/central/core/cccm6100.jsp" id="helpView">View CCCM6100</a></li>
							<li><a href="/central/core/about.jsp" id="helpAbout">About CC</a></li>
							<li><a href="/central/core/hlpidx.jsp" id="helpHelp">CC Help</a></li>
						</ul>
					</li>
				</ul>

				<ul><li><a href="/central/core/lo.jsp">Logout</a></ul>
			</div>
		</div>
	</DIV>
	<!-- end header -->
	<DIV id=content>
		<%
			com.ase.paging.Paging paging = new com.ase.paging.Paging();
			String sql = 	aseUtil.getPropertySQL( session, "index" );

			if ( sql != null ){
				// display news with active dates for next 2 weeks
				String startDate = aseUtil.addToDate(0);
				String endDate = aseUtil.addToDate(14);
				String temp = "";
				String dataType = (String)session.getAttribute("aseDataType");

				if ( "Access".equals(dataType) )
					temp = "(enddate <= #" + endDate + " 23:59:59#)";
				else
					temp = "(enddate <= to_date('" + endDate + "', 'mm/dd/yyyy'))";

				sql = sql.replace("_date_", temp );

				paging.setSQL( sql );
				paging.setSorting(false);
				paging.setDetailLink("newsdtlx.jsp");
				paging.setOnClick("return getHelpNewsIndex('<| link |>');");
				paging.setRecordsPerPage(99);
				out.print( paging.showRecords( conn, request, response ) );
				paging = null;
			}

			asePool.freeConnection(conn);
		%>
	</DIV>
	<!-- end content -->
	<DIV id=footer>
		<%@ include file="../inc/footerx.jsp" %>
	</DIV>
	<!-- end footer -->
</DIV>
<!-- end container -->

</body>
</html>