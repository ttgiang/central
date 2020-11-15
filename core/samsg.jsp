<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	samsg.jsp	- to get exactly to the right condition
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String code = website.getRequestParameter(request,"c","");
	String kix = website.getRequestParameter(request,"kix","");

	String message = "";
	String align = "";

	int codeName = 0;

	if (processPage){
		if (code.length() > 0){
			if (code.equals("ctsk"))
				codeName = 0;
			else if (code.equals("dtsk"))
				codeName = 1;
			else if (code.equals("dlthst"))
				codeName = 2;
			else if (code.equals("fill"))
				codeName = 3;
			else if (code.equals("lgs"))
				codeName = 4;
			else if (code.equals("rclhst"))
				codeName = 5;
			else if (code.equals("sync"))
				codeName = 6;
			else if (code.equals("props"))
				codeName = 7;
			else
				codeName = -1;
		}

		align = "left";

		message = (String)session.getAttribute("aseApplicationMessage");

		switch (codeName){
			case 0:
				message += "<br/><br/>Task created successfully..<p><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">Return to aproval detail</a></p>";
				break;
			case 1:
				message += "<br/><br/>Task deleted successfully..<p><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">Return to aproval detail</a></p>";
				break;
			case 2:
				message += "<br/><br/>History deleted successfully.<p><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">Return to aproval detail</a></p>";
				break;
			case 3:
				message += "<br/><br/>Items filled successfully.";
				break;
			case 4:
				message += "<br/><br/><a href=\"/central/core/zccv2.jsp\" class=\"linkcolumn\">Log </a>written successfully.";
				break;
			case 5:
				message += "<br/><br/>Approval history was recalled successfully.<p><a href=\"/central/core/crsprgs.jsp?kix="+kix+"\" class=\"linkcolumn\">Return to aproval detail</a></p>";
				break;
			case 6:
				message += "<br/><br/>Items Synched successfully.";
			case 7:
				message += "<br/><br/>Property file verification completed. See output for details.";
				break;
		}
	}

	asePool.freeConnection(conn,"samsg",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tbody>
		<tr>
			<td width="10%">&nbsp;</td>
			<td align="<%=align%>"><%=message%></td>
			<td width="10%">&nbsp;</td>
		</tr>
	</tbody>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
