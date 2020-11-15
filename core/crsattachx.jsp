<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsattachx.jsp - delete attachment
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "crsattachx";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String action = website.getRequestParameter(request,"act", "");
	String kix = website.getRequestParameter(request,"kix","");
	int id = website.getRequestParameter(request,"id",0);

	// where do we have to go back to when all is done
	String r1 = website.getRequestParameter(request,"r1","");
	String r2 = website.getRequestParameter(request,"r2","");

	String title = "";
	String alpha = "";
	String num = "";
	String message = "";
	String inputTitle = "";

	String[] info = helper.getKixInfo(conn,kix);
	alpha = info[0];
	num = info[1];

	if (processPage && "r".equals(action)){
		Attach attach = AttachDB.getAttachment(conn,kix,id);
		if (attach!=null){
			title = attach.getFileDescr();
		}
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete Attachment";

	fieldsetTitle = "Delete Attachment";
	inputTitle = "Description";

	asePool.freeConnection(conn,"crsattachx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsattachx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	if (processPage){
%>
	<form method="post" action="/central/servlet/kuri" name="aseForm">
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
						<% out.println(Skew.showInputScreen(request)); %>
						<input type="hidden" value="<%=action%>" name="act">
						<input type="hidden" value="<%=kix%>" name="kix">
						<input type="hidden" value="<%=id%>" name="id">
						<input type="hidden" value="<%=r1%>" name="r1">
						<input type="hidden" value="crsattach" name="r2">
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
<%
	}
%>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
