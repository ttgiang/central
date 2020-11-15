<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	valmod.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "System Table Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/valmod.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	int numberOfColumns = 13;
	int columnCounter = 0;
	String required = "";
	String sql;

	int lid = website.getRequestParameter(request,"lid",0);
	String topic = website.getRequestParameter(request,"c","");
	String subtopic = website.getRequestParameter(request,"s","");
	String[] sColumnValue = new String[numberOfColumns];

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String HTMLFormField = "";

	// make sure we have and id to work with. if one exists,
	// it has to be greater than 0
	if ( lid > 0 ){
		Values values = ValuesDB.getValues(conn,lid);
		if ( values != null ){
			// -----------------------------> 3
			columnCounter = -1;
			sColumnValue[++columnCounter] = values.getId()+"";
			sColumnValue[++columnCounter] = values.getTopic();
			sColumnValue[++columnCounter] = values.getSubTopic();
			sColumnValue[++columnCounter] = NumericUtil.intToString(values.getSeq());
			sColumnValue[++columnCounter] = values.getShortDescr();
			sColumnValue[++columnCounter] = values.getLongDescr();
			sColumnValue[++columnCounter] = values.getAuditBy();
			sColumnValue[++columnCounter] = values.getAuditDate();
		}
	}
	else{
		lid = 0;
		// -----------------------------> 4
		sql = "0,"+topic+","+subtopic+",,," + user + "," + aseUtil.getCurrentDateTimeString();
		sColumnValue = sql.split(",");
	}

	columnCounter = -1;

%>
		<form method="post" name="aseForm" action="/central/servlet/padme">
			<table height="180" width="100%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">ID:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[++columnCounter]%></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Topic:&nbsp;</td>
					 <td>
					 	<select name="topic" class="inputsmall">
					 		<% int j = ++columnCounter; %>
					 		<option value="" selected></option>
					 		<option value="<%=topic%>" <% if(sColumnValue[j].equals(topic)) out.println("selected"); %>><%=topic%></option>
					 		<option value="<%=Constant.IMPORT_COREQ%>" <% if(sColumnValue[j].equals(Constant.IMPORT_COREQ)) out.println("selected"); %>>Co-Requisites</option>
					 		<option value="<%=Constant.IMPORT_XLIST%>" <% if(sColumnValue[j].equals(Constant.IMPORT_XLIST)) out.println("selected"); %>>Cross List</option>
					 		<option value="<%=Constant.IMPORT_GESLO%>" <% if(sColumnValue[j].equals(Constant.IMPORT_GESLO)) out.println("selected"); %>>GESLO</option>
					 		<option value="<%=Constant.IMPORT_ILO%>" <% if(sColumnValue[j].equals(Constant.IMPORT_ILO)) out.println("selected"); %>>Institution LO</option>
					 		<option value="<%=Constant.IMPORT_PLO%>" <% if(sColumnValue[j].equals(Constant.IMPORT_PLO)) out.println("selected"); %>>Program SLO</option>
					 		<option value="<%=Constant.IMPORT_PREREQ%>" <% if(sColumnValue[j].equals(Constant.IMPORT_PREREQ)) out.println("selected"); %>>Pre Requisities</option>
					 		<option value="<%=Constant.IMPORT_SLO%>" <% if(sColumnValue[j].equals(Constant.IMPORT_SLO)) out.println("selected"); %>>Student LO</option>
					 	</select>
					 </td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">SubTopic:&nbsp;</td>
					 <td><input name="subTopic" type="text" class="input" size="80" value="<%=sColumnValue[++columnCounter]%>"></td>
				</tr>

				<%
					if (lid > 0){
				%>
					<tr class="textblackTRTheme0">
						 <td nowrap class="textblackTH">Sequence:&nbsp;</td>
						 <td><input name="seq" type="text" class="input" size="4" value="<%=sColumnValue[++columnCounter]%>"></td>
					</tr>
				<%
					}
					else{
				%>
					<tr class="textblackTRTheme0">
						 <td nowrap class="textblackTH">Sequence:&nbsp;</td>
						 <td class="datacolumn">TBD</td>
					</tr>
				<%
					}
				%>


				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Short Description:&nbsp;</td>
					 <td><textarea cols="85" rows="8" class="input"  name="shortDescr"><%=sColumnValue[++columnCounter]%></textarea></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Long Description:&nbsp;</td>
					 <td><textarea cols="85" rows="8" class="input"  name="longDescr"><%=sColumnValue[++columnCounter]%></textarea></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Updated By:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[++columnCounter]%></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Updated Date:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[++columnCounter]%></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTH">Campus:&nbsp;</td>
					 <td class="datacolumn"><%=campus%></td>
				</tr>

				<tr class="textblackTRTheme0">
					 <td class="textblackTHRight" colspan="2"><div class="hr"></div>
							<input name="lid" type="hidden" value="<%=lid%>">
							<input name="campus" type="hidden" value="<%=campus%>">
<%
							if ( lid > 0 ){
								out.println("<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
								out.println("<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
								out.println("<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
							}
							else{
								out.println("<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
								out.println("<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
							}
%>
							<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="document.aseForm.formAction.value='c';">
							<input type="hidden" name="formName" value="aseForm">
					 </td>
				</tr>
			</table>
		</form>

<%
	asePool.freeConnection(conn,"valmod",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
