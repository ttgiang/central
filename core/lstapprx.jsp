<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	lstapprx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String alpha = "";
	String num = "";
	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String kix = website.getRequestParameter(request,"kix","");

	String nextApprover = "";
	int route = 0;

	boolean isProgram = ProgramsDB.isAProgram(conn,campus,kix);

	String[] info = helper.getKixInfo(conn,kix);
	info = helper.getKixInfo(conn,kix);
	if (info != null){
		if (isProgram){
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			num = info[Constant.KIX_PROGRAM_DIVISION];
		}
		else{
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
		}

		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

	}

	boolean isLastApprover = ApproverDB.isLastApprover(conn,campus,user,route);
	String displayApprovalRecommendation = Util.getSessionMappedKey(session,"DisplayApprovalRecommendation");

	int voteFor = website.getRequestParameter(request,"voteFor",0);
	int voteAgainst = website.getRequestParameter(request,"voteAgainst",0);
	int voteAbstain = website.getRequestParameter(request,"voteAbstain",0);
	String comments = website.getRequestParameter(request,"comments","");

	boolean sendToProposer = false;
	boolean showRecommendationForm = false;

	if (processPage && formName != null && formName.equals("aseForm") ){
		if (formAction.equalsIgnoreCase("s")){
			if ( alpha.length() > 0 && num.length() > 0 ){
				String appr = website.getRequestParameter(request,"appr","");

				// sequence of 99 is outline revision request. At which point,
				// the list of names contains both proposer and approvers.
				// proposer starts with P_ and approvers with A_

				// if it is the proposer, the outline is placed in MODIFY status
				// and the appropriate task is assigned.
				int seq = website.getRequestParameter(request,"seq",0);

				if (seq==99){
					if (appr.indexOf("P_")==0)
						sendToProposer = true;

					// remove prefix to get the name
					appr = appr.substring(2);
				}

				boolean debug = false;

				if (debug){
					System.out.println("kix: " + kix);
					System.out.println("alpha: " + alpha);
					System.out.println("num: " + num);
					System.out.println("sendToProposer: " + sendToProposer);
				}
				else{
					if (!sendToProposer){
						if (isProgram)
							msg = ProgramApproval.setProgramForApproval(conn,campus,kix,appr,seq,user);
						else
							msg = CourseApproval.setCourseForApproval(conn,campus,alpha,num,appr,seq,user);
					}
					else{
						if (isProgram)
							msg = ProgramApproval.rejectProgramToProposer(conn,kix,user);
						else
							msg = CourseApproval.rejectOutlineToProposer(conn,kix,user);
					}

				} // debug

				if ( "Exception".equals(msg.getMsg()) ){
					message = "Request for approval failed.<br><br>" + msg.getErrorLog();
				}
				else if ( !"".equals(msg.getMsg()) ){
					message = "Unable to forward approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
				}
				else{
					message = "Approval forwarded to " + appr;

					showRecommendationForm = true;
				}
			}	// course alpha and num length
		}	// action = s
	}	// processPage && valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "";

	if (isProgram){
		pageTitle = "Program Approval";
		fieldsetTitle = pageTitle;
	}
	else{
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
		fieldsetTitle = "Outline Approval";
	}

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

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

<%
	if (processPage && isProgram && showRecommendationForm){
%>

<%@ include file="prgappry.jsp" %>

<%
	}

	asePool.freeConnection(conn,"lstapprx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
