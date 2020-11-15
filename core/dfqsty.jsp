<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dfqsty.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formName = website.getRequestParameter(request,"formName");
	String message = "";
	StringBuffer sequences = new StringBuffer();
	String questionType = website.getRequestParameter(request,"questionType");
	int items = website.getRequestParameter(request,"items",0);
	int i;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if ( formName != null && formName.equals("aseForm") ){
		if (items > 0){
			for (i=1; i<=items; i++){
				if (i==1)
					sequences.append(website.getRequestParameter(request,"s"+i,0));
				else
					sequences.append(","+website.getRequestParameter(request,"s"+i,0));
			}

			msg = QuestionDB.resequenceItems2(conn,questionType,campus,sequences.toString());
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Question resequencing failed.<br><br>" + msg.getErrorLog();
			}
			else if ( !"".equals(msg.getMsg()) ){
				message = "Unable to resequence euestions.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
			}
			else{
				message = "Question resequencing completed successfully.<br>";
			}
		}	// items
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Item Resequencing";
	fieldsetTitle = pageTitle;

	asePool.freeConnection(conn);
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
