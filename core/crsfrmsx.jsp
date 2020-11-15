<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfrmsx.jsp - delete linker entry
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "crsfrmsx";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String action = website.getRequestParameter(request,"act", "");
	String kix = website.getRequestParameter(request,"kix", "");
	int seq = website.getRequestParameter(request,"seq",0);

	String title = "";
	String link = "";
	String descr = "";
	String alpha = "";
	String num = "";

	String type = (String)session.getAttribute("aseType");
	if (type==null)
		type="PRE";

	String message = "";
	String inputTitle = "";

	if (formName != null && formName.equals("aseForm") ){
		if (kix != null){

			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];

			if ("r".equals(action)){
				Form form = FormDB.getForm(conn,kix,seq);
				if (form!=null){
					title = form.getTitle();
				}
			}
		}	// alpha & num
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete Form";

	fieldsetTitle = "Delete Form";
	inputTitle = "Title";

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

<form method="post" action="/central/servlet/frms" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="20">
				<TD class="textblackTH" width="20%">Campus:</TD>
				<TD class="datacolumn"><%=campus%></TD>
			</TR>
			<TR height="20">
				<TD class="textblackTH" width="20%"><%=inputTitle%>:</TD>
				<TD class="datacolumn"><%=title%></TD>
			</TR>
			<TR height="20">
				<TD colspan="2"><div class="hr"></div></TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					Do you wish to continue?<br/><br/>
					<br />
					<input type="hidden" value="<%=action%>" name="act">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=seq%>" name="seq">
				</TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					<br />
					<input title="continue with request" type="submit" name="aseDelete" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" type="submit" name="aseCancel" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
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
