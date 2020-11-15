<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwstsh.jsp - outline review comments
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String helpButton = website.getRequestParameter(request,"help");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";
	int route = 0;

	String pageTitle = "Outline Review Comments";

	String kix = website.getRequestParameter(request,"kix");

	boolean foundation = com.ase.aseutil.fnd.FndDB.isFoundation(conn,kix);

	if (!kix.equals(Constant.BLANK)){

		String[] info = null;

		if(foundation){
			info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
			pageTitle = "Foundation Course Review Comments";
		}
		else{
			info = helper.getKixInfo(conn,kix);
			pageTitle = "Outline Review Comments";
		}

		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if ((Constant.ON).equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}

	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="../inc/expand.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
	<tr><td align="center" class="textblackthcenter">
		<%
			out.println(pageTitle + "<br>");
			out.println(courseDB.setPageTitle(conn,"",alpha,num,campus));
		%>
	</td></tr>
</table>

<p align="center">
<a class="linkcolumn" href="crsrvwcmnts.jsp#" onclick="ddaccordion.collapseall('technology'); return false">Collapse all</a>
<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a class="linkcolumn" href="crsrvwcmnts.jsp#" onclick="ddaccordion.expandall('technology'); return false">Expand all</a>
<div class="hr"></div>
</p>

<%
	out.println(ReviewerDB.getReviewHistory(conn,kix,0,campus,0,0));

	asePool.freeConnection(conn);

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>

</body>
</html>