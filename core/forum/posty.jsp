<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	posty.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String thisPage = "forum/posty";

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");

	String kix = "";
	String alpha = "";
	String num = "";
	String progress = "";
	String subProgress = "";

	int fid = website.getRequestParameter(request,"fid",0);
	int mid = website.getRequestParameter(request,"mid",0);
	int tid = website.getRequestParameter(request,"tid",0);
	int item = website.getRequestParameter(request,"item",0);
	int tab = website.getRequestParameter(request,"tab",0);

	//
	// foundation
	//
	int sq = website.getRequestParameter(request,"sq",0);
	int en = website.getRequestParameter(request,"en",0);
	int qn = website.getRequestParameter(request,"qn",0);

	String rtn = website.getRequestParameter(request,"rtn","");

	int lastMessageID = 0;

	if (fid > 0){
		kix = ForumDB.getKix(conn,fid);
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		progress = info[Constant.KIX_PROGRESS];
		subProgress = info[Constant.KIX_SUBPROGRESS];
	}

	String message = "";

	// check to prevent reposting
	String processed = aseUtil.nullToBlank((String)session.getAttribute("aseProcessed"));

%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%

	if (processPage && !processed.equals("YES")){

		try{

			String subject = website.getRequestParameter(request,"subject","");
			String body = website.getRequestParameter(request,"message","");

			//
			// ckeditor does something funny when space is entered more than once
			//
			body = body.replace("&nbsp;"," ");

			if (!subject.equals(Constant.BLANK)){

				if(mid==0){

					//
					// this section is for postings created as a result of course review screen
					// click on pencil icon to get to post.jsp then processing through
					//

					int mode = Constant.REVIEW;
					if (subProgress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)){
						mode = Constant.REVIEW_IN_APPROVAL;
					}

					Review review = new Review();
					review.setId(0);
					review.setUser(user);
					review.setAlpha(alpha);
					review.setNum(num);
					review.setHistory(kix);
					review.setComments(body);
					review.setSubject(subject);
					review.setItem(QuestionDB.getQuestionNumber(conn,campus,item));
					review.setCampus(campus);
					review.setEnable(false);
					review.setAuditDate(aseUtil.getCurrentDateTimeString());
					review.setSq(sq);
					review.setEn(en);
					review.setQn(qn);
					lastMessageID = ReviewDB.insertReview(conn,review,""+tab,mode);
					review = null;

					lastMessageID = ForumDB.getLastMessageID(conn,fid);
					tid = ForumDB.getMessageThreadParent(conn,fid,lastMessageID);
				}
				else{
					Messages messages = new Messages();
					messages.setTimeStamp(AseUtil.getCurrentDateTimeString());
					messages.setForumID(fid);
					messages.setThreadID(tid);
					messages.setItem(item);
					messages.setThreadParent(website.getRequestParameter(request,"pid",0));
					messages.setThreadLevel(website.getRequestParameter(request,"level",0));
					messages.setAuthor(user);
					messages.setNotify(website.getRequestParameter(request,"notify",false));
					messages.setSubject(subject);
					messages.setSq(sq);
					messages.setEn(en);
					messages.setQn(qn);
					messages.setBody(body);
					lastMessageID = ForumDB.insertMessage(conn,messages);
					messages = null;
				}

				if (lastMessageID > 0){
					message = "Message posted successfully";
				}
				else{
					message = "Unable to post message";
				}
			}
		}
		catch(Exception e){
			System.out.println(e.toString());
		}
	}	// processPage

	// required for upload
	session.setAttribute("aseKix",kix);
	session.setAttribute("aseFid",fid);
	session.setAttribute("aseMid",mid);
	session.setAttribute("aseUploadTo","Forum");
	session.setAttribute("aseCallingPage",thisPage);
	session.setAttribute("aseProcessed","YES");

	asePool.freeConnection(conn,"posty",user);

%>

<%@ include file="../../inc/header3.jsp" %>

<p align="center"><%=message%></p>

<p align=\"center\">

<%
	// if the user's name is in the kix, then it's a private listing
	String rtnToPage = "display";
	if (kix.indexOf(user)>-1){
		rtnToPage = "dsplst";
	}

	// make sure we go back to the right places
	if (item > 0){
		rtnToPage = "displaymsg";
	}

	if (src.equals(Constant.FORUM_USERNAME)){
		if (mid > 0){
			rtnToPage = "displayusrmsg";
		}
		else{
			rtnToPage = "usrbrd";
		}
	}

	if(rtnToPage.equals("")){
		rtnToPage = "displayusrmsg";
	}

	rtnToPage = "displayusrmsg";

%>

<img src="../../images/viewcourse.gif" border="0" alt="Back to message listing" title="Back to message listing">&nbsp;&nbsp;<a href="displayusrmsg.jsp?kix=<%=kix%>&fid=<%=fid%>&mid=<%=tid%>&item=<%=item%>&rtn=<%=rtn%>" class="linkcolumn">View replies</a>

<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<img src="/central/images/ed_list_num.gif" border="0" alt="Back to post listing" title="Back to post listing">&nbsp;&nbsp;<a href="usrbrd.jsp?fid=<%=fid%>" class="linkcolumn">Go to post listing</a>

<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
<img src="../../images/viewcourse.gif" border="0" alt="Back to message listing" title="Back to message listing">&nbsp;&nbsp;<a href="../msgbrd.jsp" class="linkcolumn">Go to board listing</a>

<%
	if (SQLUtil.isSysAdmin(conn,user)){
%>
		<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
		<img src="/central/images/attachment.gif" border="0" alt="attach document" title="attach document">&nbsp;&nbsp;<a href="../gnrcmprt.jsp?fid=<%=fid%>&mid=<%=lastMessageID%>&src=thisPage&kix=hasValue" class="linkcolumn">attach document</a>&nbsp;
<%
	}

	String caller = (String)session.getAttribute("aseResumeOutline");
	if (caller != null && caller.length() > 0){
		String bookmark = (String)session.getAttribute("aseResumeOutlineBookmark");
		out.println("<font class=\"copyright\">&nbsp;&nbsp;|&nbsp;&nbsp;</font>");
		out.println("<img src=\"/central/images/viewcourse.gif\" border=\"0\" alt=\"resume current work\" title=\"resume current work\">&nbsp;&nbsp;");
		out.println("<a href=\"../"+caller+".jsp?kix="+kix+"#"+bookmark+"\" class=\"linkcolumn\">resume current work</a>&nbsp;");
	} // caller
%>
</p>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>

