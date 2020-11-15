<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndedt6x.jsp	- processing of approval/review confirmation
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String temp = "";
	String alpha = "";
	String num = "";

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
	}

	String message = "";
	String sURL = "";
	String errorMsg = "";

	int route = website.getRequestParameter(request,"selectedRoute",0);
	String progress = website.getRequestParameter(request,"aseProgress","",true);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Approve Foundation Course Content";

	// outline validation before approval/review
	boolean proceedWithApproval = true;

	if (processPage){
		if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
			if (ApproverDB.isRoutingOutOfSequence(conn,campus,route)){
				temp = ApproverDB.getRoutingNameByID(conn,campus,route);
				errorMsg += "<li>The requested approval routing (<font class=\"textblackth\">"+temp+"</font>) is not properly defined</li>";
				proceedWithApproval = false;
			}
		}

		boolean debug = false;
		if (debug){
			out.println( "alpha: " + alpha + "<br>");
			out.println( "num: " + num + "<br>");
			out.println( "progress: " + progress + "<br>");
			out.println( "campus: " + campus + "<br>");
			out.println( "route: " + route + "<br>");
			out.println( "formName: " + formName + "<br>");
			out.println( "formAction: " + formAction + "<br>");
			out.println( "proceedWithApproval: " + proceedWithApproval + "<br>");
		}
		else{
			if ( formName != null && formName.equals("aseForm") ){
				if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){
					if (proceedWithApproval){
						//
						//	packets are submitted as pending. packet sent only if route = 0 the first time in.
						//	if packet is used and route is > 0, then it's because we already got the process rolling.
						//
						//	review is forwarded to selection of reviewers
						//
						if (progress.equals(Constant.COURSE_REVIEW_TEXT)) {
							sURL = "crsrvw.jsp?kix=" + kix;
						}
						else if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){
							msg = courseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,user);
							if ( "Exception".equals(msg.getMsg()) ){
								message = "Request for foundation course approval failed.<br><br>" + msg.getErrorLog();
							}
							else if ("forwardURL".equals(msg.getMsg()) ){
								sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
							}
							else if (!(Constant.BLANK).equals(msg.getMsg())){
								message = "Unable to initiate foundation course approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
							}
							else{
								temp = "";
								boolean experimental = Outlines.isExperimental(num);
								Approver ap = ApproverDB.getApprovers(conn,campus,alpha,num,user,experimental,route);
								if (ap != null){
									temp = ap.getAllApprovers().replace(",",", ");
									temp = DistributionDB.expandNameList(conn,campus,temp,true);
								}

								String currentApprover = ApproverDB.getCurrentApprover(conn,campus,alpha,num);
								if (currentApprover == null){
									currentApprover = "";
								}
								else{
									// if current and delegate are same, don't show both
									currentApprover = DistributionDB.expandNameList(conn,campus,currentApprover);
								}

								StringBuffer output = new StringBuffer();

								if (!temp.equals(Constant.BLANK) && !currentApprover.equals(Constant.BLANK)){
									output.append("Outline has been submitted for approval.<br/><br/>"
										+ "<p align=\"left\">The following are scheduled to approve this foundation course:<br/><br/>"
										+ "<font class=\"datacolumn\">" + temp + "</font>"
										+ "<br/><br/>Current approver(s): <font class=\"datacolumn\">" + currentApprover + "</font>"
										+ "</p>");
								}

								output.append("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
								output.append("			<tr>" );
								output.append("				 <td>" );
								output.append(ReviewerDB.getReviewHistory(conn,kix,0,campus,0,Constant.REVIEW));
								output.append("				</td>" );
								output.append("			</tr>" );
								output.append("</table>");

								message = output.toString();
							}
						}
					}
					else{
						message = "Unable to process your approval request.<br/>"
							+ "<p align=\"left\">Possible error(s):<br/><br/><ul>" + errorMsg
							+ "</ul></p>";
					}  // proceedWithApproval
				} // skew
				else{
					message = "Invalid security code";
				}
			}	// form
		}	// if debug
	} //processPage

	asePool.freeConnection(conn,"fndedt6x",user);

	if (!sURL.equals(Constant.BLANK)){
		response.sendRedirect(sURL);
	}

	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);

	fnd = null;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="../inc/expand.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println( "<br><p align='center'>" + message + "</p>" );
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
