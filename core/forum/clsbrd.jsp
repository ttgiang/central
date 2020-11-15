<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	clsbrd.jsp - create program
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

	// origin, item and tab tell us how we go here. If we go here not by starting this page
	// or the forum, then we want to save the value to the session and hide the menu
	String item = "";
	String tab = "";
	String kix = "";
	String orig = AseUtil.nullToBlank((String)session.getAttribute("aseOrigin"));
	if (!orig.equals(Constant.BLANK)){
		item = AseUtil.nullToBlank((String)session.getAttribute("aseOriginItem"));
		tab = AseUtil.nullToBlank((String)session.getAttribute("aseOriginTab"));
		kix = AseUtil.nullToBlank((String)session.getAttribute("aseKix"));
	}
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>

	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link rel="stylesheet" type="text/css" href="inc/niceframe.css">

	<script language="JavaScript" src="inc/clsbrd.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="./inc/usrheader.jsp" %>

<%
	int fid = website.getRequestParameter(request,"fid",0);
	if(fid > 0){
		kix = ForumDB.getKix(conn,fid);
	}

	String forumName = ForumDB.getSubjectFromFid(conn,fid);
	String forumOwner = ForumDB.getCreator(conn,fid);
	String message = "";

	boolean posted = false;

	if (processPage){
		String cmdYes = website.getRequestParameter(request,"cmdYes","");
		if (cmdYes.toUpperCase().equals("YES") && fid > 0 && user.equals(forumOwner)){
			int rowsAffected = ForumDB.closeForum(conn,user,fid);
			if (rowsAffected > 0){
				message = "Message board closed successfully.";
			}
			else{
				message = "Error while attempting to close message board.";
			}
			posted = true;
		}
	}

	asePool.freeConnection(conn,"clsbrd",user);
%>

<div id="main">
	<table class="highcontainer" cellspacing="8" cellpadding="8">
		<tbody>
			<tr>
				<td class="htd">
					<div id="rankings">

						<h3 class="goldhighlightsbold"><%=forumName%></h3>

						<table width="100%" cellspacing="1" cellpadding="4">
							<tbody>
								<tr>
									<th style="text-align:left;" nowrap="nowrap">Posted Messages</th>
									<th width="10%">Posted By</th>
									<th width="15%">Posted Date</th>
									<th width="10%">Responses</th>
									<th width="10%">Participants</th>
								</tr>
								<%
									int i = 0;

									String clss = "";

									for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPosts(conn,fid)){

										if (i % 2 == 0){
											clss = "rankline1";
										}
										else{
											clss = "rankline2";
										}

										++i;
								%>
									<tr class="<%=clss%>">
										<td style="text-align:left;"><%=u.getString1()%></td>
										<td ><%=u.getString2()%></td>
										<td style="text-align:left;"><%=u.getString3()%></td>
										<td><%=u.getString4()%></td>
										<td><%=u.getString5()%></td>
									</tr>
								<% } %>

							</tbody>
						</table>
					</div>
				</td>
			</tr>
			<%

				String reviewerNames = ReviewerDB.getReviewerNames(conn,kix);
				String approverNames = ApproverDB.getApproverNames(conn,kix);

				if (	user.equals(forumOwner)
						&& (reviewerNames == null || reviewerNames.equals(Constant.BLANK))
						&& (approverNames == null || approverNames.equals(Constant.BLANK))
				){
			%>
					<tr>
						<td class="htd" align="center">
							<%
								if (posted){
									out.println(message);
								}
								else{
							%>
								<form name="aseForm" method="post" action="?">
									Closing a board prevents new postings from being created. Do you wish to continue?
									<br><br>
										<input type="hidden" value="<%=fid%>" name="fid">
										<input type="submit" value="Yes" name="cmdYes" class="input">
										<input type="submit" value="No" name="cmdNo" class="input" onClick="return cancelForm(<%=fid%>);">
								</form>
							<%
								}
							%>
						</td>
					</tr>
			<%
				}
			%>
		</tbody>
	</table>

	<p align="left">

		<%
			if(!orig.equals(Constant.BLANK)){
		%>
				<img src="../../images/back.gif" border="0" alt="return to outline" title="return to outline">&nbsp;<A class="linkcolumn" HREF="../crsedt.jsp?ts=<%=tab%>&no=<%=item%>&kix=<%=kix%>">return to outline<i></i></A>
				&nbsp;&nbsp;
		<%
			}
		%>

		<img src="./images/legend.png" border="0" alt="go to board listing" title="go to board listing">&nbsp;<A class="linkcolumn" HREF="../msgbrd.jsp">return to board listing<i></i></A>
	</p>

</div>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
