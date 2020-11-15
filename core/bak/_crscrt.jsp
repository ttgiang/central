<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscrt.jsp	create new outline.
	*	TODO: crscrt.js has code for checkData
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	// GUI
	String chromeWidth = "40%";
	String pageTitle = "screen 1 of 3";
	fieldsetTitle = "Create New Outline ";
	String sql = "";

	String campus = (String)session.getAttribute("aseCampus");
	String user = (String)session.getAttribute("aseUserName");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		/* Big box with list of options */
		#ajax_listOfOptions{
			position:absolute;			/* Never change this one */
			width:320px;					/* Width of box */
			height:250px;					/* Height of box */
			overflow:auto;					/* Scrolling features */
			border:1px solid #317082;	/* Dark green border */
			background-color:#FFF;		/* White background color */
			text-align:left;
			font-size:.9em;
			z-index:100;
		}
		#ajax_listOfOptions div{	/* General rule for both .optionDiv and .optionDivSelected */
			margin:1px;
			padding:1px;
			cursor:pointer;
			font-size:0.9em;
		}
		#ajax_listOfOptions .optionDiv{	/* Div for each item in list */

		}
		#ajax_listOfOptions .optionDivSelected{ /* Selected item in the list */
			background-color:#317082;
			color:#FFF;
		}
		#ajax_listOfOptions_iframe{
			background-color:#F00;
			position:absolute;
			z-index:5;
		}

		form{
			display:inline;
		}
	</style>

	<script language="JavaScript" src="js/crscrt.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	showForm(request,response,session,out,aseUtil);
	asePool.freeConnection(conn);
%>

<%!
	//
	// show this form with data
	//
	void showForm(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						AseUtil aseUtil) throws java.io.IOException {
		try{
			String campus = (String)session.getAttribute("aseCampus");
			String user = (String)session.getAttribute("aseUserName");

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crscrtx.jsp\'>" );
			out.println("			<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );
			out.println("			<input type=\'hidden\' name=\'thisCampus\' value=\'" + campus + "\'>" );

			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			// static
			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + campus + "</td></tr>" );

			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Proposer:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" + user + "</td></tr>" );

			// alpha
			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Alpha:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
			out.println("				</td></tr>" );

			// number
			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'input\' id=\"num\" name=\"num\" value=\"\" size=\'38\' maxlength=\'4\'>" );
			out.println("				</td></tr>" );

			// title
			out.println("				<tr height=\"30\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Title:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'input\' id=\"title\" name=\"title\" value=\"\" size=\'38\' maxlength=\'30\'>" );
			out.println("				</td></tr>" );

			// form buttons
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'c\'>" );
			out.println("							<input type=\'hidden\' name=\'badData\' value=\'\'>" );
			out.println("							<input title=\"continue\" type=\'submit\' name=\'aseSubmit\' value=\'Continue\' class=\'inputsmallgray\' onClick=\"return checkForm(\'s\')\">" );
			out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
