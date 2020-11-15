<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	dltx.jsp
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
	String kix = website.getRequestParameter(request,"kix","");
	int fid = website.getRequestParameter(request,"fid",0);
	int item = website.getRequestParameter(request,"item",0);
	int emid = website.getRequestParameter(request,"emid",0);
	int rmid = website.getRequestParameter(request,"rmid",0);

	if (processPage){
		int rowsAffected = 0;

		try{
			rowsAffected = ForumDB.deletePost(conn,fid,emid,item);

			if (rowsAffected >= 0){
				message = "Message deleted successfully";
			}
			else{
				message = "Unable to update message";
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

	asePool.freeConnection(conn,"dltx",user);
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
<a href="displayusrmsg.jsp?fid=<%=fid%>&mid=<%=rmid%>&item=<%=item%>" class="linkcolumn">return to message listing</a>
</p>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
