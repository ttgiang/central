<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgprgs.jsp
	*	2007.09.01
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String alpha = "";
	String num = "";
	String chromeWidth = "80%";

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
	}

	String pageTitle = alpha;
	fieldsetTitle = "Program Progress";
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
					out.println(ProgramsDB.showProgramProgress(conn,campus));
				}

				asePool.freeConnection(conn,"prgprgs",user);
			%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>