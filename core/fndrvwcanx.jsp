<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndrvwcanx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String kix = "";
	String alpha = "";
	String num = "";
	String message = "";
	String proposer = "";
	String progress = "";
	String subprogress = "";
	String currentApprover = "";

	String pageTitle = "";

	fieldsetTitle = "Cancel Foundation Course Review";

	kix = website.getRequestParameter(request,"kix","");
	if (processPage && !kix.equals(Constant.BLANK)){
		String[] info = com.ase.aseutil.fnd.FndDB.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		proposer = info[Constant.KIX_PROPOSER];
		progress = info[Constant.KIX_PROGRESS];
		subprogress = info[Constant.KIX_SUBPROGRESS];

		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){

				//
				//	kix is the id from table course. we'll start using the id where applicable.
				//	to avoid trouble with older implementation, we use kix to get the alpha and
				//	num needed for this to continue on successfully.
				//
				//	kix works when we come here from sltcrs. when coming from task, kix does
				//	not exists.
				//
				//	to cancel a review, the proposer can only if progress is approval
				//
				//	or
				//
				//	an approver can if the subprogress is review within approval
				//
				//	when in review, it's the proposer
				//
				//	when in review within approval, it's the approver
				//
				if (subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL)){
					currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
				}

				//
				// REVIEW_IN_REVIEW
				//
				boolean reviewInReview = false;
				String allowReviewInReview = Util.getSessionMappedKey(session,"AllowReviewInReview");
				int level = website.getRequestParameter(request,"level",0);
				if(allowReviewInReview.equals(Constant.ON) && level > 1){
					reviewInReview = true;
				}

				//
				// process
				//
				if (progress.equals(Constant.COURSE_REVIEW_TEXT) && (!proposer.equals(user) && !reviewInReview)){
					message = "This option is only available to the proposer.<br><br>";
				}
				else if (progress.equals(Constant.COURSE_APPROVAL_TEXT)
					&& subprogress.equals(Constant.FND_REVIEW_IN_APPROVAL)
					&& !currentApprover.equals(user)
					){
					message = "This option is only available to the proposer of this foundation course.<br><br>";
				}
				else{
						msg = com.ase.aseutil.fnd.FndDB.cancelReview(conn,campus,kix,user,level);
					if ("Exception".equals(msg.getMsg())){
						message = "Foundation course review cancellation failed.<br><br>" + msg.getErrorLog();
					}
					else if ( !msg.getMsg().equals(Constant.BLANK) ){
						message = "Unable to cancel foundation course review.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "Foundation course cancelled successfully<br>";
					}
				}	// proposer
			}	// action = s
			else{
				message = "Invalid security code";
			}
		}	// valid form
	}
	else{
		message = "Unable to process request";
	}

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"fndrvwcanx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%= message %></p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

