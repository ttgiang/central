<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcrtw.jsp	create new outline.
	*	TODO: fndcrtw.js has code for checkData
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "80%";

	fieldsetTitle = "Create Foundation Course";

	String sql = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	String courseTitle = "";

	String kix = website.getRequestParameter(request,"kix","");
	if (!kix.equals(Constant.BLANK)){
		//
		// on create, we don't have this info so get it from helper
		//
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		courseTitle = info[Constant.KIX_COURSETITLE];
	}

	String pageTitle = "screen 2 of 4 - Select foundation type";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>

<form method="post" name="aseForm" action="fndcrtx.jsp">
	<table height="90" width="96%" cellspacing='4' cellpadding='4' align="center"  border="0">

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
			 <td class="dataColumn"><%=alpha%> <%=num%> - <%=courseTitle%></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Description:&nbsp;</td>
			 <td class="dataColumn"><% out.println(courseDB.getCourseItem(conn,kix,"coursedescr")); %></td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Foundation Type:&nbsp;</td>
			 <td class="dataColumn">
			 	<%
					out.println(com.ase.aseutil.fnd.FndDB.drawFndRadio(conn,"foundation",""));
			 	%>
			 </td>
		</tr>

		<tr height="30">
			 <td class="textblackTH" nowrap>Assessment:&nbsp;</td>
			 <td class="dataColumn">
			 	<%
						String ckName = "assessment";
						String ckData = "";
			 	%>
				<%@ include file="ckeditor02.jsp" %>
			 </td>
		</tr>

		<tr>
			 <td class="textblackTHRight" colspan="2">
					<input type="hidden" name="formName" value="aseForm">
					<input type="hidden" name="formAction" value="c">
					<input type="hidden" name="kix" value="<%=kix%>">
					<input type="hidden" name="alpha" value="<%=alpha%>">
					<input type="hidden" name="num" value="<%=num%>">
					<input title="continue" type="submit" name="aseSubmit" value="Continue" class="inputsmallgray" onClick="return checkForm('s')">
					<input title="abort selected operation" type="submit" name="aseCancel" id="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
					<br/><br/>
			 </td>
		</tr>

	</table>
</form>

<%
	}

	asePool.freeConnection(conn,"fndcrtw",user);
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
