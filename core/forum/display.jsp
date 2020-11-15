<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	bb.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String thisPage = "forum/display";

	String pageTitle = "Message Board";

	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"../images/helpicon.gif\" border=\"0\" alt=\"show FAQ help\" title=\"show FAQ help\" onclick=\"switchMenu('forumHelp');\">";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String kix = website.getRequestParameter(request,"aseKix","",true);
	String status = website.getRequestParameter(request,"status","");

	String sort = website.getRequestParameter(request,"s","date");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<%
	if (processPage){

		int fid = website.getRequestParameter(request,"fid",0);
		if (fid > 0){
			kix = ForumDB.getKix(conn,fid);
		}

		// requires for upload
		session.setAttribute("aseKix",kix);
		session.setAttribute("aseUploadTo","Forum");
		session.setAttribute("aseCallingPage",thisPage);

		boolean ignorePeriod = true;

		out.println(ForumDB.display(conn,user,kix,fid,sort,ignorePeriod));

		if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
			if (!origin.equals(Constant.COURSE) && !origin.equals(Constant.PROGRAM)){
				out.println(ForumDB.search());
			}
		}
	}

	asePool.freeConnection(conn,"display",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
