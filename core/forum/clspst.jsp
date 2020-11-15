<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	clspst.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String thisPage = "forum/display";

	String pageTitle = "Message Board";

	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"../images/helpicon.gif\" border=\"0\" alt=\"show FAQ help\" title=\"show FAQ help\" onclick=\"switchMenu('forumHelp');\">";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>

	<link rel="stylesheet" type="text/css" href="inc/style.css">

	<script language="JavaScript" src="inc/clspst.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="./inc/usrheader.jsp" %>

<%
	int fid = website.getRequestParameter(request,"fid",0);
	int mid = website.getRequestParameter(request,"mid",0);
	int item = website.getRequestParameter(request,"item",0);
	String forumName = ForumDB.getSubjectFromFid(conn,fid);
	String forumOwner = "";

	if (mid > 0){
		forumOwner = ForumDB.getCreator(conn,fid,mid);
	}
	else{
		forumOwner = ForumDB.getCreator(conn,fid);
	}

	String message = "";

	boolean posted = false;

	if (processPage){
		String cmdYes = website.getRequestParameter(request,"cmdYes","");
		if (cmdYes.toUpperCase().equals("YES") && fid > 0 && user.equals(forumOwner)){
			int rowsAffected = ForumDB.closePost(conn,fid,mid);
			if (rowsAffected > 0){
				message = "Post closed successfully.";
			}
			else{
				message = "Error while attempting to close post.";
			}
			posted = true;
		}
		else{
			message = "Only the creator may close this post";
		}
	}

	boolean isNotificationAvailable = ForumDB.isNotificationAvailable(conn,fid);

	// origin, item and tab tell us how we go here. If we go here not by starting this page
	// or the forum, then we want to save the value to the session and hide the menu
	String tab = "";
	String kix = "";
	String sItem = "";
	String orig = AseUtil.nullToBlank((String)session.getAttribute("aseOrigin"));
	if (!orig.equals(Constant.BLANK)){
		sItem = "" + item;
		if (item==0){
			sItem = AseUtil.nullToBlank((String)session.getAttribute("aseOriginItem"));
		}
		tab = AseUtil.nullToBlank((String)session.getAttribute("aseOriginTab"));
		kix = ForumDB.getKix(conn,fid);
	}

	String proposer = "";
	String[] info = helper.getKixInfo(conn,kix);
	if(!kix.equals(Constant.BLANK)){
		proposer = info[Constant.KIX_PROPOSER];
	}

	asePool.freeConnection(conn,"clspst",user);
%>

<table cellspacing="8" cellpadding="8" width="100%">
	<tbody>
		<%
			if (user.equals(forumOwner)){
		%>
				<tr>
					<td align="center">
						<%
							if (posted){

								String aseBoard = (String)session.getAttribute("aseBoard");

								out.println(	message
													+ Html.BR()
													+ Html.BR()
												);
						%>
								<%
									if(proposer.equals(user) && !orig.equals(Constant.BLANK)){
								%>
										<img src="../../images/back.gif" border="0" alt="return to outline" title="return to outline">&nbsp;<A class="linkcolumn" HREF="../crsedt.jsp?ts=<%=tab%>&no=<%=sItem%>&kix=<%=kix%>">return to outline<i></i></A>
										&nbsp;&nbsp;
								<%
									}
								%>
								<img src="./images/legend.png" border="0" alt="go to board listing" title="go to board listing">&nbsp;<A class="linkcolumn" HREF="../msgbrd.jsp">return to board listing<i></i></A>
								&nbsp;&nbsp;<font class="copyright">|</font>&nbsp;&nbsp;
								<img src="../../images/ed_list_num.gif" border="0" alt="go to post listing" title="go to post listing">&nbsp;<A class="linkcolumn" HREF="./usrbrd.jsp?fid=<%=fid%>">return to post listing</A>
						<%
							}
							else{
						%>
							<form name="aseForm" method="post" action="?">
								<%
									if (isNotificationAvailable){
										out.println("There are notifications that have not been viewed.<br><br>");
									}
								%>
								Closing a post prevents new replies from taking place. Do you wish to continue?
								<br><br>
									<input type="hidden" value="<%=fid%>" name="fid">
									<input type="hidden" value="<%=mid%>" name="mid">
									<input type="submit" value="Yes" name="cmdYes" class="input">
									<input type="submit" value="No" name="cmdNo" class="input" onClick="return cancelForm();">
							</form>
						<%
							}
						%>
					</td>
				</tr>
		<%
			}
			else{
		%>
				<tr>
					<td align="center">
						<%=message%>
						<br>
						<br>
						<%
							if(proposer.equals(user) && !orig.equals(Constant.BLANK)){
						%>
								<img src="../../images/back.gif" border="0" alt="return to outline" title="return to outline">&nbsp;<A class="linkcolumn" HREF="../crsedt.jsp?ts=<%=tab%>&no=<%=sItem%>&kix=<%=kix%>">return to outline<i></i></A>
								&nbsp;&nbsp;
						<%
							}
						%>

						<img src="../../images/ed_list_num.gif" border="0" alt="go to post listing" title="go to post listing">&nbsp;<A class="linkcolumn" HREF="./usrbrd.jsp?fid=<%=fid%>">return post listing</A>
					</td>
				</tr>
		<%
			}
		%>
	</tbody>
</table>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
