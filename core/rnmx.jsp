<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnmy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String message = "";
	String campus = "";
	String user = "";
	String kix = "";
	String alpha = "";
	String num = "";

	if (processPage){
		String formSelect = website.getRequestParameter(request,"formSelect");
		String formAction = website.getRequestParameter(request,"formAction");
		String formName = website.getRequestParameter(request,"formName");
		campus = website.getRequestParameter(request,"aseCampus","",true);
		user = website.getRequestParameter(request,"aseUserName","",true);
		kix = website.getRequestParameter(request,"kix","");

		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];

		boolean debug = false;

		if (debug){
			out.println("campus: " + campus + "</br>");
			out.println("kix: " + kix + "</br>");
			out.println("alpha: " + alpha + "</br>");
			out.println("num: " + num + "</br>");
			out.println("user: " + user + "</br>");
			out.println("formSelect: " + formSelect + "</br>");
		}
		else{
			if (formName != null && formName.equals("aseForm") && formAction.equalsIgnoreCase("s") ){

				if (kix.length() > 0 && formSelect.length() > 0){

					RenameDB renameDB = new RenameDB();
					boolean setReviewers = renameDB.setApprovers(conn,campus,user,kix,formSelect);
					renameDB = null;

					String approvers = formSelect;
					String approversForDisplay = EmailListsDB.expandListNames(conn,campus,user,approvers);
					if (setReviewers){
						if (approversForDisplay.equals(","))
							message = "Operation completed successfully";
						else
							message = "Approval request sent to the following: " + approversForDisplay;
					}
					else{
						message = "Unable to send approval request to: " + approversForDisplay;
					} // setReviewers

				}
				else{
					message = "Unable to process approval request. Please review your data and submit again.";
				} // invalid or no date

			}	// valid form

		}	// debug

	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	fieldsetTitle = "Rename/renumber Outline";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/rnm.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage)
		out.println(message);

	asePool.freeConnection(conn,"rnmy",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
