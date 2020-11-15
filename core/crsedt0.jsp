					<tr><td>
						<br/>
							<input type="hidden" value="" name="questions">
								<TABLE cellSpacing=0 cellPadding=3 width="100%" border=0>
									<TBODY>
										<tr>
											<td>
												<%
													String courseTerm = courseDB.getCourseItem(conn,kix,Constant.COURSE_EFFECTIVETERM);
													if (courseTerm != null && !courseTerm.equals(Constant.BLANK)){
														courseTerm = "<h3 class=\"subheader\"><br>"
																		+ BannerDB.getBannerContent(campus,courseTerm,courseAlpha,courseNum);
													}
													else{
														courseTerm = "<h3 class=\"subheader\"><br><p>Banner data not found. Please make sure an effective term is available.</p><br>";
													}

													courseTerm += "<font class=\"textblack\"><br>*NOTE: Banner data is an extract from <a href=\"https://www.sis.hawaii.edu/uhdad/bwckctlg.p_disp_dyn_ctlg\" target=\"_target\" class=\"linkcolumn\">here</a>.</font><br>"
																	+ "<br></h3><br>";

													out.println(courseTerm);
												%>
											</td>
										</tr>
									</TBODY>
								</TABLE>
					</td></tr>
					<tr>
						<td align="right"><div class="hr"></div>
							<table border="0" width="100%">
								<tr>
									<td width="50%" nowrap>
										<%@ include file="crsedt12.jsp" %>
									</td>
									<td align="right">
										<input type="hidden" value="<%=currentTab%>" name="currentTab">
										<input type="submit" value="Close" class="inputsmallgray" onClick="return checkForm('f')">
										<input type="submit" value="Review" <%=reviewDisabled%> class="inputsmallgray<%=reviewClass%>" onClick="return checkForm('r')">
										<input type="submit" value="Approval" <%=approvalDisabled%> class="inputsmallgray<%=approvalClass%>" onClick="return checkForm('a')">
										<input type="hidden" value="q" name="formAction">
										<input type="hidden" value="aseForm" name="formName">
										<input type="hidden" value="<%=courseAlpha%>" name="alpha">
										<input type="hidden" value="<%=courseNum%>" name="num">
										<%
											if (approvalDisabled.equals("disabled")){
												String[] listRange = Util.getINIKeyValues(conn,campus,"OutlineApprovalBlackOutDate");
												if (listRange != null){
													out.println("<br/><br/>Outline approval is not permitted between " + listRange[0] + " and " + listRange[1] + ".");
												}
											}
										%>
									</td>
								</tr>
							</table>
						</td>
					</tr>
