<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprpndy.jsp - submit pending approval
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String proposer = "";
	String alpha = "";
	String num = "";
	String message = "";
	String sURL = "";
	boolean approval = false;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		proposer = info[Constant.KIX_PROPOSER];
	}
	else{
		alpha = website.getRequestParameter(request,"aseAlpha","",true);
		num = website.getRequestParameter(request,"aseNum","",true);
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
	}

	int route = website.getRequestParameter(request,"route",0);

	String packet = website.getRequestParameter(request,"packet","false");
	String content = website.getRequestParameter(request,"content","");
	String subject = "Course approval request was declined ("+alpha+" "+num+")";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	// a route number is available only if cmdYes selected
	if (route > 0){
		approval = true;
	}

	// form title
	if (processPage && formName != null && formName.equals("aseForm") ){
		pageTitle = "Outline Packet Submitted";
	} // processPage

	fieldsetTitle = "Approve Outline Content";

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){

				boolean debug = false;

				if (debug){
					out.println("approval: " + approval + Html.BR());
					out.println("formName: " + formName + Html.BR());
					out.println("packet: " + packet + Html.BR());
					out.println("alpha: " + alpha + Html.BR());
					out.println("num: " + num + Html.BR());
					out.println("proposer: " + proposer + Html.BR());
					out.println("proposer: " + proposer + Html.BR());
					out.println("route: " + route + Html.BR());
					out.println("content: " + content + Html.BR());
					out.println("subject: " + subject + Html.BR());
				}
				else{

					if (approval){

						if (packet.equals(Constant.TRUE)){
							msg = ChairProgramsDB.requestPacketApproval(conn,campus,user,route);
						}
						else{
							msg = courseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,proposer);
						} // packet

						if ( "Exception".equals(msg.getMsg()) ){
							message = "Request for outline approval failed.<br><br>"
								+ aseUtil.nullToBlank(msg.getErrorLog());
						}
						else if ("forwardURL".equals(msg.getMsg()) ){
							sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
						}
						else if (!"".equals(msg.getMsg())){
							message = "Unable to initiate outline approval.<br><br>"
								+ MsgDB.getMsgDetail(msg.getMsg());
						}
						else{
							message = "Outline has been submitted for approval.<br/><br/>"
								+ aseUtil.nullToBlank(msg.getUserLog());
						} // msg

					}
					else{
						// when rejecting, we send back to the proposer
						// recreate task for proposer

						if(courseDB.declineOutlinePacketApproval(conn,campus,alpha,num,user,proposer,content,subject) > 0){
							message = "Message sent to proposer";
						}

					} // approval

					// approved or not, we still remove task for this entry
					TaskDB.logTask(conn,proposer,user,alpha,num,
										Constant.APPROVAL_PENDING_TEXT,
										campus,
										Constant.BLANK,
										Constant.TASK_REMOVE,
										Constant.PRE);

					// if all approvals have been completed, remove task to approve
					TaskDB.removePendingApprovalTask(conn,campus,user,alpha,num);

				} // debug

			} // skew
			else{
				message = "Invalid security code";
			}
		}
		else{
			message = "Unauthorized access!";
		}	// form
	}
	else{
		message = "Unauthorized access!";
	} //processPage

	asePool.freeConnection(conn,"crsapprpndy",user);

	if (!sURL.equals(Constant.BLANK)){
		response.sendRedirect(sURL);
	}

	session.setAttribute("aseAlpha", null);
	session.setAttribute("aseNum", null);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
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
