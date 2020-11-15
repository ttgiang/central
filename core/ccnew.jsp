<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccnew.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	asePool.freeConnection(conn,"ccnew",user);

	String pageTitle = "CC Setup";
	fieldsetTitle = "CC Setup";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" cellpadding="4">
	<tr bgcolor="<%=Constant.ODD_ROW_BGCOLOR%>">
		<td width="10%" valign="top" class="textblackth">Task</td>
		<td width="90%" valign="top" class="textblackth">Description</td>
	</tr>

	<tr>
		<td width="10%" valign="top" class="datacolumn">Course Item</td>
		<td width="90%" valign="top" class="datacolumn">Starting with <a href="../inc/cccm6100.htm" class="linkcolumn">CCCM6100</a>, determine the items to include for data collection. For example,
			pre-requisites, co-requisites, learning outcomes, etc. Generally, the items included here are similar to those currently on your
			existing forms.<br/><br/>
			All campuses must have course items defined. By default, course alpha, number, and title are added automatically.
		</td>
	</tr>

	<tr bgcolor="<%=Constant.ODD_ROW_BGCOLOR%>">
		<td width="10%" valign="top" class="datacolumn">Campus Item</td>
		<td width="90%" valign="top" class="datacolumn">If there are items (data) you wish to collect but cannot find on <a href="../inc/cccm6100.htm" class="linkcolumn">CCCM6100</a>, this is where
			you will define additional items for collection.
		</td>
	</tr>

	<tr>
		<td width="10%" valign="top" class="datacolumn">Course Data</td>
		<td width="90%" valign="top" class="datacolumn">Working with the CC System Administrator, existing data in electronic form can be imported into the system to avoid input errors. Electronic forms refers
			to data in a database, or spreadsheet format. Data from a PDF or MS-Word document does not qualify since the data is not formatted in a manner suitable for automation.
			<br/><br/>As an option, consider copy-n-paste data from existing documents into CC as you go through the modificaiton process.
			<br/><br/>CC can also automate the process of importing existing program SLOs and institution learning outcomes.
		</td>
	</tr>

	<tr bgcolor="<%=Constant.ODD_ROW_BGCOLOR%>">
		<td width="10%" valign="top" class="datacolumn">Users</td>
		<td width="90%" valign="top" class="datacolumn">Similar to course data, user data can be imported provided you have something available in electronic form. For example, your campus directory or UH directory.
			<br/><br/>Users are authenticated using their UH login and CC determines what they can/cannot do.
		</td>
	</tr>

	<tr>
		<td width="10%" valign="top" class="datacolumn">System Settings</td>
		<td width="90%" valign="top" class="datacolumn">Configure CC settings to fit your campus processes. For example, the following is a partial list of CC settings.
			<br/><br/>
			<ul>
				<li>Enable outline validation - when turned on, outlines must be validated before the approval process takes place</li>
				<li>Enable text counter - display a counter showing the number of text characters available for input</li>
				<li>Enable voting buttons - enable voting options during the approval process</li>
				<li>Cancel review any time - enable to allow cancellation of an outline review at any time</li>
			</ul>
		</td>
	</tr>

	<tr bgcolor="<%=Constant.ODD_ROW_BGCOLOR%>">
		<td width="10%" valign="top" class="datacolumn">System Tables</td>
		<td width="90%" valign="top" class="datacolumn">Provide listings of specific table data in use on your campus. For example:
			<br/><br/>
			<ul>
				<li>Contact Hours - Lab, Lecture, Lecture/Lab</li>
				<li>Method of Delivery - video, in class, lectures</li>
			</ul>
		</td>
	</tr>

	<tr>
		<td width="10%" valign="top" class="datacolumn">Approval Routing</td>
		<td width="90%" valign="top" class="datacolumn">Specify the order in which outlines are approved. For example, start with the divison chair, then curriculum chair, then etc.
		</td>
	</tr>

	<tr bgcolor="<%=Constant.ODD_ROW_BGCOLOR%>">
		<td width="10%" valign="top" class="datacolumn">Linked Item</td>
		<td width="90%" valign="top" class="datacolumn">Specify how individual outline items are linked. For example, how are learning outcomes tied to program learning objectives.
		</td>
	</tr>

</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
