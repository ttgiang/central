<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrwslo.jsp	review slo/comp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String alpha = "";
	String num = "";
	String type = "";

	String thisPage = "crsrwslo";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String campusName = CampusDB.getCampusName(conn,campus);

	/*
		jsid is sent over from crscmpy which does the processing of page submission.

		it is compared to the current session id to make sure we are not hacked. if it is
		good, use the session alpha and number to avoid being forced to go back to sltcrs.
	*/
	String jsid = website.getRequestParameter(request,"jsid","");
	String kix = website.getRequestParameter(request,"kix","");
	if (kix!=null && kix.length()>0){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		if (jsid.equals(session.getId())){
			alpha = (String)session.getAttribute("aseAlpha");
			num = (String)session.getAttribute("aseNum");
		}
		else{
			alpha = website.getRequestParameter(request,"alpha");
			num = website.getRequestParameter(request,"num");
		}

		kix = helper.getKix(conn,campus,alpha,num,"PRE");
	}

	// is there a course and number to work with?
	if ((alpha==null || alpha.length()==0) && (num==null || num.length()==0)){
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}

	session.setAttribute("aseAlpha",alpha);
	session.setAttribute("aseNum",num);

	// GUI
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Course SLO/Competencies";

	alpha = aseUtil.nullToBlank(alpha);
	num = aseUtil.nullToBlank(num);
	kix = aseUtil.nullToBlank(kix);

	if (alpha.length()>0 || num.length()>0 || kix.length()>0){
		if (!DistributionDB.hasMember(conn,campus,"SLOReviewer",user)){
			String message = "You are not authorized to review outline SLO/competencies.";
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?alpha=" + alpha + "&num=" + num  + "&campus=" + campus + "&rtn=crsrwslo");
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsrwslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	// form action goes to crscmpy
	if (alpha != null && num != null){
		String comp = CompDB.getCompsToReview(conn,alpha,num,campus,"PRE",user,"","",false);
		if (comp!=null)
			out.println(comp);
	}

	asePool.freeConnection(conn,"crsrwslo",user);
%>

<div class="hr"></div><p align="left"><b>NOTE</b>: When available, select <b>Yes</b> or <b>No</b> for each SLO then click the 'Save' button.<br/><br/>Once all SLOs are approved, select 'Return to Proposer'
to notify the proposer that you are finished reviewing.</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
