<%@page import="com.ase.aseutil.jquery.JQueryServlet"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndrvwer.jsp
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

	session.setAttribute("aseThisPage","fndrvwer");
	session.setAttribute("aseResumeOutline","fndrvwer");

	// this value is set for work with message board. it is set when arriving
	// at the board page and cleared upon returning
	session.setAttribute("aseOrigin",null);

	String chromeWidth = "90%";
	String pageTitle = "";
	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with
	String thisPage = "fndrvwer";
	session.setAttribute("aseThisPage",thisPage);

	String kix = website.getRequestParameter(request,"kix");

	// whether to hide or show items not enabled for modifications
	String hideOrShow = website.getRequestParameter(request,"hide");

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	int id = NumericUtil.getInt(fnd.getFndItem(conn,kix,"id"),0);

	String[] info = fnd.getKixInfo(conn,kix);
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
	fieldsetTitle = "Review Foundation Course";

	if (processPage && kix.length()>0){

		if (subProgress.equals(Constant.FND_REVIEW_IN_APPROVAL)){
			mode = Constant.REVIEW_IN_APPROVAL;
			fieldsetTitle = "Foundation Course Review within Approval";
			subtitle = "Review within Approval Comments";
		}
		else{
			mode = Constant.REVIEW;
			subtitle = "Review Comments";
		}

		boolean mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,user);
		if (!fnd.isReviewer(conn,campus,alpha,num,user) && !mayKickOffReview){
			error = true;
			message = "You are not authorized to review this foundation course or the review period has expired.";
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + "&rtn=" + thisPage);
		}
	}
	else{
		message = "CC has encountered an invalid operation";
	}

	//
	// message board (forum)
	//
	int fid = 0;
	String messageBoard = Util.getSessionMappedKey(session,"EnableMessageBoard");
	if(messageBoard.equals(Constant.ON)){
		fid = ForumDB.getForumID(conn,campus,kix);
	}

	//
	// review in review
	//
	int reviewerLevel = 0;
	String allowReviewInReview = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","AllowReviewInReview");
	if(allowReviewInReview.equals(Constant.ON)){
		// add 1 to indicate this is the next level up for reviewers inviting people to review
		reviewerLevel = ReviewerDB.getReviewerLevel(conn,kix,user) + 1;
	}

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/fndrvwer.js"></script>
	<link type="text/css" href="../inc/fndedt.css" rel="Stylesheet" />
   <link href="../inc/bootstrap.min.css" rel="stylesheet">

	<style type="text/css">
		legend {
			padding: 4px 4px;
			border-color: #999 #CCC #CCC #999;
			border-style: solid;
			font-size: 12px;
			border-width: 1px;
			background: #EEE;
			width: 200px;
		}

		h3, .h3 {
			font-size: 14px;
		}

		.new_line_padded{ clear: left; padding: 2px 2px;  }

	</style>

	<!-- TTG - popup for quick comment -->
	<%@ include file="./js/plugins/popup/includes.jsp" %>
	<script>

		$(document).ready(function(){
			$("#content").corner("10px");

			var readComment = $('#addComments');

			//
			// saveComment
			//
			$("#saveComment").click(function() {
				document.addCommentsForm.acktion.value = "s";
				document.addCommentsForm.submit();
				$.unblockUI();
			});

			//
			// cancelComment
			//
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
				document.addCommentsForm.f_sq.value = aCommentId[1];
				document.addCommentsForm.f_en.value = aCommentId[2];
				document.addCommentsForm.f_qn.value = aCommentId[3];
				document.addCommentsForm.bkmrk.value = aCommentId[4];

				$.blockUI(readComment, {width:'540px', height:'300px'});
			});

			//
			// cmdFinish
			//
			$("#cmdFinish").click(function() {

				window.location = "fndrvwerx.jsp?f=1&kix=<%=kix%>";

				return false;

			});

			//
			// cmdViewComments
			//
			$("#cmdViewComments").click(function() {

				var myLink = "";

				var messageBoard = '<%=messageBoard%>';

				if(messageBoard=='1'){
					myLink = "./forum/prt.jsp?fid=<%=fid%>&mid=0&itm=0&sq=0&en=0&qn=0";
				}
				else{
					myLink = "crsrvwcmnts.jsp?md=0&kix=<%=kix%>&qn=0";
				}

				var win2 = window.open(myLink, 'myWindow','toolbar=no,width=900,height=800,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');

				return false;

			});

			//
			// cmdInviteReviewers
			//
			$("#cmdInviteReviewers").click(function() {

				window.location = "crsrvw.jsp?kix=<%=kix%>&rl=<%=reviewerLevel%>";

				return false;

			});

		 }); // jq

	</script>
	<!-- TTG - popup for quick comment -->

	<style type="text/css">
		.btn-sm {
			color: #ffffff;
			padding: 5px 10px;
			font-size: 12px;
			line-height: 1.5;
			border-radius: 9px;
		}

	</style>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

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

			msg = fnd.reviewFnd(conn,campus,alpha,num,kix,mode,user);

			out.println("<div style=\"position:relative\" id=\"position-relative\">"
				+ msg.getErrorLog()
				+ "</div>");

			%>

			<br/>

			<%@ include file="fndattach00.jsp" %>

			<%

			String reviewerWithinApprovalCanVote = Util.getSessionMappedKey(session,"ReviewerWithinApprovalCanVote");

			if (		progress.equals(Constant.FND_APPROVAL_TEXT)
					&& subProgress.equals(Constant.FND_REVIEW_IN_APPROVAL)
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
					<form method="post" action="fndrvwerx.jsp" name="aseForm">
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

	fnd = null;

	asePool.freeConnection(conn,"fndrvwer",user);
%>

<%@ include file="../inc/footer.jsp" %>

<!-- TTG - popup for quick comment -->
<div id="addComments" style="display:none;cursor:default;">
	<h3 class="subheader">
		<%=alpha%>&nbsp;<%=num%>&nbsp;-&nbsp;<%=courseTitle%>
		<br>
		<%=subtitle%>
	</h3>
	<form id="addCommentsForm" name="addCommentsForm" method="POST" action="<%=JQueryServlet.SAVE_FND_COMMENT%>.do">
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
	<input type="hidden" value="0" name="f_sq">
	<input type="hidden" value="0" name="f_en">
	<input type="hidden" value="0" name="f_qn">
	<input type="hidden" value="0" name="acktion">
	<input class="inputsmallgray" type="button" id="saveComment" name="saveComment" value="Save">
	<input class="inputsmallgray" type="button" id="cancelComment" name="cancelComment" value="Cancel">
	</form>
</div>
<!-- TTG - popup for quick comment -->

</body>
</html>
