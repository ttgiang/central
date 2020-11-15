<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprx.jsp
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
	String comments = "";
	String message = "";
	String sURL = "";
	String kix = "";
	String enabledForEdits = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		if ( formName != null && formName.equals("aseApprovalForm") ){
			alpha = website.getRequestParameter(request,"alpha","");
			num = website.getRequestParameter(request,"num","");
			comments = website.getRequestParameter(request,"comments","");

			//
			// ER00009 - remember where user comments so we can place check marks on this page
			//
			enabledForEdits = website.getRequestParameter(request,"e","");

			kix = helper.getKix(conn,campus,alpha,num,"PRE");
			int voteFor = website.getRequestParameter(request,"voteFor",0);
			int voteAgainst = website.getRequestParameter(request,"voteAgainst",0);
			int voteAbstain = website.getRequestParameter(request,"voteAbstain",0);

			if ( alpha.length() > 0 && num.length() > 0 ){
				if (Skew.confirmEncodedValue(request)){
					if (formAction.equalsIgnoreCase("s") ){
						//
						//	msg.code returns 1 if successful with method. returns 2 if successful and
						//	also the last person to approve.
						//
						Outlines.deleteTempOutline(conn,campus,alpha,num);

						//
						// notify when approval at sequence. must do at this point because
						// outline approval changes sequence and alter routing if it's the last person
						// kix and route is gone by then
						//
						// INLINE
						ApproverDB.notifiedDuringApproval(conn,campus,user,kix);

						//
						// outline approval
						//
						msg = courseDB.approveOutline(conn,campus,alpha,num,user,true,comments,voteFor,voteAgainst,voteAbstain);
						if ( "Exception".equals(msg.getMsg()) ){
							message = "Outline approval failed.<br><br>" + msg.getErrorLog();
						}
						else if ("forwardURL".equals(msg.getMsg()) ){
							sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
						}
						else if (!"".equals(msg.getMsg())){
							message = "Unable to approve outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
						}
						else{
							if (msg.getCode() == 2){
								message = "Outline was approved and finalized.";
							}
							else{
								if (msg.getErrorLog() != null && msg.getErrorLog().length() > 0)
									message = "Outline was approved and next approver (" + msg.getErrorLog() + ") has been notified.";
								else
									message = "Outline was approved.";
							}
						}
					}	// action = s
					else if (formAction.equalsIgnoreCase("r") ){
						session.setAttribute("aseApplicationComments",comments);
						session.setAttribute("aseApplicationVoteFor",voteFor);
						session.setAttribute("aseApplicationVoteAgainst",voteAgainst);
						session.setAttribute("aseApplicationVoteAbstain",voteAbstain);
						session.setAttribute("aseApprovalRejection", "1");
						sURL = "shwfld.jsp?cmnts=0&alpha=" + alpha + "&num=" + num + "&e=" + enabledForEdits;
					}	// action = revise
					else if (formAction.equalsIgnoreCase("v") ){
						session.setAttribute("aseModificationMode", "");
						session.setAttribute("aseWorkInProgress", "0");
						session.setAttribute("aseProgress", "REVIEW");
						sURL = "crsedt6.jsp?kix="+kix;
					}	// action = review
					else {
						// NOTE: recent reported defects has been with data having multiple forms causing the page to page
						// when formaction is not available, it is likely that form data caused an error for CC. For example,
						// data on the form consisting of bad characters like pasting from MS-Word. This has happened in the
						// past where the extra data from Word breaks the processing of JS.
						// Recommendation is for campus admin to clean up the data or fast approve the outline.
						message = "Curriculum Central was not able to complete the requested action.<br><br>Contact your campus administrator for assistance.";
					}	// action = error
				}
				else{
					message = "Invalid security code";
				}
			}
		}	// valid form
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Approve Outline";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"crsapprx",user);

	if ( sURL != null && sURL.length() > 0 ){
		response.sendRedirect(sURL);
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscpy.js"></script>

	<script type="text/javascript">

		function showHistory(kix){

			var myLink = "crsstsh.jsp?kix=<%=kix%>";

			var win2 = window.open(myLink, 'myWindow','toolbar=no,width=800,height=600,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');

			return false;

		}

	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%=message%></p>
<p align="center">
<a href="##" onClick="return showHistory();" class="linkcolumn">approval history</a>&nbsp;&nbsp;<font class="copyright">|</a>&nbsp;&nbsp;<a href="crssts.jsp" class="linkcolumn">approval status</a>
</p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
