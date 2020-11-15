<%@page import="com.ase.aseutil.jquery.JQueryServlet"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwer.jsp
	*	2007.09.01	review outline
	*	TODO - allow proposer to comment back to reviewer
	*	TODO remove statement and use arraylist
	*
	*  NOTE: updating here may require updating crsvwer
	*
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crsrvwer");
	session.setAttribute("aseResumeOutline","crsrvwer");

	// this value is set for work with message board. it is set when arriving
	// at the board page and cleared upon returning
	session.setAttribute("aseOrigin",null);

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

	// whether to hide or show items not enabled for modifications
	String hideOrShow = website.getRequestParameter(request,"hide");

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];
	String type = info[Constant.KIX_TYPE];
	String progress = info[Constant.KIX_PROGRESS];
	String subProgress = info[Constant.KIX_SUBPROGRESS];
	String courseTitle = info[Constant.KIX_COURSETITLE];
	String subtitle = "";

	boolean error = false;

	int mode = 0;

	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Outline";

	if (processPage && kix.length()>0){

		if (subProgress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
			mode = Constant.REVIEW_IN_APPROVAL;
			fieldsetTitle = "Outline Review within Approval";
			subtitle = "Review within Approval Comments";
		}
		else{
			mode = Constant.REVIEW;
			subtitle = "Review Comments";
		}

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

	<!-- TTG - popup for quick comment -->
	<%@ include file="./js/plugins/popup/includes.jsp" %>
	<script>

		$(document).ready(function(){
			$("#content").corner("10px");

			var readComment = $('#addComments');

			$("#saveComment").click(function() {
				document.addCommentsForm.acktion.value = "s";
				document.addCommentsForm.submit();
				$.unblockUI();
			});

			$("#cancelComment").click(function() {
				document.addCommentsForm.acktion.value = "c";
				document.addCommentsForm.submit();
				$.unblockUI();
			});

			// Opens up the message to read it when you double click on a message
			$(".popupItem").click(function() {

				// save the id to our popup form so we know how to save the data
				// on submission
				var commentId = this.id;
				var aCommentId = commentId.split("_");
				document.addCommentsForm.tab.value = aCommentId[0];
				document.addCommentsForm.qn.value = aCommentId[1];
				document.addCommentsForm.seq.value = aCommentId[2];
				document.addCommentsForm.bkmrk.value = aCommentId[3];

				$.blockUI(readComment, {width:'540px', height:'300px'});
			});

		 });

	</script>
	<!-- TTG - popup for quick comment -->

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && !error){

		if (alpha != null && num != null){

			boolean hide = false;

			// apply hide/show only if there are enabled items and not all items
			if (MiscDB.getEdit1(conn,kix).length() > 0 || MiscDB.getEdit2(conn,kix).length() > 0){
				if (hideOrShow.equals("1")){
					out.println("<p align=\"center\"><br>Display <a href=\"?kix="+kix+"&hide=0\" class=\"linkcolumn\">all</a> items</p>");
					hide = true;
				}
				else{
					out.println("<p align=\"center\"><br>Display <a href=\"?kix="+kix+"&hide=1\" class=\"linkcolumn\">only</a> items enabled for modifications</p>");
					hide = false;
				}
			} // edit1

			msg = Outlines.reviewOutline(conn,campus,alpha,num,kix,mode,user);
			out.println("<div style=\"position:relative\" id=\"position-relative\">"
				+ msg.getErrorLog()
				+ "</div>");

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
				<div class="hr"></div>
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
								<tr><td colspan="2"><div class="hr"></div></td></tr>
								<TR>
									<td>&nbsp;</td>
									<TD align="left">
										<input type="submit" name="cmdContinue" value="Save & Continue Review" class="" onClick="return checkForm('s')">&nbsp;
										<input type="submit" name="cmdFinish" value="Save & Finish Review" class="" onClick="return checkForm('s')">&nbsp;
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

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<!-- TTG - popup for quick comment -->
<div id="addComments" style="display:none;cursor:default;">
	<h3 class="subheader">
		<%=alpha%>&nbsp;<%=num%>&nbsp;-&nbsp;<%=courseTitle%>
		<br>
		<%=subtitle%>
	</h3>
	<form id="addCommentsForm" name="addCommentsForm" method="POST" action="<%=JQueryServlet.SAVE_COMMENT%>.do">
		<table width=100% class="content_table" >
			<tr>
				<td><textarea name="comment" id="comment" class="inputsmall" style="height:180px;width:520px;"></textarea></td>
			</tr>
		</table>
	<p>
	<input type="hidden" value="<%=alpha%>" name="alpha">
	<input type="hidden" value="<%=num%>" name="num">
	<input type="hidden" value="<%=kix%>" name="kix">
	<input type="hidden" value="<%=mode%>" name="md">
	<input type="hidden" value="0" name="tab">
	<input type="hidden" value="0" name="qn">
	<input type="hidden" value="0" name="seq">
	<input type="hidden" value="0" name="bkmrk">
	<input type="hidden" value="0" name="acktion">
	<input class="inputsmallgray" type="button" id="saveComment" name="saveComment" value="Save">
	<input class="inputsmallgray" type="button" id="cancelComment" name="cancelComment" value="Cancel">
	</form>
</div>
<!-- TTG - popup for quick comment -->

</body>
</html>
