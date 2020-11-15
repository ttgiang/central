<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsqlstx.jsp	- confirm before saving NO LONGER IN USE
	*
	*	NO LONGER IN USE. crsqlst calls the processing servlet directly
	*
	*	2009.06.05
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "Quick List Entry";
	fieldsetTitle = pageTitle;

	String typeName = "";
	String alpha = website.getRequestParameter(request,"alpha","");
	String type = website.getRequestParameter(request,"type","");
	if (type.equals(Constant.COURSE_GESLO))
		typeName = "General Ed. Student Learning Outcomes";
	else if (type.equals(Constant.COURSE_INSTITUTION_LO))
		typeName = "Institution Learning Outcomes";
	else if (type.equals(Constant.COURSE_PROGRAM_SLO))
		typeName = "Program Learning Outcomes";
	else if (type.equals(Constant.COURSE_OBJECTIVES))
		typeName = "Student Learning Outcomes";

	int division = website.getRequestParameter(request,"division",0);

	String divisionName = "";
	String alphaName = "";

	// when left empty, division will take its place and vice versa
	if (type.equals(Constant.COURSE_INSTITUTION_LO)){
		alphaName = "";
		divisionName = "";
	}
	else{
		if ((Constant.BLANK).equals(alpha))
			alphaName = "[ALPHA WILL BE FILLED WITH DIVISION VALUE]";
		else
			alphaName = alpha;

		if (division == 0)
			divisionName = "[DIVISION WILL BE FILLED WITH ALPHA VALUE]";
		else
			divisionName =  DivisionDB.getDivisonNameFromID(conn,campus,division);
	} // type ILO

	String lst = website.getRequestParameter(request,"lst","");
	String fileName = website.getRequestParameter(request,"fileName","");
	String temp = "";
	String[] arr;
	int i = 0;

	if (processPage){
		try{
			if (!lst.equals(Constant.BLANK)){
				arr = lst.split("//");
			}
			else{
				arr = ("Import file name: " + fileName).split(",");
				lst = "filename:" + fileName;
			} // empty list?


			session.setAttribute("aseImportList",lst);

			for(i=0;i<arr.length;i++){
				if (arr[i] != null && !(Constant.BLANK).equals(arr[i]))
					temp += "<li>" + arr[i] + "</li>";
			}

		}
		catch(Exception e){
			//out.println(e.toString());
		}
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crsqlstx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
%>

<p><font class="textblackth">Verify content below and click 'Submit' to save your changes</font><p/>

<table width="60%" border="0" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>">
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="10%" valign="top" class="textblackth">Campus:</td>
		<td width="90%" valign="top" class="datacolumn"><%=campus%></td>
	</tr>
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="10%" valign="top" class="textblackth">Type:</td>
		<td width="90%" valign="top" class="datacolumn"><%=typeName%></td>
	</tr>
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="10%" valign="top" class="textblackth">Division:</td>
		<td width="90%" valign="top" class="datacolumn"><%=divisionName%></td>
	</tr>
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="10%" valign="top" class="textblackth">Alpha:</td>
		<td width="90%" valign="top" class="datacolumn"><%=alphaName%></td>
	</tr>
	<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="100%" valign="top" colspan="2">
			<font class="textblackth">List Content</font><br/>
			<ul class="datacolumn">
				<%=temp%>
			</ul>
		</td>
	</tr>
	<tr height="30" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
		<td width="100%" valign="top" colspan="2" align="right">
			<form name="aseForm" method="post" action="/central/servlet/list" ENCTYPE="multipart/form-data">
				<input type="hidden" value="c" name="formAction">
				<input type="hidden" value="aseForm" name="formName">
				<input type="hidden" value="qlstntr" name="src">
				<input type="hidden" value="<%=lst%>" name="lst">
				<input type="hidden" value="crsqlst" name="rtn">
				<input type="hidden" value="<%=type%>" name="type">
				<input type="hidden" value="<%=division%>" name="division">
				<input type="hidden" value="<%=alpha%>" name="alpha">
				<input title="continue" type="submit" value="Submit" class="inputsmallgray">&nbsp;
				<input title="cancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				&nbsp;&nbsp;&nbsp;&nbsp;
			</form>
		</td>
	</tr>
</table>

<%
	}

	asePool.freeConnection(conn,"crsqlstx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
