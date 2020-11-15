<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.ase.aseutil.jquery.JQueryServlet"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgappr.jsp - program approval
	*
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "prgappr";
	session.setAttribute("aseThisPage",thisPage);
	session.setAttribute("aseCallingPage",thisPage);

	String alpha = "";
	String num = "";
	String type = "";
	String message = "";
	String screenMessage = "";
	String progress = "";
	int route = 0;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");

	// whether to hide or show items not enabled for modifications
	String hideOrShow = website.getRequestParameter(request,"hide");

	String reviseDisabled = "";
	String submitClass = "";

	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
		type = info[Constant.KIX_TYPE];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
		progress = info[Constant.KIX_PROGRESS];
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "80%";
	String pageTitle = alpha;
	fieldsetTitle = "Program Approval";

	boolean approvalAllowed = true;
	String approvalByDate = "";

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Voting buttons may ben enabled during review and approval process.");

	String degreeDescr = "";
	String divisionDescr = "";
	String title = "";
	String proposer = "";
	String effectiveDate = "";
	String description = "";

	String enableVotingButtons = "";
	boolean showGroupVote = false;
	String subProgress = "";
	History h = null;

	//System.out.println("kix: " + kix);
	//System.out.println("route: " + route);

	if (processPage){
	if (!ProgramsDB.isNextApprover(conn,campus,kix,user,route)){
			message = "It is not your turn to approve this program.";
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?noMsg=1?kix=" + kix + "&campus=" + campus + "&rtn=" + thisPage);
		}
		else{
			session.setAttribute("aseApplicationMessage","");
		}

		Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
		if ( program != null ){
			degreeDescr = program.getDegreeDescr();
			divisionDescr = program.getDivisionDescr();
			title = program.getTitle();
			proposer = program.getProposer();
			effectiveDate  = program.getEffectiveDate();
			description = program.getDescription();
		}

		enableVotingButtons = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableVotingButtons");

		// retrieve votes by groups if it was sent for review
		showGroupVote = false;
	} // processPage
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<script type="text/javascript" src="js/prgappr.js"></script>

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

		out.println("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">"
			+ "<tr>"
			+ "<td class=\"textblackth\" width=\"15%\" valign=\"top\">Degree:&nbsp;</td>"
			+ "<td class=\"datacolumn\" valign=\"top\">" + degreeDescr + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<td class=\"textblackth\" width=\"15%\" valign=\"top\">Division:&nbsp;</td>"
			+ "<td class=\"datacolumn\" valign=\"top\">" + divisionDescr + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<td class=\"textblackth\" valign=\"top\">Title:&nbsp;</td>"
			+ "<td class=\"datacolumn\" valign=\"top\">" + title + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<td class=\"textblackth\" valign=\"top\">Description:&nbsp;</td>"
			+ "<td class=\"datacolumn\" valign=\"top\">" + description + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<td class=\"textblackth\" valign=\"top\">Effective Date:&nbsp;</td>"
			+ "<td class=\"datacolumn\" valign=\"top\">" + effectiveDate + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<tr><td colspan=\"2\" align=\"right\">"
			+ "<img src=\"images/comment.gif\" title=\"approval comments\" alt=\"approval comments\" id=\"approval comments\">&nbsp;<a href=\"prghst.jsp?kix="+kix+"\" class=\"linkcolumnhighlights\" title=\"approval comments\" onclick=\"asePopUpWindow(this.href,'aseWin1','800','600','no','center');return false\" onfocus=\"this.blur()\">approval comments</a>"
			+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;");

		int fid = 0;
		String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
		if (enableMessageBoard.equals(Constant.ON)){
			fid = ForumDB.getForumID(conn,campus,kix);
		}

		if(fid > 0){
			if(ForumDB.countPostsToForum(conn,fid) > 0){
				out.println("&nbsp;&nbsp;<img src=\"images/comment.gif\" title=\"review comments\" alt=\"review comments\" id=\"review comments\">&nbsp;<a href=\"./forum/prt.jsp?fid="+fid+"\" class=\"linkcolumnhighlights\" title=\"approval comments\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\">review comments</a>");
			}
		}
		else{
			if(ReviewerDB.countComments(conn,kix) > 0){
				out.println("&nbsp;&nbsp;<img src=\"images/comment.gif\" title=\"review comments\" alt=\"review comments\" id=\"review comments\">&nbsp;<a href=\"prgrvwcmnts.jsp?c=-1&md=3&qn=0&kix="+kix+"\" class=\"linkcolumnhighlights\" title=\"approval comments\" onclick=\"asePopUpWindow(this.href,'aseWin2','800','600','no','center');return false\" onfocus=\"this.blur()\">review comments</a>");
			}
		}

		out.println("<img src=\"../images/clip.gif\"><a href=\"#attachment\" class=\"linkcolumnhighlights\">attachments</a>"
			+ "&nbsp;&nbsp;&nbsp;</td></tr>"
			+ "<td colspan=\"2\"><br><div class=\"hr\"></div></td>"
			+ "</tr>"
			+ "<table>");

			msg = ProgramsDB.reviewProgram(conn,campus,kix,Constant.APPROVAL,user,hide);

		out.println("<div style=\"position:relative\" id=\"position-relative\">"
			+ msg.getErrorLog()
			+ "</div>");
%>
	<form method="post" action="prgapprx.jsp" name="aseForm">
		<TABLE cellSpacing=0 cellPadding=5 width="100%" border=0>
			<TBODY>
				<tr><td colspan="2"><div class="hr"></div></td></tr>
				<tr><td width="10%" class="textblackth">Approver:</td><td class="datacolumn"><%=user%></td></tr>
				<tr><td width="10%" class="textblackth">Date:</td><td class="datacolumn"><%=aseUtil.getCurrentDateTimeString()%></td></tr>

				<%
					if (showGroupVote){
				%>
					<TR>
						<TD valign="top" width="10%" class="textblackth">Group Votes:</td>
						<td>
							For:&nbsp;&nbsp;<input type="input" disabled value="<%=h.getVoteFor()%>" class="input" maxlength="3" size="3" name="groupFor">
							&nbsp;&nbsp;Against:&nbsp;&nbsp;<input type="input" disabled value="<%=h.getVoteAgainst()%>" class="input" maxlength="3" size="3" name="groupAgainst">
							&nbsp;&nbsp;Abstain:&nbsp;&nbsp;<input type="input" disabled value="<%=h.getVoteAbstain()%>" class="input" maxlength="3" size="3" name="groupAbstain">
							<a href="crshst.jsp?hid=<%=kix%>&nvtr=<%=user%>&t=PRE" class="linkColumn" onclick="return hs.htmlExpand(this, { objectType: 'ajax', width: 600} )">&nbsp;approval comments</a>
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
					</TD>
				</TR>
				<TR>
					<TD valign="top" width="10%" class="textblackth">Comments:</td>
					<td>
						<textarea name="comments" cols="80" rows="10" class="input"></textarea>
						<input type="hidden" value="<%=kix%>" name="kix">
					</TD>
				</TR>
				<TR><td>&nbsp;</td><TD align="left" colspan="2"><% out.println(Skew.showInputScreen(request)); %></td></tr>
				<TR>
					<td>&nbsp;</td>
					<TD align="left">
						<br />
						<input title="approval program content" type="submit"  value=" Approve " class="inputgo" onClick="return checkForm('s')">&nbsp;
						<input title="revise program content..." type="submit" value=" Revise  " <%=reviseDisabled%> class="inputstop<%=submitClass%>" onClick="return checkForm('r')">&nbsp;
						<input title="review program content..." type="submit" value=" Review  " class="inputother" onClick="return checkForm('v');">&nbsp;
						<input title="cancel selected operation" type="submit" value=" Cancel  " class="inputother" onClick="return cancelForm()">&nbsp;
						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">

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
	<li class="textblack">Revise - sends the program back to the proposer/author for revision.</li>
	<li class="textblack">Cancel - cancels your approval at this time. You may return to this screen by selecting "Program approval" from your task list.</li>
</ul>

<%
	}
	else{
		if (!approvalAllowed){
			%>
				The period for this program approval has ended (<%=approvalByDate%>).
				<br/>
				<br/>
				Contact your CC administrator for assistance.
			<%
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<%
	asePool.freeConnection(conn,"prgappr",user);
%>

<!-- TTG - popup for quick comment -->
<div id="addComments" style="display:none;cursor:default;">
	<h3 class="subheader">
		<%=alpha%>&nbsp;-&nbsp;<%=num%>
		<br>
		Approval Comments
	</h3>
	<form id="addCommentsForm" name="addCommentsForm" method="POST" action="<%=JQueryServlet.SAVE_COMMENT%>.do">
		<table width=100% class="content_table" >
			<tr>
				<td><textarea name="comment" id="comment" class="inputsmall" style="height:180px;width:520px;"></textarea></td>
			</tr>
		</table>
	<p>

	<input type="hidden" value="0" name="enable">
	<input type="hidden" value="<%=alpha%>" name="alpha">
	<input type="hidden" value="<%=num%>" name="num">
	<input type="hidden" value="<%=kix%>" name="kix">
	<input type="hidden" value="0" name="qn">
	<input type="hidden" value="0" name="id">
	<input type="hidden" value="-1" name="tab">
	<input type="hidden" value="0" name="seq">
	<input type="hidden" value="<%=Constant.APPROVAL%>" name="md">

	<input class="inputsmallgray" type="button" id="saveComment" value="Save">
	<input class="inputsmallgray" type="button" id="cancelComment" value="Cancel">
	</form>
</div>
<!-- TTG - popup for quick comment -->

</body>
</html>

