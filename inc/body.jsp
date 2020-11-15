<!-- body -->
<table border="0" cellpadding="0" cellspacing="0" id="table1">
	<tbody>
		<tr>
			<td valign="top">
				<form action="?" method="post" name="aseForm">
					<table align="center" border="0" cellpadding="0" cellspacing="0" width="100" id="table2">
						<tbody>
							<tr>
								<td class="<%=(String)session.getAttribute("aseBGColor")%>BGColor"><img src="../images/pixel.gif" border="0" height="1" width="10"></td>
								<th class="<%=(String)session.getAttribute("aseBGColor")%>BGColor" nowrap="nowrap">
									<font color="#FFFFFF">Curriculum Central Login</font><img src="../images/pixel.gif" border="0" height="1" width="20">
								</th>
								<td><img src="../images/formtab_r_<%=(String)session.getAttribute("aseBGColor")%>.gif" border="0" height="21" width="10"></td>
								<td background="../images/line_t.gif" width="60%">&nbsp;</td>
								<td background="../images/line_t.gif"><img src="../images/pixel.gif" border="0" height="1" width="10"></td>
							</tr>
							<tr>
								<td background="../images/line_l.gif"><img src="../images/pixel.gif" border="0"></td>
								<td colspan="3">
									<div id="subscribe_error" style="display: none;"></div>
									<img src="../images/pixel.gif" border="0" height="10" width="1"><br>
									<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table3">
										<tbody>
											<tr>
												<td bgcolor="#a0a0a0">
													<table border="0" cellpadding="2" cellspacing="1" width="100%" id="table4">
														<tbody>
															<tr>
																<td id="user" bgcolor="#ffffff" nowrap="nowrap">&nbsp;User ID:</td>
																<td bgcolor="#dbeaf5"><input name="user" class="input" value="<%=cookieUserName%>" type="text">
																	<!--
																		<a href="javascript:void(0);" title="Enter your UH E-mail ID"><img src="../images/btn_help.gif" border="0"></a>
																	-->
																</td>
															</tr>
															<tr>
																<td id="userpw" bgcolor="#dbeaf5">Password:</td>
																<td bgcolor="#ffffff"><input name="userpw" class="input" value="" type="password">
																	<input type="hidden" name="formName" value="aseForm">
																	<input type="hidden" name="formAction" value="Login">
																	<!--
																		<a href="javascript:void(0);" title="Enter your UH E-mail password"><img src="../images/btn_help.gif" border="0"></a>
																	-->
																</td>
															</tr>
														</tbody>
													</table>
												</td>
											</tr>
											<tr>
												<td><br><div align="center"><font color="red"><%= (String)session.getAttribute("aseApplicationMessage")%></font></div><br>Log in with your UH username and password. Your username should be all lowercase.</td>
											</tr>
										</tbody>
									</table>
									<img src="../images/pixel.gif" border="0" height="10" width="1"><br>
								</td>
								<td background="../images/line_r.gif"><img src="../images/pixel.gif" border="0"></td>
							</tr>
							<tr>
								<td class="<%=(String)session.getAttribute("aseBGColor")%>BGColor"><img src="../images/formtab_b_<%=(String)session.getAttribute("aseBGColor")%>.gif" border="0" height="20"></td>
								<td colspan="4" align="right" class="<%=(String)session.getAttribute("aseBGColor")%>BGColor">
									<table border="0" cellpadding="0" cellspacing="0" id="table5">
										<tbody>
											<tr>
												<td bgcolor="#dbeaf5">
													<input name="Submit" value="Submit" style="border: 0px none ; background: rgb(219, 234, 245) none repeat scroll 0%; height: 17px; width: 100px; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;" type="submit">
												</td>
												<td><img src="../images/pixel.gif" border="0" height="18" width="1"></td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</td>
		</tr>
	</tbody>
</table>
<!-- body -->
