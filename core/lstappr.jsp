<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	lstappr.jsp - list approver names for selection
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "lstappr";
	session.setAttribute("aseThisPage",thisPage);

	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String type = "";
	String proposer = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		proposer = info[3];
		route = NumericUtil.nullToZero(info[6]);
	}

	String pageTitle = "";

	boolean isProgram = ProgramsDB.isAProgram(conn,campus,kix);
	if (isProgram){
		pageTitle = "Program Approval";
		fieldsetTitle = pageTitle;
	}
	else{
		pageTitle = "Outline Approval - (" + courseDB.setPageTitle(conn,"",alpha,num,campus) + ")";
		fieldsetTitle = "Outline Approvers";
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/lstappr.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="lstapprx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<td width="10%">&nbsp;</td>
				<TD width="80%">
					<br />
					Curriculum Central does not have sufficient information to determine the next approver. Please
					select from the list below and click 'Submit' to continue the approval process.<br/><br/>
					<%
						// sequence of 99 is part of the revision of an outline where we need to list
						// the approvers + the proposer for selection to send back. Value of 99
						// comes from msg.jsp under code LSTAPPR
						// must differentiate between the proposer and approver when sequence is 99
						int seq = website.getRequestParameter(request,"s",0);
						if (processPage && seq>0){
							if (seq==99){
								Approver approver = null;

								if (isProgram)
									approver = ApproverDB.getApprovers(conn,kix,proposer,false,route);
								else
									approver = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,false,route);

								if (approver != null){
									String approvers = "P_" + proposer + ",A_"
																+ approver.getAllApprovers().replace(",",",A_");

									String approversValue = "PROPOSER - " + proposer + ",APPROVER - "
																+ approver.getAllApprovers().replace(",",",APPROVER - ");

									out.println(Html.drawRadio(conn,approversValue,approvers,"appr","",campus,false));
								}
							}
							else{
								out.println(ApproverDB.displayApproversBySeq(conn,campus,seq,route));
							}
						}

						asePool.freeConnection(conn,"lstappr",user);
					%>
					<input title="continue approval process" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input type="hidden" value="" name="nextApprover">
					<input type="hidden" value="s" name="formAction">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=seq%>" name="seq">
					<input type="hidden" value="aseForm" name="formName">
				</TD>
				<td width="10%">&nbsp;</td>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
