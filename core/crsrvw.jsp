<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvw.jsp	-	select names of coure reviewers
	*	TODO				if during invite of reviewers that we remove all, or cancel, then it's no longer in review
	*						need to reset to modify
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "crsrvw";
	int fndURL = website.getRequestParameter(request,"fnd",0);
	if(fndURL==1){
		thisPage = "fndrvw";
	}

	session.setAttribute("aseThisPage",thisPage);


	String alpha = "";
	String num = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String selectedCampus = website.getRequestParameter(request,"selectedCampus","");
	if (selectedCampus.equals(Constant.BLANK)){
		selectedCampus = campus;
	}

	// check for valid request
	String kix = website.getRequestParameter(request,"kix","");
	String useKix = kix;

	// ER99999
	// used by review in review. this represents the user level
	//
	// REVIEW_IN_REVIEW
	// if level is greater than 1, we check to make sure this person
	// has reviewers in the pipeline to work with and not a URL hack
	//
	int level = website.getRequestParameter(request,"rl",0);
	if(level > 1){
		level = ReviewerDB.getReviewerLevel(conn,kix,user) + 1;
	}

	boolean foundation = false;

	//
	// review for course/program?
	//
	boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

	//
	// is it a foundation?
	//

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	if(!isAProgram){
		foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);
	}

	//
	// kix data
	//
	String[] info = null;
	if(foundation){
		info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}
	else{
		if (!kix.equals("")){
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

	boolean mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,user);

	//
	// determine what this user is able to do
	//
	if (kix != null && kix.length() > 0){

		boolean isReviewer = ReviewerDB.isReviewer(conn,kix,user);

		if(foundation){
			if (!fnd.reviewable(conn,campus,kix,user) && !mayKickOffReview && !isReviewer){
				String message = "You are not authorized to request a review or reviews are not permitted at this time.";
				session.setAttribute("aseApplicationMessage",message);
				response.sendRedirect("msg.jsp?campus=" + campus + "&rtn=" + thisPage);
			}
		}
		else if (isAProgram){
			if (!ProgramsDB.isProgramReviewable(conn,campus,kix,user)){
				String message = "You are not authorized to request a review or reviews are not permitted at this time.";
				session.setAttribute("aseApplicationMessage",message);
				response.sendRedirect("msg.jsp?campus=" + campus + "&rtn=" + thisPage);
			}
		}
		else{
			if (!courseDB.isCourseReviewable(conn,campus,alpha,num,user) && !mayKickOffReview && !isReviewer){
				String message = "Only the proposer may request a review or invite reviewers for this outline";
				session.setAttribute("aseApplicationMessage",message);
				response.sendRedirect("msg.jsp?alpha=" + alpha + "&num=" + num  + "&campus=" + campus + "&rtn=" + thisPage);
			}
		}

	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "70%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	//
	// page message
	//
	if(level > 1){
		pageTitle = pageTitle + " (Review in Review)";
	}

	//
	// review type
	//
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

	fnd = null;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsrvw.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
			   "bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aaSorting": [ [1,'asc'], [3,'asc'] ],
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '70%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && !message.equals("sendRedirect")){
		if (message.equals("") || message.length()==0){
			try{
				String sql = "";
				String view = "";

				out.println("<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
				out.println("	<tr>" );
				out.println("		<td>" );
				out.println("			<form method=\'post\' name=\'aseForm2\' action=\'crsrvw.jsp\'>" );
				out.println("				<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
				out.println("					<tr>" );
				out.println("						<td width=\"10%\" class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
				out.println("							<td valign=top height=40>" );
				sql = aseUtil.getPropertySQL(session,"campusList");
				out.println( aseUtil.createSelectionBox(conn, sql, "selectedCampus", selectedCampus, "",false ));
				out.println("<input type=\'submit\' name=\'aseGo\' value=\'Change\' class=\'inputsmallgray\'>" );
				out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
				out.println("							</td>" );
				out.println("					</tr>" );
				out.println("				</table>" );
				out.println("			</form>" );
				out.println("		</td></tr>" );
				out.println("	</tr>" );

				out.println("<form method=\'post\' name=\'aseForm\' action=\'crsrvw1.jsp\'>" );
				out.println("	<tr>" );
				out.println("		<td>" );
				out.println("				<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
				out.println("					<tr>" );
				out.println("					 	<td width=\"10%\" class=\'textblackTH\' nowrap valign=top>Reviewers:</td>" );
				out.println("					 	<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");

				// for courses, we don't send in kix
				if (!isAProgram && !foundation){
					useKix = "";
				}

				// rl==0 is the proposer'
				// when rl > 0, we have review in review
				if(level == 0){
					out.println(ReviewerDB.getCampusReviewUsers2(conn,campus,selectedCampus,alpha,num,user,useKix));
					out.println("						</td>" );
					out.println("					 	<td width=\"10%\" valign=\'middle\'>" );
					out.println("							<input type=\"button\" class=\"inputsmallgray80\" value=\"Remove\" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
					out.println("							<input type=\"button\" class=\"inputsmallgray80\" value=\"Add\" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
					out.println("						</td>" );

					out.println("					 	<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");

					if (isAProgram){
						out.println(ReviewerDB.getCourseReviewers2(conn,campus,useKix,""));
					}
					else{
						out.println(ReviewerDB.getCourseReviewers2(conn,campus,alpha,num));
					}
				}
				else{
					out.println(ReviewerDB.getListOfUsersForReview(conn,campus,selectedCampus,user,kix,level));

					out.println("						</td>" );
					out.println("					 	<td width=\"10%\" valign=\'middle\'>" );
					out.println("							<input type=\"button\" class=\"inputsmallgray80\" value=\"Remove\" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
					out.println("							<input type=\"button\" class=\"inputsmallgray80\" value=\"Add\" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
					out.println("						</td>" );

					out.println("					 	<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");

					out.println(ReviewerDB.getMyReviewers(conn,campus,user,kix,level));
				} // level

				out.println("					 	</td>" );
				out.println("					</tr>" );
				out.println("				</table>" );
				out.println("		 </td>" );
				out.println("	</tr>" );

				// form buttons
				out.println("				<tr>" );
				out.println("					 <td class=\'textblackTHRight\'><hr size=\'1\'>" );
				out.println("							<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
				out.println("							<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
				out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
				out.println("							<input type=\'hidden\' name=\'level\' value=\'" + level + "\'>" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
				out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
				out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
				out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
				out.println("					 </td>" );
				out.println("				</tr>" );
				out.println("</form>" );

				//
				// only show listing of reviewers for review in review since regular review
				// shows reviewers in the list box
				//
				// REVIEW_IN_REVIEW
				//
				String allowReviewInReview = Util.getSessionMappedKey(session,"AllowReviewInReview");
				if(allowReviewInReview.equals(Constant.ON)){

					sql = aseUtil.getPropertySQL( session,"reviewers");
					if ( sql != null && sql.length() > 0 ){
						sql = aseUtil.replace(sql, "_alpha_", alpha);
						sql = aseUtil.replace(sql, "_num_", num);
						paging = null;
						com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
						out.print("<TR><td class=\"textblackth\"><br/>Current Reviewers:<br><br>" + jqPaging.showTable(conn,sql,"") + "</td></tr>");
						jqPaging = null;
					}

				} // allowReviewInReview

				out.println("			</table>" );
			}
			catch( Exception e ){
				MailerDB mailerDB = new MailerDB(conn,campus,kix,user,e.toString(),"Outline Review - crsrvw");
			}
		}
		else{
			out.println( "<br><p align=\'center\'>" + message + "</p>" );

			try{
				out.println ( "<p align=center>" + CourseDB.showCourseProgress(conn,campus,alpha,num,"PRE") + "</p>" );
			}
			catch(Exception e){
				MailerDB mailerDB = new MailerDB(conn,campus,kix,user,e.toString(),"Outline Review - crsrvw");
			}
		}
	}

	asePool.freeConnection(conn,"crsrvw",user);
%>

<br/><br/>
Instructions:<br/><br/>
To add reviewers, select a name from the left list, click 'Add'.<br/>
To remove reviewers, select from the right list, click 'Remove'.<br/><br/>
Lists are ordered by lastname then firstname with UH ID in parenthesis.

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

