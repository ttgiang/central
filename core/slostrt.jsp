<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	slostrt.jsp - start assessment
	*
	*	NOTE: Not in use. Logic moved to AssessedDataDB.java >> Reports >> SLO (called by crscntidx.jsp)
	*
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "slostrt";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String kix = website.getRequestParameter(request,"kix");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String proposer = "";

	if (	(alpha==null || alpha.length()==0) &&
			(num==null || num.length()==0) &&
			(kix==null || kix.length()==0)){
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}
	else{
		if (!"".equals(kix)){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			proposer = info[3];
		}
	}

	if ("".equals(proposer))
		proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Start Outline Assessment";

	String message = "";

	if (alpha.length()>0 || num.length()>0 || kix.length()>0){
		if (!proposer.equals(user)){
			message = "This option is only available to the proposer of this outline.<br><br>";
		}
		else{
			if (	!SLODB.sloProgress(conn,campus,alpha,num,"PRE","APPROVED") &&
					SLODB.doesSLOExist(conn,campus,alpha,num)){
				message = "Assessment is currently in progress. Select Assess or Edit SLO to continue.<br><br>";
			}
		}

		if (!"".equals(message)){
			session.setAttribute("aseApplicationMessage",message);
			asePool.freeConnection(conn);
			response.sendRedirect("msg.jsp?alpha=" + alpha + "&num=" + num  + "&campus=" + campus + "&rtn=" + thisPage);
		}
	}

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/slostrt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/chewie" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br />
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
				</TD>
			</TR>
			<TR>
				<TD align="center">
					<br />
					<input title="continue with request" name="aseSubmit" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" name="aseCancel" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm(); return true;">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="<%=thisPage%>" name="caller">
					<input type="hidden" value="ASSESS" name="progress">
					<input type="hidden" value="aseForm" name="formName">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
