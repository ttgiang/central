<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnmax.jsp - rename/renumber submission
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String message = "";
	String sURL = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix", "");

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if (kix.length() > 0){
				if (Skew.confirmEncodedValue(request)){

					if (formAction.equalsIgnoreCase("s") ){

						String submit = website.getRequestParameter(request,"aseSubmit", "");
						String denied = website.getRequestParameter(request,"aseDenied", "");
						String comments = website.getRequestParameter(request,"approval","");

						String approved = "0";
						if(submit.toLowerCase().equals("approved")){
							approved = "1";
						}

						RenameDB rename = new RenameDB();
						int rowsAffected = rename.processApproval(conn,campus,user,kix,approved,comments);
						rename = null;

						if(rowsAffected > 0){
							message = "Comments updated successfully.";
						}
						else{
							message = "Error processing approval";
						}

					}	// action = s
				}
				else{
					message = "Invalid security code";
				} // skew is valid

			} // kix is valid

		}	// valid form

	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Approve Outline Rename/Renumber";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"rnmax",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%=message%></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
