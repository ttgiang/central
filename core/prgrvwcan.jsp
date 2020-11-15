<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvwcan.jsp	- cancel program review request
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String pageTitle = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with

	String thisPage = "prgrvwcan";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");

	if (processPage){
		if (!"".equals(kix)){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_PROGRAM_TITLE];
			num = info[Constant.KIX_PROGRAM_DIVISION];

			pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
			fieldsetTitle = "Cancel Program Review";

			if (!ProgramsDB.isProgramReviewable(conn,campus,kix,user)){
				String message = "You are not authorized to cancel this program or cancellation is not permitted at this time.";
				session.setAttribute("aseApplicationMessage",message);
				response.sendRedirect("msg.jsp?campus=" + campus + "&rtn=" + thisPage);
			}
		}
		else{
			response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
		}
	}

	asePool.freeConnection(conn,"prgrvwcan",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgrvwcan.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="prgrvwcanx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br />
					<input type="hidden" value="<%=kix%>" name="kix">
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
