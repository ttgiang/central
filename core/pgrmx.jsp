<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	pgrmx.jsp	- confirm adding new list
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Quick List Program SLO Entry";
	fieldsetTitle = pageTitle;

	String clrList = website.getRequestParameter(request,"clrList","0");
	String alpha = website.getRequestParameter(request,"alpha","");
	String lst = website.getRequestParameter(request,"lst","");
	String temp = "";
	String[] arr;
	int i = 0;
	try{
		arr = lst.split("//");
		for(i=0;i<arr.length;i++){
			if (arr[i] != null && !"".equals(arr[i]))
				temp += "<li>" + arr[i] + "</li>";
		}
	}
	catch(Exception e){
		out.println(e.toString());
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/pgrmx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p><font class="textblackth">Verify content below and click 'Submit' to save your changes.</font><p/>

<table width="60%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="10%" valign="top" class="textblackth">Campus:</td>
		<td width="90%" valign="top" class="datacolumn"><%=campus%></td>
	</tr>
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="10%" valign="top" class="textblackth">Alpha:</td>
		<td width="90%" valign="top" class="datacolumn"><%=alpha%></td>
	</tr>
	<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="100%" valign="top" colspan="2">
			<font class="textblackth">Program SLO</font><br/>
			<ul class="datacolumn">
				<%=temp%>
			</ul>
			<br/><br/>
			<form name="aseForm" method="post" action="pgrmy.jsp">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="aseForm" name="formName">
				<input type="hidden" value="pslo" name="src">
				<input type="hidden" value="<%=lst%>" name="lst">
				<input type="hidden" value="<%=alpha%>" name="alpha">
				<input type="hidden" value="<%=clrList%>" name="clrList">
				<input title="continue" type="submit" value="Submit" class="inputsmallgray">&nbsp;
				<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
			</form>
		</td>
	</tr>
</table>

<%
	asePool.freeConnection(conn,"pgrmx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
