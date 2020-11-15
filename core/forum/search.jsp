<%@ include file="../ase.jsp" %>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>

<%
	/**
	*	ASE
	*	search.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String status = website.getRequestParameter(request,"status","");
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

		String searchType = "";

		String keyword = website.getRequestParameter(request,"keyword","");
		String author  = website.getRequestParameter(request,"author","");
		String subject = website.getRequestParameter(request,"subject","");
		String body    = website.getRequestParameter(request,"body","");
		String startDate = website.getRequestParameter(request,"startDate","");
		String endDate   = website.getRequestParameter(request,"endDate","");

		String aType = website.getRequestParameter(request,"aType","");
		String bType = website.getRequestParameter(request,"bType","");
		String sType = website.getRequestParameter(request,"sType","");

		// determine search type
		if (!"".equals(keyword))
			searchType = "basic";
		else{
			if (	!"".equals(author) ||
					!"".equals(subject) ||
					!"".equals(body) ||
					!"".equals(startDate) ||
					!"".equals(endDate)){
				searchType = "advanced";
			}
		} // if (!"".equals(keyword))

		String sql = ForumDB.getSearchSQL(searchType,author,aType,subject,sType,body,bType,startDate,endDate,keyword);

		// perform search
		if (!"".equals(sql)){
			paging = new com.ase.paging.Paging();
			paging.setScriptName("search.jsp");
			paging.setDetailLink("displaymsg.jsp");
			paging.setUrlKeyName("mid");
			paging.setSQL(sql);
			paging.setRecordsPerPage(999);
			out.print(paging.showRecords(conn,request,response));
			paging = null;
		} // if sql

		// show form
		if ("basic".equals(searchType)){
			out.println("<BR><hr size='1'><p align=\"left\"><B><I>Refine your search:</I></B></p>");
			out.println(ForumDB.showSearchFormAdvanced(0,"","","","",keyword,"","",""));
		}
		else if ("advanced".equals(searchType)){
			out.println("<BR><hr size='1'><p align=\"left\"><B><I>Refine your search:</I></B></p>");
			out.println(ForumDB.showSearchFormAdvanced(0,author,aType,subject,sType,body,bType,startDate,endDate));
		}
		else{
			out.println("<p align=\"left\"><B><I>Advanced search:</I></B></p>");
			out.println(ForumDB.showSearchFormAdvanced(0,"","","","","","","",""));
		} // if basic
	} // processPage

	asePool.freeConnection(conn,"search",user);
%>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
