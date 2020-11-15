<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscanslo.jsp - cancel review request
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "crscanslo";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");
	String kix = website.getRequestParameter(request,"kix");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	int errorCode = 0;

	String proposer = "";

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		proposer = info[3];
	}
	else{
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
	}

	if ("".equals(proposer))
		proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Cancel SLO Review";

	String message = "";

	if (kix.length()>0){
		if (!proposer.equals(user)){
			message = "Cancellation is only available to the proposer of this outline.<br><br>";
		}
		else{
			if (!SLODB.sloProgress(conn,campus,alpha,num,"PRE","REVIEW") ){
				message = "SLO review has not been requested.<br><br>";
			}
			else{
				if (SLODB.reviewStarted(conn,campus,alpha,num) ){
					message = "Cancellation is not permitted once reviewers start to add comments.<br><br>";
					errorCode = 1;
				}
			}
		}	// proposer

		if (!"".equals(message) && errorCode==0){
			session.setAttribute("aseApplicationMessage",message);
			asePool.freeConnection(conn);
			response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + "&rtn=" + thisPage);
		}
	}

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscanslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<form method="post" action="crscanslox.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					SLO review has begun. Do you wish to continue?
					<br />
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
				</TD>
			</TR>
			<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
			<TR>
				<TD align="center">
					<br />
					<input title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
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
