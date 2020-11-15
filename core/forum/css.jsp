<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	displayusrmsg.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Message Board";
	String thisPage = "forum/displaymsg";

	String rtrToBoard = AseUtil.nullToBlank((String)session.getAttribute("aseBoard"));

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
	<script language="JavaScript" src="inc/displayusrmsg.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/forum.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/usrheader.jsp" %>

<%
	if (processPage){
		int fid = website.getRequestParameter(request,"fid",0);
		int mid = website.getRequestParameter(request,"mid",0);
		int item = website.getRequestParameter(request,"item",0);

		String kix = ForumDB.getKixFromMid(conn,mid) + "_" + mid;

		// requires for upload
		session.setAttribute("aseKix",kix);
		session.setAttribute("aseUploadTo","Forum");
		session.setAttribute("aseCallingPage",thisPage);

%>

<div id="page">
	<div id="primary">
		<div id="content" role="main">
			<div id="comments">
				<ol class="commentlist">
					<%
						out.println(Board.displayBoardThreaded(conn,user,fid,mid,item,"",""));
					%>
				</ol>
			</div>
		</div>
	</div>
</div>

<%

	}

	asePool.freeConnection(conn,"displaymsg",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
