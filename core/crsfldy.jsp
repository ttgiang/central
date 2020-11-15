<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.html.HtmlSanitizer"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfldy.jsp
	*	2007.09.01	displays content of course for debugging or viewing purposes
	*	TODO	work on handling of arc and can? Most likely NOT NEEDED
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","crsfld");

	String chromeWidth = "90%";
	String pageTitle = "";
	String alpha = "";
	String num = "";
	String type = "";

	session.setAttribute("aseCallingPage","crsfldy");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
		type = website.getRequestParameter(request,"view");;
	}

	if ((alpha==null || alpha.length()==0) && (num==null || num.length()==0)){
		response.sendRedirect("sltcrs.jsp?cp=crsfld");
	}

	if (type != null && type.length() > 0){
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	}

	fieldsetTitle = "Display Course Data";

	// reset for next selection
	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);
	session.setAttribute("aseView", null);

	session.setAttribute("aseKix", kix);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
	<script type="text/javascript" src="js/crsattach.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%

	if (processPage){
		String temp;

		if (alpha == null) {
			out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
		}
		else{

			// ER26 - ttgiang 2012-04-01
			out.println("<div align=\"middle\">" + CourseFieldsDB.drawRawEditIndex(conn,campus,0,1,CourseDB.totalQuestionsUsed(conn,campus),false,kix) + "</div>");
			out.println(CourseFieldsDB.getFieldMeta(conn,kix,2,user));

			// ER41 - ttgiang 2013-10-14
			out.println("<font class=\"textblackth\">Supporting Documents:</font><br>" + AttachDB.getAttachmentAsHTMLList(conn,kix));
			out.println( "<p align=\'left\'><a href=\'crsattach.jsp?kix="+kix+"\' class=\'linkColumn\' alt=\"Upload/attach documents\" title=\"Upload/attach documents\"><img src=\"../images/upload.png\" border=\"0\"></a></p>");

			out.println( "<br><hr size=\'1\'>");
			out.println( "<p align=\'center\'><a name=\"upload\"></a><a href=\'crsfld.jsp\' class=\'linkColumn\'>display another outline</a>"
				+ "&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'crsfldzz.jsp?kix="+kix+"\' class=\'linkColumn\'>re-generate outline</a></p>");
		}
	}

	asePool.freeConnection(conn,"crsfldy",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

