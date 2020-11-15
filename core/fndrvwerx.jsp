<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndrvwerx.jsp	- course review finished
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String message = "";
	String alpha = "";
	String num = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix");
	String url = "";

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	if (processPage && !kix.equals(Constant.BLANK)){
		String[] info = fnd.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];

		String cmdContinue = website.getRequestParameter(request,"cmdContinue","");
		String cmdFinish = website.getRequestParameter(request,"cmdFinish","");

		// f comes from i'm finished link during review outside of approval process
		String finish = website.getRequestParameter(request,"f","");

		// if a button was pressed and it's a valid button, update approver comments
		if (cmdFinish.length()>0 || cmdContinue.length()>0){
			if (Skew.confirmEncodedValue(request)){
				String comments = website.getRequestParameter(request,"comments","");
				int voteFor = website.getRequestParameter(request,"voteFor",0);
				int voteAgainst = website.getRequestParameter(request,"voteAgainst",0);
				int voteAbstain = website.getRequestParameter(request,"voteAbstain",0);
				int rowsAffected = fnd.approveReview(conn,campus,kix,alpha,num,user,comments,voteFor,voteAgainst,voteAbstain);
				message = "Foundation course review was saved successfully.";
			}
			else{
				message = "Invalid security code";
			} // skew
		}	// if cmdFinish

		if (cmdFinish.length()>0 || finish.equals(Constant.ON)){
			msg = fnd.endReviewerTask(conn,campus,kix,user);
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Error while saving outline review." + msg.getErrorLog();
			}
			else if ("forwardURL".equals(msg.getMsg()) ){
				url = "lstappr.jsp?kix="+kix+"&s=1";
			}
			else
				message = "Foundation course review was saved successfully.";
		}
	} // kix

	String chromeWidth = "90%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Foundation Course";

	asePool.freeConnection(conn,"fndrvwerx",user);

	fnd = null;

	if (!url.equals(Constant.BLANK)){
		response.sendRedirect(url);
	}
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br><p align="center"><%=message%></p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
