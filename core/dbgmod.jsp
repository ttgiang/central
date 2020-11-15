<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dbgmod.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String pageTitle = "System Debug Maintenance";
	fieldsetTitle = pageTitle;
	session.setAttribute("aseApplicationMessage","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/dbgmod.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String named = website.getRequestParameter(request,"lid","");
	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

	String valu = "";
	String selection = "";

	// on most paging add screen, a 0 says that we have nothing so we add
	// since this is text addition, we need to clear so we can continue
	if (named.equals(Constant.OFF)){
		named = "";
	}

	if (processPage){
		if (named != null && named.length() > 0){

			boolean debug = DebugDB.getDebug(conn,named);
			if (debug){
				valu = "ON";
				selection = "1";
			}
			else{
				valu = "OFF";
				selection = "0";
			}
		}
%>
	<form method="post" name="aseForm" action="/central/servlet/sith">
		<table width="100%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
			<tr height="30">
				 <td nowrap class="textblackTH" width="15%">Name:&nbsp;</td>

<%
				if (named != null && named.length() > 0){
%>
				 <td class="datacolumn" valign="top"><input type="hidden" name="named" value="<%=named%>"><%=named%></td>
<%
				}
				else{
%>
				 <td class="textblackTH"><input type="text" size="80" maxlength="50" class="input"  name="named" value="<%=named%>"></td>
<%
				}
%>
			</tr>

			<tr height="30">
				 <td nowrap class="textblackTH">Debug:&nbsp;</td>
				 <td class="textblackTH"><% 	out.println(aseUtil.radioYESNO(selection,"debug",false)); %></td>
			</tr>

			<tr height="30">
				 <td class="textblackTHRight" colspan="2"><div class="hr"></div>
						<input name="named" type="hidden" value="<%=named%>">
<%
					if (processPage){
						if (named != null && named.length() > 0){
							out.println("<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
							out.println("<input type=\'submit\' name=\'aseDelete\' value=\'Delete\' class=\'inputsmallgray\' onClick=\"return confirmDelete(this.form)\">" );
							out.println("<input type=\'hidden\' name=\'formAction\' value=\'s\'>" );
						}
						else{
							out.println("<input type=\'submit\' name=\'aseInsert\' value=\'Insert\' class=\'inputsmallgray\' onClick=\"return checkForm(this.form)\">" );
							out.println("<input type=\'hidden\' name=\'formAction\' value=\'i\'>" );
						}
					}
%>
						<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="document.aseForm.formAction.value='c';">&nbsp;&nbsp;&nbsp;
						<input type="hidden" name="formName" value="aseForm">
				 </td>
			</tr>
		</table>
	</form>

<%
	}

	asePool.freeConnection(conn,"dbgmod",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
