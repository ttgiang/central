<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcrtx.jsp	create new outline.
	*	TODO: fndcrtx.js has code for checkData
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "80%";

	String pageTitle = "screen 4 of 4 - Confirm foundation course selection";

	fieldsetTitle = "Create Foundation Course";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String authors = website.getRequestParameter(request,"formSelect","");
	String foundation = website.getRequestParameter(request,"foundation","");
	String assessment = website.getRequestParameter(request,"assessment","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/fndcrty.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>

<form method="post" name="aseForm" action="fndcrtz.jsp">
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
			 <td class="textblackTH" nowrap>Outline:&nbsp;</td>
			 <td class="dataColumn"><%=alpha%> <%=num%> - <%=courseDB.getCourseItem(conn,kix,"coursetitle")%></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Description:&nbsp;</td>
			 <td class="dataColumn"><% out.println(courseDB.getCourseItem(conn,kix,"coursedescr")); %></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Foundation Type:&nbsp;</td>
			 <td class="dataColumn"><%=foundation%> - <% out.println(com.ase.aseutil.fnd.FndDB.getFoundationDescr(foundation)); %></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Assessment:&nbsp;</td>
			 <td class="dataColumn"><% out.println(assessment); %></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Co-Authors:&nbsp;</td>
			 <td class="dataColumn"><%=authors%></td>
		</tr>

		<tr>
			 <td class="textblackTHRight" colspan="2">
					<input type="hidden" name="formName" value="aseForm">
					<input type="hidden" name="formAction" value="c">
					<input type="hidden" name="kix" value="<%=kix%>">
					<input type="hidden" name="alpha" value="<%=alpha%>">
					<input type="hidden" name="foundation" value="<%=foundation%>">
					<input type="hidden" name="authors" value="<%=authors%>">
					<input type="hidden" name="num" value="<%=num%>">
					<input title="continue" type="submit" name="aseSubmit" value="Create" class="inputsmallgray" onClick="return checkForm('s')">
					<input title="abort selected operation" type="submit" name="aseCancel" id="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
					<br/><br/>
			 </td>
		</tr>

	</table>
</form>

<%
	}

	asePool.freeConnection(conn,"fndcrty",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){

		//
		// aseCancel
		//
		$("#aseCancel").click(function() {

			window.location = "fndmnu.jsp";

			return false;

		});

	}); // jq

</script>

</body>
</html>
