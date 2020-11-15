<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	edtcmmntx.jsp	save edit comment
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Edit Comments";
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix","");
	String comments = website.getRequestParameter(request,"comments","");
	int id = website.getRequestParameter(request,"id",0);
	int voteFor = website.getRequestParameter(request,"voteFor",0);
	int voteAgainst = website.getRequestParameter(request,"voteAgainst",0);
	int voteAbstain = website.getRequestParameter(request,"voteAbstain",0);

	if (processPage){
		HistoryDB.updateHistory(conn,comments,kix,id,voteFor,voteAgainst,voteAbstain);
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	asePool.freeConnection(conn,"edtcmmntx",user);

	response.sendRedirect("crsprgs.jsp?kix="+kix);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

