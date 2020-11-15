<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrnmxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "crsrnm";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	String type = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
	}
	else{
		alpha = website.getRequestParameter(request,"fromAlpha","");
		num = website.getRequestParameter(request,"fromNum","");
		type = website.getRequestParameter(request,"type","");
	}

	// sent in from crsedt (course mod)
	// st determines whether we are here to start a change alpha or number
	// depending on st, we initialize screen accordingly
	String sa = website.getRequestParameter(request,"sa","");
	String sn = website.getRequestParameter(request,"sn","");
	String st = website.getRequestParameter(request,"st","");
	String ts = website.getRequestParameter(request,"ts","");
	String no = website.getRequestParameter(request,"no","");
	if (st.equals("a")){
		sa = "";
	}
	else if (st.equals("n")){
		sn = "";
	}

	// GUI
	String chromeWidth = "70%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Rename/Renumber Outline";
	String message = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="bigbox.jsp" %>
	<script language="JavaScript" src="js/crsrnmxx.js"></script>
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

			String sql = "";

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'crsrnmxy.jsp\'>" );
			out.println("			<input type=\'hidden\' name=\'thisOption\' value=\'CUR\'>" );

			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
			out.println("					 <td class=\'dataColumn\'>" );
			out.println(campus);
			out.println("						<input type=\"hidden\" name=\"thisCampus\" value=\'" + campus + "\'>" );
			out.println("				</td></tr>" );
			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\' width=\"15%\">Course Alpha:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' value=\""+sa+"\" id=\"alpha\" name=\"alpha\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getACS\',event,\'/central/servlet/ACS\'," + aseUtil.SHORT_ALPHA + ",'',document.aseForm.thisOption,document.aseForm.thisCampus,'')\">" );
			out.println("						<input type=\"hidden\" id=\"alpha_hidden\" name=\"alpha_ID\">" );
			out.println("				</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'  width=\"15%\">Course Number:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"text\" class=\'inputajax\' value=\""+sn+"\" id=\"toNum\" name=\"toNum\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getNum\',event,\'/central/servlet/jenga\',0,document.aseForm.thisCampus,document.aseForm.alpha_ID,'','')\">" );
			out.println("						<input type=\"hidden\" id=\"toNum_hidden\" name=\"toNum_ID\">" );
			out.println("				</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTH\'  width=\"15%\">Justification:&nbsp;</td>" );
			out.println("					 <td>" );

			String ckName = "justification";
			String ckData = "";
%>
			<%@ include file="ckeditor02.jsp" %>
<%

			out.println("				</td></tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'2\'><br/>" );
			out.println("							<input type=\'hidden\' name=\'kix\' value=\'" + kix + "\'>" );
			out.println("							<input type=\'hidden\' name=\'st\' value=\'" + st + "\'>" );
			out.println("							<input type=\'hidden\' name=\'no\' value=\'" + no + "\'>" );
			out.println("							<input type=\'hidden\' name=\'ts\' value=\'" + ts + "\'>" );
			out.println("							<input type=\'hidden\' name=\'fromAlpha\' value=\'" + fromAlpha + "\'>" );
			out.println("							<input type=\'hidden\' name=\'fromNum\' value=\'" + fromNum + "\'>" );
			out.println("							<input type=\'hidden\' name=\'type\' value=\'" + type + "\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("							<input type=\'hidden\' name=\'formAction\' value=\'q\'>" );
			out.println("							<input title=\"continue\" type=\'submit\' name=\'aseSubmit\' id=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(\'s\')\">" );
			out.println("							<input title=\"abort selected operation\" type=\'submit\' name=\'aseCancel\' id=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			String notified = aseUtil.lookUp(conn, "tblDistribution", "members", "title='NotifiedWhenCopy' AND campus = '" + campus + "'" );
			out.println("				<tr>" );
			out.println("					 <td colspan=2 nowrap><div class=\"hr\"></div>The following occur upon submission:<ul><li>Rename/renumber notifications sent to <strong>" + notified + "</strong></li><li>Rename/renumber outline will be available for modifications</li></ul></td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"crsrnmxx",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
