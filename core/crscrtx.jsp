<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscrt.jsp	create new outline.
	*	TODO: crscrt.js has code for checkData
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "70%";

	String pageTitle = "screen 2 of 4";

	fieldsetTitle = "Create New Outline "
						+ "&nbsp;&nbsp;&nbsp;<img src=\"./images/helpicon.gif\" border=\"0\" alt=\"help\" title=\"help\" onclick=\"switchMenu('crshlp');\">";

	String sql = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = website.getRequestParameter(request,"alpha","",false);
	String alphas = UserDB.getUserDepartments(conn,user);

	// access to all alphas requires a listing of all alphas during course create
	if(alphas.toUpperCase().indexOf("*ALL") > -1){
		alphas = "*ALL";
	}

	// must be set to 30 as Banner dictates it.
	int maxTitleLength = 30;

	String help = "Create";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscrt.js"></script>
	<script language="JavaScript" type="text/javascript" src="js/textcounter.js"></script>

	<%@ include file="bigbox.jsp" %>
	<script type="text/javascript" src="../inc/ajax.js"></script>
	<script type="text/javascript" src="../inc/ajax-dynamic-list.js"></script>

	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>

<form method="post" name="aseForm" action="crscrty.jsp">
	<input type="hidden" name="campus" value="<%=campus%>">

	<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
		<tr >
			 <td colspan="2">
					<%
						String helpArg1 = "Course";
						String helpArg2 = help;
					%>
					<%@ include file="crshlpx.jsp" %>
			 </td>
		</tr>
	</table>

	<table height="90" width="90%" cellspacing='1' cellpadding='2' align="center"  border="0">

		<tr height="30">
			 <td class="textblackTH" nowrap>Campus:&nbsp;</td>
			 <td class="dataColumn"><%=campus%></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Proposer:&nbsp;</td>
			 <td class="dataColumn"><%=user%></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Alpha:&nbsp;</td>
			 <td class="dataColumn">
				<%
					if(alphas.equals("*ALL")){
						sql = aseUtil.getPropertySQL(session,"alphaidx");
						sql = aseUtil.replace(sql, "_index_", "");
						out.println(aseUtil.createSelectionBox(conn,sql,"alpha","","","",false,"onChange=\"javascript:alphaOnChange();\""));

					}
					else if (alphas != null && alphas.length() > 0){
						String[] as = alphas.split(",");
						int is = as.length;
						out.println("<select name=\"alpha\" class=\"input\" onChange=\"javascript:alphaOnChange();\">");
						out.println("<option value=\"\"></option>");
						for (int z=0;z<is;z++){
							out.println("<option value=\""+as[z]+"\">" + as[z] + "</option>");
						}
						out.println("</select>");
					}
				%>
			 </td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Number:&nbsp;</td>
			 <td>
			 <%
				out.println("<input type=\"text\" class=\'inputajax\' value=\"\" id=\"num\" name=\"num\" autocomplete=\"off\" value=\"\" onkeyup=\"ajax_showOptions(this,\'getNum\',event,\'/central/servlet/jenga\',0,document.aseForm.campus,document.aseForm.alpha,'','')\">" );
				out.println("<input type=\"hidden\" id=\"num_hidden\" name=\"num_ID\">" );
			 %>
			 <!--
			 <input type="text" class="input" id="num" name="num" value="" size="10" maxlength="4">
			 -->
			 </td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Title:&nbsp;</td>
			 <td><input type="text"
			 			class="input" id="title" name="title" value="" size="50" maxlength="<%=maxTitleLength%>"
			 			onKeyDown="textCounter(document.aseForm.title,document.aseForm.textLen,<%=maxTitleLength%>)"
			 			onKeyUp="textCounter(document.aseForm.title,document.aseForm.textLen,<%=maxTitleLength%>)">
			 			<font class="textblackth"><div id="inputCounter">Characters remaining for input: <%=maxTitleLength%>.</div></font>
			 </td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Comments:&nbsp;</td>
			 <td>
			 	<%
					String ckName = "comments";
					String ckData = "";
				%>

				<%@ include file="ckeditor02.jsp" %>

			 </td>
		</tr>

		<tr>
			 <td class="textblackTHRight" colspan="2">
					<input type="hidden" name="formName" value="aseForm">
					<input type="hidden" name="formAction" value="c">
					<input type="hidden" name="textLen" value="0">
					<input type="hidden" name="badData" value="">
					<input title="continue" type="submit" name="aseSubmit" value="Continue" class="inputsmallgray" onClick="return checkForm('s')">
					<input title="abort selected operation" type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
					<br/><br/>
			 </td>
		</tr>

		<%
			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left>" );
			out.println("				<br /><div style=\"border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;\" id=\"output\">" );

			if (alpha != null && alpha.length() > 0)
				out.println("				<p align=\"center\"><br/><br/>Loading available outlines...<img src=\"../images/spinner.gif\" alt=\"Loading available outlines...\" border=\"0\"></p>" );

			out.println("				</div>" );
			out.println("			 </td>" );
			out.println("		</tr>" );
		%>

	</table>
</form>

<%
	}

	asePool.freeConnection(conn,"crscrtx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
