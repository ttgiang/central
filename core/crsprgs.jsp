<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsprgs.jsp	- add/delete approval tasks
	*	2007.09.01
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = "";
	String num = "";
	String type = "";
	String chromeWidth = "80%";

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Progress"
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/outlinerecall.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table width="100%">
	<tr>
		<td>
			<%
				if (processPage){
					out.println(outlines.showOutlineProgress(conn,kix,user));
				}

				asePool.freeConnection(conn,"crsprgs",user);
			%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
