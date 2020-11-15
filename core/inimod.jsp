<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	inimod.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "System Settings Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/inimod.js"></script>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	int numberOfColumns = 12;
	String required = "";
	String sql;

	//
	// values here are not allowed to change once they are set to ON or YES
	//
	String locked = "EnableMessageBoard";
	String asterisk = "";
	boolean disableSubmit = false;

	int lid = website.getRequestParameter(request,"lid",0);
	String category = website.getRequestParameter(request,"c","");
	String[] sColumnValue = new String[numberOfColumns];
	String kedit = "Y";

	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

	String HTMLFormField = "";
	String kid = "";
	String kval1 = "";

	// make sure we have and id to work with. if one exists,
	// it has to be greater than 0
	if ( request.getParameter("lid") != null ){
		lid = Integer.parseInt(request.getParameter("lid"));
		if ( lid > 0 ){
			Ini ini = IniDB.getINI(conn,lid);
			if ( ini != null ){
				// -----------------------------> 3
				sColumnValue[0] = ini.getId();
				sColumnValue[1] = ini.getCategory();
				sColumnValue[2] = ini.getKid();
				sColumnValue[3] = ini.getKdesc();
				sColumnValue[4] = ini.getKval1();
				sColumnValue[5] = ini.getKval2();
				sColumnValue[6] = ini.getKval3();
				sColumnValue[7] = ini.getKval4();
				sColumnValue[8] = ini.getKval5();
				sColumnValue[9] = ini.getKedit();
				sColumnValue[10] = ini.getKlanid();
				sColumnValue[11] = ini.getKdate();
				kedit = ini.getKedit();

				kid = sColumnValue[2];
				kval1 = sColumnValue[4];
			}
		}
		else{
			lid = 0;
			// -----------------------------> 4
			sql = "0,"+category+",,,,,,,,," + user + "," + aseUtil.getCurrentDateTimeString();
			sColumnValue = sql.split(",");
		}
	}

	//
	// is this an option we allow modification?
	//
	if(locked.contains(kid)){

		if(kval1.equals(Constant.ON)){
			disableSubmit = true;
		}

		asterisk = "*";
	}

%>

		<form method="post" name="aseForm" action="/central/servlet/is">
			<table height="180" width="100%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
<%
				// on add, check whether this is a campus wide entry
				if (lid==0 && SQLUtil.isSysAdmin(conn,user)){
					HTMLFormField = aseUtil.drawHTMLField(conn,"radio","YN","campusWide","N",0,0,false,campus,false);
					out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
					out.println("					 <td class=\'textblackTH\'>System Wide:&nbsp;</td>" );
					out.println("					 <td>" + HTMLFormField + "</td>" );
					out.println("				</tr>" );
				}
%>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">ID:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[0]%></td>
				</tr>
<%
				if ( lid > 0 ){
					out.println("<tr class=\"textblackTRTheme0\">");
					out.println("<td nowrap class=\"textblackTH\">Category:&nbsp;</td>");
					out.println("<td class=\"datacolumn\"><input type=\"hidden\" name=\"category\" value=\"" + sColumnValue[1] + "\">" + sColumnValue[1] + "</td>");
					out.println("</tr>");
					out.println("<tr class=\"textblackTRTheme0\">");
					out.println("<td nowrap class=\"textblackTH\">Key:&nbsp;</td>");
					out.println("<td class=\"datacolumn\"><input type=\"hidden\" name=\"kid\" value=\"" + sColumnValue[2] + "\">" + sColumnValue[2] + asterisk + "</td>");
					out.println("</tr>");
				}
				else{
					out.println("<tr class=\"textblackTRTheme0\">");
					out.println("<td nowrap class=\"textblackTH\">Category:&nbsp;</td>");
					out.println("<td><textarea cols=\"85\" rows=\"2\" class=\"inputrequired\"  name=\"category\">"+sColumnValue[1]+"</textarea></td>");
					out.println("</tr>");
					out.println("<tr class=\"textblackTRTheme0\">");
					out.println("<td nowrap class=\"textblackTH\">Key:&nbsp;</td>");
					out.println("<td><textarea cols=\"85\" rows=\"2\" class=\"inputrequired\"  name=\"kid\">"+sColumnValue[2]+"</textarea></td>");
					out.println("</tr>");
				}
