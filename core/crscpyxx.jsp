<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscpyxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");

	if (campus != null){
		campus = campus.toUpperCase();
	}

	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String type = "";
	String outlineCampus = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[Constant.KIX_TYPE];
		outlineCampus = info[Constant.KIX_CAMPUS];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = website.getRequestParameter(request,"t");
		outlineCampus = website.getRequestParameter(request,"cps");
		kix = helper.getKix(conn,outlineCampus,alpha,num,type);
	}

	// default the alpha and number so that we have a consistent copy across campuses
	String defaultAlpha = "";
	String defaultNum = "";

	if(!outlineCampus.equals(campus)){
		defaultAlpha = alpha;
		defaultNum = num;
	}
	else if(outlineCampus.equals(campus)){
		defaultAlpha = alpha;
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,outlineCampus);
	fieldsetTitle = "Copy Outline";
	String message = "";
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

	<script language="JavaScript" src="js/crscpyxx.js"></script>
	<script type="text/javascript" src="../inc/ajax.js"></script>
	<script type="text/javascript" src="../inc/ajax-dynamic-list.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){

		try{

			String fromAlpha = alpha;
			String fromNum = num;

			// when from and to are the same campus, don't default alpha and num
			if (outlineCampus.equals(campus)){
				fromAlpha = "";
				fromNum = "";
			}

			String sql = "";

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crscpyxy.jsp\'>" );
			out.println("			<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );

			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap colspan=2><br /><p align=\'center\'>Enter new alpha and number</p><br /></td>" );
			out.println("				</tr>" );
			out.println("				<tr>" );
			out.println("					 <td width=\"15%\" class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td width=\"85%\" class=\'dataColumn\'>" );
			out.println( campus );
			out.println("						<input type=\"hidden\" name=\"thisCampus\" value=\'" + campus + "\'>" );
			out.println("				</td></tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Course Alpha:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\""+defaultAlpha+"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
			out.println("				</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Course Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' id=\"toNum\" name=\"toNum\" autocomplete=\"off\" value=\""+defaultNum+"\" size=\'4\' maxlength=\'4\'>" );
			out.println("				</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Comments:&nbsp;</td>" );
			out.println("					 <td>" );

			String ckName = "comments";
			String ckData = "";
%>
			<%@ include file="ckeditor02.jsp" %>
<%
			out.println("				</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><div class=\"hr\"></div>" );
			out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("							<input type=\'hidden\' name=\'fromCampus\' value=\'" + outlineCampus + "\'>" );
			out.println("							<input type=\'hidden\' name=\'fromAlpha\' value=\'" + fromAlpha + "\'>" );
			out.println("							<input type=\'hidden\' name=\'fromNum\' value=\'" + fromNum + "\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'q\'>" );
			out.println("							<input title=\"continue\" type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(\'s\')\">" );
			out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			String notified = aseUtil.lookUp(conn, "tblDistribution", "members", "title='NotifiedWhenCopy' AND campus = '" + campus + "'" );
			out.println("				<tr>" );
			out.println("					 <td colspan=2 nowrap><div class=\"hr\"></div>The following occur upon submission:<ul><li>Copied notifications sent to <strong>" + notified + "</strong></li><li>Copied outline will be available for modifications</li></ul></td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}


	}

	asePool.freeConnection(conn,"crscpyxx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
