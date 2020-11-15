<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpzz.jsp	course competency - confirm desire to request review (selected from menu)
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "crscmpzz";
	session.setAttribute("aseThisPage",thisPage);

	String proposer = "";
	String message = "";
	String alpha = "";
	String num = "";
	String type = "";

	String pageTitle = "Review SLO/Competency";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String kix = website.getRequestParameter(request,"kix");

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		proposer = info[3];

		if (!proposer.equals(user)){
			message = "Only the proposer may request SLO review for " + alpha + " " + num + ".<br><br>";
			session.setAttribute("aseApplicationMessage",message);
			asePool.freeConnection(conn);
			response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + "&campus=" + campus + "&rtn=" + thisPage);
		}
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crscmpzz.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	try{
		String progress = "REVIEW";

		out.println("	<table width=\'40%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/chewie\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textbrownTH\' nowrap colspan=\"2\">Student Learning Outcome Review<br><br></td>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td colspan=\"2\"><p align=\"left\">Please confirm your request to have " + alpha + " " + num + " SLOs reviewed.<br/><br/>If you choose to '<b>Continue</b>', your SLOs " +
			"will be locked from modifications while all other items remain editable.<br><br>Choose '<b>Cancel</b>' to end this operation.<br/><br/></td>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + campusName );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Outline:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + alpha + " " + num);
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Reviewers:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + DistributionDB.getDistributionMembers(conn,campus,"SLOReviewer"));
		out.println("			</td></tr>" );

		// TODO
		//out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		//out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
		//out.println("					 <td class=\'dataColumn\'><br/>" + Skew.showInputScreen(request));
		//out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
		out.println("				<td><br/><br/><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
		out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
		out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
		out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
		out.println("					<input type=\'hidden\' name=\'progress\' value=\'" + progress + "\'>" );
		out.println("					<input type=\'hidden\' name=\'caller\' value=\'crscmpzz\'>" );
		out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					<input title=\"continue with request\" type=\'submit\' name=\'aseSubmit\' value=\'Continue\' class=\'inputsmallgray\' onclick=\"return aseSubmitClick(\'a\');\">" );
		out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("			</td></tr>" );
		out.println("		</form>" );

		// form buttons
		out.println("	</table>" );
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
