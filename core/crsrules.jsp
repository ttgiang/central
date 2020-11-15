<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrules.jsp	- rules
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Course Rules";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String frm = website.getRequestParameter(request,"frm","");
	String kix = website.getRequestParameter(request,"kix","");

	String data = null;
	String form = null;

	// hasRules was set and comes over from other points. It's used to determine
	// whether we need to follow some defined rule. The data value was saved
	// elsewhere also. It comes over as session or direct from a request
	// parameter depends on where crsrules was called.
	String hasRules = website.getRequestParameter(request,"rls","0");

	if (processPage){
		String currentTab = (String)session.getAttribute("aseCurrentTab");
		String currentNo = (String)session.getAttribute("asecurrentSeq");
		int nextNo = 1;

		if (currentNo != null && currentNo.length() > 0)
			nextNo = Integer.parseInt(currentNo) + 1;

		String backToEditCurrent = "crsedt.jsp?kix="+kix+"&ts="+currentTab+"&no="+currentNo;
		String backToEditNext = "crsedt.jsp?kix="+kix+"&ts="+currentTab+"&no="+nextNo;

		// are there rules to process
		if ("1".equals(hasRules))
			data = (String)session.getAttribute("aseQuestions");
		else
			data = website.getRequestParameter(request,"questions");

		// which form are we working with
		if ("diversification".equals(frm))
			form = "divmtrx";

		if (form != null && form.length() > 0){
			if ("diversification".equals(frm)){
				// no point in forwarding if the topic does not exist for diversification
				long countRecords = aseUtil.countRecords(conn,"tblValues","WHERE campus='"
										+ campus
										+ "' AND topic='"
										+ data
										+ "'");

				if (countRecords > 0)
					response.sendRedirect(form + ".jsp?kix="+kix+"&topic="+data);
				else
					response.sendRedirect(backToEditNext);
			}
			else
				response.sendRedirect(backToEditCurrent);
		}
		else{
			response.sendRedirect(backToEditCurrent);
		}
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	asePool.freeConnection(conn,"crsrules",user);
%>
</form>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
