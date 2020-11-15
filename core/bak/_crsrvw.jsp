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
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "crsrvw";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	// check for valid request
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	boolean mayKickOffReview = ReviewerDB.reviewDuringApprovalAllowed(conn,kix,user);

	// determine what this user is able to do
	if (kix != null && kix.length() > 0){
		if (!courseDB.isCourseReviewable(conn,campus,alpha,num,user) && !mayKickOffReview){
			String message = "Only the proposer may request a review or invite reviewers for this outline";
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?alpha=" + alpha + "&num=" + num  + "&campus=" + campus + "&rtn=" + thisPage);
		}
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Outline";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsrvw.js"></script>
</head>
<body topmargin="0" leftmargin="0" onload="showReviewers('<%=campus%>','<%=alpha%>','<%=num%>');">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && !"sendRedirect".equals(message)){
		if ("".equals(message) || message.length()==0){
			try{
				String sql = "";
				String view = "";

				out.println("		<form method=\'post\' name=\'aseForm\' action=\'crsrvw1.jsp\'>" );
				out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\' nowrap colspan=4><br /><p align=\'center\'>Select names of reviewers</p><br /></td>" );
				out.println("				</tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
				out.println("					 <td colspan=\'3\'>" );
				sql = aseUtil.getPropertySQL(session,"campusList");
				out.println( aseUtil.createSelectionBox(conn, sql, "thisCampus", campus, "onchange=\"showReviewers(this.value,\'" + alpha + "\',\'" + num + "\')\"",false ));
				out.println(  );
				out.println("				</td></tr>" );

				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTH\' nowrap>Reviewers:&nbsp;</td>" );
				out.println("					 <td class=\'textblackTD\' nowrap valign=top>");
				out.println("						<div id=\'txtReviewers\'>Loading user names...</div>");
				out.println("					</td>" );
				out.println("					 <td class=\'textblackTH\' valign=\'middle\'>" );
				out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   <   \" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
				out.println( "<input type=\"button\" class=\"inputsmallgray\" value=\"   >   \" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
				out.println("					 </td>" );

				sql = ReviewerDB.getCourseReviewers(conn,campus,alpha,num);
				out.println("					 <td class=\'textblackTD\' valign=\'middle\'>" + aseUtil.createStaticSelectionBox(sql,sql,"toList",null,"",""," ","10") + "</td>" );
				out.println("				</tr>" );

				// form buttons
				out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
				out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
				out.println("							<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
				out.println("							<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
				out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
				out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
				out.println("							<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
				out.println("							<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
				out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
				out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
				out.println("					 </td>" );
				out.println("				</tr>" );

				out.println("			</table>" );
				out.println("		</form>" );
			}
			catch( Exception e ){
				out.println(e.toString());
			}
		}
		else{
			out.println( "<br><p align=\'center\'>" + message + "</p>" );

			try{
				out.println ( "<p align=center>" + CourseDB.showCourseProgress(conn,campus,alpha,num,"PRE") + "</p>" );
			}
			catch(Exception ex){
				out.println ( ex.toString() );
			}
		}
	}

	asePool.freeConnection(conn,"crsrvw",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
