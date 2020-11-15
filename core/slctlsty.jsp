<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	slctlst.jsp	- select from a list to import
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	String src = website.getRequestParameter(request,"src","");
	String dst = website.getRequestParameter(request,"dst","");
	String rtn = website.getRequestParameter(request,"rtn","");
	String subtopic = website.getRequestParameter(request,"subtopic","");

	int rowsAffected = 0;
	String listName = DivisionDB.getDivisionNameFromCode(conn,campus,subtopic);

	String pageTitle = "Import List Items";

	fieldsetTitle = pageTitle;

	if (processPage){
		if (dst.equals(Constant.COURSE_OBJECTIVES)){
			rowsAffected = CompDB.insertListFromSrc(conn,campus,kix,user,src,subtopic);
		}
		else {
			rowsAffected = GenericContentDB.insertListFromSrc(conn,campus,kix,user,src,dst,subtopic);
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<p align="center">
List created successfully!
<br/><br/>

<%
	if (dst.equals(Constant.COURSE_OBJECTIVES)){
%>
		<a href="<%=rtn%>.jsp?kix=<%=kix%>&s=c" class="linkcolumn">return to list entry</a>
<%
	}
	else {
%>
		<a href="<%=rtn%>.jsp?kix=<%=kix%>&src=<%=dst%>&dst=<%=dst%>" class="linkcolumn">return to list entry</a>
<%
	}
%>

</p>

<%
	asePool.freeConnection(conn,"slctlsty",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
