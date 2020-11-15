<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	about.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Curriculum Central (CC) Release Notes";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="./js/jquery/themes/base/jquery-ui.css" />
	<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
	<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>

	<style media="screen" type="text/css">

		#container {
			clear:left;
			width:100%;
			overflow:hidden;
		}
		#row1 {
			width:100%;
			position:relative;
			overflow:hidden;
		}
		#row2 {
			width:100%;
			position:relative;
			overflow:hidden;
		}

	</style>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<div id="container">

	<div id="row1">
		<%@ include file="idx.jsp" %>
	</div>

	<div id="row2">
		<div id="accordion">
		  <h3 align="left">2013.07</h3>
		  <div>
			 <p align="left">
				<ul align="left">
					<li>New (user features)
						<ul>
							<li>Message board (ER00018)</li>
							<li>Advance to campus tab on course edit</li>
							<li>Outline display in compress mode by default</li>
							<li>Email notification during approval</li>
							<li>Audit detail in outline footer</li>
							<li>Upload documents in raw edit</li>
							<!--
							<li>Hide grid when linked items have not been established (pending - KAP request)</li>
							<li>User defined input length</li>
							-->
						</ul>
					</li>
					<li>In Production
						<ul>
							<li>HAW, HIL, HON, KAP, KAU, LEE, MAN, UHMC, WIN</li>
						</ul>
					</li>
					<li>In Test
						<ul>
							<li>WOA</li>
						</ul>
					</li>
					<li>Team Members
						<ul>
							<li>HAW - J. SANTOS, M. OKUMA</li>
							<li>HIL - J. AWAYA, J. IPPOLITO</li>
							<li>KAP - S. POPE</li>
							<li>KAU - K. LEE</li>
							<li>LEE - P. GROSS</li>
							<li>MAN - M. YAMADA, R. BUNGARD</li>
							<li>UHMC - D. AMBY, K. DUKELOW</li>
							<li>WIN - K. MORIMATSU</li>
							<li>WOA - S. PELOWSKI</li>
						</ul>
					</li>
					<li>Project Coordinator
						<ul>
							<li>J. ITANO</li>
						</ul>
					</li>
					<li>Developer
						<ul>
							<li>T. Giang</li>
						</ul>
					</li>
				</ul>
			 </p>
		  </div>

		  <h3 align="left">2013.03</h3>
		  <div>
			 <p align="left">
				<ul align="left">
					<li>New (user features)
						<ul>
							<li>Expedited course deletes</li>
							<li>User maintenance</li>
							<li>Limit effective terms</li>
							<li>Course outline & program search</li>
							<li>Approver routes</li>
							<li>Course summary</li>
							<li>Review in review</li>
							<li>CC Lab
								<ul>
									<li>Print to PDF</li>
									<li>User website and photo in profile</li>
								</ul>
							</li>
							<!--
							<li>Message board (ER00018)</li>
							<li>Hide grid when linked items have not been established (pending - KAP request)</li>
							<li>User defined input length</li>
							-->
						</ul>
					</li>
					<li>In Production
						<ul>
							<li>HAW, HIL, HON, KAP, KAU, LEE, MAN, UHMC, WIN</li>
						</ul>
					</li>
					<li>In Test
						<ul>
							<li>WOA</li>
						</ul>
					</li>
					<li>Team Members
						<ul>
							<li>P. GROSS - LEE</li>
							<li>D. AMBY - UHMC</li>
							<li>R. BUNGARD - MAN</li>
							<li>K. DUKELOW - UHMC</li>
							<li>J. AWAYA, J. IPPOLITO - HIL</li>
							<li>K. LEE - KAU</li>
							<li>K. MORIMATSU - WIN</li>
							<li>S. PELOWSKI - WOA</li>
							<li>S. POPE - KAP</li>
							<li>J. SANTOS, M. OKUMA - HAW </li>
							<li>M. YAMADA - MAN</li>
						</ul>
					</li>
					<li>Project Coordinator
						<ul>
							<li>J. ITANO</li>
						</ul>
					</li>
					<li>Developer
						<ul>
							<li>T. Giang</li>
						</ul>
					</li>
				</ul>
			 </p>
		  </div>

			<h3 align="left">2012.11</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>View outline with review/approver comments</li>
								<li>User defined checkbox and radio controls</li>
								<li>Revisions during black out dates</li>
								<li>Replacing FCKeditor with CKeditor</li>
								<li>System setting to include/exclude proposers notification during course approval (ER00035)</li>
								<!--
								<li>Message board (ER00018)</li>
								<li>Hide grid when linked items have not been established (pending - KAP request)</li>
								<li>User website and photo in profile</li>
								<li>User defined input length</li>
								-->
							</ul>
						</li>
						<li>In Production
							<ul>
								<li>HIL, HON, KAP, KAU, LEE, MAN, UHMC, WIN</li>
							</ul>
						</li>
						<li>In Test
							<ul>
								<li>HAW, WOA</li>
							</ul>
						</li>
						<li>Team Members
							<ul>
								<li>W. ALBRITTON - LEE</li>
								<li>D. AMBY - UHMC</li>
								<li>R. BUNGARD - MAN</li>
								<li>K. DUKELOW - UHMC</li>
								<li>A. KOMENAKA - HIL</li>
								<li>K. LEE - KAU</li>
								<li>K. MORIMATSU - WIN</li>
								<li>S. PELOWSKI - WOA</li>
								<li>S. POPE - KAP</li>
								<li>J. SANTOS - HAW </li>
								<li>M. YAMADA - MAN</li>
							</ul>
						</li>
						<li>Project Coordinator
							<ul>
								<li>J. ITANO</li>
							</ul>
						</li>
						<li>Developer
							<ul>
								<li>T. Giang</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2012.10</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>Auto enable editable items during approval (ER00009)</li>
								<li>Enable outline items for modifications</li>
								<li>Enable grouped item dependency</li>
								<li>Text counter for input control type text, textarea</li>
								<li>Raw edit (ER00026)</li>
								<li>Return to previous position (ER00019)</li>
								<li>Compare outlines across campuses</li>
								<!--
								<li>Message board (ER00018)</li>
								<li>Hide grid when linked items have not been established (pending - KAP request)</li>
								<li>User website and photo in profile</li>
								<li>User defined input length</li>
								-->
							</ul>
						</li>
						<li>In Production
							<ul>
								<li>HIL, HON, KAP, KAU, LEE, MAN, UHMC, WIN</li>
							</ul>
						</li>
						<li>In Test
							<ul>
								<li>HAW, WOA</li>
							</ul>
						</li>
						<li>Team Members
							<ul>
								<li>W. ALBRITTON - LEE</li>
								<li>D. AMBY - UHMC</li>
								<li>R. BUNGARD - MAN</li>
								<li>K. DUKELOW - UHMC</li>
								<li>A. KOMENAKA - HIL</li>
								<li>K. LEE - KAU</li>
								<li>K. MORIMATSU - WIN</li>
								<li>S. PELOWSKI - WOA</li>
								<li>S. POPE - KAP</li>
								<li>J. SANTOS - HAW </li>
								<li>M. YAMADA - MAN</li>
							</ul>
						</li>
						<li>Project Coordinator
							<ul>
								<li>J. ITANO</li>
							</ul>
						</li>
						<li>Developer
							<ul>
								<li>T. Giang</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2012.08</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>User defined course catalog (ER00025)</li>
								<li>Course/Program action report (ER00016)</li>
								<li>Announcements linked by page (see help icon at lower right-hand corner)</li>
								<li>System setting (see links at lower right-hand corner)</li>
								<li>View archived/deleted history</li>
								<li>Experimental & End Date Reporting</li>
								<!--
								<li>Message board (ER00018)</li>
								<li>Hide grid when linked items have not been established (pending - KAP request)</li>
								<li>User website and photo in profile</li>
								<li>User defined input length</li>
								-->
							</ul>
						</li>
						<li>In Production
							<ul>
								<li>HIL, HON, KAP, KAU, LEE, MAN, UHMC, WIN</li>
							</ul>
						</li>
						<li>In Test
							<ul>
								<li>HAW, WOA</li>
							</ul>
						</li>
						<li>Team Members
							<ul>
								<li>W. ALBRITTON - LEE</li>
								<li>D. AMBY - UHMC</li>
								<li>R. BUNGARD - MAN</li>
								<li>K. DUKELOW - UHMC</li>
								<li>A. KOMENAKA - HIL</li>
								<li>K. LEE - KAU</li>
								<li>K. MORIMATSU - WIN</li>
								<li>S. PELOWSKI - WOA</li>
								<li>S. POPE - KAP</li>
								<li>J. SANTOS - HAW </li>
								<li>M. YAMADA - MAN</li>
							</ul>
						</li>
						<li>Project Coordinator
							<ul>
								<li>J. ITANO</li>
							</ul>
						</li>
						<li>Developer
							<ul>
								<li>T. Giang</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2012.06</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>Email course outline/program proposal as attachment (ER00006 - LEE request)</li>
								<li>Hide/show items on course review/approval screen (MAN request)</li>
								<li>Course modification enhanced display</li>
								<li>List exports (Reports >> Exports)</li>
								<li>Campuses determine approval email FROM name (last approver or proposer - MAN request)</li>
								<li>Help Index on outline maintenance screen (MAN request)</li>
								<li>Flex table task display</li>
								<li>Editor width adjusted from 600 to 800px (KAU request)</li>
								<li>Compare similar items system wide</li>
								<li>Header Text (MAN request)</li>
								<li>Access to *ALL alphas (MAN request)</li>
								<li>Show GESLO links to Evals (KAU request)</li>
								<li>Activity log search</li>
								<li>Re-sequence approvers</li>
							</ul>
						</li>
						<li>In Production
							<ul>
								<li>HIL, KAP, LEE, MAN, UHMC, WIN</li>
							</ul>
						</li>
						<li>In Test
							<ul>
								<li>HAW, HON, KAU</li>
							</ul>
						</li>
						<li>Team Members
							<ul>
								<li>W. ALBRITTON - LEE</li>
								<li>D. AMBY - UHMC</li>
								<li>R. BUNGARD - MAN</li>
								<li>K. DUKELOW - UHMC</li>
								<li>A. KOMENAKA - HIL</li>
								<li>K. LEE - KAU</li>
								<li>K. MORIMATSU - WIN</li>
								<li>S. POPE - KAP</li>
								<li>J. SANTOS - HAW </li>
								<li>M. YAMADA - MAN</li>
							</ul>
						</li>
						<li>Project Coordinator
							<ul>
								<li>J. ITANO</li>
							</ul>
						</li>
						<li>Developer
							<ul>
								<li>T. Giang</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2011.12</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>Approval Routing as Packets</li>
								<li>Course Create</li>
								<li>Daily email notification</li>
								<li>Enable/Disable extra button during Course Modifications</li>
								<li>Flex Table</li>
								<li>General Education SLO display in multiple formats</li>
								<li>Quick Edit</li>
								<li>Rename/Renumber during course modification</li>
								<li>Send mail from test system</li>
								<li>Department drop down list</li>
							</ul>
						</li>
						<li>Enhancement
							<ul>
								<li>Text and Word counter (ER00024)</li>
							</ul>
						</li>
						<li>In Production
							<ul>
								<li>HIL, KAP, LEE, UHMC, WIN</li>
							</ul>
						</li>
						<li>In Test
							<ul>
								<li>HAW, KAU, MAN</li>
							</ul>
						</li>
						<li>Team Members
							<ul>
								<li>W. ALBRITTON - LEE</li>
								<li>D. AMBY - UHMC</li>
								<li>R. BUNGARD - MAN</li>
								<li>K. DUKELOW - UHMC</li>
								<li>A. KOMENAKA - HIL</li>
								<li>K. LEE - KAU</li>
								<li>K. MORIMATSU - WIN</li>
								<li>S. POPE - KAP</li>
								<li>J. SANTOS - HAW </li>
								<li>M. YAMADA - MAN</li>
							</ul>
						</li>
						<li>Project Coordinator
							<ul>
								<li>J. ITANO</li>
							</ul>
						</li>
						<li>Developer
							<ul>
								<li>T. Giang</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2011.09</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>Enable/Disable Programs and SLOs menu item</li>
								<li>Enable/Disable Display of comment box during course/program edits</li>
								<li>Implementation of FlexTable
									<ul>
										<li>Reports >> display outline >> course or programs</li>
										<li>Reports >> approval status</li>
										<li>Reports >> review status</li>
									</ul>
								</li>
								<li>Implementation of FlexEdit
									<ul>
										<li>System Settings</li>
									</ul>
								</li>
								<li>Up to date Banner display of course data</li>
								<li>User task list maintenance (admin only)</li>
								<li>CC setup verification (Utilities >> Review CC Setup)</li>
								<li>Show/Hide course title on Display Report screen</li>
							</ul>
						</li>
						<li>Enhancement
							<ul>
								<li>Various enhancements (ER00014)</li>
								<li>News maintenance is a 2 step process. Step 1 collects news information and Step 2 for file uploads.</li>
							</ul>
						</li>
						<li>Fixes
							<ul>
								<li>List import (DF00040)</li>
								<li>Correct outline questions display inconsistencies (DF)</li>
								<li>Program raw edits (DF00041)</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2011.04</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>New (user features)
							<ul>
								<li>Change approver name (ER00001)</li>
								<li>Change approval routing sequence (ER00003)</li>
								<li>CCCM6100 Questions Used (Utilities >> System Wide)</li>
								<li>Online Defect/Enhancement Reports (Utilities >> System Wide)</li>
								<li>User Friendly PDF Reports (on going)</li>
								<li>Hide grid when linked items have not been established (pending)</li>
								<li>Email course outline/program proposal as attachment (pending)</li>
							</ul>
						</li>
						<li>New (technical features)
							<ul>
								<li>Session check for access</li>
							</ul>
						</li>
						<li>Fixes
							<ul>
								<li>List import (DF00040)</li>
								<li>Correct outline questions display inconsistencies (DF)</li>
								<li>Progrma raw edits (DF00041)</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2010.10</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>Edit approval comments</li>
						<li>Expanded name selection box (ER00002)</li>
						<li>Include PLO on course create</li>
						<li>Recommended approval workflow</li>
						<li>Restoration of cancelled programs</li>
						<li>Track Item Changes</li>
						<li>Rename outline</li>
						<li>Change reviewer comment display for ease of viewing</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2010.08</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>Adding drop down list for contact hours</li>
						<li>Message Page</li>
						<li>Screen with editable items for Functional Designation</li>
						<li>Pre/Co Requisites Consent</li>
						<li>Number of credits as drop down list</li>
						<li>Approval Black Out Date</li>
						<li>Approval By Date</li>
						<li>Outline Approvals as Packets</li>
						<li>Pre/Co Requisites & Cross Listing Approval</li>
						<li>Course Menu Changes</li>
						<li>Task Display</li>
						<li>Programs & Course</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2010.04</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>Compare outline items</li>
						<li>Enable items during review</li>
						<li>Import data</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2010.01</h3>
			<div>
				<p align="left">
					<ul align="left">
					<li>Create task for NotifiedWhenApproved distribution list</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2009.12</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>Outline Restore</li>
						<li>Fast Track approvals</li>
						<li>One Step Back on outline approval rejection</li>
						<li>Course item definition upgrades</li>
						<li>System settings upgrades</li>
						<li>Outline Approval Review - include reviews during the approval process</li>
						<li>User Email List - users can create email distribution list. Useful when sending for reviews by groups.</li>
						<li>Outline Validation - approval not permitted until all required outline items have been completed.<br/>
							Campus administrators may set system flag EnableOutlineValidation to '1' to enable validation or '0' to ignore.
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2009.11</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>System StartPage - campus determines landing page upon successful login</li>
						<li>Compare outlines - place outlines side by side to compare differences</li>
						<li>Outline at a glance - display information about an outline</li>
						<li>Disabled 'Add Approver' on Approver Sequence screen when there are outline approvals in progress for the selected sequence.</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2009.10</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>Outline Approver Instructions - campus admin may add notes/instructions to be sent with outline approval email.</li>
						<li>Notify when Cross-Listing added - when enabled, division chairs of cross-listed outline will be notified by email</li>
						<li>Outline cancellation notifies only those who have approved or is schedule to approve</li>
						<li>Help documentation by page. For example, campuses can write help documentation for individual pages</li>
						<li>Display state of an outline on user's task list. The following
						states are available:
							<ul>
								<li>DELETING - pending approval task for outline going through deletion process</li>
								<li>MODIFY - task to be operated on an existing outline</li>
								<li>NEW - task to be operated on a newly created outline</li>
							</ul>
						</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2009.09</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>View reviewer/approver comments (Course &gt;&gt; Display Comments, Reports &gt;&gt; Outline Review Comments)<br/><br/></li>
						<li>Upload attachments to news - available to campus administrators (Utilities &gt;&gt; News Maintenance)<br/><br/></li>
						<li>Additional ALPHAs - support for multiple alpha/departments. Applicable to
						viewing, creating, modification, etc. of outlines.<br/><br/></li>
						<li>Edit reviewer comments - permit edit/delete of reviewer comments
						up until the review session ends</li>
						<li>Attachments (Within course modifications)<br/><br/></li>
						<li>Additional Forms - linking additional forms to campus process (Utilities &gt;&gt; Forms)<br/><br/></li>
						<li>Consent for Pre/Co-Requisites (Within course modifications)</li>
					</ul>
				</p>
			</div>

			<h3 align="left">2009.08</h3>
			<div>
				<p align="left">
					<ul align="left">
						<li>Quick List Entry (Within course modifications, Utilities &gt;&gt; Quick List Entry)</li>
					</ul>
				</p>
			</div>

		</div>
	</div>

</div>

<%@ include file="../inc/footer.jsp" %>

<%
	asePool.freeConnection(conn,"rlsnotes",user);
%>

	<script>
		$(function() {
			$( "#accordion" ).accordion({
				heightStyle: "content"
			});
		});
	</script>

</body>
</html>
