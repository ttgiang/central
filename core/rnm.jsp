<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnm.jsp	-	rename/renumber outline
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "rnm";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// check for valid request
	String kix = website.getRequestParameter(request,"kix","");

	String alpha = "";
	String num = "";
	String message = "";
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	// GUI
	String chromeWidth = "70%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	fieldsetTitle = "Rename/Renumber Outline";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/rnm.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
		try{
			String sql = "";
			String view = "";

			out.println("<form method=\'post\' name=\'aseForm\' action=\'rnmx.jsp\'>" );

			out.println("<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("	<tr>" );
			out.println("		<td width=\"10%\" class=\'textblackTH\' nowrap valign=top>Approvers:</td>" );
			out.println("		<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");
			out.println(ReviewerDB.getCampusReviewUsers2(conn,campus,campus,alpha,num,user,kix));
			out.println("		</td>" );
			out.println("		<td width=\"10%\" valign=\'middle\'>" );
			out.println("			<input type=\"button\" class=\"inputsmallgray80\" value=\"Remove\" onclick=\"move(this.form.toList,this.form.fromList)\" name=\"cmdExclude\"><br/><br/>" );
			out.println("			<input type=\"button\" class=\"inputsmallgray80\" value=\"Add\" onclick=\"move(this.form.fromList,this.form.toList)\" name=\"cmdInclude\">" );
			out.println("		</td>" );

			out.println("		<td width=\"40%\" class=\'textblackTD\' nowrap valign=top>");
			out.println(ReviewerDB.getCourseReviewers2(conn,campus,alpha,num));
			out.println("		</td>" );
			out.println("	</tr>" );

			// form buttons
			out.println("	<tr>" );
			out.println("		<td colspan=\"4\" class=\'textblackTHRight\'><div class=\"hr\"></div>" );
			out.println("			<input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("			<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("			<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("			<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("			<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
			out.println("			<input type=\'hidden\' name=\'formSelect\' value=\'q\'>" );
			out.println("			<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return validateForm(\'s\')\">" );
			out.println("			<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("		</td>" );
			out.println("	</tr>" );
			out.println("</table>" );

			out.println("</form>" );
		}
		catch( Exception e ){
			MailerDB mailerDB = new MailerDB(conn,campus,kix,user,e.toString(),"Outline Review");
		}
	}

	asePool.freeConnection(conn,"rnm",user);
%>

Instructions:<br/><br/>
<ul>
	<li>To add approvers, select a name from the left list, click 'Add'.</li>
	<li>To remove approvers, select from the right list, click 'Remove'.</li>
	<li>Click 'Submit' to continue</li>
</ul>

Lists are ordered by lastname then firstname with UH ID in parenthesis.

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

