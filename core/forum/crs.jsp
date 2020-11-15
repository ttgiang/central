<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	crs.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");

	// origin tells us how we go here. If we go here not by starting this page or the forum,
	// then we want to save the value to the session and hide the menu
	String orig = website.getRequestParameter(request,"orig","");
	if (!orig.equals(Constant.BLANK)){
		session.setAttribute("aseOrigin",orig);
	}

	String kix = website.getRequestParameter(request,"aseKix","",true);
	int item = website.getRequestParameter(request,"asecurrentSeq",0,true);
	int table = website.getRequestParameter(request,"aseCurrentTab",0,true);
	int create = website.getRequestParameter(request,"aseCreate",0,true);
	String forumName = website.getRequestParameter(request,"forumName","");
	String forumDescr = website.getRequestParameter(request,"forumDescr","");

	boolean createMessage = false;
	String message = "";

	int fid = 0;
	int mid = 0;
	int rowsAffected = 0;

	Forum forum = null;

	if (processPage && !kix.equals(Constant.BLANK)){

		try{
			String[] info = helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];

			forumName = alpha + " " + num;
			forumDescr = CourseDB.getCourseDescription(conn,alpha,num,campus);

			// first time through, add the forum. the forum added the first time also includes the message.
			// second time in, only the message is added.
			fid = ForumDB.getForumID(conn,campus,kix);
			if (fid == 0){
				createMessage = true;
				forum = new Forum(0,campus,kix,item,user,user,forumName,forumDescr,AseUtil.getCurrentDateTimeString(),"",src);
				rowsAffected = ForumDB.insertForum(conn,forum,table,createMessage);

				// if the forum was added with the item, then send the user to the page with the
				// message to work on. rowsaffected contains the id that is needed to push forward.
				fid = rowsAffected;

				if (rowsAffected > 1)
					message = "Message board created successfully";
				else
					message = "Unable to create message board";
			}
			else{
				mid = ForumDB.getMessageID(conn,kix,item);
				if (mid == 0){
					Messages messages = new Messages();
					messages.setTimeStamp(aseUtil.getCurrentDateTimeString());
					messages.setForumID(fid);
					messages.setItem(item);
					messages.setThreadID(0);
					messages.setThreadParent(0);
					messages.setThreadLevel(1);
					messages.setAuthor(user);
					messages.setNotify(false);
					messages.setSubject("Question No. " + item);
					messages.setBody(QuestionDB.getCourseQuestion(conn,campus,table,item));
					rowsAffected = ForumDB.insertMessage(conn,messages);
					if (rowsAffected > 1)
						message = "Message added successfully";
					else
						message = "Unable to add message";
				}
			}

			forum = null;
		}
		catch(Exception e){
			//System.out.println(e.toString());
		}
	}	// processPage

	session.setAttribute("aseKix",null);

	asePool.freeConnection(conn,"crs",user);
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header3.jsp" %>

<%
	// when the forum is created automatically, redirect user to the forum message
	if (processPage && create == 1){
		mid = ForumDB.getMessageID(conn,kix,item);
		if (mid > 0){
			response.sendRedirect("displaymsg.jsp?fid="+fid+"&mid="+mid+"&item="+item);
		}
		else{
			response.sendRedirect("display.jsp?orig="+orig+"&fid="+fid+"&item="+item);
		}
	}
	else{
%>

<p align="center"><%=message%></p>

<p align=\"center\"><a href="display.jsp?fid=<%=fid%>" class="linkcolumn">return to message board</a></p>

<%
	}
%>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
