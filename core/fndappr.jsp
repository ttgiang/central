<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.ase.aseutil.jquery.JQueryServlet"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndappr.jsp - outline approval
	*
	*	2009.07.22 - enable voting buttons for all levels (remove isDivisionChair)
	*	2007.09.01 - initial
	*
	*  NOTE: updating here may require updating crsvwer
	*
	**/

	boolean processPage = true;
	boolean error = false;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "fndappr";
	session.setAttribute("aseThisPage",thisPage);
	session.setAttribute("aseResumeOutline",thisPage);

	String alpha = "";
	String num = "";
	String type = "";
	String message = "";
	String screenMessage = "";
	String progress = "";
	int route = 0;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = website.getRequestParameter(request,"kix","");

	//
	// ER00009 - ttg - 2012.08.12
	// remember where user comments so we can place check marks on this page
	//
	String enabledForEdits = ParkDB.getApproverCommentedItems(conn,kix,user);

	// whether to hide or show items not enabled for modifications
	String hideOrShow = website.getRequestParameter(request,"hide");

	String reviseDisabled = "";
	String submitClass = "";
	String courseTitle = "";

	if (!kix.equals(Constant.BLANK)){
		String[] info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
		progress = info[Constant.KIX_PROGRESS];
		courseTitle = info[Constant.KIX_COURSETITLE];

		if (progress.equals(Constant.COURSE_DELETE_TEXT)){
			reviseDisabled = "disabled";
			submitClass = "off";
			screenMessage = "<br><br><br><font class=\"textblackth\">Note: Revisions are not permitted when an outline is going through the approval process for deletion.</font>";
		}
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "80%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Foundation Course Approval";

	boolean approvalAllowed = true;
	String approvalByDate = "";
	String itemIsEnabled = "";

	if (processPage && kix.length()>0){

		// check on approval by date
		if ((Constant.ON).equals(Util.getSessionMappedKey(session,"EnableApprovalByDates"))){
			Approver ap = ApproverDB.getApprover(conn,user,route);
			if(ap != null){
				approvalByDate = ap.getEndDate();

				// is today's date greater than the approve by date. a blank date means we don't have to check
				if (!approvalByDate.equals(Constant.BLANK) &&
						DateUtility.compare2Dates(aseUtil.getCurrentDateString(),approvalByDate) > 0){
					approvalAllowed = false;
					processPage = false;
					error = true;
				}
			}
		}

		if (processPage){

			// approvals allowed for outlines in APPROVAL or DELETE progress and type="PRE"
			if (	(progress.equals(Constant.COURSE_APPROVAL_TEXT) || progress.equals(Constant.COURSE_DELETE_TEXT))
					&& type.equals(Constant.PRE)){
				if (!courseDB.isNextApprover(conn,campus,alpha,num,user)){
					error = true;
					response.sendRedirect("fndappry.jsp?kix=" + kix);
				}
				else{
					session.setAttribute("aseApplicationMessage","");
				}
			}
			else{
				error = true;
				session.setAttribute("aseApplicationMessage","");
				response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
			}
		}
	}

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Voting buttons may ben enabled during review and approval process.");

	String enableVotingButtons = "";
	String votingText = "";
	boolean showGroupVote = false;
	String subProgress = "";
	History h = null;

	if (processPage && !error){
		enableVotingButtons = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableVotingButtons");

		if (enableVotingButtons.equals(Constant.ON)){
			//
			//	approval and review in approval displays voting summary
			//	or
			//	review
			//
			subProgress = outlines.getSubProgress(conn,kix);

			if (
					(progress.equals(Constant.FND_APPROVAL_TEXT) && progress.equals(Constant.FND_REVIEW_IN_APPROVAL)) ||
					progress.equals(Constant.FND_REVIEW_TEXT)
				){
				h = HistoryDB.getGroupVotes(conn,campus,kix,user);
				if (h != null){
					showGroupVote = true;
					votingText = "Group Votes";
				} // h != null
			} // approval and review in approval or just review
			else{
				// in approval process, show for info only
				if (progress.equals(Constant.FND_APPROVAL_TEXT)){
					h = HistoryDB.getGroupVotes(conn,campus,kix,"");
					if (h != null){
						showGroupVote = true;
						votingText = "All Votes";
					} // h != null
				} // FND_APPROVAL_TEXT
			}
		} // enableVotingButtons

		// ttg-showGroupVote
		showGroupVote = false;

	} // processPage
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="js/fndappr.js"></script>

	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

	<%@ include file="highslide.jsp" %>
	<%@ include file="stickytooltip.jsp" %>

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

			var enabledForEdits = "<%=enabledForEdits%>";

			// Opens up the message to read it when you double click on a message
			$(".popupItem").click(function() {

				// save the id to our popup form so we know how to save the data
				// on submission
				var allowEdit = 0;
				var commentId = this.id;
				var aCommentId = commentId.split("_");
				document.addCommentsForm.tab.value = aCommentId[0];
				document.addCommentsForm.qn.value = aCommentId[1];
				document.addCommentsForm.seq.value = aCommentId[2];
				document.addCommentsForm.bkmrk.value = aCommentId[3];
				allowEdit = aCommentId[4];

				if(enabledForEdits != ''){
					enabledForEdits = ","+enabledForEdits+",";
					var thisSequence = ","+document.addCommentsForm.seq.value+",";
					if(enabledForEdits.indexOf(thisSequence) > -1){
						document.addCommentsForm.enableForMod.checked = true;
					}
				}

				if(allowEdit == 0){
					document.addCommentsForm.enableForMod.disabled = true;
				}

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

		msg = outlines.reviewOutline(conn,campus,alpha,num,kix,Constant.APPROVAL,user,hide);

		out.println("<div style=\"position:relative\" id=\"position-relative\">"
			+ msg.getErrorLog()
			+ "</div>");
%>
	<form method="post" action="fndapprx.jsp" name="aseApprovalForm">
		<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
			<TBODY>
				<tr><td colspan="2"><div class="hr"></div></td></tr>
				<tr><td width="10%" class="textblackth">Approver:</td><td class="datacolumn"><%=user%></td></tr>
				<tr><td width="10%" class="textblackth">Date:</td><td class="datacolumn"><%=aseUtil.getCurrentDateTimeString()%></td></tr>

				<%
					if (showGroupVote){
				%>
					<TR>
						<TD valign="top" width="10%" class="textblackth"><%=votingText%>:</td>
						<td>
							For:&nbsp;&nbsp;<input type="input" disabled value="<%=h.getVoteFor()%>" class="input" maxlength="3" size="3" name="groupFor">
							&nbsp;&nbsp;Against:&nbsp;&nbsp;<input type="input" disabled value="<%=h.getVoteAgainst()%>" class="input" maxlength="3" size="3" name="groupAgainst">
							&nbsp;&nbsp;Abstain:&nbsp;&nbsp;<input type="input" disabled value="<%=h.getVoteAbstain()%>" class="input" maxlength="3" size="3" name="groupAbstain">
						</TD>
					</TR>
				<%
					}
				%>

				<TR>
					<TD valign="top" width="10%" class="textblackth">Vote:</td>
					<td>
						For:&nbsp;&nbsp;<input type="input" value="0" class="input" maxlength="3" size="3" name="voteFor">
						&nbsp;&nbsp;Against:&nbsp;&nbsp;<input type="input" value="0" class="input" maxlength="3" size="3" name="voteAgainst">
						&nbsp;&nbsp;Abstain:&nbsp;&nbsp;<input type="input" value="0" class="input" maxlength="3" size="3" name="voteAbstain">
						<!--
						&nbsp;<a href="crshst.jsp?hid=<%=kix%>&nvtr=&t=PRE" class="linkColumn" onclick="asePopUpWindow(this.href,'aseWin4','800','600','yes','center');return false" onfocus="this.blur()">view history</a>
						-->
					</TD>
				</TR>
				<TR>
					<TD valign="top" width="10%" class="textblackth">Comments:</td>
					<td>
<%
						String ckName = "comments";
						String ckData = "";
%>
			<%@ include file="ckeditor02.jsp" %>

						<input type="hidden" value="<%=alpha%>" name="alpha">
						<input type="hidden" value="<%=num%>" name="num">
					</TD>
				</TR>
				<TR><td>&nbsp;</td><TD align="left" colspan="2"><% out.println(Skew.showInputScreen(request)); %></td></tr>
				<TR>
					<td>&nbsp;</td>
					<TD align="left">
						<br>
						<input title="approval outline content" type="submit"  value=" Approve " class="inputgo" onClick="return checkForm('s');">&nbsp;
						<input title="revise outline content..." type="submit" value=" Revise  " <%=reviseDisabled%> class="inputstop<%=submitClass%>" onClick="return checkForm('r')">&nbsp;
						<input title="review outline content..." type="submit" value=" Review  " class="inputother" onClick="return checkForm('v');">&nbsp;
						<input title="cancel selected operation" type="submit" value=" Cancel  " class="inputother" onClick="return cancelForm();">&nbsp;
						<input title="view approval history" type="submit" value=" History  " class="inputother" onClick="return showHistory('<%=kix%>');">
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseApprovalForm" name="formName">
						<input type="hidden" value="<%=enabledForEdits%>" name="e">
						<%=screenMessage%>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</form>

<div class="hr"></div>

<font class="textblackth">Button Description</font>
<ul>
	<li class="textblack">Approve - save your vote and comment and sends the process on to the next approver. If you are the last approver, the process ends.</li>
	<li class="textblack">Revise - sends the outline back to the proposer/author for revision.</li>
	<li class="textblack">Review - sends the outline out for review/voting by select users</li>
	<li class="textblack">Cancel - cancels your approval at this time. You may return to this screen by selecting "Outline approval" from your task list.</li>
</ul>

NOTE: Highlighted item(s) are items requiring modifications by the proposer/author.

<%
	}
	else{
		if (!approvalAllowed){
			%>
				The period for this outline approval has ended (<%=approvalByDate%>).
				<br>
				<br>
				Contact your CC administrator for assistance.
			<%
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<%
	asePool.freeConnection(conn,"fndappr",user);
%>

<!-- TTG - popup for quick comment -->
<div id="addComments" style="display:none;cursor:default;">
	<h3 class="subheader">
		<%=alpha%>&nbsp;<%=num%>&nbsp;-&nbsp;<%=courseTitle%>
		<br>
		Approval Comments
	</h3>
	<form id="addCommentsForm" name="addCommentsForm" method="POST" action="<%=JQueryServlet.SAVE_COMMENT%>.do">
		<table width=100% class="content_table" >
			<tr>
				<td><textarea name="comment" id="comment" class="inputsmall" style="height:180px;width:520px;"></textarea></td>
			</tr>
			<tr>
				<td><input type="checkbox" name="enableForMod" id="enableForMod" value="1"> Check here to enable this item for modificaton</td>
			</tr>
		</table>
	<p>
	<input type="hidden" value="<%=alpha%>" name="alpha">
	<input type="hidden" value="<%=num%>" name="num">
	<input type="hidden" value="<%=kix%>" name="kix">
	<input type="hidden" value="<%=Constant.APPROVAL%>" name="md">
	<input type="hidden" value="0" name="tab">
	<input type="hidden" value="0" name="qn">
	<input type="hidden" value="0" name="seq">
	<input type="hidden" value="0" name="bkmrk">
	<input type="hidden" value="0" name="acktion">
	<input type="hidden" value="<%=enabledForEdits%>" name="enabledForEdits">
	<input class="inputsmallgray" type="button" id="saveComment" name="saveComment" value="Save">
	<input class="inputsmallgray" type="button" id="cancelComment" name="cancelComment" value="Cancel">

	</form>
</div>
<!-- TTG - popup for quick comment -->

</body>
</html>
