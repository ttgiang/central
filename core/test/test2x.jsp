<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsattach.jsp	course attachment
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// these values were set in crsedt
	String caller = aseUtil.getSessionValue(session,"aseCallingPage");

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"","","",campus);
	fieldsetTitle = "Outline Attachments";

	String stamp = "";
	String kix = "";
	String alpha = "";
	String num = "";
	String comment = "";
	String fieldName = "";
	String fileName = "";
	String fileTitle = "";
	String contentType = "";

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">

	<style type="text/css">
		.upload_field { width: 90%; display: block; }
		em.alt { color: #999; }
		#upload_files fieldset { border: 1px solid #ccc; -moz-border-radius: 7px; -webkit-border-radius: 7px; }
		#upload_files legend { font-size: 1.2em; }
		fieldset.alt { background-color: #f7f7ff; }
	</style>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
