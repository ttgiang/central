<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	prgapprx.jsp
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
	String sURL = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	int voteFor = website.getRequestParameter(request,"voteFor",0);
	int voteAgainst = website.getRequestParameter(request,"voteAgainst",0);
	int voteAbstain = website.getRequestParameter(request,"voteAbstain",0);
	String comments = website.getRequestParameter(request,"comments","");

	String[] info = helper.getKixInfo(conn,kix);
	alpha = info[Constant.KIX_PROGRAM_TITLE];
	num = info[Constant.KIX_PROGRAM_DIVISION];
	int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

	// used in prgappry.jsp
	String nextApprover = "";

	boolean isLastApprover = ApproverDB.isLastApprover(conn,campus,user,route);
	String displayApprovalRecommendation = Util.getSessionMappedKey(session,"DisplayApprovalRecommendation");

	if (processPage){

		boolean debug = false;

		if (debug){
			out.println("kix: " + kix + Html.BR());
			out.println("formAction: " + formAction + Html.BR());
			out.println("formName: " + formName + Html.BR());
			out.println("alpha: " + alpha + Html.BR());
			out.println("route: " + route + Html.BR());
			out.println("isLastApprover: " + isLastApprover + Html.BR());
			out.println("displayApprovalRecommendation: " + displayApprovalRecommendation + Html.BR());
			out.println("skew: " + Skew.confirmEncodedValue(request) + Html.BR());
		}
		else{
			if ( formName != null && formName.equals("aseForm") ){
				if (Skew.confirmEncodedValue(request)){

					// if the form is valid and is last approver or recommendation is not on
					if (	formAction.equalsIgnoreCase("s")
							&&
							(displayApprovalRecommendation.equals(Constant.OFF) || isLastApprover)
						){

						/*
							if the displayApprovalRecommendation flag is set, we will not process the approval here.
							it will be held up until the next screen.

							msg.code returns 1 if successful with method. returns 2 if successful and
							also the last person to approve.
						*/
						msg = ProgramApproval.approveProgram(conn,campus,kix,user,true,comments,voteFor,voteAgainst,voteAbstain);
						if ( "Exception".equals(msg.getMsg()) ){
							message = "Program approval failed.<br><br>" + msg.getErrorLog();
						}
						else if ("forwardURL".equals(msg.getMsg()) ){
							sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
						}
						else if (!"".equals(msg.getMsg())){
							message = "Unable to approve program.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
						}
						else{
							if (msg.getCode() == 2){
								message = "Program was approved and finalized.";
							}
							else{
								if (msg.getErrorLog() != null && msg.getErrorLog().length() > 0)
									message = "Program was approved and next approver (" + msg.getErrorLog() + ") has been notified.";
								else
									message = "Program was approved.";
							}
						}
					}	// action = s
					else if (formAction.equalsIgnoreCase("r") ){
						session.setAttribute("aseApplicationComments",comments);
						session.setAttribute("aseApplicationVoteFor",voteFor);
						session.setAttribute("aseApplicationVoteAgainst",voteAgainst);
						session.setAttribute("aseApplicationVoteAbstain",voteAbstain);
						session.setAttribute("aseApprovalRejection", "1");
						sURL = "shwprgfld.jsp?cmnts=0&kix=" + kix;
					}	// action = r
					else if (formAction.equalsIgnoreCase("v") ){
						session.setAttribute("aseModificationMode", "");
						session.setAttribute("aseWorkInProgress", "0");
						session.setAttribute("aseProgress", "REVIEW");
						sURL = "prgedt6.jsp?kix="+kix;
					}	// action = review
					else {
						// NOTE: recent reported defects has been with data having multiple forms causing the page to page
						// when formaction is not available, it is likely that form data caused an error for CC. For example,
						// data on the form consisting of bad characters like pasting from MS-Word. This has happened in the
						// past where the extra data from Word breaks the processing of JS.
						// Recommendation is for campus admin to clean up the data or fast approve the outline.
						//  message = "Curriculum Central was not able to complete the requested action.<br><br>Contact your campus administrator for assistance.";
					}	// action = error
				}
				else{
					message = "Invalid security code";
				} // skew
			}	// valid form
		} // debug
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = alpha;
	fieldsetTitle = "Program Approval";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

	if ( sURL != null && sURL.length() > 0 ){
		response.sendRedirect(sURL);
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgappr.js"></script>
	<%@ include file="fckeditor.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<p align="center"><%=message%></p>

<%
	if (displayApprovalRecommendation.equals(Constant.ON) && !isLastApprover){
%>

<%@ include file="prgappry.jsp" %>

<%
	}
%>

<%
	asePool.freeConnection(conn,"prgapprx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
