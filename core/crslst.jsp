<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslst.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "50%";
	String alpha = null;
	String courseNum = null;
	String message = "";
	String campus = "";

	String pageTitle = "List Courses";
	fieldsetTitle = pageTitle;
	String formName = website.getRequestParameter(request,"formName","");
	String viewOption = website.getRequestParameter(request,"viewOption");

	if ( formName != null && "aseForm".equals(formName) ){
		alpha = website.getRequestParameter(request,"alpha_ID","");
		courseNum = website.getRequestParameter(request,"numbers_ID","");
		campus = website.getRequestParameter(request,"thisCampus","");

		// thisOption is used as a way of getting values during selection of coursetype
		// and it exists only after the form is submitted
		viewOption = website.getRequestParameter(request,"thisOption");

		//if ( alpha != null && courseNum != null ){
			// TODO - not needed
			// do we allow links to course from here?
			// Current working just fine. No need to link
			// since it requires popping up a new window for the course
			// content. Linking in the same window would erase all the courses
			// and forcing selection all over again.
		//}	// if alpha
	}	// if form

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		/* Big box with list of options */
		#ajax_listOfOptions{
			position:absolute;	/* Never change this one */
			width:320px;	/* Width of box */
			height:250px;	/* Height of box */
			overflow:auto;	/* Scrolling features */
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

	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/crslst.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/inc/ajax-dynamic-list.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{
		String sql = "";
		String view = "";

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
		out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		// course by type
		// when viewOption does not have any value, display all 3 course types
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Type:&nbsp;</td>" );
		out.println("					 <td>" );
		out.println("<input onClick=\'checkCourseType()\' type='radio' value='ARC' name='viewOption1'>&nbsp;Archived&nbsp;" );
		out.println("<input onClick=\'checkCourseType()\' type='radio' value='CUR' name='viewOption1'>&nbsp;Approved&nbsp;" );
		out.println("<input onClick=\'checkCourseType()\' type='radio' value='PRE' name='viewOption1'>&nbsp;Proposed&nbsp;" );
		out.println("<input type=\'hidden\' name=\'edt\' value=\'1\'>" );
		out.println("<input type=\'hidden\' name=\'thisOption\' value=\'\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Campus:&nbsp;</td>" );
		out.println("					 <td>" );
		sql = "SELECT campus, campusdescr FROM tblCampus WHERE campus <> 'ALL' ORDER BY campus ";
		out.println( aseUtil.createSelectionBox( conn, sql, "thisCampus", campus,false));
		out.println("					 </td>" );
		out.println("				</tr>" );

		// outline by short alpha
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Alpha:&nbsp;</td>" );
		out.println("					 <td>" );
		out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha3\" name=\"alpha3\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS3\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">" );
		out.println("						<input type=\"hidden\" id=\"alpha3_hidden\" name=\"alpha3_ID\">" );
		out.println("				</td></tr>" );

		// OR
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td colspan=\'2\' align=\'center\'>-- OR --</td>" );
		out.println("				</tr>" );

		// outline by number
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Number:&nbsp;</td>" );
		out.println("					 <td>" );
		out.println("						<input type=\"text\" class=\'inputajax\' id=\"numbers2\" name=\"numbers2\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS2\',event,\'/central/servlet/ACS\'," + aseUtil.NUMBER + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">" );
		out.println("						<input type=\"hidden\" id=\"numbers2_hidden\" name=\"numbers2_ID\">" );
		out.println("				</td></tr>" );

		// OR
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td colspan=\'2\' align=\'center\'>-- OR --</td>" );
		out.println("				</tr>" );

		// outline by long alpha
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\' nowrap>Course:&nbsp;</td>" );
		out.println("					 <td>" );
		out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA + ",'','',document.aseForm.thisCampus,'')\">" );
		out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
		out.println("				</td></tr>" );

		// form buttons
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
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

 	asePool.freeConnection(conn);

%>

<%@ include file="../inc/chromefooter.jsp" %>

<table border="0" width="100%" id="table2">
	<tr>
		<td valign="top">
			<fieldset class="FIELDSET100">
				<legend>Available Courses</legend>
					<div id="txtCourses"><br />List of outlines will be displayed here...</div>
			</fieldset>
		</td>
	</tr>
</table>


<%@ include file="../inc/footer.jsp" %>
</body>
</html>
