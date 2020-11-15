<!-- 	this differs from header.jsp in that it hides the menu -->

<table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
	<tbody>
		<tr>
			<td bgcolor="#ffffff" valign="top" height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" background="/central/core/images/stripes.png">
					<!-- header -->
					<tr>
						<td class="intd" height="05%">
							<table border="0" width="100%" id="asetable2" cellspacing="0" cellpadding="3">
								<tr class="<%=(String)session.getAttribute("aseBGColor")%>BGColor">
									<td valign="top">Curriculum Central v2.0</td>
									<td class="<%=(String)session.getAttribute("aseBGColor")%>BGColor" align="right"><font color="#c0c0c0">Welcome: <%=session.getAttribute("aseUserFullName")%>&nbsp;&nbsp;&nbsp;</font></td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- header -->
					<tr>
						<td class="intd" height="90%" align="center" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="center" valign="top">
										<!-- PAGE CONTENT GOES HERE -->
										<fieldset class="FIELDSET100">
											<legend><%=fieldsetTitle%></legend>
											<br>

