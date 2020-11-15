<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrwslox.jsp	return completed SLO review to proposer
	*	NOT USED. Replaced with call from CompDB.setCompApproval
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "SLO Review";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	try{
		String alpha = "";
		String num = "";
		String type = "";

		String kix = website.getRequestParameter(request,"kix");
		if (!kix.equals("")){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			type = info[2];
		}
		else{
			alpha = (String)session.getAttribute("aseAlpha");
			num = (String)session.getAttribute("aseNum");
			type = (String)session.getAttribute("aseType");
		}

		String campus = Util.getSessionMappedKey(session,"aseCampus");
		String user = Util.getSessionMappedKey(session,"aseUserName");

		String campusName = CampusDB.getCampusName(conn,campus);
		String proposer = courseDB.getCourseProposer(conn,campus,alpha,num,type);

		int rowsAffected = SLODB.reviewCompleted(conn,kix,user,proposer);

		out.println("	<table width=\'40%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td colspan=\"2\"><p align=\"left\">SLO Review completion was sent successfully to: " + proposer + "<br/><br/></td>" );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Campus:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + campusName );
		out.println("			</td></tr>" );

		out.println("			<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("				 <td class=\'textblackTH\' nowrap>Outline:&nbsp;</td>" );
		out.println("					 <td class=\'dataColumn\'>" + alpha + " " + num);
		out.println("			</td></tr>" );

		out.println("	</table>" );

		asePool.freeConnection(conn);
	}
	catch(Exception e){}
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
