<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmnt.jsp	- add comments to course reviews
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String type = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int id = website.getRequestParameter(request,"id", 0);
	int mode = website.getRequestParameter(request,"md", Constant.REVIEW);

	//
	// item represents the item as designed in CCCM6100
	// qseq is the actual sequence on the outline
	//
	int item = website.getRequestParameter(request,"qn", 0);

	boolean update = false;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	String tb = website.getRequestParameter(request,"c","");
	int source = Integer.parseInt(tb);

	// this is the item sequence as it appears on the outline. if we get here without the seq
	// go get it
	int qseq = website.getRequestParameter(request,"qseq", 0);
	if(qseq == 0){
		qseq = QuestionDB.getCourseSequenceByNumber(conn,campus,tb,item);
	}

	String chromeWidth = "68%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Item Comments";
	session.setAttribute("aseApplicationMessage","");

	//save to session for return to item number after saving (ER00019)
	String bookmark = "c"+tb+"-"+item;
	session.setAttribute("aseReviewApprovalItem",bookmark);

	//
	// ER00009 - ttg - 2012.08.12
	// remember where user comments so we can place check marks on this page
	//
	String enabledForEdits = ParkDB.getApproverCommentedItems(conn,kix,user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="js/crscmnt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			int maxNo = 0;
			String questionNumber = "" + item;
			String comments = "";

			String question = QuestionDB.getCourseQuestionByNumber(conn,campus,source,item);
			if (tb.equals("2")){
				maxNo = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);
				int itm = QuestionDB.getCourseSequenceByNumber(conn,campus,"2",item);
				questionNumber = "" + (itm + maxNo);
			}
			else{
				maxNo = QuestionDB.getCourseSequenceByNumber(conn,campus,"1",item);
				questionNumber = "" + (maxNo);
			}

			String auditby = user;
			String auditdate = AseUtil.getCurrentDateTimeString();

			if (item>0 && source>0 && mode>0 && id>0){
				update = true;

				Review review = ReviewerDB.getReview(conn,campus,kix,id);
				if (review != null){
					comments = review.getComments();
					auditby = review.getUser();
					auditdate = review.getAuditDate();
				}
			}

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/r2d2\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='6' align=\'center\'  border=\'0\'>" );

			out.println("				<tr>" );
			out.println("					 <td width=\"12%\" class=\'textblackTH\' nowrap>Question:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + questionNumber + ". " + question +"</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Comments:&nbsp;</td>" );
			out.println("					 <td>");

			String ckName = "comments";
			String ckData = comments;
%>
			<%@ include file="ckeditor02.jsp" %>
<%
			out.println("					 </td></tr>" );

			boolean isApprover = ApproverDB.isApprover(conn,kix,user);
			boolean isReviewer = ReviewerDB.isReviewer(conn,kix,user);

			out.println("<input name=\'enable\' type=\'hidden\' value=\'0\'>" );

			if (Constant.APPROVAL==mode && isApprover){

				String itemIsEnabled = "";
				if(com.ase.aseutil.ParkDB.isItemEnabled(conn,kix,user,qseq)){
					itemIsEnabled = "checked";
				}

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Enable for<br>modification:&nbsp;</td>" );

				if (QuestionDB.isCourseNumFromSequence(conn,campus,qseq) || QuestionDB.isCourseAlphaFromSequence(conn,campus,qseq)){
					out.println("<td class=\'datacolumn\'><input type=\"checkbox\" disabled name=\"forShowOnly\" id=\"forShowOnly\" value=\"0\">" );
					out.println("<input type=\"hidden\" name=\"enableForMod\" id=\"enableForMod\" value=\"0\">" );
					out.println("Course alpha/number may not be enabled for modification." );
				}
				else{
					out.println("<td class=\'datacolumn\'><input type=\"checkbox\" "+itemIsEnabled+" name=\"enableForMod\" id=\"enableForMod\" value=\"1\">" );
					out.println("Check here to enable this item for modificaton" );
				}

				out.println("</td></tr>" );

			}

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated By:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditby + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Updated Date:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + auditdate + "</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><div class=\"hr\"></div>" );
			out.println("							<input name=\'item\' type=\'hidden\' value=\'" + item + "\'>" );
			out.println("							<input name=\'qseq\' type=\'hidden\' value=\'" + qseq + "\'>" );
			out.println("							<input name=\'alpha\' type=\'hidden\' value=\'" + alpha + "\'>" );
			out.println("							<input name=\'num\' type=\'hidden\' value=\'" + num + "\'>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input name=\'tb\' type=\'hidden\' value=\'" + tb + "\'>" );
			out.println("							<input name=\'id\' type=\'hidden\' value=\'" + id + "\'>" );
			out.println("							<input name=\'mode\' type=\'hidden\' value=\'" + mode + "\'>" );
			out.println("							<input name=\'enabledForEdits\' type=\'hidden\' value=\'" + enabledForEdits + "\'>" );

			if (update)
				out.println("							<input title=\"update entered data\" type=\'submit\' name=\'aseUpdate\' value=\'Update\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
			else
				out.println("							<input title=\"save entered data\" type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );

			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td colspan=\"2\">"
				+ ReviewerDB.getReviewsForEdit(conn,kix,user,item,NumericUtil.getInt(tb),mode)
				+ "</td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );

%>

<br/>
<font class="textblackth">Note</font>
<ul>
	<li class="textnormal">Place a checkmark to enable this item for modification by the proposer</li>
	<li class="textnormal">When enabled or turned on for modification, only the user who turned it on or an approver may turn it off again</li>
	<li class="textnormal"><u>Completed</u> status indicates that comments are no longer available for edit. This situation exists after a round of review has completed and the out was sent back to either the proposer or approver.</li>
	<li class="textnormal"><u>In Progress</u> status permits reviewers/approvers to continue editing their comments as long as the review process is on going.</li>
</ul>

<%
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}
	else
		out.println("CC was not able to process your request.");

	asePool.freeConnection(conn,"crscmnt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
