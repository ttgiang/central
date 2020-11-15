			<%
				switch (currentTab){
					case TAB_BANNER :
							%>
								<%@ include file="crsedt0.jsp" %>
							<%
						break;
					case TAB_COURSE :
					case TAB_CAMPUS :
							%>
								<tr>
									<td class="textblackTH">
										<table width="100%" border="0">
											<tr>
												<td colspan="3">
													<%@ include file="crsedt13.jsp" %>
												</td>
											</tr>
											<tr>
												<td class="textblackTH" width="70%" valign="top"><br/><%=displaySeq+courseTabCount%>.&nbsp;<%=question%>&nbsp;<%=extraHelp%>
													<img src="images/helpicon.gif" border="0" alt="show help for current question" title="show help for current question" onclick="switchMenu('crshlp');">
												</td>
												<td width="15%">&nbsp;</td>
												<td width="15%" align="right" nowrap valign="top">

													<%
														if (question_friendly.equals(Constant.COURSE_ALPHA) || question_friendly.equals(Constant.COURSE_NUM)){
															String facultyCanRenameRenumber = Util.getSessionMappedKey(session,"FacultyCanRenameRenumber");

															RenameDB renameDB = new RenameDB();

															if (!renameDB.isMatch(conn,campus,courseAlpha,courseNum)
																&& facultyCanRenameRenumber.equals(Constant.ON)
																&& !ApproverDB.approvalInProgress(conn,kix)){

																String renameTitle = "";
																String renameType = "";

																if (question_friendly.equals(Constant.COURSE_ALPHA)){
																	renameTitle = "rename outline";
																	renameType = "a";
																}
																else if (question_friendly.equals(Constant.COURSE_NUM)){
																	renameTitle = "renumber outline";
																	renameType = "n";
																}

																if (!renameType.equals(Constant.BLANK)){
																	out.println("<br><a href=\"crsrnmxx.jsp?cps="+campus+"&kix="+kix+"&type=PRE&sa="+courseAlpha+"&sn="+courseNum+"&st="+renameType+"&ts="+currentTab+"&no="+currentSeq+"\" class=\"linkcolumn\"><img src=\"../images/rename.png\" title=\""+renameTitle+"\" alt=\""+renameTitle+"\" border=\"0\"></a>&nbsp;");
																}
															} // facultyCanRenameRenumber

															renameDB = null;

														} // if alpha or num

														// get any help files for the campus
														String fileName = (String)session.getAttribute("asePageName");
														if (fileName == null || fileName.length() == 0){
															fileName = HelpDB.getPageHelp(conn,"crsedt",campus);
															session.setAttribute("asePageName",fileName);
														}

														// compare items
														session.setAttribute("aseLinker",
																						Encrypter.encrypter(	"kix="+kix+","
																					+	"key1="+question_friendly));
														out.println("<a href=\"crscmpi.jsp\" onclick=\"asePopUpWindow(this.href,'aseCrsedt2','800','600','yes','center');return false\" onfocus=\"this.blur()\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/compare.gif\" border=\"0\" alt=\"compare outline item\" title=\"compare outline item\"></a>&nbsp;");

														// if help exists, show
														if (questionHelp != null && questionHelp.length() > 0){
															out.println("<a href=\""+questionHelp+"\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/pdf.gif\" border=\"0\" alt=\"show help instructions\" title=\"show help instructions\"></a>&nbsp;");
														}
														else{
															if (fileName != null && fileName.length() > 0){
																out.println("<a href=\""+fileName+"\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/pdf.gif\" border=\"0\" alt=\"show help instructions\" title=\"show help instructions\"></a>&nbsp;");
															}
														}
																		// if campus has it's own audio file, use it. Otherwise, use default
														if (questionAudio != null && questionAudio.length() > 0){
															out.println("<a href=\""+questionAudio+"\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/vol.gif\" border=\"0\" alt=\"show help\" title=\"show help\"></a>&nbsp;");
														}
														else{
															out.println("<a href=\"/centraldocs/docs/help/V_ModifyOutline.swf\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/vol.gif\" border=\"0\" alt=\"show help\" title=\"show help\"></a>&nbsp;");
														}

														out.println("<a href=\"crslnkdxx.jsp?kix="+kix+"&src="+question_friendly+"\" class=\"linkColumn\"><img src=\"../images/ed_link.gif\" border=\"0\" alt=\"link outline items\" title=\"link outline items\"></a>&nbsp;");
														out.println("<a href=\"vwcrsy.jsp?pf=1&kix="+kix+"\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/printer.gif\" border=\"0\" alt=\"printer friendly\" title=\"printer friendly\"></a>&nbsp;&nbsp;");

														//
														// is there a scanned archived file. a link appears if we have a scanned document
														// and no course ARC exists.
														//
														String docName = DocsDB.getDocumentPath(conn,campus,"C",courseAlpha,courseNum,"ARC");
														if(docName != null && docName.length() > 0){
															out.println("<a href=\""+docName+"\" class=\"linkColumn\" target=\"_blank\"><img src=\"../images/archive01.gif\" border=\"0\" width=\"22\" alt=\"view scanned document\" title=\"view scanned document\"></a>&nbsp;&nbsp;");
														} // docName

													%>
													<!--
													<img src="images/abc00.gif" border="0" alt="show help for current question" title="show help for current question" onclick="switchMenu('crshlpABC');">
													-->
													<img src="images/helpicon.gif" border="0" alt="show help for current question" title="show help for current question" onclick="switchMenu('crshlp');">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							<%
								if (extraButton.length() > 0 && extraData != null && extraTitle.length() > 0){
							%>
									<%@ include file="crsedt4.jsp" %>
							<%
								} // extraButton

							%>
								<tr><td>&nbsp;</td></tr>

								<tr>

									<td class="dataColumn" height="100" valign="top">

									<%
										// ----------------------------------------------------
										// default text
										// ----------------------------------------------------
										String displayedText = HTMLFormField + "<br/>" + HTMLFormFieldExplain;

										String column = "";

										if(currentTab==Constant.TAB_COURSE){
											column = CCCM6100DB.getCourseFriendlyNameFromSequence(conn,campus,currentSeq);
										}
										else{
											column = CCCM6100DB.getCampusFriendlyNameFromSequence(conn,campus,currentSeq);
										}

										if(QuestionDB.isDefaultTextPermanent(conn,campus,currentTab,column)){

											String defaultText = QuestionDB.getDefaultText(conn,campus,currentTab,column);

											if(QuestionDB.defaultTextAppends(conn,campus,currentTab,column,"A")){
												displayedText = displayedText + "<div class=\"defaultText\">" + defaultText + "</div>";
											}
											else if(QuestionDB.defaultTextAppends(conn,campus,currentTab,column,"B")){
												displayedText = "<div class=\"defaultText\">" + defaultText + "</div>" + displayedText;
											}
										} // default text

										out.println(displayedText);

									%>

									</td>
								</tr>

								<tr><td><div class="hr"></div></td>
								</tr>

								<tr>
									<td>
										<table width="100%" border="0">
											<tr>
												<td align="right" width="60%">
													<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
														<img src="../images/spinner.gif" alt="processing..." border="0">&nbsp;saving...
													</div>
												</td>
												<td align="right" width="50%" nowrap>
													<input type="hidden" value="<%=nextNo%>" name="no">
													<input type="hidden" value="<%=currentSeq%>" name="lastNo">
													<input type="hidden" value="<%=newNo%>" name="newNo">
													<input type="hidden" value="<%=currentTab%>" name="currentTab">
													<input type="hidden" value="<%=endOfThisTab%>" name="endOfThisTab">
													<input type="hidden" value="<%=recyclePage%>" name="recyclePage">

													<%
														if (!extraButton.equals(Constant.BLANK)){
													%>
														<input title="<%=extraCmdTitle%>" type="submit" value="<%=extraButton%>" <%=extraDisabled%> class="inputsmallgrayextra<%=extraClass%>" onClick="return extraForm('<%=extraForm%>','<%=extraArg%>','<%=kix%>')">
													<%
														}

														if (messagePage){
															submitDisabled = "disabled";
															submitClass = "off";
														}
													%>

													<input name="cmdEdt2Save" title="save entered data" type="submit" value="Save" <%=submitDisabled%> class="inputsmallgray<%=submitClass%>" onClick="return checkForm('s')">
													<input name="cmdEdt2Close" title="end this operation" type="submit" value="Close" class="inputsmallgray" onClick="return checkForm('f')">
													<input name="cmdEdt2Review" title="request outline review" type="submit" value="Review" <%=reviewDisabled%> class="inputsmallgray<%=reviewClass%>" onClick="return checkForm('r')">
													<input name="cmdEdt2Approval" title="request outline approval" type="submit" value="Approval" <%=approvalDisabled%> class="inputsmallgray<%=approvalClass%>" onClick="return checkForm('a')">&nbsp;

													<input type="hidden" value="q" name="formAction">
													<input type="hidden" value="aseForm" name="formName">
													<input type="hidden" value="<%=question_friendly%>" name="column">
													<input type="hidden" value="<%=questionTab%>" name="questionTab">
													<input type="hidden" value="<%=courseAlpha%>" name="alpha">
													<input type="hidden" value="<%=courseNum%>" name="num">
													<input type="hidden" value="<%=question_explain%>" name="question_explain">
													<input type="hidden" value="0" name="selectedCheckBoxes">
													<input type="hidden" value="<%=extraDataFound%>" name="extraDataFound">
													<input type="hidden" value="<%=hasRules%>" name="hasRules">
													<input type="hidden" value="<%=rulesForm%>" name="rulesForm">
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
								<%@ include file="crsedt5.jsp" %>
							<%
						break;
					case TAB_STATUS:
							%>
								<%@ include file="crsedt8.jsp" %>
							<%
						break;
					case TAB_FORMS:
							%>
								<%@ include file="crsedt4.jsp" %>
								<input type="hidden" value="<%=Constant.COURSE_FORMS%>" name="column">
								<tr><td class="dataColumn" height="100" valign="top"><%=HTMLFormField%></td></tr>
								<%@ include file="crsedt10.jsp" %>
							<%
						break;
					case TAB_ATTACHMENT:
							// needed for when attachment does not work properly and we need to come back
							session.setAttribute("aseKix",kix);
							%>
								<%@ include file="crsedt4.jsp" %>
								<%@ include file="crsedt11.jsp" %>
							<%
						break;
				}	// switch
			%>