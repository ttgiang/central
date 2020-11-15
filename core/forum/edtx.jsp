<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	edtx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String message = "";
	int table = 1;

	String thisPage = "forum/dsplst";

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String kix = website.getRequestParameter(request,"kix","");

	String status = website.getRequestParameter(request,"status","");
	String newStatus = website.getRequestParameter(request,"newStatus","");

	if (!newStatus.equals(Constant.BLANK)){
		status = newStatus;
	}

	String forumName = website.getRequestParameter(request,"forumName","");
	String forumDescr = website.getRequestParameter(request,"forumDescr","");
	String forumCampus = website.getRequestParameter(request,"forumCampus","");
	String xref = website.getRequestParameter(request,"xref","");

	if (forumCampus == null || forumCampus.equals(Constant.BLANK)){
		forumCampus = "ALL";
	}

	int fid = website.getRequestParameter(request,"fid",0);
	int priority = website.getRequestParameter(request,"priority",0);

	if (processPage){
		int rowsAffected = 0;

		try{
			boolean debug = false;

			if (debug){
				System.out.println("status: " + status);
				System.out.println("campus: " + forumCampus);
				System.out.println("category: " + src);
				System.out.println("title: " + forumName);
				System.out.println("Description: " + forumDescr);
				System.out.println("priority: " + priority);
				System.out.println("xref: " + xref);
			}
			else{
				Forum forum = new Forum(fid,
												forumCampus,
												kix,
												0,
												user,
												user,
												forumName,
												forumDescr,
												AseUtil.getCurrentDateTimeString(),
												"",
												src,
												status,
												priority,
												xref);

				rowsAffected = ForumDB.updateForum(conn,forum);

				if (rowsAffected >= 0)
					message = "Message updated successfully";
				else
					message = "Unable to update message";

				forum = null;
			}
		}
		catch(Exception e){
			//System.out.println(e.toString());
		}
	}	// processPage

	// requires for upload
	session.setAttribute("aseKix",kix);
	session.setAttribute("aseUploadTo","Forum");
	session.setAttribute("aseCallingPage",thisPage);

	asePool.freeConnection(conn,"edtx",user);
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header3.jsp" %>

<p align="center"><%=message%></p>

<p align=\"center\">
<a href="display.jsp?fid=0" class="linkcolumn">return to message listing</a>
<font class="">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a href="display.jsp?fid=<%=fid%>" class="linkcolumn">view newly created message</a>
<font class="">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a href="../gnrcmprt.jsp?src=thisPage&kix=hasValue" class="linkcolumn">attach document</a>
</p>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
