<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	expdltx.jsp - confirmation page for outline approval
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "expdltx";

	String alpha = "";
	String num = "";
	String type = "";
	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		type = info[Constant.KIX_TYPE];
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Expedited Outline Delete";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/expdltx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	if (processPage && type.equals(Constant.CUR)){
%>
		<form method="post" action="expdltxx.jsp" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD align="center">
							Do you wish to continue with the expedited request?
							<br/><br/>
							<input type="hidden" value="<%=kix%>" name="kix">
						</TD>
					</TR>
					<TR><TD align="center"><% out.println(Skew.showInputScreen(request)); %></td></tr>

					<TR>
						<TD align="center">
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
							<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
							</div>
						</td>
					</tr>

					<TR>
						<TD align="center">
							<br />
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>
<%
	} // processPage

	asePool.freeConnection(conn,"expdltx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
