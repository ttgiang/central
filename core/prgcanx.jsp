<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="net.fckeditor.*" %>

<%
	/**
	*	ASE
	*	prgcan.jsp - cancel program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "80%";
	fieldsetTitle = "Cancel Program";
	String pageTitle = fieldsetTitle;

	String kix = website.getRequestParameter(request,"lid", "");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String auditby = "";
	String auditdate = "";
	String title = "";
	String effectiveDate = "";
	String description = "";

	int items = 0;

	if (processPage){
		try{
			// make sure we have and id to work with. if one exists,
			// it has to be greater than 0
			Programs program = new Programs();
			if (!kix.equals("")){
				program = ProgramsDB.getProgram(conn,campus,kix);
				if ( program != null ){
					title = program.getTitle();
					effectiveDate  = program.getEffectiveDate();
					auditby = program.getAuditBy();
					auditdate = program.getAuditDate();
					description = program.getDescription();
					pageTitle = title + " - " + effectiveDate;
				}
			}
			else{
				kix = "";
				auditdate = aseUtil.getCurrentDateTimeString();
				auditby = user;
			}
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}

	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/prgcanx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>

<form method="post" action="prgcanxx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br/><br/>
					<input type="hidden" value="<%=kix%>" name="kix">
				</TD>
			</TR>
			<TR><TD align="center"><% out.println(Skew.showInputScreen(request)); %></td></tr>

			<TR>
				<TD align="center">
					<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
					<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
					</div>
				</td>
			</tr>

			<TR>
				<TD align="center">
					<br />
					<input id="cmdYes" title="continue with request" type="submit" <%=disabled%>  value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
					<input id="cmdNo" title="end requested operation" type="submit" <%=disabled%> value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%
	} // processPage

	asePool.freeConnection(conn,"prgcan",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

<DIV id="dateDiv" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;"></DIV>

</body>
</html>
