<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	updbnr.jsp - update banner data
	*	2007.09.01	user index. different from banner in that it holds specifics for CC
	**/

	String pageTitle = "Update Banner";
	fieldsetTitle = pageTitle;

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){

		String message = "";

		String x = website.getRequestParameter(request,"x", "");

		if (x.equals("af")){
			message = BannerDB.getBannerSubject(conn,false);
		}
		else if (x.equals("at")){
			message = BannerDB.getBannerSubject(conn,true);
		}
		else if (x.equals("b")){
			message = BannerDB.processBanner(conn);
		}
		else if (x.equals("o")){
			message = BannerDB.addBannerToCourse(conn);
		}
		else if (x.equals("st")){
			message = "Subject codes: " + BannerDB.updateBannerData(conn,"alpha") + Html.BR();
			message += "College codes: " + BannerDB.updateBannerData(conn,"college") + Html.BR();
			message += "Department codes: " + BannerDB.updateBannerData(conn,"dept") + Html.BR();
			message += "Division codes: " + BannerDB.updateBannerData(conn,"division") + Html.BR();
			message += "Level codes: " + BannerDB.updateBannerData(conn,"level") + Html.BR();
			message += "Term codes: " + BannerDB.updateBannerData(conn,"terms") + Html.BR();
		}

		out.println("<h3 class=\"subheader\"><p align=\"left\">" + message + "</p></h3>");
	}

	asePool.freeConnection(conn,"updbnr",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
