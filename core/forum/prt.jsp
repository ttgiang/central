<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	prt.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String thisPage = "forum/display";

	String pageTitle = "Message Board";

	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link rel="stylesheet" type="text/css" href="inc/niceframe.css">
	<link rel="stylesheet" type="text/css" href="inc/forum.css">
</head>
<body topmargin="0" leftmargin="0">

<%
	int fid = website.getRequestParameter(request,"fid",0);
	int midUrl = website.getRequestParameter(request,"mid",0);

	//
	// itm comes from approval/review screen
	//
	int itm = website.getRequestParameter(request,"itm",0);

	//
	// foundation
	//
	int sq = website.getRequestParameter(request,"sq",0);
	int en = website.getRequestParameter(request,"en",0);
	int qn = website.getRequestParameter(request,"qn",0);

	String forumName = "";
	String forumDesc = "";
	String fndType = "";
	boolean isFoundation = false;

	if (processPage && fid > 0){

		Forum forum = ForumDB.getForum(conn,fid);
		forumName = forum.getForum();
		forumDesc = forum.getDescr();

		if (forum.getHistoryid() != null && forum.getHistoryid().length() > 0){

			String courseDescr = "";

			com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

			isFoundation = fnd.isFoundation(conn,forum.getHistoryid());

			String hallmark = "";

			if(isFoundation){
				fndType = fnd.getFndItem(conn,forum.getHistoryid(),"fndtype");
				if(sq > 0){
					hallmark = "<br><br>" + fnd.getFoundations(conn,fndType,sq,0,0);
					courseDescr = "<br><br>" + fnd.getFoundations(conn,fndType,sq,en,qn);
				}
			}
			else{
				courseDescr = courseDB.getCourseDescription(conn,forum.getHistoryid());
			}

			if(isFoundation){
				forumName = forumName + " - " + forumDesc + hallmark + courseDescr;
			}
			else{
				if (courseDescr != null && courseDescr.length() > 0){
					forumName = forumName + " - " + courseDescr;
				}
				else{
					forumName = forumName + " - " + forumDesc;
				}
			}

		}

		String forumOwner = forum.getCreator();
		String status = forum.getStatus();

		String kix = ForumDB.getKix(conn,fid);

		session.setAttribute("aseKix",kix);

		if(isFoundation){
			midUrl = ForumDB.getTopLevelPostingMessage(conn,fid,sq,en,qn);
		}
		else if(midUrl == 0 && itm > 0){
			midUrl = ForumDB.getTopLevelPostingMessage(conn,fid,itm);
		}

	}
	else{

		processPage = false;

	} // valid fid

	asePool.freeConnection(conn,"prt",user);
%>

<div id="main">
	<h3 class="goldhighlightsbold"><%=forumName%></h3>

	<%
		if (processPage){
	%>

		<table width="100%" cellspacing="1" cellpadding="4">
			<tbody>

				<%
					int i = 0;

					String clss = "";

					for(com.ase.aseutil.Generic u: com.ase.aseutil.ForumDB.getUserPosts(conn,fid,midUrl)){

						if (i % 2 == 0){
							clss = "rankline1";
						}
						else{
							clss = "rankline2";
						}

						++i;

						int mid = Integer.parseInt(u.getString6());
						int item = Integer.parseInt(u.getString9());

						String notification = "&nbsp;&nbsp;";
						String replies = "&nbsp;&nbsp;";

						if(!ForumDB.isPostClosed(conn,fid,mid)){
							if (ForumDB.isNotificationAvailable(conn,user,fid,mid)){
								notification = "&nbsp;&nbsp;<img src=\"./images/staryellow.gif\" border=\"0\" title=\"notification requests\">";
							}

							if (ForumDB.isReplyAvailable(conn,user,fid,mid)){
								replies = "&nbsp;&nbsp;<img src=\"./images/new.png\" border=\"0\" title=\"replies\">";
							}
						} // not closed

				%>
					<tr class="<%=clss%>">
						<td style="text-align:left;">
							<%
								String temp = Board.printChildren(conn,fid,item,0,0,mid,user);
								if(!temp.equals(Constant.BLANK)){

									if(isFoundation){
										//
										// bring in question text only if not printing all
										//
										String fndText = "";
										if(sq==0){
											fndText = ForumDB.getQuestionFromMid(conn,fndType,fid,mid);
										}
										out.println(item + ": " + fndText + temp);
									}
									else{
										out.println(item + ": " + temp);
									}

								}
							%>
						</td>
					</tr>
				<%
					} // for
				%>

			</tbody>
		</table>

	<%
		}
		else{
			out.println("Postings not available for requested item");
		}
		// processPage
	%>

</div>

</div>

</body>
</html>

