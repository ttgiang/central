<table border="0" width="100%" height="100%" id="table1">
	<tr>
		<td height="5%" valign="top">
			<TABLE class=epi-chromeBorder cellSpacing=0 cellPadding=1 width="100%" border=0>
				<TBODY>
					<TR>
						<TD>
							<TABLE class=epi-chromeHeaderBG cellSpacing=0 cellPadding=4 width="100%" border=0>
								<TBODY>
									<TR>
										<TD class=epi-chromeHeaderFont id="" noWrap width="100%">
											<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="table13">
												<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
													<td style="BORDER-RIGHT: #ffffff 2px solid; BORDER-TOP: #ffffff 1px solid; VERTICAL-ALIGN: middle; TEXT-ALIGN: center" height="22">
														<a href="../core/index.jsp" onmouseover="window.status='Return to home page'; return true;" onmouseout="window.status=''; return true;" title="Return to home page">Home</a>
													</td>
													<td style="BORDER-RIGHT: #ffffff 2px solid; BORDER-TOP: #ffffff 1px solid; VERTICAL-ALIGN: middle; TEXT-ALIGN: center" height="22">
														<a href="../core/crs.jsp" onmouseover="window.status='Diplay course menu'; return true;" onmouseout="window.status=''; return true;" title="Diplay course menu">Course</a>
													</td>
													<td style="BORDER-RIGHT: #ffffff 2px solid; BORDER-TOP: #ffffff 1px solid; VERTICAL-ALIGN: middle; TEXT-ALIGN: center" height="22">
														<a href="../core/prg.jsp" onmouseover="window.status='Diplay program menu'; return true;" onmouseout="window.status=''; return true;" title="Diplay program menu">Programs</a>
													</td>
													<td style="BORDER-RIGHT: #ffffff 2px solid; BORDER-TOP: #ffffff 1px solid; VERTICAL-ALIGN: middle; TEXT-ALIGN: center" height="22">
														<a href="../core/utilities.jsp" onmouseover="window.status='Diplay utilities menu'; return true;" onmouseout="window.status=''; return true;" title="Diplay utilities menu">Utilities</a>
													</td>
													<td style="BORDER-RIGHT: #ffffff 2px solid; BORDER-TOP: #ffffff 1px solid; VERTICAL-ALIGN: middle; TEXT-ALIGN: center" height="22">
														<%
															if ( session.getAttribute("aseUserName") != null )
																out.print( "<a href=\"../core/lo.jsp\">Log Out</a>" );
															else{
																//out.print( "<a href=\"https://login.its.hawaii.edu/cas/login?service=https://myserver/myapp\">Login securely</a>" );
																out.print( "<a href=\"../core/li.jsp\">Login securely</a>" );
															}
														%>
													</td>
													<td style="BORDER-TOP: #ffffff 1px solid; VERTICAL-ALIGN: middle; TEXT-ALIGN: center" height="22">
														<a href="../core/help.jsp" onmouseover="window.status='Display CC help'; return true;" onmouseout="window.status=''; return true;" title="Display CC help">Help</a>
													</td>
												</tr>
											</table>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
					</TR>
				</tbody>
			</table>

		</td>
	</tr>
	<tr>
		<td height="90%" valign="top">
			<table valign="top" border="0" width="100%" id="table14" cellspacing="0" cellpadding="0" height="100%">
				<tr height="05%" valign="top" align="center"><td>&nbsp;</td></tr>
				<tr height="95%" valign="top">
					<td>
						<div align="center">
							<!-- BODY GOES HERE -->
