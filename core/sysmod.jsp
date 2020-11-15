<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sysmod.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
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
	<script language="JavaScript" src="js/sysmod.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String named = website.getRequestParameter(request,"lid","");
	String campus = Encrypter.decrypter((String)session.getAttribute("aseCampus"));
	String user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));
	String valu = "";
	String global = "";
	String descr = "";

	// on most paging add screen, a 0 says that we have nothing so we add
	// since this is text addition, we need to clear so we can continue
	if ("0".equals(named))
		named = "";

	if (processPage){
		if (named != null && named.length() > 0){
			Sys sys = SysDB.getSysDB(conn,named);
			valu = sys.getValu();
			global = sys.getCampus();
			descr = sys.getDescr();
		}

%>

	<form method="post" name="aseForm" action="/central/servlet/sabre">
		<table height="180" width="100%" cellspacing="1" cellpadding="2" align="center"  border="0">
			<tr>
				 <td nowrap class="textblackTH">Global:&nbsp;</td>

<%
				if (named != null && named.length() > 0){
%>
				 <td class="datacolumn"><input type="hidden" name="global" value="<%=global%>"><%=global%></td>
<%
				}
				else{
%>
				 <td><input type="text" size="80" maxlength="10" class="input"  name="global" value="<%=global%>"></td>
<%
				}
%>
			</tr>

			<tr>
				 <td nowrap class="textblackTH">Name:&nbsp;</td>

<%
				if (named != null && named.length() > 0){
%>
				 <td class="datacolumn"><input type="hidden" name="named" value="<%=named%>"><%=named%></td>
<%
				}
				else{
%>
				 <td><input type="text" size="80" maxlength="50" class="input"  name="named" value="<%=named%>"></td>
<%
				}
%>
			</tr>

			<tr>
				 <td nowrap class="textblackTH">Value:&nbsp;</td>
				 <td><textarea cols="85" rows="2" class="input" name="valu"><%=valu%></textarea></td>
			</tr>

			<tr>
				 <td nowrap class="textblackTH">Description:&nbsp;</td>
				 <td><textarea cols="85" rows="2" class="input" name="descr"><%=descr%></textarea></td>
			</tr>

			<tr>
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
						<input type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="document.aseForm.formAction.value='c';">
						<input type="hidden" name="formName" value="aseForm">
				 </td>
			</tr>
		</table>
	</form>

<%
	}

	asePool.freeConnection(conn,"sysmod",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
