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

	session.setAttribute("aseThisPage","usrbrd");

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
	String thisPage = "forum/display";

	String pageTitle = "Message Board";

	fieldsetTitle = pageTitle
						+ "&nbsp;&nbsp;&nbsp;<img src=\"../images/helpicon.gif\" border=\"0\" alt=\"message board help\" title=\"message board help\" onclick=\"switchMenu('forumHelp');\">";

	// retrieve key information
	int fid = website.getRequestParameter(request,"fid",0);
	String kix = website.getRequestParameter(request,"kix","");

	// save for later
	if(kix == null || kix.equals(Constant.BLANK) || kix.equals("hasValue")){
		kix = (String)session.getAttribute("aseHistoryID");
	}

	// must have fid to go on
	if (fid > 0){
		kix = ForumDB.getKix(conn,fid);
	}
	else if (!kix.equals(Constant.BLANK)){
		fid = ForumDB.getForumID(conn,campus,kix);
	}

	boolean isAProgram = ProgramsDB.isAProgram(conn,kix);

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	boolean foundation = false;

	if(!isAProgram){
		foundation = fnd.isFoundation(conn,kix);
	}

	String forumName = "";
	String forumDescr = "";
	String forumOwner = "";
	String status = "";
	String historyid = "";

	// if still 0, chances are we cancelled along the way so one was not created
	if(fid == 0 && !kix.equals(Constant.BLANK)){

		String[] info = null;

		if(foundation){
			info = fnd.getKixInfo(conn,kix);
		}
		else{
			info = helper.getKixInfo(conn,kix);
		}

		String alpha = info[Constant.KIX_ALPHA];
		String num = info[Constant.KIX_NUM];

		forumName = alpha + " " + num;

		if(foundation){
			forumDescr = info[Constant.KIX_COURSETITLE];
		}
		else{
			forumDescr = CourseDB.getCourseDescription(conn,alpha,num,campus);
		}

		String src = Constant.COURSE;
		if(isAProgram){
			src = Constant.PROGRAM;
		}
		else if(foundation){
			src = Constant.FOUNDATION;
		}

		Forum forum = new Forum(0,campus,kix,0,user,user,forumName,forumDescr,AseUtil.getCurrentDateTimeString(),"",src);
		fid = ForumDB.insertForum(conn,forum,0,false);
		forum = null;
	}

	fnd = null;

	// remember the view user was on before coming here (open=1, closed=0, both=2)
	String aseBoardsToShow = (String)session.getAttribute("aseBoardsToShow");
	if (aseBoardsToShow == null){
		aseBoardsToShow = "1";
	}

	//-------------------------------------------------------------
	// mode of operation (add/remove members)
	//-------------------------------------------------------------
	String addBoardMemberMessage = "";
	String m = website.getRequestParameter(request,"m","");
	if (!m.equals(Constant.BLANK)){

		boolean error = false;

		String uid = website.getRequestParameter(request,"uid","");

		// is member delete requested?
		if (!uid.equals(Constant.BLANK)){

			if (m.equals("a")){

				if(!UserDB.isMatch(conn,uid,campus)){
					addBoardMemberMessage = "<img src=\"/central/images/err_alert.gif\" border=\"\">&nbsp;<font color=\"red\">Invalid user id</font>";
					error = true;
				}
				else{
					Board.addBoardMember(conn,fid,uid.toUpperCase());
				} // user is valid

			}
			else if (m.equals("d")){
				Board.deleteBoardMember(conn,fid,uid.toUpperCase());
			}

			//
			// redirect to clear out data
			//
			if(!error) response.sendRedirect("usrbrd.jsp?fid="+fid);

		} // valid uid

	} // valid mode

	//-------------------------------------------------------------
	// retrieve forum data
	//-------------------------------------------------------------
	Forum forum = ForumDB.getForum(conn,fid);
	if(forum != null){
		forumName = forum.getForum();
		forumDescr = forum.getDescr();
		forumOwner = forum.getCreator();
		status = forum.getStatus();
		historyid = forum.getHistoryid();
	}

	if (historyid != null && historyid.length() > 0){
		String courseDescr = courseDB.getCourseDescription(conn,historyid);
		if (courseDescr != null && courseDescr.length() > 0){
			forumName = forumName + " - " + courseDescr;
		}
		else{
			forumName = forumName + " - " + forumDescr;
		}
	} // forum.getHistoryid()

	int i = 0;

	String clss = "";
	String proposer = "";

	String[] info = helper.getKixInfo(conn,kix);
	if(!kix.equals(Constant.BLANK)){
		proposer = info[Constant.KIX_PROPOSER];
	}

	// make sure we go back with valid data
	if (tab.equals(Constant.BLANK)){
		tab = "" + Constant.TAB_COURSE;
	}

	// make sure we go back with valid data
	if (item.equals(Constant.BLANK)){
		item = "1";
	}

	// release connection back to pool
	asePool.freeConnection(conn,"usrbrd",user);

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" href="../../inc/fader.css" type="text/css" media="screen" title="no title" charset="utf-8">
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
				<td width="33%"><h3 class="goldhighlightsbold"><%=forumName%></h3></td>
				<td align="center" width="34%">
				<%
						// whether to hide or show items not enabled for modifications
						String hideOrShow = website.getRequestParameter(request,"hide","");

						boolean hide = false;

						// apply hide/show only if there are enabled items and not all items
						if (MiscDB.getEdit1(conn,kix).length() > 0 || MiscDB.getEdit2(conn,kix).length() > 0){
							if (hideOrShow.equals("1")){
								out.println("<p align=\"center\"><br>Display <a href=\"usrbrd.jsp?fid="+fid+"&hide=0\" class=\"linkcolumn\">all</a> items</p>");
								hide = true;
							}
							else{
								out.println("<p align=\"center\"><br>Display <a href=\"usrbrd.jsp?fid="+fid+"&hide=1\" class=\"linkcolumn\">only</a> items enabled for modifications</p>");
								hide = false;
							}
						} // edit1

				%>
				</td>
				<td align="right" width="33%">

					<%
						if(proposer.equals(user) && !orig.equals(Constant.BLANK)){
					%>
							<A class="linkcolumn" HREF="../crsedt.jsp?ts=<%=tab%>&no=<%=item%>&kix=<%=kix%>"><img src="../../images/back.gif" border="0" title="resume outline work"></A>
							&nbsp;<font class="copyright">|</font>&nbsp;
					<%
						}
					%>

					<%
						//
						// rtn is set here to keep back.gif on at all times for the right person
						//

						String reviewerNames = ReviewerDB.getReviewerNames(conn,kix);
						String approverNames = ApproverDB.getApproverNames(conn,kix);

						String rtn = "";

						if(reviewerNames != null && reviewerNames.contains(user)){
							rtn = "rvw";
						}
						else if(approverNames != null && approverNames.contains(user)){
							rtn = "apr";
						}

						if (rtn.equals("rvw")){

							if(isAProgram){
								rtn = "prgrvwer.jsp?kix="+kix;
								rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>";
							}
							else if(foundation){
								rtn = "fndrvwer.jsp?kix="+kix;
								rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>";
							}
							else{
								rtn = "crsrvwer.jsp?kix="+kix;
								rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>";
							}

						}
						else if (rtn.equals("apr")){

							if(isAProgram){
								rtn = "prgappr.jsp?kix="+kix;
								rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume program work\" title=\"resume program work\"></a>";
							}
							else if(foundation){
								rtn = "fndappr.jsp?kix="+kix;
								rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume foundation work\" title=\"resume foundation work\"></a>";
							}
							else{
								rtn = "crsappr.jsp?kix="+kix;
								rtn = "<a href=\"/central/core/"+rtn+"\"><img src=\"../../images/back.gif\" border=\"0\" alt=\"resume outline work\" title=\"resume outline work\"></a>";
							}

						}

						if(!rtn.equals(Constant.BLANK)){
							out.println(rtn + "&nbsp;<font class=\"copyright\">|</font>&nbsp;");
						}

					%>

					<A class="linkcolumn" HREF="../msgbrd.jsp?s=<%=aseBoardsToShow%>"><img src="./images/legend.png" border="0" title="go to board listing"></A>

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
						//
						// may close a board as long as
						//
						// 1) you are the owner
						// 2) it's not already closed
						// 3) there are no reviewers
						// 4) there are no approvers
						// 5) not in approval or review status
						//
						if(	user.equals(forumOwner)
								&& !status.toLowerCase().equals(ForumDB.FORUM_CLOSED)
								&& (reviewerNames == null || reviewerNames.equals(Constant.BLANK))
								&& (approverNames == null || approverNames.equals(Constant.BLANK))
						){
					%>
							&nbsp;<font class="copyright">|</font>&nbsp;
							<A class="linkcolumn" HREF="./clsbrd.jsp?fid=<%=fid%>"><img src="./images/close_door.gif" border="0" title="close message board"></A>
					<%
						}
					%>

					&nbsp;<font class="copyright">|</font>&nbsp;
					<%
						if(foundation){
					%>
							<a href="/centraldocs/docs/fnd/HAW/<%=kix%>.html" class="linkcolumn" target="_blank"><img src="../../images/compare.gif" border="0" title="view content"></a>
					<%
						}
						else{
					%>
							<a href="../vwcrsy.jsp?pf=1&kix=<%=kix%>&comp=0" class="linkcolumn" target="_blank"><img src="../../images/compare.gif" border="0" title="view content"></a>
					<%
						}
					%>
					&nbsp;<font class="copyright">|</font>&nbsp;
					<a href="../crsqstq.jsp?ts=1&h=0" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWinForumUsrBrd','800','600','yes','center');return false" onfocus="this.blur()"><img src="../../images/ed_list_bullet.gif" border="0" title="view outline item index"></a>&nbsp;&nbsp;
					<a href=#?w=500 rel=page_help class=poplight><img src="/central/core/images/helpicon.gif" alt="page help"></a>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td class="htd" colspan="3">

					<a href="##" onClick="return hideAllPosts(<%=fid%>);" class="linkcolumn" target="_blank"><img src="/central/images/expand/subtract.jpg" title="hide all posts"></a>
					&nbsp;
					<a href="##" onClick="return showAllPosts(<%=fid%>);" class="linkcolumn" target="_blank"><img src="/central/images/expand/add.jpg" title="show all posts"></a>

					<div id="aseEdit" class="base-container ase-table-layer">
						<div id="record-1" class="ase-table-row-headerX">
						<div class="col13">&nbsp;</div>
						<div class="col14"><font class="textblackth">Posts</font></div>
						<div class="col13"><font class="textblackth">Created By</font></div>
						<div class="col15"><font class="textblackth">Created Date</font></div>
						<div class="col20"><font class="textblackth">Last Post</font></div>
						<div class="col8"><font class="textblackth">Members</font></div>
						<div class="col8"><font class="textblackth">Replies</font></div>
						<div class="col8"><font class="textblackth">Status</font></div>
						<div id="ras" class="space-line"></div>
					</div>

					<%
						i = 0;

						clss = "";

						int mid = 0;
						String itm = "";

						String allMid = "";
						String allItm = "";

						String notification = "";
						String replies = "";

						//
						// how many quetions are we working with
						// pad with commas for replace to work in loop
						//
						int maxNoCampus = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_CAMPUS);
						int maxNoCourse = courseDB.countCourseQuestions(conn,campus,"Y","",Constant.TAB_COURSE);

						String items = "";
						int ti = maxNoCampus + maxNoCourse;
						int iTab = 0;
						for(int j=1; j<(ti+1); j++){
							iTab = 1;
							if(j > maxNoCourse){
								iTab = 2;
							}
							items = items + "," + "" + iTab + "_" + j;
						} // number of items to work with
						if(!items.equals(Constant.BLANK)){
							items = items + ",";
						}

						//
						// determine whether we are showing all or only enabled items
						//
						String enabledItems = "";
						if(hide){
							String edited1 = MiscDB.getColumn(conn,kix,"edited1");
							String edited2 = MiscDB.getColumn(conn,kix,"edited2");

							enabledItems = edited1;

							if(!edited2.equals(Constant.BLANK)){
								enabledItems = enabledItems + "," + edited2;
							}

							enabledItems = "," + enabledItems + ",";
						}

						//
						// display posts
						//
						for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPosts(conn,fid,hide)){

							mid = Integer.parseInt(u.getString6());

							itm = u.getString9();

							//
							// remove items already posted. what remains are items allowed to create posts for
							//
							items = items.replace(",1_"+itm+",",",");
							items = items.replace(",2_"+itm+",",",");

							if (i==0){
								allMid = "" + mid;
								allItm = "" + itm;
							}
							else{
								allMid += "," + mid;
								allItm += "," + itm;
							}

							if (i % 2 == 0){
								clss = "ase-table-row-detail-no-border";
							}
							else{
								clss = "ase-table-row-detail-highlight-no-border";
							}

							++i;

							notification = "&nbsp;&nbsp;";
							replies = "&nbsp;&nbsp;";

							if(!ForumDB.isPostClosed(conn,fid,mid)){

								if (ForumDB.isReplyAvailable(conn,user,fid,mid)){
									replies = "&nbsp;&nbsp;<img src=\"./images/new.png\" border=\"0\" title=\"replies\">";
								}

							} // not closed

							boolean show = false;

							if(hide){
								if(enabledItems.contains(","+itm+",")){
									show = true;
								}
							}
							else{
								show = true;
							}

							if(show){

							%>
								<div id="record<%=i%>a" class="<%=clss%>">
									<div class="col13">
										<div style="float: left;">
											<a href="displayusrmsg.jsp?kix=<%=kix%>&fid=<%=fid%>&mid=<%=mid%>&item=<%=itm%>"><img src="../../images/viewcourse.gif" border="0" title="view replies"></a>
											&nbsp;
											<a href="prt.jsp?fid=<%=fid%>&mid=<%=mid%>" class="linkcolumn" target="_blank"><img src="/central/images/printer.jpg" title="printer friendly"></a>
											&nbsp;
											<a href="##" onClick="return hidePost(<%=fid%>,<%=mid%>,<%=itm%>);" class="linkcolumn" target="_blank"><img src="/central/images/expand/subtract.jpg" title="hide posts"></a>
											&nbsp;
											<a href="##" onClick="return showPost(<%=fid%>,<%=mid%>,<%=itm%>);" class="linkcolumn" target="_blank"><img src="/central/images/expand/add.jpg" title="show posts"></a>
										</div>
										<div style="float: left;">
											<%=notification%>
										</div>
										<div style="float: left;">
											<%=replies%>
										</div>
									</div>
									<div class="col14"><%=u.getString1()%></div>
									<div class="col13"><%=u.getString2()%></div>
									<div class="col15"><%=u.getString3()%></div>
									<div class="col20"><%=u.getString7()%></div>
									<div class="col8"><%=u.getString5()%></div>
									<div class="col8"><%=u.getString4()%></div>
									<div class="col8"><%=u.getString8()%></div>
									<div id="ras" class="space-line"></div>
								</div>

								<div id="record<%=i%>b" class="<%=clss%>">
									<div class="col30"></div>
									<div class="col70"><div id="<%=fid%>_<%=mid%>_<%=itm%>"></div></div>
									<div id="ras" class="space-line"></div>
								</div>
							<%
							} // show

						} // for

						//
						// remove padded commas
						//
						if(!items.equals(Constant.BLANK)){
							if (items.endsWith(",")){
								items = items.substring(0,items.length()-1);
							}
						}

					%>
				</td>
			</tr>

			<%
				//
				// allow to post?
				//
				if((reviewerNames.contains(user) || approverNames.contains(user)) && !proposer.equals(user)){
				%>
					<tr>
						<td colspan="2">
							<form method="post" action="?" name="aseFormNewPost">
								Create post for item:
								<%
									String itemsForShow = items.replace("1_","").replace("2_","");
									out.println(aseUtil.createStaticSelectionBox(itemsForShow,items,"item","","",""," ","INFO"));
								%>
								<input type="hidden" name="fid" id="fid" value="<%=fid%>"></input>
								<input type="hidden" name="kix" id="kix" value="<%=kix%>"></input>
								<input class="input" type="submit" value="create" id="cmdCreate" name="cmdCreate" onClick="return createNewPost();">
								&nbsp;&nbsp;
								<a href="../crsqstq.jsp?ts=1&amp;h=0" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseWinForumUsrBrd','800','600','yes','center');return false" onfocus="this.blur()"><img src="../../images/ed_list_bullet.gif" border="0" title="view outline item index"></a>
							</form>
						</td>
					</tr>
				<%
				} // if allowed to post

			%>

		</tbody>
	</table>

	<form method="post" action="?" name="aseForm2">
		<input type="hidden" name="mid" id="mid" value="<%=allMid%>"></input>
		<input type="hidden" name="itm" id="itm" value="<%=allItm%>"></input>
	</form>

	<p>&nbsp;</p>

	<%
		//
		// invite users
		//
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
										<th width="15%" align="left">Members</th>
										<th width="77%" align="left">Postings</th>
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
												<%
													String postings = u.getString2();

													if(!postings.equals(Constant.BLANK) && !postings.equals("0")){
												%>
														&nbsp;
												<%
													}
													else{
												%>
														<a href="?fid=<%=fid%>&m=d&uid=<%=u.getString1()%>"><img src="/central/images/del.gif" border="0" title="delete"></a>
												<%
													}
												%>
											</td>
											<td style="text-align:left;"><%=u.getString1()%></td>
											<td style="text-align:left;"><%=postings%></td>
										</tr>
									<%
										}
									%>

								</tbody>
							</table>
						</div>

						<%
							if(!status.toLowerCase().equals(ForumDB.FORUM_CLOSED)){
						%>
							<form method="post" action="?" name="aseForm">
								Add member (UH mail ID): <input class="input" type="text" name="uid"></input>&nbsp;
									<input class="input" type="submit" value="add" id="cmdAdd" name="cmdAdd">
									<input type="hidden" name="fid" id="fid" value="<%=fid%>"></input>
									<input type="hidden" name="m" id="m" value="a"></input>&nbsp;<%=addBoardMemberMessage%>
							</form>
							<p>
							Note: Add member(s) who are not part of the approval or review process. Members with postings may not be removed (deleted) from messages boards.
						<%
							}
						%>
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

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="./inc/jquery.masonry.min.js"></script>

