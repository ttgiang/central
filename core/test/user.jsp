<!-
	@author	ase
	@version	1.0
!>
<%
	String pageTitle = "User Maintenance";
%>

<%@ include file="ase.jsp" %>

<html>
<head>
    <title><%=session.getAttribute("aseApplicationTitle")%>: User</title>
    <link rel="stylesheet" href="../inc/style.css">
</head>
<body topmargin="0" leftmargin="0">
<table align="center" width="100%" height="100%" border="0">
	<tr height="25%">
		<td>
			<tags:Header backColor="#C0C0C0" title="Learning JSP" image="images/cc4b.gif" />
		</td>
	</tr>
	<tr height="65%" valign="top">
		<td valign="top" >
			<table width="100%" height="100%" border="0">
				<tr>
					<td valign="top">
						<!-- BODY GOES HERE -->
							<%
								ase.paging.Paging paging = new ase.paging.Paging();
								paging.setTableWidth((String)session.getAttribute("aseTableWidth"));
								paging.setSQL("SELECT id, userid, access, lastname, firstname, position from tblInstructors ");
								paging.setSortOrder(aseSrt);
								paging.setOrderBy(aseCol);
								paging.SetAllignTableCell(true);
								paging.setRecordsPerPage(aseRecordsPerPage);
								paging.setDebug(true);
								out.print( paging.showRecords(conn,asePage) );
								paging = null;
								conn.close();
								conn = null;
							%>
						<!-- BODY GOES HERE -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="05%" valign="bottom">
		<td>
			<tags:Footer backColor="#C0C0C0"/>
		</td>
	</tr>
</table>
</body>
</html>
