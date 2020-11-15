<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsqstq.jsp display questions index
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String legend = "";
	int tab = website.getRequestParameter(request,"ts", -1);
	int help = website.getRequestParameter(request,"h", 0);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (tab==1){
		legend = "Course";
	}
	else{
		legend = "Campus";
	}
%>

<title>Curriculum Central: Course Questions</title>

<link rel="stylesheet" type="text/css" href="/central/inc/style.css">
<link rel="stylesheet" type="text/css" href="/central/inc/bluetabs.css" />
<link rel="stylesheet" type="text/css" href="/central/inc/site.css" />
</head>
<body topmargin="0" leftmargin="0">
<table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
	<tbody>
		<tr>
			<td bgcolor="#ffffff" valign="top" height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
					<tr>
						<td class="intd" height="90%" align="center" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="" valign="top">
										<!-- PAGE CONTENT GOES HERE -->
											<b><%=legend%> Questions</b>
											<br>
											<table border="0" cellpadding="2">
											<%
												if (processPage && tab>0){
													out.println(QuestionDB.getCampusQuestion(conn,campus,tab,help));
												}

												asePool.freeConnection(conn,"crsqstq",user);
											%>
											</table>
										<!-- PAGE CONTENT ENDS HERE -->
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

</body>
</html>