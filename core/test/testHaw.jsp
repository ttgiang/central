<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	testHaw.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Curriculum Central Demo - Hawaii CC";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String documentsURL = SysDB.getSys(conn,"documentsURL");

	asePool.freeConnection(conn,"testHaw",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table align="center" width="100%" border="0" id="table2" cellspacing="4" cellpadding="4">

	<tr>
		<td valign="top">
			<h3 class="subheader">CAFs</h3>
			<ul>
				<li><a href="hawCC/Acc 32 - New.pdf" class="linkcolumn" target="_blank">Acc 32 - New</a></li>
				<li><a href="hawCC/Acc 132 - Modify (prereqs and coreqs).pdf" class="linkcolumn" target="_blank">Acc 132 - Modify (prereqs and coreqs)</a></li>
				<li><a href="hawCC/Acc 132 - Modify (was Acc 32).pdf" class="linkcolumn" target="_blank">Acc 132 - Modify (was Acc 32)</a></li>
				<li><a href="hawCC/Fire 101 - Modify (coreq again).pdf" class="linkcolumn" target="_blank">Fire 101 - Modify (coreq again)</a></li>
				<li><a href="hawCC/Fire 101 - Modify (coreq none to some).pdf" class="linkcolumn" target="_blank">Fire 101 - Modify (coreq none to some)</a></li>
				<li><a href="hawCC/Fire 101 - New.pdf" class="linkcolumn" target="_blank">Fire 101 - New</a></li>
				<li><a href="hawCC/Fire 208 - Delete.pdf" class="linkcolumn" target="_blank">Fire 208 - Delete</a></li>
				<li><a href="hawCC/Fire 208 - Modify (prereq).pdf" class="linkcolumn" target="_blank">Fire 208 - Modify (prereq)</a></li>
				<li><a href="hawCC/Fire 208 - New.pdf" class="linkcolumn" target="_blank">Fire 208 - New</a></li>
				<li><a href="hawCC/HosT 100 - New (not approved yet).pdf" class="linkcolumn" target="_blank">HosT 100 - New (not approved yet)</a></li>
				<li><a href="hawCC/HosT 265 - New (not approved yet).pdf" class="linkcolumn" target="_blank">HosT 265 - New (not approved yet)</a></li>
				<li><a href="hawCC/Mkt 193B - Delete.pdf" class="linkcolumn" target="_blank">Mkt 193B - Delete</a></li>
				<li><a href="hawCC/Mkt 193B - Modify (title prereqs coreqs description).pdf" class="linkcolumn" target="_blank">Mkt 193B - Modify (title prereqs coreqs description).pdf</a></li>
				<li><a href="hawCC/Mkt 193B - New.pdf" class="linkcolumn" target="_blank">Mkt 193B - New</a></li>
			</ul>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
