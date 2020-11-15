<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	usrbrd.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// origin, item and tab tell us how we go here. If we go here not by starting this page
	// or the forum, then we want to save the value to the session and hide the menu
	String item = "";
	String tab = "";
	String orig = AseUtil.nullToBlank((String)session.getAttribute("aseOrigin"));
	if (!orig.equals(Constant.BLANK)){
		item = AseUtil.nullToBlank((String)session.getAttribute("aseOriginItem"));
		tab = AseUtil.nullToBlank((String)session.getAttribute("aseOriginTab"));
	}
	else{
		orig = website.getRequestParameter(request,"orig","");
		if (!orig.equals(Constant.BLANK)){
			session.setAttribute("aseOrigin",orig);

			item = website.getRequestParameter(request,"item","");
			if (!item.equals(Constant.BLANK)){
				session.setAttribute("aseOriginItem",item);
			}

			tab = website.getRequestParameter(request,"ts","1");
			if (!tab.equals(Constant.BLANK)){
				session.setAttribute("aseOriginTab",tab);
			}

		}
	}

	// which view to return
	String rtrToBoard = AseUtil.nullToBlank((String)session.getAttribute("aseBoard"));

	String thisPage = "forum/display";

	String pageTitle = "Message Board";

	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"../images/helpicon.gif\" border=\"0\" alt=\"show FAQ help\" title=\"show FAQ help\" onclick=\"switchMenu('forumHelp');\">";

	// retrieve key information
	int fid = website.getRequestParameter(request,"fid",0);
	String kix = website.getRequestParameter(request,"kix","");

	if (fid > 0){
		kix = ForumDB.getKix(conn,fid);
	}
	else if (!kix.equals(Constant.BLANK)){
		fid = ForumDB.getForumID(conn,campus,kix);
	}

	session.setAttribute("aseKix",kix);

	// remember the view user was on before coming here (open=1, closed=0, both=2)
	String aseBoardsToShow = (String)session.getAttribute("aseBoardsToShow");
	if (aseBoardsToShow == null){
		aseBoardsToShow = "1";
	}

	// mode of operation
	String m = website.getRequestParameter(request,"m","");

	if (!m.equals(Constant.BLANK)){

		String uid = website.getRequestParameter(request,"uid","");
		// is member delete requested?
		if (!uid.equals(Constant.BLANK)){
			if (m.equals("a")){
				Board.addBoardMember(conn,fid,uid.toUpperCase());
			}
			else if (m.equals("d")){
				Board.deleteBoardMember(conn,fid,uid.toUpperCase());
			}
		} // valid uid

	} // valid mode

	// retrieve forum data
	Forum forum = ForumDB.getForum(conn,fid);
	String forumName = forum.getForum();
	String forumDesc = forum.getDescr();
	String forumOwner = forum.getCreator();
	String status = forum.getStatus();

	if (forum.getHistoryid() != null && forum.getHistoryid().length() > 0){

		String courseDescr = courseDB.getCourseDescription(conn,forum.getHistoryid());
		if (courseDescr != null && courseDescr.length() > 0){
			forumName = forumName + " - " + courseDescr;
		}
		else{
			forumName = forumName + " - " + forumDesc;
		}

	} // forum.getHistoryid()

	int i = 0;

	String clss = "";

	// release connection back to pool
	asePool.freeConnection(conn,"usrbrd",user);

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link rel="stylesheet" type="text/css" href="inc/forum.css">
	<link rel="stylesheet" type="text/css" href="inc/niceframe.css">
	<script language="JavaScript" src="inc/usrbrd.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="./inc/usrheader.jsp" %>

