<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	postx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Message Board - Posting Confirmation";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");

	int fid = website.getRequestParameter(request,"fid",0);
	int mid = website.getRequestParameter(request,"mid",0);
	int tid = website.getRequestParameter(request,"tid",0);
	int pid = website.getRequestParameter(request,"pid",0);
	int item = website.getRequestParameter(request,"item",0);
	int level = website.getRequestParameter(request,"level",0);
	int notify = website.getRequestParameter(request,"notify",0);
	int tab = website.getRequestParameter(request,"tab",0);
	String rtn = website.getRequestParameter(request,"rtn","");

	//
	// foundation
	//
	int sq = website.getRequestParameter(request,"sq",0);
	int en = website.getRequestParameter(request,"en",0);
	int qn = website.getRequestParameter(request,"qn",0);

	boolean bNotify = false;
	String sNotify = "No";

	if (notify == 1){
		bNotify = true;
		sNotify = "Yes";
	}

	String subject = website.getRequestParameterEditor(request,"subject","");
	String body = website.getRequestParameterEditor(request,"message","");

	//
	// ckeditor does something funny when space is entered more than once
	//
	body = body.replace("&nbsp;"," ");

	String message = "";

	asePool.freeConnection(conn,"postx",user);
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<script type="text/javascript" src="inc/validate.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header3.jsp" %>

<%
	if (processPage){

%>

<FORM NAME="aseForm" ACTION="posty.jsp" METHOD="post">
	<INPUT TYPE="hidden" NAME="mode" VALUE="e">
	<INPUT TYPE="hidden" NAME="mid" VALUE="<%=mid%>">
	<INPUT TYPE="hidden" NAME="fid" VALUE="<%=fid%>">
	<INPUT TYPE="hidden" NAME="tid" VALUE="<%=tid%>">
	<INPUT TYPE="hidden" NAME="tab" VALUE="<%=tab%>">
	<INPUT TYPE="hidden" NAME="pid" VALUE="<%=pid%>">
	<INPUT TYPE="hidden" NAME="item" VALUE="<%=item%>">
	<INPUT TYPE="hidden" NAME="level" VALUE="<%=level%>">
	<INPUT TYPE="hidden" NAME="notify" VALUE="<%=notify%>">
	<INPUT TYPE="hidden" NAME="subject" VALUE="<%=subject%>">
	<INPUT TYPE="hidden" NAME="message" VALUE="<%=body%>">
	<INPUT TYPE="hidden" NAME="src" VALUE="<%=src%>">
	<INPUT TYPE="hidden" NAME="rtn" VALUE="<%=rtn%>">
	<INPUT TYPE="hidden" NAME="sq" VALUE="<%=sq%>">
	<INPUT TYPE="hidden" NAME="en" VALUE="<%=en%>">
	<INPUT TYPE="hidden" NAME="qn" VALUE="<%=qn%>">

	<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="4" width="700" align="left">
		<TR >
			<TD width="10%" class="textblackth">Name:&nbsp;</TD>
			<TD width="90%" class="datacolumn"><%=user%></TD>
		</TR>

		<TR >
			<TD width="10%" class="textblackth">Subject:&nbsp;</TD>
			<TD width="90%" class="datacolumn"><%=subject%></TD>
		</TR>

		<TR >
			<TD width="10%" class="textblackth">Message:&nbsp;</TD>
			<TD width="90%" class="datacolumn"><%=body%></TD>
		</TR>

		<TR >
			<TD width="10%" class="textblackth">Notify:&nbsp;</TD>
			<TD width="90%" class="datacolumn"><%=sNotify%></TD>
		</TR>

		<TR height="40">
			<TD width="10%" class="textblackth">&nbsp;</TD>
			<TD width="90%"  valign="bottom" ALIGN="left">
				<INPUT class="input" TYPE="submit" VALUE="Post" id="cmdSubmit" name="cmdSubmit">&nbsp;&nbsp;
				<INPUT class="input" TYPE="submit" VALUE="Edit Post" id="cmdEdit" name="cmdEdit" onClick="return editForm();">&nbsp;&nbsp;
				<INPUT class="input" TYPE="submit" VALUE="Cancel" id="cmdCancel" name="cmdCancel" onClick="return cancelForm();">
			</TD>
		</TR>
	</TABLE>
</FORM>

<%
	}	// processPage
%>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
