<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvw1.jsp - enter date and notes to be sent to outline reviewers
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String currentDate = aseUtil.getCurrentDateString();

	// course to work with
	String formSelect = website.getRequestParameter(request,"formSelect");
	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");

	boolean foundation = false;

	boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

	//
	// is it a foundation?
	//

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	if(!isAProgram){
		foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
	}

	String[] info = null;

	if(foundation){
		info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}
	else{
		//
		//
		//
		if (!kix.equals(Constant.BLANK)){
			info = helper.getKixInfo(conn,kix);

			if (isAProgram){
				alpha = info[Constant.KIX_PROGRAM_TITLE];
				num = info[Constant.KIX_PROGRAM_DIVISION];
			}
			else{
				alpha = info[Constant.KIX_ALPHA];
				num = info[Constant.KIX_NUM];
			}

		}
		else{
			alpha = website.getRequestParameter(request,"alpha");
			num = website.getRequestParameter(request,"num");
		}
	}

	fnd = null;

	//
	// REVIEW_IN_REVIEW
	//
	String allowReviewInReview = Util.getSessionMappedKey(session,"AllowReviewInReview");
	int level = website.getRequestParameter(request,"level",0);
	String originalReviewByDate = courseDB.getCourseItem(conn,kix,"reviewdate");
	String maxReviewDueDate = ReviewerDB.getMaxDueDate(conn,kix);
	boolean hasReviewInReview = ReviewerDB.hasReviewInReview(conn,kix);

	//
	//
	//
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String reviewers = formSelect;
	String reviewersForDisplay = EmailListsDB.expandListNames(conn,campus,user,reviewers);

	// a comma means no names were selected. when no names selected, it
	// is referring to removal of all remaining reviewers for this outline
	if (reviewersForDisplay.equals(",")){
		reviewersForDisplay = "";
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	if(foundation){
		fieldsetTitle = "Review Foundation Course";
	}
	else if(isAProgram){
		fieldsetTitle = "Review Program";
	}
	else{
		fieldsetTitle = "Review Outline";
	}

	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsrvw.js"></script>

	<script language="JavaScript" src="js/CalendarPopup.js"></script>
	<link href="../inc/calendar.css" rel="stylesheet" type="text/css">
	<SCRIPT language="JavaScript" id="dateID">
		var dateCal = new CalendarPopup("dateDiv");
		dateCal.setCssPrefix("CALENDAR");
	</SCRIPT>

	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && formSelect != null && formSelect.length() > 0){
		try{
			String sql = "";
			String view = "";

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crsrvwx.jsp\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			if (!reviewersForDisplay.equals(Constant.BLANK)){
				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' width=\"15%\" nowrap>Reviewers:&nbsp;</td>" );
				out.println("					 <td class=\'datacolumn\'>" + reviewersForDisplay.replace(",",",&nbsp;") + "</td></tr>" );

				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Due Date:&nbsp;</td>" );
				out.println("					 <td><input onFocus=\"dateCal.select(document.forms[0].reviewDate,'anchorDate','MM/dd/yyyy'); return false;\" size=\'10\' class=\'input\'  name=\'reviewDate\' type=\'text\' value=\'\'>&nbsp;");
				out.println("					 <A HREF=\"#\" onClick=\"dateCal.select(document.forms[0].reviewDate,'anchorDate','MM/dd/yyyy'); return false;\" NAME=\"anchorDate\" ID=\"anchorDate\" class=\"linkcolumn\">(MM/DD/YYYY)</A>" );

				if(!originalReviewByDate.equals(Constant.BLANK) && !maxReviewDueDate.equals(Constant.BLANK)){
					if(level > 1){
						out.println("<br><font class=\"goldhighlights\">Review due date may not be later than: " + originalReviewByDate + "</font>");
					}
					else{
						if(allowReviewInReview.equals(Constant.ON) && hasReviewInReview){
							out.println("<br><font class=\"goldhighlights\">Review due date may not be earlier than: " + maxReviewDueDate + "</font>");
						}
					}
				}

				out.println("</td></tr>" );

			}
			else{
				out.println("					 <td><input name=\'reviewDate\' type=\'hidden\' value=\'\'>");
			}

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Comments:&nbsp;</td>" );
			out.println("					 <td>");

			String ckName = "comments";
			String ckData = "";

%>
<%@ include file="ckeditor02.jsp" %>
<%
			out.println("					 </td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><div class=\'hr\'></div>" );
			out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'" + formSelect + "\'>" );
			out.println("							<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("							<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("							<input type=\'hidden\' name=\'level\' value=\'" + level + "\'>" );
			out.println("							<input type=\'hidden\' name=\'originalReviewByDate\' value=\'" + originalReviewByDate + "\'>" );
			out.println("							<input type=\'hidden\' name=\'maxReviewDueDate\' value=\'" + maxReviewDueDate + "\'>" );
			out.println("							<input type=\'hidden\' name=\'allowReviewInReview\' value=\'" + allowReviewInReview + "\'>" );
			out.println("							<input type=\'hidden\' name=\'hasReviewInReview\' value=\'" + hasReviewInReview + "\'>" );
			out.println("							<input type=\'hidden\' name=\'currentDate\' value=\'" + currentDate + "\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("							<input title=\"submit review request\" type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm0(\'s\')\">" );
			out.println("							<input title=\"abort review request\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'\' colspan=\'2\'><br><br>" );
			if(allowReviewInReview.equals(Constant.ON)){
				out.println("Note: because proposers are allowed to extend review due dates, the following conditions are checked if review within review is enabled."
								+ "<ul>"
								+ "<li>Proposer<ul>"
								+ "<li>Review due dates may not be ealier than the latest review date set by reviewers during review within review invitiations</li>"
								+ "</ul></li>"
								+ "<li>Reviewers<ul>"
								+ "<li>Review due dates may not be later than the review date set by the proposer of this outline</li>"
								+ "</ul></li>"
								+ "</ul>"
								+ "");
			}
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			MailerDB mailerDB = new MailerDB(conn,
														campus,
														kix,
														user,
														e.toString(),
														fieldsetTitle + " selection");
		}
	}
	else{
		out.println("You have not selected any reviewers."
			+ "<p><a href=\"crsrvw.jsp?kix="+kix+"&rl="+level+"\" class=\"linkcolumn\">select reviewers</a>"
			+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<a href=\"tasks.jsp\" class=\"linkcolumn\">return to task listing</a>"
			+ "<p>To remove all reviewers and cancel your review request, click <a href=\"crsrvwcan.jsp?kix="+kix+"&rl="+level+"\" class=\"linkcolumn\">here</a>.</p></p>");
	}

	asePool.freeConnection(conn,"crsrvw1",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>

