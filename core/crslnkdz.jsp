<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnkdz.jsp	course linked item matrix
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Linked Outline Item Matrix";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/linkeditems.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crslnkdz.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<p align="center">
<table border="0" width="80%">
	<tr>
		<td>
			Note: the following matrix is used to tell CC which outline items are linked together.<br/><br/>
			<ol>
				<li>Move down the first column (BLUE) and select the based outline item</li>
				<li>Now move across from the selected based item and place a check mark in as many items as necessary to establish links</li>
				<li>Repeat steps 1 and 2 to create additional links</li>
			</ol>
		</td>
	</tr>
	<tr>
		<td>
			IE: To have 'Program SLO' linked to 'Competency', locate 'Competency' as the based outline item and move across and place
			a check mark under the 'Program SLO' column.
		</td>
	</tr>
</table>
</p>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		out.println(LinkedUtil.drawLinkedItemMatrix(conn,campus));
	}

	asePool.freeConnection(conn,"crslnkdz",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
