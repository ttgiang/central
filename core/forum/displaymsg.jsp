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

	String pageTitle = "Message Board";
	String thisPage = "forum/displaymsg";

	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String status = website.getRequestParameter(request,"status","");

	String sort = website.getRequestParameter(request,"s","");
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
		int mid = website.getRequestParameter(request,"mid",0);
		int item = website.getRequestParameter(request,"item",0);

		String kix = ForumDB.getKixFromMid(conn,mid) + "_" + mid;

		// requires for upload
		session.setAttribute("aseKix",kix);
		session.setAttribute("aseUploadTo","Forum");
		session.setAttribute("aseCallingPage",thisPage);

		out.println(ForumDB.displayMessage(conn,user,mid,item,sort));

		if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals(Constant.BLANK) ){
			if (!origin.equals(Constant.COURSE) && !origin.equals(Constant.PROGRAM)){
				out.println(ForumDB.search());
			}
		}
	}

	asePool.freeConnection(conn,"displaymsg",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
