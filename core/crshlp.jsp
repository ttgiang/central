<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crshlp.jsp help text on edit screen
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String question = "";
	String helpTitle = "CC Help";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	int si = website.getRequestParameter(request,"n",0);
	int type = website.getRequestParameter(request,"t",0);

	if (type==-1){
		String hlp = website.getRequestParameter(request,"h");

		Help help = QuestionDB.getHelp(conn,"Course",hlp,campus);
		if (help != null){
			question = help.getContent();
			helpTitle = helpTitle + " - " + help.getTitle();
		}
	}
	else
		question = QuestionDB.getCourseHelp(conn,campus,type,si);

	asePool.freeConnection(conn,"crshlp",user);
%>

<title>Curriculum Central: Course Questions</title>

<style type='text/css'>
	#dhtmlgoodies_tooltip{
		background-color:#EEE;
		border:1px solid #000;
		position:absolute;
		display:none;
		z-index:20000;
		padding:2px;
		font-size:0.9em;
		-moz-border-radius:6px;	/* Rounded edges in Firefox */
		font-family: "Trebuchet MS", "Lucida Sans Unicode", Arial, sans-serif;
	}

	#dhtmlgoodies_tooltipShadow{
		position:absolute;
		background-color:#555;
		display:none;
		z-index:10000;
		opacity:0.7;
		filter:alpha(opacity=70);
		-khtml-opacity: 0.7;
		-moz-opacity: 0.7;
		-moz-border-radius:6px;	/* Rounded edges in Firefox */
	}
</style>

<link rel="stylesheet" type="text/css" href="/central/inc/style.css">
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
											<b><%=helpTitle%></b>
											<br>
											<table border="0" cellpadding="2">
												<tr><td valign=top><%=question%></td></tr>
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