<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<%@ page import="com.ase.aseutil.*"%>

<%
	/**
	*	ASE
	*	crscan.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	String campus = "";
	String user = "";

	String chromeWidth = "60%";
	String pageTitle = "";
	String thisPage = "";
	String fieldsetTitle = "";
	String disabled = "";
	String off = "";

	//asePool.freeConnection(conn,"crscan",user);
%>

<html>
<head>
	<title>My Secret Santa</title>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/ss.js"></script>
</head>
<body topmargin="0" leftmargin="0" background="../images/ss.jpg" text="#0000CC">
<br />

<p align="center">
	<table border="0" width="100%" id="table1" height="90%">
		<tr>
			<td height="20%">&nbsp;</td>
		</tr>
		<tr>
			<td height="50%" align="center">
				<form method="post" action="ssy.jsp" name="aseForm">

					<fieldset class="FIELDSET50">
						<legend><font color="#000">Secret Santa - screen 2 of 4</font></legend>

						<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
							<TBODY>
								<TR>
									<TD align="center">
										<br/>
										<strong>Enter your name:</strong>
										<br/><br/>
										<input type="text" name="name" class="input">
									</TD>
								</TR>

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
										<input id="cmdYes" title="continue with request" type="submit" <%=disabled%> value="Next" class="inputsmallgray<%=off%>" onClick="return checkFormX('s')">&nbsp;
										<input id="cmdNo"  title="end requested operation" type="submit" <%=disabled%> value="Cancel" class="inputsmallgray<%=off%>" onClick="return cancelForm()">
										<input type="hidden" value="c" name="formAction">
										<input type="hidden" value="aseForm" name="formName">
									</TD>
								</TR>
							</TBODY>
						</TABLE>

					</fieldset>

				</form>
			</td>
		</tr>
		<tr>
			<td height="30%">&nbsp;</td>
		</tr>
	</table>
</p>

</body>
</html>
