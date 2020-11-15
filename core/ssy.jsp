<%@ include file="ase.jsp" %>

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
	String disabled = "";
	String off = "";

	String name = website.getRequestParameter(request,"name", "").toUpperCase();
	String availableNames = "";
	String accessNames = "";
	String selectedNames = "";
	String remainingNames = "";

	Misc misc = null;

	if (conn != null){
		misc = MiscDB.getMiscByHistoryUserID(conn,"SYS","SYS","THANHG");

		if (misc != null){
			// remove this person's name from the list of available names
			accessNames = misc.getCourseAlpha().toUpperCase();
			availableNames = misc.getCourseAlpha().toUpperCase();
			availableNames = availableNames.replace(name.toUpperCase(),"");
			availableNames = availableNames.replace(",,",",");

			if (availableNames.startsWith(","))
				availableNames = availableNames.substring(1);

			if (availableNames.endsWith(","))
				availableNames = availableNames.substring(0,availableNames.length()-1);

			selectedNames = misc.getDescr().toUpperCase();

			remainingNames = misc.getVal().toUpperCase();
			remainingNames = remainingNames.replace(name.toUpperCase(),"");
			remainingNames = remainingNames.replace(",,",",");

			if (remainingNames.startsWith(","))
				remainingNames = remainingNames.substring(1);

			if (remainingNames.endsWith(","))
				remainingNames = remainingNames.substring(0,remainingNames.length()-1);
		}

		if (accessNames != null){
			if (accessNames.toLowerCase().indexOf(name.toLowerCase()) < 0)
				processPage = false;
		}
	}

	asePool.freeConnection(conn,"ssy",user);
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
				<form method="post" action="ssz.jsp" name="aseForm">

					<fieldset class="FIELDSET50">
						<legend><font color="#000">Secret Santa - screen 3 of 4</font></legend>

						<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
							<TBODY>

								<%
									if (processPage){
								%>
									<TR>
										<TD align="center">
											<br/>
											<strong>Hi <%=name%>, click 'Next' to find your Secret Santa in the list of remaining names.</strong>
											<br/><br/>
											<table border="0" width="100%" id="table2">
												<tr>
													<td height="30" width="25%">Available names:</td>
													<td width="75%"><%=availableNames%></td>
												</tr>
												<tr>
													<td height="30" width="25%">Selected names:</td>
													<td width="75%"><%=selectedNames%></td>
												</tr>
												<tr>
													<td height="30" width="25%">Remaining names:</td>
													<td width="75%"><%=remainingNames%></td>
												</tr>
											</table>

											<br/><br/>
										</TD>
									</TR>
								<%
									}
									else{
										off = "off";
								%>
									<TR>
										<TD align="center">
											<br/>
											<strong>Hi <%=name%>, you are not permitted to this site. Click 'Cancel' to enter your name again.</strong>
											<br/><br/>
										</TD>
									</TR>

								<%
									}
								%>

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
										<input id="cmdYes" title="continue with request" type="submit" <%=disabled%> value="Next" class="inputsmallgray<%=off%>" onClick="return checkFormY('s')">&nbsp;
										<input id="cmdNo"  title="end requested operation" type="submit" <%=disabled%> value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
										<input type="hidden" value="<%=remainingNames%>" name="remainingNames">
										<input type="hidden" value="<%=name%>" name="name">
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
