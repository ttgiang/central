<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpz.jsp	course competency - confirm desire to request review (called by crscmp)
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String currentTab = "";
	String currentNo = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String jsid = website.getRequestParameter(request,"jsid");
	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = (String)session.getAttribute("aseAlpha");
		num = (String)session.getAttribute("aseNum");
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
	}

	currentTab = (String)session.getAttribute("aseCurrentTab");
	currentNo = (String)session.getAttribute("asecurrentSeq");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Course SLO/Competencies";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crscmpz.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	//NOTE: Because of servlet chewie, we will not get back to here after form submission

	// jsid exists only after returning to this screen from form submit
	// if first time through, set the hidden variable
	if (jsid.equals("")){
		showConfirmationForm(request,response,session,out,conn,alpha,num,kix);
	}
	else{
		String sid = (String)session.getId();
		if (sid.equals(jsid)){
			showConfirmed(request,response,session,out,conn,alpha,num,kix);
		}
	}

	asePool.freeConnection(conn);
%>

<%!
	//
	// show confirmed entry and offer links to various pages
	// NOTE: we come back here after chewie processes the confirmation screen
	//
	void showConfirmed(javax.servlet.http.HttpServletRequest request,
										javax.servlet.http.HttpServletResponse response,
										javax.servlet.http.HttpSession session,
										javax.servlet.jsp.JspWriter out,
										Connection conn,
										String alpha,
										String num,
										String kix) throws java.io.IOException {
		try{
			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
			String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			String currentTab = (String)session.getAttribute("aseCurrentTab");
			String currentNo = (String)session.getAttribute("asecurrentSeq");
			String campusName = CampusDB.getCampusName(conn,campus);

			out.println("	<table width=\'40%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textbrownTH\' nowrap colspan=\"2\">Student Learning Outcome Review<br><br></td>" );
			out.println("			</td></tr>" );

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td colspan=\"2\"><p align=\"left\">Request completed successfully<br/><br/></td>" );
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
			out.println("				<td colspan=\"2\"><br/><br/><input type=\'hidden\' name=\'thisAlpha\' value=\'" + alpha + "\'>" );
			out.println("					<p align=\"center\"><input type=\'hidden\' name=\'thisNum\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'thisCampus\' value=\'" + campus + "\'>" );
			out.println("					<input type=\'hidden\' name=\'thisOption\' value=\'PRE\'>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input title=\"return to SLO screen\" type=\'submit\' name=\'aseReturnToSLO\' value=\'Return to SLO\' class=\'input\' onClick=\"return returnToSLO('"+kix+"','"+currentTab+"','"+currentNo+"')\">" );

			// tab and no are set to 0 when coming from sltcrs to clear out any prior work. if they are 0s here
			// it's because the edit took place out of the crsedt page
			if (!currentTab.equals("0") && !currentNo.equals("0"))
				out.println("					<input title=\"send notification to proposer\" type=\'submit\' name=\'aseReturnToModify\' value=\'Return to Modification\' class=\'input\' onClick=\"return returnToEdit('"+kix+"','"+currentTab+"','"+currentNo+"')\">" );

			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseFinish\' value=\'Close\' class=\'input\' onClick=\"return cancelForm()\">" );
			out.println("			</p></td></tr>" );
			out.println("		</form>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	//
	// show this form with data
	//
	void showConfirmationForm(javax.servlet.http.HttpServletRequest request,
										javax.servlet.http.HttpServletResponse response,
										javax.servlet.http.HttpSession session,
										javax.servlet.jsp.JspWriter out,
										Connection conn,
										String alpha,
										String num,
										String kix) throws java.io.IOException {
		try{

			String currentTab = (String)session.getAttribute("aseCurrentTab");
			String currentNo = (String)session.getAttribute("asecurrentSeq");

			String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));

			String campusName = CampusDB.getCampusName(conn,campus);
			String jsid = (String)session.getId();
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

			out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("				 <td class=\'textblackTH\' nowrap>&nbsp;</td>" );
			out.println("				<td><br/><br/><input type=\'hidden\' name=\'alpha\' value=\'" + alpha + "\'>" );
			out.println("					<input type=\'hidden\' name=\'num\' value=\'" + num + "\'>" );
			out.println("					<input type=\'hidden\' name=\'campus\' value=\'" + campus + "\'>" );
			out.println("					<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("					<input type=\'hidden\' name=\'progress\' value=\'" + progress + "\'>" );
			out.println("					<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					<input type=\'hidden\' name=\'caller\' value=\'crscmpz\'>" );
			out.println("					<input type=\'hidden\' name=\'jsid\' value=\'" + jsid + "\'>" );
			out.println("					<input title=\"send mail to reviewer\" type=\'submit\' name=\'aseSubmit\' value=\'Continue\' class=\'input\' onclick=\"aseSubmitClick(\'a\');\">" );
			out.println("					<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'input\' onClick=\"return returnToEdit('"+kix+"','"+currentTab+"','"+currentNo+"')\">" );
			out.println("			</td></tr>" );
			out.println("		</form>" );

			// form buttons
			out.println("	</table>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
