<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcmnt.jsp	- add comments to course reviews
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

	int sq = website.getRequestParameter(request,"sq", 0);
	int en = website.getRequestParameter(request,"en", 0);
	int qn = website.getRequestParameter(request,"qn", 0);

	String ssq = website.getRequestParameter(request,"sq", "");
	String sen = website.getRequestParameter(request,"en", "");
	String sqn = website.getRequestParameter(request,"qn", "");

	String ref = ssq + "-" + sen + "-" + sqn;

	int source = Constant.TAB_FOUNDATION;

	String fndtype = website.getRequestParameter(request,"fndtype", "");

	boolean update = false;

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = fnd.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	if(fndtype.equals(Constant.BLANK)){
		fndtype = fnd.getFndItem(conn,kix,"fndtype");
	}

	String chromeWidth = "68%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Foundation Course Item Comments";
	session.setAttribute("aseApplicationMessage","");

	//save to session for return to item number after saving (ER00019)
	String bookmark = "c"+source+"-"+ref;
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
	<script language="JavaScript" src="js/fndcmnt.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			String comments = "";
			String questionNumber = "" + ref.replace("_",".");
			String auditby = user;
			String auditdate = AseUtil.getCurrentDateTimeString();

			String label = "";
			if(en > 0 && qn == 0){
				label = "Explanatory";
			}
			else if(en > 0 && qn > 0){
				label = "Question";
			}

			if (mode>0 && id>0){
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
			out.println("					 <td width=\"12%\" class=\'textblackTH\' nowrap>Hallmark:&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + fnd.getFoundations(conn,fndtype,sq,0,0) +"</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td width=\"12%\" class=\'textblackTH\' nowrap>"+label+":&nbsp;</td>" );
			out.println("					 <td class=\'datacolumn\'>" + fnd.getFoundations(conn,fndtype,sq,en,qn) +"</td></tr>" );

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
				if(com.ase.aseutil.ParkDB.isItemEnabled(conn,kix,user,qn)){
					itemIsEnabled = "checked";
				}

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Enable for<br>modification:&nbsp;</td>" );

				out.println("<td class=\'datacolumn\'><input type=\"checkbox\" "+itemIsEnabled+" name=\"enableForMod\" id=\"enableForMod\" value=\"1\">" );
				out.println("Check here to enable this item for modificaton" );

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
			out.println("							<input name=\'sq\' type=\'hidden\' value=\'" + sq + "\'>" );
			out.println("							<input name=\'en\' type=\'hidden\' value=\'" + en + "\'>" );
			out.println("							<input name=\'qn\' type=\'hidden\' value=\'" + qn + "\'>" );
			out.println("							<input name=\'alpha\' type=\'hidden\' value=\'" + alpha + "\'>" );
			out.println("							<input name=\'num\' type=\'hidden\' value=\'" + num + "\'>" );
			out.println("							<input name=\'kix\' type=\'hidden\' value=\'" + kix + "\'>" );
			out.println("							<input name=\'id\' type=\'hidden\' value=\'" + id + "\'>" );
			out.println("							<input name=\'tb\' type=\'hidden\' value=\'" + source + "\'>" );
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
				+ ReviewerDB.getReviewsForEdit(conn,kix,user,sq,en,qn,mode)
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
	else{
		out.println("CC was not able to process your request.");
	}

	fnd = null;

	asePool.freeConnection(conn,"fndcmnt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
