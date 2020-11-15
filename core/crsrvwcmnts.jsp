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

	String pageTitle = "Approval/Review Comments";

	String kix = website.getRequestParameter(request,"kix","");
	String alpha = "";
	String num = "";

	int sq = website.getRequestParameter(request,"sq",0);
	int en = website.getRequestParameter(request,"en",0);
	int qn = website.getRequestParameter(request,"qn",0);

	boolean foundation = false;
	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	boolean isAProgram = ProgramsDB.isAProgram(conn,campus,kix);
	if(!isAProgram){
		foundation = fnd.isFoundation(conn,kix);
	}

	String[] info = null;
	if(foundation){
		info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}
	else if (isAProgram){
		info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
	}
	else{
		info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}

	fieldsetTitle = pageTitle;
	pageTitle = pageTitle + "<br>" + courseDB.setPageTitle(conn,"",alpha,num,campus);

	fnd = null;
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
	if (processPage && !kix.equals(Constant.BLANK)){
		int item = website.getRequestParameter(request,"qn",0);
		int seq = website.getRequestParameter(request,"fd",0);
		int acktion = website.getRequestParameter(request,"md",0);
		int source = website.getRequestParameter(request,"c",0);

		out.println("<p align=\"center\"><font class=\"textblackth\">" + pageTitle + "</font></p>");
%>
		<p align="center">
		<a class="linkcolumn" href="crsrvwcmnts.jsp#" onclick="ddaccordion.collapseall('technology'); return false">Collapse all</a>
		<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<a class="linkcolumn" href="crsrvwcmnts.jsp#" onclick="ddaccordion.expandall('technology'); return false">Expand all</a>
		<div class="hr"></div>
		</p>

		<table width="100%" cellspacing="5" border="0">
			<tr>
				<td>
					<%
						if(Util.getSessionMappedKey(session,"EnableMessageBoard").equals(Constant.OFF)){
							if(foundation){
								out.println(ReviewerDB.getReviewHistory(conn,kix,sq,en,qn,acktion));
							}
							else{
								out.println(ReviewerDB.getReviewHistory(conn,kix,item,campus,source,acktion));
							}
						}
					%>
				</td>
			</tr>
		</table>
<%
		out.println("<table border=\"0\" cellpadding=\"1\" width=\"98%\">"
				+ "<tr><td valign=top>"
				+ "<div class=\"technology closedlanguage\" headerindex=\"0h\">Approval History & Voting Summary</div>"
				+ "<div class=\"thelanguage\" contentindex=\"0c\" style=\"display: none; \">  "
				+ HistoryDB.displayVotingHistory(conn,campus,kix)
				+ "</div>"
				+ "</td></tr>"
				+ "</table>");

	} // processPage

	asePool.freeConnection(conn,"crsrvwcmnts",user);

%>

</body>
</html>

