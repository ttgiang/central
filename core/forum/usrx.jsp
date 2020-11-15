<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	usrx.jsp - create a forum on the fly
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String message = "";

	// createMessage is meant for work with outline review and not manually
	// created boards

	boolean createMessage = false;
	int table = 1;
	int fid = 0;

	String thisPage = "forum/dsplst";

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = "TBD";

	String type = website.getRequestParameter(request,"type","user");

	String forumName = website.getRequestParameter(request,"forumName","");
	String forumDescr = website.getRequestParameter(request,"forumDescr","");

	String forumCampus = campus;

	if (processPage){
		int rowsAffected = 0;

		try{
			Forum forum = new Forum(0,
											forumCampus,
											kix,
											0,
											user,
											user,
											forumName,
											forumDescr,
											AseUtil.getCurrentDateTimeString(),
											Constant.BLANK,
											Constant.FORUM_USERNAME);

			rowsAffected = ForumDB.insertForum(conn,forum,table,createMessage);

			// the returned value is formulated in the object creating the forum
			kix  = ForumDB.getKix(conn,rowsAffected);

			// the kix value is used to returned the actual forum id
			fid = ForumDB.getForumID(conn,campus,kix);

			if (rowsAffected > 1){
				message = "Message board created successfully";
			}
			else{
				message = "Unable to create message board";
			}

			forum = null;
		}
		catch(Exception e){
			//System.out.println(e.toString());
		}
	}	// processPage

	// requires for upload
	session.setAttribute("aseKix",kix);
	session.setAttribute("aseUploadTo","Forum");
	session.setAttribute("aseCallingPage",thisPage);

	asePool.freeConnection(conn,"usrx",user);
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
<a href="usrbrd.jsp?fid=<%=fid%>" class="linkcolumn">return to message listing</a>
<font class="">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a href="display.jsp?fid=<%=fid%>" class="linkcolumn">view newly created message</a>
<font class="">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<a href="../gnrcmprt.jsp?src=thisPage&kix=hasValue" class="linkcolumn">attach document</a>
</p>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
