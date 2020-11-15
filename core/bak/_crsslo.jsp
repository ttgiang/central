<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsslo.jsp	-	SLO Assessment - connect content --> slo --> assessments. Works with crscntidx.jsp
	*	TODO need to tie this together and save
	*	TODO need to set type the right way
	*	TODO type shouldn't be as PRE. Use variable
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "80%";
	String pageTitle = "";
	String thisPage = "crsslo";
	String type = "PRE";

	String message = "";
	String alpha = "";
	String num = "";
	String campus = (String)session.getAttribute("aseCampus");
	String user = (String)session.getAttribute("aseUserName");
	String kix = website.getRequestParameter(request,"kix");
	String url = "";

	session.setAttribute("aseApplicationMessage","");

	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];

		// check to see if SLO exists?
		// if no, create default
		SLODB.createSLO(conn,campus,alpha,num,user,kix);

		if (SLODB.sloProgress(conn,kix,"MODIFY") || SLODB.sloProgress(conn,kix,"INPROGRESS")){
			/*
				when in MODIFY status, we convert to ASSESS and create
				default entries (done in crscntidx.jsp --> AssessedDataDB.listAssessment)
				this IF should only be completed once
			*/
			message = "";
		}
		else if (!SLODB.sloProgress(conn,kix,"ASSESS")){
			message = "You are not authorized to assess this SLO or it is not assessable at this time.<br><br>";
			url = "msg.jsp?nomsg=1&kix=" + kix + "&campus=" + campus;
		}
	}
	else{
		url = "index.jsp";
	}

	session.setAttribute("aseApplicationMessage",message);
	asePool.freeConnection(conn);

	if ("".equals(url)){
		pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
		fieldsetTitle = "Outline SLO Assessment";
	}
	else{
		response.sendRedirect(url);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script language="JavaScript" src="js/crsslo.js"></script>
</head>
<body topmargin="0" leftmargin="0" onload="aseOnLoad('<%=kix%>');">

<%@ include file="../inc/header.jsp" %>

<%
	if (message.length()==0){
		try{
		%>
			<form method="post" name="aseForm" action="crsslo.jsp">

				<%
					if (!"LEE".equals(campus)){
				%>
					<%@ include file="crsslox.jsp" %>
				<%
					}
				%>

				<input type="hidden" name="kix" value="<%=kix%>">
				<input type="hidden" name="alpha" value="<%=alpha%>">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="type" value="<%=type%>">
				<input type="hidden" name="formName" value="aseForm">
			</form>

			<table width="90%" cellspacing="0" cellpadding="2" align="center"  border="0">
				<tr>
					<td>
						<TABLE class=epi-chromeHeaderBG cellSpacing=0 cellPadding=2 width="100%" border=0>
							<TBODY>
								<TR>
									<TD class=epi-chromeHeaderFont id="" noWrap width="100%">
										<B><div align="center"><%=pageTitle%></div></B>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</td>
				</tr>
				<tr>
					 <td colspan=3 align=center>
						<br />
						<div style="border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 900px;" id="output">
							<p align=center></p>
						</div>
					 </td>
				</tr>
				<tr>
					 <td colspan=3>
						<br />
						<p>
							NOTE: Assessed By and Assessed Date are displayed only after all assessments have been approved for each SLOs.
						</p>
					 </td>
				</tr>
			</table>
		<%
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
