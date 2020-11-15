<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvw2.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String userCampus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		String reviewers = "";
		String selectedCampus = website.getRequestParameter(request,"r");
		String alpha = website.getRequestParameter(request,"alpha");
		String num = website.getRequestParameter(request,"num");

		//ttg-getCampusReviewUsers2
		//reviewers = ReviewerDB.getCampusReviewUsers(conn,userCampus,selectedCampus,alpha,num,user);
		reviewers = ReviewerDB.getCampusReviewUsers2(conn,userCampus,selectedCampus,alpha,num,user);
		out.println(reviewers);
	}

	asePool.freeConnection(conn,"crsrvw2",user);
%>

</body>
</html>
