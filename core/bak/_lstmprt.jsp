<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.*"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	lstmprt.jsp	- generic import
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// this is in case the form doesn't know how to return here from submission processing
	session.setAttribute("aseCallingPage","lstmprt");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "List Import";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="js/lstmprt.js"></script>

	<link rel="stylesheet" href="./js/jquery/themes/base/jquery.ui.all.css">
	<script src="./js/jquery/jquery-1.5.1.js"></script>
	<script src="./js/jquery/ui/jquery.ui.core.js"></script>
	<script src="./js/jquery/ui/jquery.ui.widget.js"></script>
	<script src="./js/jquery/ui/jquery.ui.tabs.js"></script>
	<link rel="stylesheet" href="./js/jquery/demos.css">

	<script>
		$(function() {
			$( "#tabs" ).tabs();
		});
	</script>

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

	<script type="text/javascript" src="../inc/ajax.js"></script>
	<script type="text/javascript" src="../inc/ajax-dynamic-list.js"></script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%

	if (processPage){
	}

	String selected = "";
	String importType = "";

	String[] staticText = com.ase.aseutil.io.ImportConstant.IMPORT_TEXT.split(",");

	StringBuffer buf = new StringBuffer();
	String[] rows = null;

	String appl = "";
	String applicationType = "";

	String frmInputType = "text";
	String temp = "";

	int i = 0;

	String importText = "";

	// determines whether the next button should be set
	// if not all data collected, then button should be false
	boolean enable = true;

	int currentStep = 0;

	String cmdButton = "Next";

%>

<div class="demo">

<form method="post" id="aseForm" name="aseForm" action="?">

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">Upload Data</a></li>
		<li><a href="#tabs-2">Import Type</a></li>
		<li><a href="#tabs-3">Application</a></li>
	</ul>
	<div id="tabs-1">
		<p>
		Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>
	</div>
	<div id="tabs-2">
		<table border="0">
			<tr>
				<td align="left">
					<%
						int start = com.ase.aseutil.io.ImportConstant.IMPORT_COREQ;
						int end = com.ase.aseutil.io.ImportConstant.IMPORT_SLO;

						for (i=start;i<=end;i++){

							selected = "";
							if (importType.equals(""+i)){
								selected = "checked";
							}

							out.println("<input type=\"radio\" " + selected + " name=\"aseListImportField\" value=\""+i+"\">"+staticText[i]+"</input><br>");
						}
					%>
				</td>
			</tr>
		</table>
	</div>
	<div id="tabs-3">
		<%
			// allocating array to hold output. array size and usage is based on index
			// where the particular item is found. which means that there will be empty or null
			// cells with the exception of the element where a valid index is located.
			rows = new String[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+1];

			buf.append("<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );
			buf.append("<input type=\"hidden\" name=\"thisCampus\" value=\'" + campus + "\'>" );

			buf.append("<table width=\"100%\" cellspacing=\"1\" cellpadding=\"2\" align=\"center\"  border=\"0\">\n");

			// check to see if this is the one and only available radio button. If so, auto check by default
			String applicationTemp = appl;

			frmInputType = "radio";

			temp = importText;
			if (temp.startsWith(",")){
				temp = temp.substring(1);
			}

			if (temp.endsWith(",")){
				temp = temp.substring(0,temp.length()-1);
			}

			// if we don't find a comma in the string, then it's only 1 radio available
			// check to checkbox if it's the one and only item
			if (temp.indexOf(",") < 0){
				applicationTemp = temp;
				frmInputType = "checkbox";
			}

			selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE)) selected = "checked";
			rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE] = "<tr><td valign=\"top\" nowrap>"
				+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE]+"</input></td>"
				+ "<td valign=\"top\">"
				+ "<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
				+ "<input type=\"hidden\" id=\"alpha_hidden\" name=\"alphaID\"><br>"
				+ "<input type=\"text\" class=\'inputajax\' id=\"number\" name=\"number\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.ALPHA_NUMBER + ",document.aseForm.alphaID,document.aseForm.thisOption,document.aseForm.thisCampus,'APPROVED')\">"
				+ "<input type=\"hidden\" id=\"number_hidden\" name=\"numberID\">"
				+ "</td></tr>";

			selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA)) selected = "checked";
			rows[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA] = "<tr><td valign=\"top\" nowrap>"
				+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_ALPHA]+"</input></td>"
				+ "<td valign=\"top\">"
				+ "<input type=\"text\" class=\'inputajax\' id=\"alphaOnly\" name=\"alphaOnly\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
				+ "<input type=\"hidden\" id=\"alphaOnly_hidden\" name=\"alphaOnlyID\">"
				+ "</td></tr>";

			selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT)) selected = "checked";
			rows[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT] = "<tr><td valign=\"top\" nowrap>"
				+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DIV_DEPT]+"</input></td>"
				+ "<td valign=\"top\">"
				+ "<input type=\"text\" class=\'inputajax\' id=\"department\" name=\"department\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DIVISION_BANNER + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
				+ "<input type=\"hidden\" id=\"department_hidden\" name=\"departmentID\">"
				+ "</td></tr>";

			selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM)) selected = "checked";
			rows[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM] = "<tr><td valign=\"top\" nowrap>"
				+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_PROGRAM]+"</input></td>"
				+ "<td valign=\"top\">"
				+ "<input type=\"text\" class=\'inputajax\' id=\"program\" name=\"program\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.PROGRAM + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
				+ "<input type=\"hidden\" id=\"program_hidden\" name=\"programID\">"
				+ "</td></tr>";

			selected = ""; if (applicationTemp.equals(""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE)) selected = "checked";
			rows[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE] = "<tr><td valign=\"top\" nowrap>"
				+ "<input type=\""+frmInputType+"\" " + selected + " name=\"aseListImportField\" value=\""+com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE+"\">"+staticText[com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE]+"</input></td>"
				+ "<td valign=\"top\">"
				+ "<input type=\"text\" class=\'inputajax\' id=\"degree\" name=\"degree\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + AseUtil.DEGREE + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">"
				+ "<input type=\"hidden\" id=\"degree_hidden\" name=\"degreeID\">"
				+ "</td></tr>";

			// loop through available import to location and only display what this import type should use.
			// for example, pre, co, and xlist should only import to course outline
			int start2 = com.ase.aseutil.io.ImportConstant.IMPORT_COURSE_OUTLINE;
			int end2 = com.ase.aseutil.io.ImportConstant.IMPORT_DEGREE;

			for (i=start2;i<=end2;i++){
				buf.append(rows[i]);
			} // for

			buf.append("</table>\n");

			out.println(buf.toString());

		%>
	</div>
</div>

</div><!-- End demo -->

</form>

<%
	asePool.freeConnection(conn,"lstmprt",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
