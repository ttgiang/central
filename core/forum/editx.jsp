<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	editx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String thisPage = "forum/editx";

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String message = "";

	int fid = website.getRequestParameter(request,"fid",0);
	int rmid = website.getRequestParameter(request,"rmid",0);
	int emid = website.getRequestParameter(request,"emid",0);
	int item = website.getRequestParameter(request,"item",0);

	// check to prevent reposting
	String processed = aseUtil.nullToBlank((String)session.getAttribute("aseProcessed"));

	if (processPage && !processed.equals("YES")){

		try{

			String subject = website.getRequestParameter(request,"subject","");
			String body = website.getRequestParameter(request,"message","");
			boolean notify = website.getRequestParameter(request,"notify",false);

			if (!subject.equals(Constant.BLANK)){

				if (Board.updatePost(conn,fid,emid,subject,body,notify) > 0){
					message = "Post updated successfully";
				}
				else{
					message = "";
				}

			}
		}
		catch(Exception e){
			System.out.println(e.toString());
		}
	}	// processPage

	session.setAttribute("aseProcessed","YES");

	asePool.freeConnection(conn,"editx",user);
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header3.jsp" %>

<p align="center">

<%=message%>

<br>
<br>

<img src="../../images/viewcourse.gif" border="0" alt="Back to message listing" title="Back to message listing">&nbsp;&nbsp;<a href="displayusrmsg.jsp?fid=<%=fid%>&mid=<%=rmid%>&item=<%=item%>" class="linkcolumn">View replies</a>

<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<img src="/central/images/ed_list_num.gif" border="0" alt="Back to post listing" title="Back to post listing">&nbsp;&nbsp;<a href="usrbrd.jsp?fid=<%=fid%>" class="linkcolumn">Go to post listing</a>

<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<img src="../../images/viewcourse.gif" border="0" alt="Back to message listing" title="Back to message listing">&nbsp;&nbsp;<a href="../msgbrd.jsp" class="linkcolumn">Go to board listing</a>

</p>



<p align=\"center\">

<%
%>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
