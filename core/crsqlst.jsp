<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsqlst.jsp	- 	quick list entry
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Quick List Entry";
	fieldsetTitle = pageTitle;

	String alphaIdx = aseUtil.getPropertySQL(session,"alphas");
	String alphaList = aseUtil.createSelectionBox(conn,alphaIdx,"alpha","","","",false,"");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsqlst.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p>
	<font class="textblackth">Use this screen to quickly add lists to Curriculumn Central</font>&nbsp;&nbsp;
	<img src="images/helpicon.gif" border="0" alt="show import help" title="show import help" onclick="switchMenu('importHelp');">
</p>

<div id="importHelp" style="width: 100%; display:none;">
	<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="60%">
		<TBODY>
			<TR>
				<TD class=title-bar width="50%"><font class="textblackth">List Import</font></TD>
				<td class=title-bar width="50%" align="right">
					<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('importHelp');">
				</td>
			</TR>
			<TR>
				<TD colspan="2">

					<p>
						List imports may be applied to a department/division or a single alpha.
						<ul>
							<li>Division/department - select the division/department to apply the list to. Once you confirm
							the list is correct, the final submit will process your data and apply the list content to a division/department.
							<li>Alpha - select Alpha to have the list applied to a particular alpha. For example, to apply the list to
							all ENG courses, select ENG in the alpha list box.
						</ul>
					</p>

				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>

<%
	if (processPage){
%>
<form name="aseForm" method="post" action="/central/servlet/list" ENCTYPE="multipart/form-data">
	<table width="60%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td width="10%" valign="top" class="textblackth">Campus:</td>
			<td width="90%" valign="top" class="datacolumn"><%=campus%></td>
		</tr>
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td width="10%" valign="top" class="textblackth">Type:</td>
			<td width="90%" valign="top" class="datacolumn">
				<select class="inputsmall" name="type">
					<option value="">-select-</option>
<!--
<option value="<%=Constant.COURSE_INSTITUTION_LO%>">Institution Learning Outcomes</option>
-->
					<option value="<%=Constant.COURSE_PROGRAM_SLO%>">Program Learning Outcomes</option>
					<option value="<%=Constant.COURSE_OBJECTIVES%>">Student Learning Outcomes</option>
				</select>
			</td>
		</tr>
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td width="10%" valign="top" class="textblackth">Division:</td>
			<td width="90%" valign="top" class="datacolumn">
				<%
					String sql = aseUtil.getPropertySQL(session,"prgdivision");
					if ( sql != null && sql.length() > 0 ){
						sql = aseUtil.replace(sql, "_campus_", campus);
						out.println(aseUtil.createSelectionBox(conn,sql,"division","",false));
					}
				%>
			</td>
		</tr>
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td width="10%" valign="top" class="textblackth">Alpha:</td>
			<td width="90%" valign="top" class="datacolumn"><%=alphaList%></td>
		</tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td height="30" width="100%" valign="top" colspan="2">
				<h3 class="subheader">Option 1 - type in your data</h3>
				<br/>Paste your list in the box below then separate each item with double slashes (//).<br/>
				Finalize the list by	removing all unnecessary text and spaces.
				<textarea name="lst" cols="110" rows="15" class="input"></textarea>
				<h3 class="subheader">Option 2 - import from a file</h3>
				<input type="file" name="file1" size="50" id="file1" class="upload" />
			</td>
		</tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td height="30" width="100%" valign="top" colspan="2" align="right">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="aseForm" name="formName">
				<input type="hidden" value="crsqlst" name="src">
				<input type="hidden" value="msg3" name="rtn">
				<input title="continue" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
				<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td colspan="2" valign="top" class="datacolumn">
				Program Learning Outcomes - requires division and/or alpha. When alpha is omitted, CC will auto fill alpha with division.
			</td>
		</tr>
	</table>
</form>

<%
	}
%>

<%@ include file="../inc/footer.jsp" %>

<%
	asePool.freeConnection(conn,"crsqlst",user);
%>

</body>
</html>
