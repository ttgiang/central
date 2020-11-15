<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdltxz.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String type = "";
	String message = "";
	String sURL = "";
	String temp = "";

	String formName = website.getRequestParameter(request,"formName");
	String formAction = website.getRequestParameter(request,"formAction");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String comments = website.getRequestParameter(request,"comments","");

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	int route = website.getRequestParameter(request,"route",0);
	if (route==0){
		route = ApproverDB.getApprovalRouting(conn,campus,kix);
	}

	if (processPage && formName.equals("aseForm")){
		if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){
			if ( alpha.length() > 0 && num.length() > 0 ){

				String approvalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");

				if(approvalSubmissionAsPackets.equals(Constant.ON)){

					// 1) deletes are permitted for CUR only
					// 2) packets requires outline in modify process

					// because of above, we have to update course from CUR to PRE prior
					// to running through here

					msg = ChairProgramsDB.setCourseApprovalPacket(conn,kix,Constant.COURSE_DELETE_TEXT,user,comments);
					if ( "Exception".equals(msg.getMsg()) ){
						message = "Request for outline approval failed.<br><br>"
							+ msg.getErrorLog();
					}
					else if (!"".equals(msg.getMsg())){
						message = "Unable to initiate outline approval.<br><br>"
							+ MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "Outline has been submitted for approval to your department/division chair ("
									+ ChairProgramsDB.getChairName(conn,campus,alpha)
									+").";
					}

				}
				else{

					msg = CourseDelete.setCourseForDelete(conn,kix,user,route,comments);
					if ( "Exception".equals(msg.getMsg()) ){
						message = "Request to delete outline failed.<br><br>" + msg.getErrorLog();
					}
					else if ("forwardURL".equals(msg.getMsg()) ){
						sURL = "lstappr.jsp?kix="+msg.getKix()+"&s="+msg.getCode();
					}
					else if (!"".equals(msg.getMsg())){
						message = "Unable to initiate outline delete approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						boolean experimental = Outlines.isExperimental(num);
						Approver ap = ApproverDB.getApprovers(conn,campus,alpha,num,user,experimental,route);
						if (ap!=null){
							temp = ap.getAllApprovers().replace(",",", ");
							temp = DistributionDB.expandNameList(conn,campus,temp);
							message = "Outline has been submitted for deletion.<br/><br/>"
								+ "<p align=\"left\">The following are scheduled to approve this deletion:<br/><br/>" + temp
								+ "</p>";
						}
					}	// exception

				} // approvalSubmissionAsPackets

			}	// course alpha and num length
		}	// action = s
		else{
			message = "Invalid security code";
		}
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete Outline";

	asePool.freeConnection(conn,"crsdltxz",user);

	if (!"".equals(sURL))
		response.sendRedirect(sURL);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsdlt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<p align="center"><%=message%></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
