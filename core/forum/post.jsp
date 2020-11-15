<%@ include file="../ase.jsp" %>

<%

	/**
	*	ASE
	*	bb.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Message Board";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String status = website.getRequestParameter(request,"status","");

	// check to prevent reposting
	session.setAttribute("aseProcessed","NO");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<script type="text/javascript" src="inc/validate.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>

<p align="left">
<%
	if (processPage){
		int mid = website.getRequestParameter(request,"mid",0);
		int fid = website.getRequestParameter(request,"fid",0);
		int pid = website.getRequestParameter(request,"pid",0);
		int tid = website.getRequestParameter(request,"tid",0);
		int tab = website.getRequestParameter(request,"tab",0);
		int item = website.getRequestParameter(request,"item",0);
		int level = website.getRequestParameter(request,"level",0);
		String rtn = website.getRequestParameter(request,"rtn","");
		String bookmark = website.getRequestParameter(request,"bookmark","");

		int sq = 0;
		int en = 0;
		int qn = 0;

		//
		// help us get back to outline work
		//
		if(!rtn.equals(Constant.BLANK)){
			if(rtn.equals("rvw")){
				session.setAttribute("aseResumeOutline","crsrvwer");
			}
			else if(rtn.equals("apr")){
				session.setAttribute("aseResumeOutline","crsappr");
			}

			if(!bookmark.equals(Constant.BLANK)){
				session.setAttribute("aseResumeOutlineBookmark",bookmark);
			}

			session.setAttribute("aseResumeOutlineTab",tab);
		}

		//
		// foundation is c99
		//
		if(bookmark.contains("c99")){
			String[] aBookmark = bookmark.split("-");
			sq = NumericUtil.getInt(aBookmark[1],0);
			en = NumericUtil.getInt(aBookmark[2],0);
			qn = NumericUtil.getInt(aBookmark[3],0);
		}

		boolean notify = website.getRequestParameter(request,"notify",false);

		String mode = website.getRequestParameter(request,"mode","a");
		String message = website.getRequestParameter(request,"message","");
		String subject = website.getRequestParameter(request,"subject","");

		String originalMessage = "";

		//
		// prefill only first time through
		//
		if (mid > 0 && rtn.equals(Constant.BLANK) && mode.equals("a")){
			subject = ForumDB.getMessageSubject(conn,mid);
			subject = "RE: " + subject;
			originalMessage = ForumDB.getMessageItem(conn,fid,mid,"message_body");
		}

		StringBuffer buf = new StringBuffer();

		if (level == 0){
			level = 1;
		}

		//
		// save this in case we need it for later use. in situation
		// where user cancels a post, we will not have forum id to work with
		//
		String historyID = website.getRequestParameter(request,"kix","");
		session.setAttribute("aseHistoryID",historyID);

		String kix = "fid="+fid+"&mid="+mid+"&item="+item+"&tid="+tid+"&pid="+pid+"&level="+level+"&subject="+subject+"";
		session.setAttribute("aseKix",kix);

		String checked = "";
		if (notify){
			checked = "checked";
		}

		//
		// pid and tid are 0 when coming from review screen
		//
		if(pid == 0 && tid == 0){
			pid = mid;
			tid = mid;
		}

%>
		<FORM NAME="aseForm" ACTION="postx.jsp" METHOD="post">
		<INPUT TYPE="hidden" NAME="mode" VALUE="<%=mode%>">
		<INPUT TYPE="hidden" NAME="mid" VALUE="<%=mid%>">
		<INPUT TYPE="hidden" NAME="fid" VALUE="<%=fid%>">
		<INPUT TYPE="hidden" NAME="tid" VALUE="<%=tid%>">
		<INPUT TYPE="hidden" NAME="tab" VALUE="<%=tab%>">
		<INPUT TYPE="hidden" NAME="pid" VALUE="<%=pid%>">
		<INPUT TYPE="hidden" NAME="item" VALUE="<%=item%>">
		<INPUT TYPE="hidden" NAME="level" VALUE="<%=level%>">
		<INPUT TYPE="hidden" NAME="rtn" VALUE="<%=rtn%>">
		<INPUT TYPE="hidden" NAME="kix" VALUE="hasValue">
		<INPUT TYPE="hidden" NAME="src" VALUE="<%=src%>">
		<INPUT TYPE="hidden" NAME="sq" VALUE="<%=sq%>">
		<INPUT TYPE="hidden" NAME="en" VALUE="<%=en%>">
		<INPUT TYPE="hidden" NAME="qn" VALUE="<%=qn%>">
		<BR>
		<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="4" width="700" align="left">
			<TR >
				<TD width="20%" class="textblackth" nowrap>Original Message:&nbsp;</TD>
				<TD width="80%" class="datacolumn"><%=originalMessage%></TD>
			</TR>
			<TR >
				<TD class="textblackth">Name:&nbsp;</TD>
				<TD class="datacolumn"><%=user%></TD>
			</TR>
			<TR >
				<TD class="textblackth">Subject:&nbsp;</TD>
				<TD><INPUT class="input" TYPE="text" NAME="subject" id="subject" MAXLENGTH="50" VALUE="<%=subject%>" size="110"></INPUT></TD>
			</TR>
			<TR >
				<TD class="textblackth">Message:&nbsp;</TD>

<%
			String ckName = "message";
			String ckData = message;
%>
			<TD>
				<%@ include file="../ckeditor02.jsp" %>
			</TD>
			</TR>

			<TR >
				<TD class="textblackth">&nbsp;</TD>
				<TD COLSPAN="2"><INPUT class="input" <%=checked%> TYPE="checkbox" NAME="notify" VALUE="1"> E-mail me when someone posts a new message in this thread.</TD>
			</TR>

			<TR height="40">
			<TD class="textblackth">&nbsp;</TD>
			<TD  valign="bottom" ALIGN="left">
				<INPUT class="input" TYPE="submit" VALUE="Post" id="cmdSubmit" name="cmdSubmit" onClick="return validateForm();">&nbsp;&nbsp;
				<INPUT class="input" TYPE="reset" VALUE="Reset Form" id="cmdReset" name="cmdReset" onClick="return resetForm();">&nbsp;&nbsp;
				<INPUT class="input" TYPE="submit" VALUE="Cancel Form" id="cmdCancel" name="cmdCancel" onClick="return cancelForm();"></TD>
			</TR>
			<TR height="40" valign="bottom">
				<TD colspan="2" VALIGN="bottom">

<%
		if (pid!=0) {
			buf.append("<img src=\"./images/document.gif\" border=\"0\" alt=\"Back to the Message\" title=\"Back to the Message\">&nbsp;<A class=\"linkcolumn\" HREF=\"displaymsg.jsp?mid=");
			buf.append(pid);
			buf.append("\">Back to the Message</A>&nbsp;");
		}
%>
		</TD>
		</TR>
		</TABLE>
		</FORM>
<%
	}

	asePool.freeConnection(conn,"post",user);
%>
</p>

<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
