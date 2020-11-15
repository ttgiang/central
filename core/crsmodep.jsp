<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsmodep.jsp 	popup window for process maintenance
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Compare Outlines";
	fieldsetTitle = pageTitle;

%>

<title>Curriculum Central: Course Questions</title>
</style>

<link rel="stylesheet" type="text/css" href="/central/inc/style.css">
<link rel="stylesheet" type="text/css" href="/central/inc/site.css" />
	<%@ include file="ase2.jsp" %>
</head>
<%@ include file="../inc/header4.jsp" %>

<body topmargin="0" leftmargin="0">

<table border="0" cellpadding="0" cellspacing="1" width="98%">
	<tbody>
		<tr>
			<td bgcolor="#ffffff" valign="top" height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					<tr>
						<td class="intd" height="90%" align="center" valign="top" colspan="2">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="" valign="top">
									<%
										if (processPage){
											String id = website.getRequestParameter(request,"lid","0");
											out.println(ModeDB.getProcessStep3a(conn,campus,id));
										}
									%>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</tbody>
</table>

<%
	asePool.freeConnection(conn,"crsmodep",user);
%>

<%@ include file="../inc/footer4.jsp" %>

</body>
</html>