<script>
	$(function(){

	  //When you click on a link with class of poplight and the href starts with a #
	  $('a.poplight[href^=#]').click(function() {

			var popID = $(this).attr('rel'); //Get Popup Name
			var popURL = $(this).attr('href'); //Get Popup href to define size

			//Pull Query & Variables from href URL
			var query= popURL.split('?');
			var dim= query[1].split('&');
			var popWidth = 500; //Gets the first query string value

			//Fade in the Popup and add close button
			$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="../../images/close_pop.png" class="btn_close" title="Close Window" alt="Close" /></a>');

			//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
			var popMargTop = ($('#' + popID).height() + 80) / 2;
			var popMargLeft = ($('#' + popID).width() + 80) / 2;

			//Apply Margin to Popup
			$('#' + popID).css({
				 'margin-top' : -popMargTop,
				 'margin-left' : -popMargLeft
			});

			//Fade in Background
			$('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
			$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer - .css({'filter' : 'alpha(opacity=80)'}) is used to fix the IE Bug on fading transparencies

			return false;
	  });

	  //Close Popups and Fade Layer
	  $('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
			$('#fade , .popup_block').fadeOut(function() {
				 $('#fade, a.close').remove();  //fade them both out
			});
			return false;
	  });

	});

</script>

<div id="page_help" class="popup_block">
	<p>
		You may post comments if you are an approver or have been invited to do reviews.
	</p>
	<p>
		Postings are permitted during approvals, reviews or if there are replies to your posts.
	</p>
	<p>
	To post a new comment, select an item in the 'Create post for item' list box, then click 'create'.
	</p>
</div>

</body>
</html>
