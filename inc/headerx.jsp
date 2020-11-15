<table border="0" width="100%" id="asetable2" cellspacing="0" cellpadding="3">
	<tr class="<%=(String)session.getAttribute("aseBGColor")%>BGColor">
		<td valign="top">
			<%
				int userLevel = NumericUtil.getNumeric(session,"aseUserRights");
				String aseServer = (String)session.getAttribute("aseServer");

				// -------------------------------------------------
				// MAIN
				// -------------------------------------------------
				out.println("<div id=\"bluemenu\" class=\"" + styleSheet + "\">");
				out.println("<ul>");

				String headerCampus = website.getRequestParameter(request,"aseCampus","",true);
				if (	(String)session.getAttribute("aseApplicationTitle") != null && headerCampus != null ) {

					out.println("<li><a href=\"/central/core/index.jsp\">Home</a></li>" +
						"<li><a href=\"/central/core/tasks.jsp\">My Tasks</a></li>" +
						"<li><a href=\"/central/core/crs.jsp\" rel=\"course\">Courses</a></li>");

					String menuEnableProgram = (String)session.getAttribute("aseMenuEnableProgram");
					if (menuEnableProgram != null && menuEnableProgram.equals(Constant.ON)){
						out.println("<li><a href=\"/central/core/prg.jsp\" rel=\"program\">Programs</a></li>");
					}

					String menuEnableFoundation = (String)session.getAttribute("aseMenuEnableFoundation");
					if (menuEnableFoundation != null && menuEnableFoundation.equals(Constant.ON)){
						out.println("<li><a href=\"/central/core/fndmnu.jsp\" rel=\"foundation\">Foundation</a></li>");
					}

					if (userLevel>=Constant.FACULTY){

						String menuEnableSLO = (String)session.getAttribute("aseMenuEnableSLO");
						if (menuEnableSLO != null && menuEnableSLO.equals(Constant.ON)){
							//out.println("<li><a href=\"/central/core/slo.jsp\" rel=\"slo\">SLOs</a></li>");
						}

						out.println("<li><a href=\"/central/core/ccrpt.jsp\" rel=\"report\">Reports</a></li>" +
							"<li><a href=\"/central/core/ccutil.jsp\" rel=\"utilities\">Utilities</a></li>" +
							"<li><a href=\"/central/core/ccbnr.jsp\" rel=\"banner\">Banner</a></li>");
					}

					//
					// logout - option 1
					//
					out.println("<li><a href=\"https://authn.hawaii.edu/cas/logout?service=http://"
						+ aseServer
						+ ":8080/central/core/lo.jsp\">Log Out</a></li>");

					//
					// logout - option 2
					//
					//out.println("<li><a href=\"http://cctest.its.hawaii.edu:8080/central/core/cas.jsp?logout\">Log Out</a></li>");

				}
				else{
					out.println("&nbsp;");
				}

				out.println("<li><a href=\"/central/core/cchlp.jsp\" rel=\"help\">Help</a></li>");

				out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=\"#ffffff\"" + (String)session.getAttribute("aseSystem") + "</font>");

				out.println("</ul>");
				out.println("</div>");

				// -------------------------------------------------
				// COURSE
				// -------------------------------------------------
				out.println("<div id=\"course\" class=\"dropmenudiv\">");
				if (userLevel>=Constant.FACULTY){

					// ttgiang archival
					//out.println("<b>Approval</b>" +
					//	"<a href=\"/central/core/crsappr.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Approve New Outline</a>" +
					//	"<a href=\"/central/core/crsappr.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Approve Outline Proposal</a>" +
					//	"<a href=\"/central/core/crscanappr.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Approval Request</a>");

					// ttgiang archival
					//out.println("<b>Maintenance</b>" +
					//	"<a href=\"/central/core/crscan.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Outline Proposal</a>" +
					//	"<a href=\"/central/core/crscpy.jsp?edt=CUR\">&nbsp;&nbsp;&nbsp;&nbsp;Copy an Outline</a>" +
					//	"<a href=\"/central/core/crscrt.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Create New Course Outline</a>");

					// ttgiang archival
					String deleteOutline = (String)session.getAttribute("aseMenuCourseDelete");
					if (deleteOutline == null || deleteOutline.length() == 0){
						deleteOutline = "0";
					}

					// ttgiang archival
					//if (deleteOutline.equals(Constant.ON) || userLevel > Constant.FACULTY){
					//	out.println("<a href=\"/central/core/crsdlt.jsp?edt=CUR\">&nbsp;&nbsp;&nbsp;&nbsp;Delete Approved Outline</a>");
					//}

					out.println("<a href=\"/central/core/dspcmnts.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Display Comments</a>" +
						"<a href=\"/central/core/vwoutline.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Display Outline</a>");

					// ttgiang archival
					//	"<a href=\"/central/core/shwfld.jsp?edt=PRE&mnu=1\">&nbsp;&nbsp;&nbsp;&nbsp;Enable Outline Items</a>" +
					//	"<a href=\"/central/core/crsmodappr.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Modify Existing Outline</a>" +
					//	"<a href=\"/central/core/crsmod.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Modify Outline Proposal</a>");

					String renameRenumber = (String)session.getAttribute("aseMenuCourseRenameRenumber");
					if (renameRenumber == null || renameRenumber.length() == 0){
						renameRenumber = "0";
					}

					// ttgiang archival
					//if (renameRenumber.equals(Constant.ON) || userLevel > Constant.FACULTY){
					//	out.println("<a href=\"/central/core/crsrnm.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Rename/Renumber Outline</a>");
					//}

					//out.println("<a href=\"/central/core/crsmod.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Work on New Course Outline</a>");

					// ttgiang archival
					//out.println("<b>Review</b>" +
					//	"<a href=\"/central/core/crsrvwcan.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Review Request</a>" +
					//	"<a href=\"/central/core/crsrvw.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Invite Reviewers</a>" +
					//	"<a href=\"/central/core/crsrqstrvw.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Request Outline Review</a>" +
					//	"<a href=\"/central/core/rvw.jsp?itm=course\">&nbsp;&nbsp;&nbsp;&nbsp;Review Outline</a>" +
					//	"<a href=\"/central/core/crsrvwsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Outline Review Status</a>" +
					//	"<a href=\"/central/core/crs.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>");

					out.println("<b>Review</b>" +
						"<a href=\"/central/core/crsrvwsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Outline Review Status</a>" +
						"<a href=\"/central/core/crs.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>");
				}
				else{
					//out.println("<b>Review</b>" +
					//	"<a href=\"/central/core/crsrvwer.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Review Outline</a>");
				}

				out.println("</div>");

				// -------------------------------------------------
				// SLO
				// -------------------------------------------------
				/*
				out.println("<div id=\"slo\" class=\"dropmenudiv\">"+
					"<b>Maintenance</b>"+
					"<a href=\"/central/core/crscmp.jsp?kix=mnu&edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Edit SLO</a>"+
					"<a href=\"/central/core/crsaslo.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Assess SLO</a>"+
					"<a href=\"/central/core/crsacan.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Assessment</a>"+
					"<b>Review</b>"+
					"<a href=\"/central/core/crscmpzz.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Request SLO Review</a>"+
					"<a href=\"/central/core/crsrwslo.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Review SLO</a>"+
					"<a href=\"/central/core/crscanslo.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Review Request</a>"+
					"<b>Approval</b>"+
					"<a href=\"/central/core/crssloappr.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Request Approval</a>"+
					"<a href=\"/central/core/crsapprslo.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Approve SLO</a>"+
					"<a href=\"/central/core/crssloapprcan.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Approval Request</a>"+
					"</div>");
				*/

				// -------------------------------------------------
				// BANNER
				// -------------------------------------------------
				out.println("<div id=\"banner\" class=\"dropmenudiv\">" +
					"<a href=\"/central/core/rstrctns.jsp\">Class Restrictions</a>" +
					"<a href=\"/central/core/bnr.jsp\">Courses & Terms</a>" +
					"<a href=\"/central/core/alphaidx.jsp\">Course Alphas</a>" +
					"<a href=\"/central/core/cllgidx.jsp\">Colleges</a>" +
					"<a href=\"/central/core/dprtmnt.jsp\">Departments</a>" +
					"<a href=\"/central/core/dvsn.jsp\">Divisions</a>" +
					"<a href=\"/central/core/stds.jsp\">Field of Study</a>" +
					"<a href=\"/central/core/lvlidx.jsp\">Levels</a>" +
					"<a href=\"/central/core/trms.jsp\">Terms</a>" +
					"</div>");

				// -------------------------------------------------
				// REPORT
				// -------------------------------------------------
				out.println("<div id=\"report\" class=\"dropmenudiv\">");
				out.println("<b>Outlines</b>" +
					"<a href=\"/central/core/crscnclled.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Cancelled/Withdrawn Outlines</a>" +
					"<a href=\"/central/core/crsdltd.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Deleted Outlines</a>" +
					"<a href=\"/central/core/vwoutline.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Display Outline</a>" +
					"<a href=\"/central/core/crsexc.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Excluded from Catalog</a>" +
					"<a href=\"/central/core/crsexp.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Experimental Outline</a>" +
					"<a href=\"/central/core/crscon.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Linked Outline Items</a>" +
					"<a href=\"/central/core/crsdtes.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Outline Dates</a>" +
					"<a href=\"/central/core/crsinf.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Outline Detail</a>" +
					"<a href=\"/central/core/crssts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Outline Approval Status</a>" +
					"<a href=\"/central/core/crsrvwsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Outline Review Status</a>" +
					"<b>Programs</b>" +
					"<a href=\"/central/core/prgvwidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Display Program</a>" +
					"<a href=\"/central/core/prginf.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Detail</a>" +
					"<a href=\"/central/core/prgsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Approval Status</a>" +
					"<a href=\"/central/core/prgrvwsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Review Status</a>" +
					"<a href=\"/central/core/ccrpt.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>");
				out.println("</div>");

				// -------------------------------------------------
				// PROGRAM
				// -------------------------------------------------
				/*
				out.println("<div id=\"program\" class=\"dropmenudiv\">"
					+ "<b>Maintenance</b>"
					+ "<a href=\"/central/core/prgcan.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Proposed Program</a>"
					+ "<a href=\"/central/core/prgcrt.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Create New Program</a>"
					+ "<a href=\"/central/core/prgdlt.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Delete Approved Program</a>"
					+ "<a href=\"/central/core/prgvwidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Display Program</a>"
					+ "<a href=\"/central/core/prgidxy.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Modify Approved Program</a>"
					+ "<a href=\"/central/core/prgidx.jsp?ack=m\">&nbsp;&nbsp;&nbsp;&nbsp;Modify Proposed Program</a>"
					+ "<a href=\"/central/core/prgidx.jsp?ack=r\">&nbsp;&nbsp;&nbsp;&nbsp;Request Program Approval</a>"
					+ "<b>Progress</b>"
					+ "<a href=\"/central/core/prgprgs.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Progress</a>"
					+ "<a href=\"/central/core/srchp.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Search Programs</a>"
					+ "<b>Approval</b>"
					+ "<a href=\"/central/core/prgappr.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Approve a Program</a>"
					+ "<a href=\"/central/core/prgcanappr.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Approval Request</a>"
					+ "<a href=\"/central/core/prgsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Approval Status</a>"
					+ "<b>Review</b>"
					+ "<a href=\"/central/core/prgrvwcan.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Review Request</a>"
					+ "<a href=\"/central/core/prgrvw.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Invite Reviewers</a>"
					+ "<a href=\"/central/core/prgrqstrvw.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Request Program Review</a>"
					+ "<a href=\"/central/core/rvw.jsp?itm=program\">&nbsp;&nbsp;&nbsp;&nbsp;Review Program</a>"
					+ "<a href=\"/central/core/prgrvwsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Review Status</a>"
					+ "<a href=\"/central/core/prg.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>");
					out.println("</div>");
				*/

				out.println("<div id=\"program\" class=\"dropmenudiv\">"
					+ "<b>Maintenance</b>"
					+ "<a href=\"/central/core/prgvwidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Display Program</a>"
					+ "<b>Progress</b>"
					+ "<a href=\"/central/core/prgprgs.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Progress</a>"
					+ "<a href=\"/central/core/srchp.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Search Programs</a>"
					+ "<b>Approval</b>"
					+ "<a href=\"/central/core/prgsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Program Approval Status</a>"
					+ "<b>Review</b>"
					+ "<a href=\"/central/core/prg.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>");
					out.println("</div>");


				// -------------------------------------------------
				// FOUNDATION
				// -------------------------------------------------
				/*
				out.println("<div id=\"foundation\" class=\"dropmenudiv\">"
					+ "<b>Maintenance</b>"
					+ "<a href=\"/central/core/fndcan.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel a Foundation Course</a>"
					+ "<a href=\"/central/core/fndcrt.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Create New Foundation Course</a>"
					+ "<a href=\"/central/core/fndwip.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Delete Approved Foundation Course</a>"
					+ "<a href=\"/central/core/fndvwidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Display Foundation Course</a>"
					+ "<a href=\"/central/core/fndvwedit.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Edit Foundation Course</a>"
					+ "<a href=\"/central/core/fndwip.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Modify Approved Foundation Course</a>"
					+ "<a href=\"/central/core/fndwip.jsp?ack=r\">&nbsp;&nbsp;&nbsp;&nbsp;Request Foundation Course Approval</a>"
					+ "<b>Progress</b>"
					+ "<a href=\"/central/core/fndwip.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Foundation Course Progress</a>"
					+ "<a href=\"/central/core/srchp.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Search Foundation Course</a>"
					+ "<b>Approval</b>"
					+ "<a href=\"/central/core/fndwip.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Approve a Foundation Course</a>"
					+ "<a href=\"/central/core/fndwip.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Approval Request</a>"
					+ "<a href=\"/central/core/fndwip.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Foundation Approval Status</a>"
					+ "<b>Review</b>"
					+ "<a href=\"/central/core/fndrvwcan.jsp?edt=PRE\">&nbsp;&nbsp;&nbsp;&nbsp;Cancel Review Request</a>"
					+ "<a href=\"/central/core/crsrvw.jsp?fnd=1\">&nbsp;&nbsp;&nbsp;&nbsp;Invite Reviewers</a>"
					+ "<a href=\"/central/core/fndrqstrvw.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Request Foundation Course Review</a>"
					+ "<a href=\"/central/core/rvw.jsp?itm=program\">&nbsp;&nbsp;&nbsp;&nbsp;Review Foundation Course</a>"
					+ "<a href=\"/central/core/fndrvwsts.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Foundation Course Review Status</a>"
					+ "<a href=\"/central/core/fndmnu.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>");
					out.println("</div>");
				*/

				// -------------------------------------------------
				// UTILITIES
				// -------------------------------------------------
				out.println("<div id=\"utilities\" class=\"dropmenudiv\">"
					+ "<b>Faculty</b>"
					+ "<a href=\"/central/core/usrprfl.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;My Profile</a>"
					+ "<a href=\"/central/core/usrlog.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Activity Log</a>"
					+ "<a href=\"/central/core/crscmpr.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Compare Outlines</a>"
					+ "<a href=\"/central/core/mailq.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Daily Notifications</a>"
					+ "<a href=\"/central/core/emailidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Email Lists</a>"
					+ "<a href=\"/central/core/shwfrms.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Forms</a>"
					+ "<a href=\"/central/core/maillog.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Mail Log</a>"
					);

				String menuMessageBoard = (String)session.getAttribute("aseMenuMessageBoard");
				if (menuMessageBoard == null || menuMessageBoard.length() == 0){
					menuMessageBoard = "0";
				}

				if (menuMessageBoard.equals(Constant.ON)){
					out.println("<a href=\"/central/core/msgbrd.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Message Board</a>");
				}

				out.println("<a href=\"/central/core/qlst.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Quick List Entry</a>"
					+ "<a href=\"/central/core/sylidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Syllabus Listing</a>"
					);

				// some items were remove from here and placed on ccutil so that there is room to show the menu
				if (userLevel>=Constant.CAMPADM){
					/*
					out.println("<b>Campus Admin</b>" +
						"<a href=\"/central/core/crsfrmsidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Additional Forms</a>" +
						"<a href=\"/central/core/appridx.jsp?pageClr=1\">&nbsp;&nbsp;&nbsp;&nbsp;Approver Sequence</a>" +
						"<a href=\"/central/core/dfqst.jsp?t=c\">&nbsp;&nbsp;&nbsp;&nbsp;Campus Item Definition</a>" +
						"<a href=\"/central/core/dfqst.jsp?t=r\">&nbsp;&nbsp;&nbsp;&nbsp;Course Item Definition</a>" +
						"<a href=\"/central/core/crslnkdz.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Edit Linked Item Matrix</a>" +
						"<a href=\"/central/core/newsidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;News Maintenance</a>" +
						"<a href=\"/central/core/ini.jsp?pageClr=1\">&nbsp;&nbsp;&nbsp;&nbsp;System Settings</a>" +
						"<a href=\"/central/core/usridx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;User Maintenance</a>" +
						"<a href=\"/central/core/ccutil.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>"
						);
					*/

					out.println("<b>Campus Admin</b>" +
						"<a href=\"/central/core/crsfrmsidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;Additional Forms</a>" +
						"<a href=\"/central/core/appridx.jsp?pageClr=1\">&nbsp;&nbsp;&nbsp;&nbsp;Approver Sequence</a>" +
						"<a href=\"/central/core/newsidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;News Maintenance</a>" +
						"<a href=\"/central/core/usridx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;User Maintenance</a>" +
						"<a href=\"/central/core/ccutil.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;MORE...</a>"
						);

				}

				if (userLevel>=Constant.SYSADM){
					out.println("<b>System Admin</b>" +
						"<a href=\"/central/core/sa.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;System Admin</a>");
				}

				out.println("</div>");

				// -------------------------------------------------
				// HELP
				// -------------------------------------------------
				out.println("<div id=\"help\" class=\"dropmenudiv\">"
					+ "<a href=\"/central/core/about.jsp\">About Curriculum Central (CC)</a>"
					+ "<a href=\"/central/core/ccfaq.jsp\">Announcements</a>"
					+ "<a href=\"/central/core/hlpidx.jsp\">Curriculum Central (CC) Help</a>"
					+ "<a href=\"/central/core/rlsnotes.jsp\">Release Notes</a>"
					+ "<a href=\"/central/core/ccnew.jsp\">Setting up CC</a>"
					+ "<a href=\"/central/inc/cccm6100.htm\" target=\"_blank\">View CCCM6100</a>"
					+ "<a href=\"/central/core/mnts.jsp\">Meeting Minutes</a>"
					);

				out.println("<b>CC Extras</b>"
					+ "<a href=\"/central/core/faq/\">&nbsp;&nbsp;&nbsp;&nbsp;Curriculum Central (CC) Answers!</a>"
					);

				if (userLevel > Constant.CAMPADM){
					out.println("<a href=\"/central/core/rqstidx.jsp\">&nbsp;&nbsp;&nbsp;&nbsp;View Request&nbsp;<img src=\"../images/sysadm.png\" border=\"0\" height=\"16\" width=\"16\" alt=\"\"></a>");
				}

				out.println("<b>Help by Campus</b>" +
					"<a href=\"../core/testHaw.jsp\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Hawaii CC</a>" +
					"<a href=\"https://sites.google.com/a/hawaii.edu/curriculum-central-help/\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Kauai CC</a>" +
					"<a href=\"http://emedia.leeward.hawaii.edu/facsenate-cc/\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Leeward CC</a>" +
					"<a href=\"http://hilo.hawaii.edu/curriculumcentral/\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;UH Hilo</a>" +
					"<a href=\"http://manoa.hawaii.edu/ovcaa/curriculumcentral/\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;UH Manoa</a>" +
					"<a href=\"http://maui.hawaii.edu/cc/index.html\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;UH Maui</a>" +
					"<b>Samples</b>" +
					"<a href=\"/central/core/docs/ics111.pdf\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Outline</a>" +
					"<a href=\"/central/core/docs/ics111-syllabus.pdf\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Syllabus</a>" +
					"<a href=\"/central/core/docs/catalog.pdf\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Catalog</a>" +
					"<b>Workflow</b>" +
					"<a href=\"/central/core/docs/crosswalk.pdf\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;Sitemap</a>" +
					"<a href=\"/central/core/docs/CCworkflow.pdf\" target=\"_blank\">&nbsp;&nbsp;&nbsp;&nbsp;CC Workflow</a>");

				out.println("</div>");
				%>
		</td>
		<td class="<%=(String)session.getAttribute("aseBGColor")%>BGColor" align="right" valign="middle">

			<%
				String ccLab = Util.getSessionMappedKey(session,"EnableCCLab");
				if(ccLab.equals(Constant.ON)){
			%>
				<a href="cclab.jsp" alt="what's in the lab" title="what's in the lab"><img width="18" height="18" src="../images/flask.png" alt="CC Lab is enabled" title="CC Lab is enabled"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%
				}
			%>

			<font color="#c0c0c0">Welcome: <%=website.getRequestParameter(request,"aseUserFullName","",true) %>
			(<%=website.getRequestParameter(request,"aseDept","",true) %>)
			&nbsp;&nbsp;&nbsp;</font>
		</td>
	</tr>
</table>