<div id="main">
	<table class="highcontainer" cellspacing="4" cellpadding="4">
		<tbody>
			<tr>
				<td><h3 class="goldhighlightsbold"><%=forumName%></h3></td>
				<td align="right">

					<%
						if(!orig.equals(Constant.BLANK)){
					%>
							<A class="linkcolumn" HREF="../crsedt.jsp?ts=<%=tab%>&no=<%=item%>&kix=<%=kix%>"><img src="../../images/back.gif" border="0" title="resume outline work"></A>
							&nbsp;<font class="copyright">|</font>&nbsp;
					<%
						}
					%>

					<A class="linkcolumn" HREF="../<%=rtrToBoard%>.jsp?s=<%=aseBoardsToShow%>"><img src="./images/legend.png" border="0" title="go to board listing"></A>

					<%
						// when working with an outline/program, users are not allowed to create a post from here.
						// must be created in the review process.
						if(!status.toLowerCase().equals(ForumDB.FORUM_CLOSED) && !CourseDB.courseExist(conn,kix)){
					%>
							&nbsp;<font class="copyright">|</font>&nbsp;
							<A class="linkcolumn" HREF="./post.jsp?src=<%=Constant.FORUM_USERNAME%>&fid=<%=fid%>"><img src="./images/icon_post_message.png" border="0" title="new post"></A>
					<%
						}
					%>

					&nbsp;<font class="copyright">|</font>&nbsp;
					<A class="linkcolumn" HREF="prt.jsp?fid=<%=fid%>" target="_blank"><img src="../../images/printer.jpg" border="0" title="printer friendly"></A>

					<%
						if(user.equals(forumOwner) && !status.toLowerCase().equals(ForumDB.FORUM_CLOSED)){
					%>
							&nbsp;<font class="copyright">|</font>&nbsp;
							<A class="linkcolumn" HREF="./clsbrd.jsp?fid=<%=fid%>"><img src="./images/close_door.gif" border="0" title="close message board"></A>
					<%
						}
					%>

					&nbsp;<font class="copyright">|</font>&nbsp;
					<a href="../vwcrsy.jsp?pf=1&kix=<%=kix%>&comp=0" class="linkcolumn" target="_blank"><img src="../../images/compare.gif" border="0" title="view outline"></a>
					&nbsp;<font class="copyright">|</font>&nbsp;
					<a href="../crsqstq.jsp?ts=1&h=0" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWinForumUsrBrd','800','600','yes','center');return false" onfocus="this.blur()"><img src="../../images/ed_list_bullet.gif" border="0" title="view item index"></a>&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td class="htd" colspan="2">
					<div id="aseEdit" class="base-container ase-table-layer">
						<div id="record-1" class="ase-table-row-headerX">
						<div class="col10">&nbsp;</div>
						<div class="col10"><font class="textblackth">Posts</font></div>
						<div class="col15"><font class="textblackth">Created By</font></div>
						<div class="col15"><font class="textblackth">Created Date</font></div>
						<div class="col10"><font class="textblackth">Last Post</font></div>
						<div class="col10"><font class="textblackth">Members</font></div>
						<div class="col10"><font class="textblackth">Replies</font></div>
						<div class="col10"><font class="textblackth">Status</font></div>
						<div class="col10"></div>
						<div id="ras" class="space-line"></div>
					</div>

					<%
						i = 0;

						clss = "";

						for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPosts(conn,fid)){

							if (i % 2 == 0){
								clss = "ase-table-row-detail-no-border";
							}
							else{
								clss = "ase-table-row-detail-highlight-no-border";
							}

							++i;

							int mid = Integer.parseInt(u.getString6());

							String notification = "&nbsp;&nbsp;";
							String replies = "&nbsp;&nbsp;";

							if(!ForumDB.isPostClosed(conn,fid,mid)){

								if (ForumDB.isReplyAvailable(conn,user,fid,mid)){
									replies = "&nbsp;&nbsp;<img src=\"./images/new.png\" border=\"0\" title=\"replies\">";
								}

							} // not closed
						%>
							<div id="record<%=i%>a" class="<%=clss%>">
								<div class="col10">
									<div style="float: left;">
										<a href="displayusrmsg.jsp?fid=<%=fid%>&mid=<%=mid%>&item=<%=u.getString9()%>"><img src="../../images/viewcourse.gif" border="0" title="view replies"></a>
										&nbsp;
										<a href="prt.jsp?fid=<%=fid%>&mid=<%=mid%>" class="linkcolumn" target="_blank"><img src="/central/images/printer.jpg" title="print"></a>
										&nbsp;
										<a href="##" onClick="return hidePost(<%=fid%>,<%=mid%>,<%=u.getString9()%>);" class="linkcolumn" target="_blank"><img src="/central/images/expand/subtract.jpg" title="hide posts"></a>
										&nbsp;
										<a href="##" onClick="return showPost(<%=fid%>,<%=mid%>,<%=u.getString9()%>);" class="linkcolumn" target="_blank"><img src="/central/images/expand/add.jpg" title="show posts"></a>
									</div>
									<div style="float: left;">
										<%=notification%>
									</div>
									<div style="float: left;">
										<%=replies%>
									</div>
								</div>
								<div class="col10"><%=u.getString1()%></div>
								<div class="col15"><%=u.getString2()%></div>
								<div class="col15"><%=u.getString3()%></div>
								<div class="col10"><%=u.getString7()%></div>
								<div class="col10"><%=u.getString5()%></div>
								<div class="col10"><%=u.getString4()%></div>
								<div class="col10"><%=u.getString8()%></div>
								<div class="col10"></div>
								<div id="ras" class="space-line"></div>
							</div>

							<div id="record<%=i%>b" class="<%=clss%>">
								<div class="col10"></div>
								<div class="col70"><div id="<%=fid%>_<%=mid%>_<%=u.getString9()%>"></div></div>
								<div class="col20"></div>
								<div id="ras" class="space-line"></div>
							</div>

						<%
							} // for
						%>
				</td>
			</tr>
		</tbody>
	</table>

	<p>&nbsp;</p>

	<%
		// invite users
		if (user.equals(forumOwner)){
	%>
		<table class="highcontainer" cellspacing="8" cellpadding="8">
			<tbody>
				<tr>
					<td class="htd">
						<div id="rankings">

							<h3 class="goldhighlightsbold">Board Members</h3>

							<table width="100%" cellspacing="1" cellpadding="4">
								<tbody>

									<tr>
										<th width="08%">&nbsp;</th>
										<th width="92%" align="left">Members</th>
									</tr>

									<%

										for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getBoardMembers(conn,fid)){

											if (i % 2 == 0){
												clss = "rankline1";
											}
											else{
												clss = "rankline2";
											}

											++i;

									%>
										<tr class="<%=clss%>">
											<td align="left">
												<a href="?fid=<%=fid%>&m=d&uid=<%=u.getString1()%>"><img src="/central/images/del.gif" border="0" title="delete"></a>
											</td>
											<td style="text-align:left;"><%=u.getString1()%></td>
										</tr>
									<%
										}
									%>

								</tbody>
							</table>
						</div>

						<form method="post" action="?" name="asForm">
							Add member (UH mail ID): <input class="input" type="text" name="uid"></input>&nbsp;
							<input class="input" type="submit" value="add" id="cmdAdd" name="cmdAdd">
							<input type="hidden" name="fid" id="fid" value="<%=fid%>"></input>
							<input type="hidden" name="m" id="m" value="a"></input>
						</form>
						<p>
						Note: Add member(s) who are not part of the approval or review process
						</p>
					</td>
				</tr>
			</tbody>
		</table>
	<%
		} // valid user?
	%>

	<%
		out.println(ForumDB.getLegend());
	%>

</div>

<%@ include file="inc/footer.jsp" %>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
