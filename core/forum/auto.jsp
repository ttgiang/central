<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	auto.jsp - create
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Create Message";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String src = website.getRequestParameter(request,"src","");
	String kix = "TBD";
	int forumId = website.getRequestParameter(request,"fid",0);
	int item = 0;

	String rtn = "display";
	if (kix.indexOf(user)>-1){
		rtn = "dsplst";
	}

	String status = website.getRequestParameter(request,"status","");

	boolean isAdmin = SQLUtil.isSysAdmin(conn,user);
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<script type="text/javascript" src="../../ckeditor/ckeditor.js"></script>
	<script language="JavaScript" src="inc/auto.js"></script>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<%
	if (processPage){
%>

 <FORM NAME="aseForm" ACTION="autox.jsp" METHOD="post">
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width="80%" align="left">

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">Key:&nbsp;</TD>
			<TD width="85%" class="datacolumn"><%=kix%></TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">Campus:&nbsp;</TD>
			<TD width="85%" class="datacolumn">
				<%
					if(isAdmin){
						String sql = aseUtil.getPropertySQL(session,"campusList");
						out.println(aseUtil.createSelectionBox(conn, sql, "forumCampus", campus, "",false ));
					}
					else{
						out.println(campus);
						out.println("<input type=\"hidden\" name=\"forumCampus\" value=\""+campus+"\">");
					}
				%>
			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth" valign="top">Status:&nbsp;</TD>
			<TD width="85%" class="datacolumn">Requirements</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Category:&nbsp;</TD>
			<TD width="85%" >
				<select class="input" id="src" name="src" onchange="javascript:categoryOnChange();">
					<option value="">-select-</option>
<!--
					<option value="<%=Constant.COURSE%>">Course Related</option>
					<option value="<%=Constant.PROGRAM%>">Program Related</option>
					<option value="">------------------------------</option>
-->
					<option value="<%=Constant.DEFECT%>">Defect Reporting</option>

					<%
						if(isAdmin){
							out.println("<option value=\""+Constant.ENHANCEMENT+"\">Enhancement Request</option>");
							out.println("<option value=\""+Constant.TODO+"\">To do</option>");
						}
					%>

				</select>
			</TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Title:&nbsp;</TD>
			<TD width="85%" class="datacolumn"><input type="text" name="forumName" size="100" maxlength="50" class="input"></TD>
		</TR>

		<TR height="30" valign="top">
			<TD width="15%" class="textblackth">Description:&nbsp;</TD>
			<TD width="85%" class="datacolumn">
<%
			String ckName = "forumDescr";
			String ckData = "";

%>
			<%@ include file="../ckeditor02.jsp" %>

			</TD>
		</TR>

		<TR height="40">
			<TD width="15%"  class="textblackth">&nbsp;</TD>
			<TD width="85%"  valign="bottom" ALIGN="left">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="aseForm" name="formName">
				<input type="hidden" name="kix" value="<%=kix%>">
				<input type="hidden" name="item" value="<%=item%>">
				<INPUT  TYPE="submit" VALUE="Post" id=cmdSubmit name=cmdSubmit class="input" onClick="return checkForm('s')">&nbsp;
				<INPUT  TYPE="submit" VALUE="Cancel" id=cmdCancel name=cmdCancel class="input" onClick="return cancelForm()">&nbsp;
				<INPUT  TYPE="reset" VALUE="Reset Form" id=cmdReset name=cmdReset class="input">&nbsp;&nbsp;
			</TD>
		</TR>

		<TR height="80">
			<TD colspan="2" VALIGN="bottom">
				<A HREF="./<%=rtn%>.jsp?fid=<%=forumId%>" class="linkcolumn"><img src="./images/folder_open.gif" border="0" alt="Back to the Folder" title="Back to the Folder">&nbsp;Back to message listing</A><BR>
			</TD>
		</TR>
	</TABLE>
</form>

<%
	}
%>

<%
	asePool.freeConnection(conn,"auto",user);
%>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>
