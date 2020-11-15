<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />
<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
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
	String secret = "";

	String name = website.getRequestParameter(request,"name", "").toUpperCase();
	String remainingNames = website.getRequestParameter(request,"remainingNames", "");

	String[] aRemainingNames = remainingNames.split(",");
	int max = aRemainingNames.length-1;

	int ss = 0;

	Random randomGenerator = new Random();

	do{
		ss = randomGenerator.nextInt(max);
		if (ss > -1)
			secret = aRemainingNames[ss];
	} while (secret.toUpperCase().equals(name));

	remainingNames = remainingNames.replace(aRemainingNames[ss],"");
	remainingNames = remainingNames.replace(",,",",");

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
				<fieldset class="FIELDSET50">
					<legend><font color="#000">Secret Santa - screen 4 of 4</font></legend>

					<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
						<TBODY>
							<TR>
								<TD align="center">
									<br/>
									<strong>Hi <%=name%>, your Secret Santa is <%=secret.toUpperCase()%>.</strong>
									<br/><br/>
									<img src="../images/adachi/<%=secret.toLowerCase()%>.jpg" border="0">
								</TD>
							</TR>

							<TR>
								<TD align="center">
									<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
									<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
									</div>
								</td>
							</tr>

							<%
								int i, j, k;
								for (i=0;i<1000;i++){
									for (j=0;j<1000;j++){
										for (k=0;k<1000;k++){
											//
										}
									}
								}
							%>

						</TBODY>
					</TABLE>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td height="30%">&nbsp;</td>
		</tr>
	</table>

</p>

</body>
</html>
