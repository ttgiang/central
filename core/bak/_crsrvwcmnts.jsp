<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwcmnts.jsp		reviewer comments
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Reviewer Comments";

	String kix = website.getRequestParameter(request,"kix","");
	String alpha = "";
	String num = "";

	boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);

	String[] info = helper.getKixInfo(conn,kix);
	if (isAProgram){
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
	}
	else{
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}

	fieldsetTitle = pageTitle;
	pageTitle = pageTitle + " (" + courseDB.setPageTitle(conn,"",alpha,num,campus) + ")";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>

	<!-- jquery -->
	<link rel="stylesheet" href="./js/jquery/themes/base/jquery.ui.all.css">
	<script src="./js/jquery/jquery-1.5.1.js"></script>
	<script src="./js/jquery/ui/jquery.ui.core.js"></script>
	<script src="./js/jquery/ui/jquery.ui.widget.js"></script>
	<script src="./js/jquery/ui/jquery.ui.accordion.js"></script>
	<script src="./js/jquery/ui/jquery.ui.button.js"></script>
	<link rel="stylesheet" href="./js/jquery/demos.css">
	<script>
	$(function() {
		var icons = {
			header: "ui-icon-circle-arrow-e",
			headerSelected: "ui-icon-circle-arrow-s"
		};
		$( "#accordion" ).accordion({
			icons: icons
		});

		$( "#toggle" ).button().toggle(function() {
			$( "#accordion" ).accordion( "option", "icons", false );
		}, function() {
			$( "#accordion" ).accordion( "option", "icons", icons );
		});
	});
	</script>
	<!-- jquery -->

</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage && !"".equals(kix)){
		int item = website.getRequestParameter(request,"qn",0);
		int acktion = website.getRequestParameter(request,"md",0);
		int source = website.getRequestParameter(request,"c",0);

		out.println("<p align=\"center\"><font class=\"textblackth\">" + pageTitle + "</font></p>");
%>

<!--
<p align="center">
<a class="linkcolumn" href="crsrvwcmnts.jsp#" onclick="ddaccordion.collapseall('technology'); return false">Collapse all</a>
<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a class="linkcolumn" href="crsrvwcmnts.jsp#" onclick="ddaccordion.expandall('technology'); return false">Expand all</a>
<hr size="1" noshade>
</p>
-->

<table width="100%" cellspacing="5" border="0">
<tr><td>

<div class="demo">
<div id="accordion">

<%

		out.println(ReviewerDB.getReviewHistory(conn,kix,item,campus,source,acktion));
	}

	asePool.freeConnection(conn,"crsrvwcmnts",user);

	//com.ase.aseutil.report.ReportComments rg = new com.ase.aseutil.report.ReportComments();
	//rg.runReport(request,response);

%>
</div>
</div>

</td></tr>
</table>

</body>
</html>

