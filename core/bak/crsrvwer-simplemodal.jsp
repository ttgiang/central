<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwer.jsp
	*	2007.09.01	review outline
	*	TODO - allow proposer to comment back to reviewer
	*	TODO remove statement and use arraylist
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

	String chromeWidth = "90%";
	String pageTitle = "";
	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with
	String thisPage = "crsrvwer";
	session.setAttribute("aseThisPage",thisPage);

	String kix = website.getRequestParameter(request,"kix");
	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];
	String progress = info[Constant.KIX_PROGRESS];
	String subProgress = info[Constant.KIX_SUBPROGRESS];

	boolean error = false;

	int mode = 0;

	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Outline";

	if (processPage && kix.length()>0){

		if (subProgress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
			mode = Constant.REVIEW_IN_APPROVAL;
			fieldsetTitle = "Outline Review within Approval";
		}
		else
			mode = Constant.REVIEW;

		boolean mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,user);
		if (!courseDB.isCourseReviewer(conn,campus,alpha,num,user) && !mayKickOffReview){
			error = true;
			message = "You are not authorized to review this outline or the review period has expired.";
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + "&rtn=" + thisPage);
		}
	}
	else
		message = "CC has encountered an invalid operation";

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/crsrvwer.js"></script>
	<link type='text/css' href='./js/popup/css/demo.css' rel='stylesheet' media='screen' />
	<link type='text/css' href='./js/popup/css/contact.css' rel='stylesheet' media='screen' />
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && !error){

		if (alpha != null && num != null){

			String useJquery = SysDB.getSys(conn,"useJQUERY");

			if (useJquery.equals(Constant.OFF)){
				msg = Outlines.reviewOutline(conn,campus,alpha,num,kix,mode,user);
				out.println(msg.getErrorLog());
			}
			else{
				//TTG - popup for quick comment
				msg = Outlines.reviewOutline(conn,campus,alpha,num,kix,mode,user);
				out.println("<div id='container'><div id='content'><div id='contact-form'>");
				out.println(msg.getErrorLog());
				out.println("</div></div></div>");
			}

			String reviewerWithinApprovalCanVote = Util.getSessionMappedKey(session,"ReviewerWithinApprovalCanVote");

			if (		progress.equals(Constant.COURSE_APPROVAL_TEXT)
					&& subProgress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)
					&& reviewerWithinApprovalCanVote.equals(Constant.ON)
					){

				String comments = "";
				int voteFor = 0;
				int voteAgainst = 0;
				int voteAbstain = 0;

				String inviter = TaskDB.getInviter(conn,campus,alpha,num,user);
				History history = HistoryDB.getHistory(conn,campus,kix,user,inviter);

				if (history != null){
					comments = history.getComments();
					voteFor = history.getVoteFor();
					voteAgainst = history.getVoteAgainst();
					voteAbstain = history.getVoteAbstain();
				}

			%>
				<hr size="1">
				<fieldset class="FIELDSET90">
					<legend><%=fieldsetTitle%></legend>
					<form method="post" action="crsrvwerx.jsp" name="aseForm">
						<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
							<TBODY>
								<tr><td width="10%" class="textblackth">Reviewer:</td><td class="datacolumn"><%=user%></td></tr>
								<tr><td width="10%" class="textblackth">Date:</td><td class="datacolumn"><%=aseUtil.getCurrentDateTimeString()%></td></tr>
								<TR>
									<TD valign="top" width="10%" class="textblackth">Vote:</td>
									<td>
										For:&nbsp;&nbsp;<input type="input" value="<%=voteFor%>" class="input" maxlength="3" size="3" name="voteFor">
										&nbsp;&nbsp;Against:&nbsp;&nbsp;<input type="input" value="<%=voteAgainst%>" class="input" maxlength="3" size="3" name="voteAgainst">
										&nbsp;&nbsp;Abstain:&nbsp;&nbsp;<input type="input" value="<%=voteAbstain%>" class="input" maxlength="3" size="3" name="voteAbstain">
									</TD>
								</TR>
								<TR>
									<TD valign="top" width="10%" class="textblackth">Comments:</td>
									<td>
										<textarea name="comments" cols="80" rows="10" class="input"><%=comments%></textarea>
									</TD>
								</TR>
								<TR><td>&nbsp;</td><TD align="left" colspan="2"><% out.println(Skew.showInputScreen(request)); %></td></tr>
								<tr><td colspan="2"><hr size="1"></td></tr>
								<TR>
									<td>&nbsp;</td>
									<TD align="left">
										<input type="submit" name="cmdContinue" value="Save & Continue Review" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
										<input type="submit" name="cmdFinish" value="Save & Finish Review" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
										<input type="hidden" value="c" name="formAction">
										<input type="hidden" value="aseForm" name="formName">
										<input type="hidden" value="<%=kix%>" name="kix">
										<input type="hidden" value="<%=mode%>" name="mode">
									</TD>
								</TR>
								<tr>
									<td colspan="2"><br/>
										<b>NOTE</b>:
										<ul>
											<li>Save & Finish Review - saves form data and finalizes outline review</li>
											<li>Save & Continue Review - saves form data but not finalizing outline review</li>
										</ul>
									</td>
								</tr>
							</TBODY>
						</TABLE>
					</form>
				</fieldset>
			<%
			}
		}
	}
	else{
		out.println(message);
	}

	asePool.freeConnection(conn,"crsrvwer",user);
%>

<script type='text/javascript' src='./js/popup/js/jquery.js'></script>
<script type='text/javascript' src='./js/popup/js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='./js/popup/js/contact.js'></script>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
