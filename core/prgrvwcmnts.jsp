<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvwcmnts.jsp		reviewer comments
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approval Comments";

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

	pageTitle = alpha + " " + num;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
	<link rel="stylesheet" type="text/css" href="./forum/inc/niceframe.css">
	<link rel="stylesheet" type="text/css" href="./forum/inc/forum.css">
	<%@ include file="../inc/expand.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage && !"".equals(kix)){
		int item = website.getRequestParameter(request,"qn",0);
		int acktion = website.getRequestParameter(request,"md",0);
		int source = website.getRequestParameter(request,"c",0);

		out.println("<p align=\"center\"><font class=\"textblackth\">" + pageTitle + "</font></p>");
%>
		<p align="center">
		<a class="linkcolumn" href="prgrvwcmnts.jsp#" onclick="ddaccordion.collapseall('technology'); return false">Collapse all</a>
		<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<a class="linkcolumn" href="prgrvwcmnts.jsp#" onclick="ddaccordion.expandall('technology'); return false">Expand all</a>
		<div class="hr"></div>
		</p>

		<table width="100%" cellspacing="5" border="0">
			<tr>
				<td>
					<% out.println(ReviewerDB.getReviewHistory(conn,kix,item,campus,source,acktion)); %>
				</td>
			</tr>
		</table>
<%
	} // processPage

	asePool.freeConnection(conn,"prgrvwcmnts",user);

	//com.ase.aseutil.report.ReportComments rg = new com.ase.aseutil.report.ReportComments();
	//rg.runReport(request,response);

%>

</td></tr>
</table>

</body>
</html>