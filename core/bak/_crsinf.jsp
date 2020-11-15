<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%!
	/**
	*	ASE
	*	crsinf.jsp
	*	2007.09.01	driver to select course to display
	**/

	// global declaration
	String progress = "";
%>

<%
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String chromeWidth = "80%";
	String pageTitle = "Select Outline";
	fieldsetTitle = pageTitle;
	String alpha = null;
	String num = null;
	String message = "";
	String campus = "";

	String formName = website.getRequestParameter(request,"formName","");

	if ( formName != null && formName.equals("aseForm") ){
		alpha = website.getRequestParameter(request,"alpha_ID","");

		// numbers_ID is the AJAX returned value. When it is null or empty
		// that means that it was not listed as part of the AJAX drop down.
		// However, because users are allowed to type into the box, collect
		// the content by going to 'numbers'.
		num = website.getRequestParameter(request,"numbers_ID","");
		if ( num == null || num.length() == 0 )
			num = website.getRequestParameter(request,"numbers","");

		if ( alpha != null && num != null ){
			message = "sendRedirect";
		}	// if alpha
	}	// if form

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		/* Big box with list of options */
		#ajax_listOfOptions{
			position:absolute;			/* Never change this one */
			width:320px;				/* Width of box */
			height:250px;				/* Height of box */
			overflow:auto;				/* Scrolling features */
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

	<script type="text/javascript" src="js/crsinf.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if ( "sendRedirect".equals( message ) ){
		asePool.freeConnection(conn);
		response.sendRedirect( "crsinfx.jsp?alpha=" + alpha + "&num=" + num );
	}
	else{
		if ( message.length() == 0 )
			showFormAjax(request,response,session,out,conn,aseUtil);
		else
			showMessage(request, response, out, conn, message, alpha, num, (String)session.getAttribute("aseCampus"));

		asePool.freeConnection(conn);
	}
%>

<%!
	//
	// show this form with data
	//
	void showFormAjax(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						AseUtil aseUtil) throws java.io.IOException {
		try{


			String sql = "";
			String progress = "APPROVED";
			String campus = (String)session.getAttribute("aseCampus");

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );
			out.println("<input type=\'hidden\' name=\'thisCampus\' value=\'" + campus + "\'>" );

			// outline by short alpha and number
			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Course Alpha & Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha3\" name=\"alpha3\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS3\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha3_hidden\" name=\"alpha3_ID\">" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers3\" name=\"numbers3\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS3\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alpha3_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"numbers3_hidden\" name=\"numbers3_ID\">" );
			out.println("				</td></tr>" );

			// OR
			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td colspan=\'2\' align=\'center\'>-- OR --</td>" );
			out.println("				</tr>" );

			// outline by number and course
			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Course Number & Alpha:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers2\" name=\"numbers2\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS2\',event,\'/central/servlet/ACS\'," + aseUtil.NUMBER + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"numbers2_hidden\" name=\"numbers2_ID\">" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha2\" name=\"alpha2\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS2\',event,\'/central/servlet/ACS\'," + aseUtil.NUMBER_ALPHA + ",document.aseForm.numbers2_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha2_hidden\" name=\"alpha2_ID\">" );
			out.println("				</td></tr>" );

			// OR
			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td colspan=\'2\' align=\'center\'>-- OR --</td>" );
			out.println("				</tr>" );

			// outline by alpha and number
			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Discipline & Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA + ",'','',document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers\" name=\"numbers\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alpha_ID,document.aseForm.thisOption,document.aseForm.thisCampus,'" + progress + "')\">" );
			out.println("						<input type=\"hidden\" id=\"numbers_hidden\" name=\"numbers_ID\">" );
			out.println("				</td></tr>" );

			// form buttons
			out.println("				<tr height=\"25\" class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><hr size=\'1\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm()\">" );
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

	//
	// showMessage
	//
	void showMessage(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.jsp.JspWriter out,
						Connection conn,
						String message,
						String alpha,
						String num,
						String campus) throws java.io.IOException {

		//out.println( "alpha: " + alpha );
		//out.println( "num: " + num );
		//out.println( "campus: " + campus );
		//alpha = "ICS";
		//num = "218";
		// when the course does not show up in the screen for selection and
		// user types in the number, it's still valid but won't matter here.
		// only when actual data comes through will this section show detail.

		String divID = alpha + "_" + num;
		out.println( "<br><p align=\'center\'>" + message + "</p>" );
		out.println( "<p align=\'center\'><div id=\'" + divID + "\'></div></p>" );
		out.println( "<p align=\'center\'><div id=\'APPROVER_LISTING\'></div></p>" );
		try{
			com.ase.aseutil.CourseDB course = new com.ase.aseutil.CourseDB();
			out.println ( "<p align=center>" + course.showCourseProgress(conn,campus,alpha,num,"PRE") + "</p>" );
			course = null;
		}
		catch(Exception ex){
			out.println( ex.toString() );
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
