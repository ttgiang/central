<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmpww.jsp - delete SLO
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String alpha = (String)session.getAttribute("aseAlpha");
	String num = (String)session.getAttribute("aseNum");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String cancel = website.getRequestParameter(request,"cmdCancel", "");
	String delete = website.getRequestParameter(request,"cmdDelete", "");

	String action = website.getRequestParameter(request,"act", "");
	String kix = website.getRequestParameter(request,"kix", "");
	int compID = website.getRequestParameter(request,"compID",0);

	String type = (String)session.getAttribute("aseType");
	if (type==null)
		type="PRE";

	String src = Constant.COURSE_OBJECTIVES;

	String message = "";

	if (processPage && formName != null && formName.equals("aseForm") ){
		if ( alpha != null && num != null ){
			if ("r".equals( action)){

				if ("Force Delete".equals(delete))
					LinkerDB.deleteLinkedItems(conn,campus,kix,src,compID);

				// deletable is only after all linked items have been removed
				boolean isDeletable = LinkerDB.isMaxtrixItemDeletable(conn,campus,kix,src,compID);
				if (isDeletable){
					msg = CompDB.addRemoveCourseComp(conn,action,campus,alpha,num,"",compID,user,kix);
					if (!"Exception".equals(msg.getMsg()))
						message = "SLO deleted successfully";
					else
						message = "Unable to complete requested operation";
				} // isDeletable
			}
		}	// alpha & num
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete SLO";

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
<p align="center"><%= message %></p>

<p align="center">
<a href="/central/core/crscmp.jsp?kix=<%=kix%>" class="linkcolumn">return to SLO screen</a>
</p>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
