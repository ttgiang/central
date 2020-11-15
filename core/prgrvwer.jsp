<%@page import="com.ase.aseutil.jquery.JQueryServlet"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvwer.jsp
	*	2007.09.01	review program
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "90%";
	String pageTitle = "";
	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with
	String thisPage = "prgrvwer";
	session.setAttribute("aseThisPage",thisPage);

	String kix = website.getRequestParameter(request,"kix");
	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_PROGRAM_TITLE];
	String num = info[Constant.KIX_PROGRAM_DIVISION];

	String progress = ProgramsDB.getProgramProgress(conn,campus,kix);
	String subProgress = ProgramsDB.getSubProgress(conn,kix);

	String subtitle = "";

	// whether to hide or show items not enabled for modifications
	String hideOrShow = website.getRequestParameter(request,"hide");

	int mode = 0;

	// GUI
	pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Program";

	if (processPage){

		if (subProgress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){
			mode = Constant.REVIEW_IN_APPROVAL;
			fieldsetTitle = "Program Review within Approval";
			subtitle = "Review within Approval Comments";
		}
		else{
			mode = Constant.REVIEW;
			subtitle = "Review Comments";
		}

		boolean mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,user);

		if (kix.length()>0){
			if (!ProgramsDB.isProgramReviewer(conn,campus,kix,user) && !mayKickOffReview){
				message = "You are not authorized to review this program or the review period has expired.";
				session.setAttribute("aseApplicationMessage",message);
				response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + campus + "&rtn=" + thisPage);
			}
		}
	}
	else
		message = "CC has encountered an invalid operation";

%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/prgrvwer.js"></script>

	<!-- TTG - popup for quick comment -->
	<%@ include file="./js/plugins/popup/includes.jsp" %>
	<script>

		$(document).ready(function(){
			$("#content").corner("10px");

			var readComment = $('#addComments');

			$("#saveComment").click(function() {
				document.addCommentsForm.submit();
				$.unblockUI();
			});

			$("#cancelComment").click(function() {
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
	if (processPage){
		if (kix != null){

			boolean hide = false;

			// apply hide/show only if there are enabled items and not all items
			// must be > 1 because a CSV is the only applicable use
			if (MiscDB.getProgramEdit1(conn,kix).length() > 1){
				if (hideOrShow.equals("1")){
					out.println("<p align=\"center\"><br>Display <a href=\"?kix="+kix+"&hide=0\" class=\"linkcolumn\">all</a> items</p>");
					hide = true;
				}
				else{
					out.println("<p align=\"center\"><br>Display <a href=\"?kix="+kix+"&hide=1\" class=\"linkcolumn\">only</a> items enabled for modifications</p>");
					hide = false;
				}
			} // edit1

			msg = ProgramsDB.reviewProgram(conn,campus,kix,Constant.REVIEW,user,hide);
			out.println("<div style=\"position:relative\" id=\"position-relative\">"
				+ msg.getErrorLog()
				+ "</div>");

			if (	progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) &&
					subProgress.equals(Constant.PROGRAM_REVIEW_IN_APPROVAL)){

				String comments = "";

				String inviter = TaskDB.getInviter(conn,campus,kix,user);
				History history = HistoryDB.getHistory(conn,campus,kix,user,inviter);

				if (history != null){
					comments = history.getComments();
				}

			%>
				<div class="hr"></div>
				<fieldset class="FIELDSET90">
					<legend>Program Review for Approval</legend>
					<form method="post" action="prgrvwerx.jsp" name="aseForm">
						<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
							<TBODY>
								<tr><td width="10%" class="textblackth">Reviewer:</td><td class="datacolumn"><%=user%></td></tr>
								<tr><td width="10%" class="textblackth">Date:</td><td class="datacolumn"><%=aseUtil.getCurrentDateTimeString()%></td></tr>
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
										<input type="submit" name="cmdContinue" value="Save & Continue Review" class="input" onClick="return checkForm('s')">&nbsp;
										<input type="submit" name="cmdFinish" value="Save & Finish Review" class="input" onClick="return checkForm('s')">&nbsp;
										<input type="hidden" value="c" name="formAction">
										<input type="hidden" value="aseForm" name="formName">
										<input type="hidden" value="<%=kix%>" name="kix">
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
		} // kix != null
	}
	else{
		out.println(message);
	}

	asePool.freeConnection(conn,"prgrvwer",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<!-- TTG - popup for quick comment -->
<div id="addComments" style="display:none;cursor:default;">
	<h3 class="subheader">
		<%=alpha%>&nbsp;-&nbsp;<%=num%>
		<br>
		<%=subtitle%>
	</h3>
	<form id="addCommentsForm" name="addCommentsForm" method="POST" action="<%=JQueryServlet.SAVE_PROGRAM_COMMENT%>.do">
		<table width=100% class="content_table" >
			<tr>
				<td><textarea name="comment" id="comment" class="inputsmall" style="height:180px;width:520px;"></textarea></td>
			</tr>
		</table>
	<p>
	<input type="hidden" value="<%=kix%>" name="kix">
	<input type="hidden" value="<%=mode%>" name="md">
	<input type="hidden" value="0" name="tab">
	<input type="hidden" value="0" name="qn">
	<input type="hidden" value="0" name="seq">
	<input class="inputsmallgray" type="button" id="saveComment" value="Save">
	<input class="inputsmallgray" type="button" id="cancelComment" value="Cancel">
	</form>
</div>
<!-- TTG - popup for quick comment -->

</body>
</html>
