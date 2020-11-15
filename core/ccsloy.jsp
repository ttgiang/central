<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccsloy.jsp	- confirm before saving
	*	2009.06.05
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String itm = website.getRequestParameter(request,"itm","");
	String rtn2 = website.getRequestParameter(request,"rtn2","");
	String kix = website.getRequestParameter(request,"kix","");
	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);

	String alpha = "";
	String num = "";
	String type = "";
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}

	String clr = website.getRequestParameter(request,"clr","0");
	String clrList = website.getRequestParameter(request,"clrList","0");
	String lst = website.getRequestParameter(request,"lst","");
	String outlineContent = website.getRequestParameter(request,"outlineContent","");
	String temp = "";
	String[] arr;
	int i = 0;
	try{
		arr = lst.split("//");
		for(i=0;i<arr.length;i++){
			if (arr[i] != null && !"".equals(arr[i]) && arr[i].length() > 0)
				temp += "<li>" + arr[i] + "</li>";
		}
	}
	catch(Exception e){
		out.println(e.toString());
	}

	String pageTitle = courseDB.setPageTitle(conn,"Quick SLO Entry - ",alpha,num,campus);
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/ccslo.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table width="100%" border="0">
	<tr>
		<td width="30%" valign="top">
			<fieldset class="FIELDSET280">
				<legend>Outline Information</legend>
				<%@ include file="crsedt9.jsp" %>
				<br/><br/><br/><br/><br/>
			</fieldset>
		</td>
		<td width="70%" valign="top">
			<fieldset class="FIELDSET560">
			<legend><strong>Quick SLO Entry - step 3 of 4</strong></legend>
				<form name="aseForm" method="post" action="/central/servlet/lee">
					<font class="textblackth">Verify content below and click 'Submit' to save your changes.</font><br/>
					<ul class="datacolumn">
						<%=temp%>
					</ul>
					<br/><br/>
					<font class="textblackth">New outline content</font><br/>
					<font class="datacolumn"><%=outlineContent%></font>
					<br/><br/>
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="ccslo" name="src">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="edtslo" name="rtn2">
					<input type="hidden" value="<%=lst%>" name="lst">
					<input type="hidden" value="<%=outlineContent%>" name="outlineContent">
					<input type="hidden" value="<%=itm%>" name="itm">
					<input type="hidden" value="<%=clr%>" name="clr">
					<input type="hidden" value="<%=clrList%>" name="clrList">
					<input title="continue" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				</form>
			</fieldset>
		</td>
	</tr>
</table>

<%
	asePool.freeConnection(conn,"ccsloy",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
