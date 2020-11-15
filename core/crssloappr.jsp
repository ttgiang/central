<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crssloappr.jsp	course competency - request SLO approval
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "crssloappr";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String proposer = "";

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		proposer = info[3];
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption="+type);
	}

	if ("".equals(proposer))
		proposer = courseDB.getCourseProposer(conn,campus,alpha,num,type);

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Request SLO Approval";
	fieldsetTitle = pageTitle;

	String message = "";

	if (kix.length()>0){
		if (SLODB.isReadyForApproval(conn,campus,kix)){
			if (SLODB.sloProgress(conn,kix,"REVIEW")){
				message = "Approval request is not permitted while review is in progress.<br><br>";
			}
			else{
				if (SLODB.sloProgress(conn,kix,Constant.COURSE_APPROVAL_TEXT)){
					message = "SLO approval already in progress.<br><br>";
				}
			}
		}
		else{
			message = "All SLO reviews must be completed prior to initiating the approval process.<br><br>";
		}

		if (!"".equals(message)){
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + "&rtn=" + thisPage);
		}
	}

	asePool.freeConnection(conn);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crssloappr.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	try{
		String progress = Constant.COURSE_APPROVAL_TEXT;

		out.println("	<table width=\'40%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'/central/servlet/chewie\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textbrownTH\' nowrap colspan=\"2\">Student Learning Outcome Approval<br><br></td>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td colspan=\"2\"><p align=\"left\">Please confirm your request to have <b>" + alpha + " " + num + "</b> SLOs approved.<br/><br/></td>" );
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
		out.println("				 <td class=\'textblackTH\' nowrap>Approvers:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + DistributionDB.getDistributionMembers(conn,campus,"SLOApprover"));
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
		out.println("				<td><br/><br/><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
		out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
		out.println("					<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
		out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
		out.println("					<input type=\'hidden\' name=\'progress\' value=\'" + progress + "\'>" );
		out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
		out.println("					<input type=\'hidden\' name=\'caller\' value=\'crscmpzz\'>" );
		out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					<input type=\'submit\' name=\'aseSubmit\' value=\'Continue\' class=\'inputsmallgray\' onclick=\"aseSubmitClick(\'a\');\">" );
		out.println("					<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("			</td></tr>" );
		out.println("		</form>" );

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