%>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Description:&nbsp;</td>

<%
				if (lid > 0){
%>
					 <td class="datacolumn"><%=sColumnValue[3]%>
					 	<input type="hidden" name="kdesc" value="<%=sColumnValue[3]%>"></td>
<%
				}
				else{
					String ckName = "kdesc";
					String ckData = "";
%>
					 <td>
						<%@ include file="ckeditor02.jsp" %>
					 </td>
<%
				}
%>


				</tr>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Value 1:&nbsp;</td>
					 <td>
					 <%
				 		String options[] = IniKeyDB.getOptionsX(conn,sColumnValue[2]);
				 		if (options != null){
							if (lid > 0 && options[0] != null && options[0].length() > 0){
								out.println(Html.drawRadio(conn,options[0],options[1],"kval1",sColumnValue[4],campus,false));
							}
						}
						else{
							out.println("<textarea cols=\"85\" rows=\"2\" class=\"input\" name=\"kval1\">" + sColumnValue[4] + "</textarea>");
						}
					 %>
					 </td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Value 2:&nbsp;</td>
					 <td><textarea cols="85" rows="2" class="input"  name="kval2"><%=sColumnValue[5]%></textarea></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Value 3:&nbsp;</td>
					 <td><textarea cols="85" rows="2" class="input"  name="kval3"><%=sColumnValue[6]%></textarea></td>
				</tr>

				<%
					// users are not allowed to touch values 4 & 5
					boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
					if ("System".equals(category) && !isSysAdmin){
						out.println("<tr class=\"textblackTRTheme0\">");
						out.println("<td nowrap class=\"textblackTH\">Value 4:&nbsp;</td>");
						out.println("<td class=\"datacolumn\"><input type=\"hidden\" name=\"kval4\" value=\""+sColumnValue[7]+"\">" + sColumnValue[7] + "</td>");
						out.println("</tr>");
						out.println("<tr class=\"textblackTRTheme0\">");
						out.println("<td nowrap class=\"textblackTH\">Value 5:&nbsp;</td>");
						out.println("<td class=\"datacolumn\"><input type=\"hidden\" name=\"kval5\" value=\""+sColumnValue[8]+"\">" + sColumnValue[8] + "</td>");
						out.println("</tr>");
					}
					else{
				%>
					<tr class="textblackTRTheme0">
						 <td nowrap class="textblackTH">Value 4:&nbsp;</td>
						 <td><textarea cols="85" rows="2" class="input"  name="kval4"><%=sColumnValue[7]%></textarea></td>
					</tr>
					<tr class="textblackTRTheme0">
						 <td nowrap class="textblackTH">Value 5:&nbsp;</td>
						 <td><textarea cols="85" rows="2" class="input"  name="kval5"><%=sColumnValue[8]%></textarea></td>
					</tr>
				<%
					}
				%>

				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Editable:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[9]%></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Updated By:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[10]%></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td nowrap class="textblackTH">Updated Date:&nbsp;</td>
					 <td class="datacolumn"><%=sColumnValue[11]%></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTH">Campus:&nbsp;</td>
					 <td class="datacolumn"><%=campus%></td>
				</tr>
				<tr class="textblackTRTheme0">
					 <td class="textblackTHRight" colspan="2"><div class="hr"></div>
							<input name="lid" type="hidden" value="<%=lid%>">
<%
							if ( lid > 0 ){
								if (kedit.equals("Y")){
									if(!disableSubmit){
										//out.println("<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
										//out.println("<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
									}
								}
								out.println("<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
							}
							else{
								//out.println("<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
								out.println("<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
							}
%>
							<input type="hidden" name="kedit" value="<%=kedit%>">
							<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="document.aseForm.formAction.value='c';">
							<input type="hidden" name="formName" value="aseForm">
					 </td>
				</tr>
			</table>
		</form>

<%
	asePool.freeConnection(conn,"inimod",user);
%>

<p></p>

<font class="textblackth">Screen Description</font>
<ul>
	<li class="textblack">Yellow text box are required entries</li>
</ul>

<font class="datacolumn">* Once enabled, the following settings may not be disabled (turned off) - <%=locked%></font>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
