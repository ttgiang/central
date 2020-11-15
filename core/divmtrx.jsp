<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	divmtrx.jsp	- diversification matrix
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String topic = website.getRequestParameter(request,"topic","");
	String subTopic =website.getRequestParameter(request,"topic","");
	String src = (String)session.getAttribute("aseQuestionFriendly");

	String currentTab = (String)session.getAttribute("aseCurrentTab");
	String currentNo = (String)session.getAttribute("asecurrentSeq");

	String kix = website.getRequestParameter(request,"kix","");

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];

	String pageTitle = "Diversification Matrix - "
						+ topic
						+ " - "
						+ courseDB.setPageTitle(conn,"",alpha,num,campus);

	fieldsetTitle = pageTitle;
	//+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/linkeditems.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/divmtrx.js"></script>
	<%@ include file="stickytooltip.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form name="aseForm" method="post" action="divmtrxx.jsp">
<%
	if (processPage){

		MiscDB.deleteStickyMisc(conn,kix,user);

		String competencies = ValuesDB.diversificationMatrix(conn,
																				kix,
																				topic,
																				subTopic,
																				Constant.COURSE_AAGEAREA_C40,
																				Constant.COURSE_COMPETENCIES,
																				true,
																				false);

		String objectives = ValuesDB.diversificationMatrix(conn,
																				kix,
																				topic,
																				subTopic,
																				Constant.COURSE_AAGEAREA_C40,
																				Constant.COURSE_OBJECTIVES,
																				true,
																				false);

		String dst = Constant.COURSE_COMPETENCIES + "," + Constant.COURSE_OBJECTIVES;

		if (competencies != null && objectives != null){
			out.println(
				 "<table width=\"94%\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
				+ "<tr><td class=\"textblackth\">COMPETENCIES</td></tr>"
				+ "<tr><td>"
				+ competencies
				+ "</td></tr>"
				+ "<tr><td class=\"textblackth\">OBJECTIVES</td></tr>"
				+ "<tr><td>"
				+ objectives
				+ "</td></tr>"
				+ "</table>"
				+ MiscDB.getStickyNotes(conn,kix,user)
				+ "<input type=\"hidden\" name=\"kix\" value=\""+kix+"\">"
				+ "<input type=\"hidden\" name=\"alpha\" value=\""+alpha+"\">"
				+ "<input type=\"hidden\" name=\"num\" value=\""+num+"\">"
				+ "<input type=\"hidden\" name=\"topic\" value=\""+topic+"\">"
				+ "<input type=\"hidden\" name=\"src\" value=\""+src+"\">"
				+ "<input type=\"hidden\" name=\"dst\" value=\""+dst+"\">"
				+ "<input type=\"submit\" class=\"input\" name=\"cmdSubmit\" value=\"Submit\" title=\"save data\">&nbsp;&nbsp;"
				+ "<input type=\"submit\" class=\"input\" name=\"cmdCancel\" value=\"Cancel\" title=\"abort selected operation\" onClick=\"return cancelForm('"+kix+"','"+currentTab+"','"+currentNo+"')\">"
				);
		}

		MiscDB.deleteStickyMisc(conn,kix,user);
	}

	asePool.freeConnection(conn,"divmtrx",user);
%>
</form>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
