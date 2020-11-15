					<table width="90%" cellspacing="0" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
						<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
							 <td class="textblackTH" nowrap colspan=3><br /><p align="left">1) Select an least 1 item from the lists below<br>2) Click add to start your assessment</p><br/></td
						</tr>
						<tr height="170" class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
							 <td align="left" valign="bottom" width="33%">
								<fieldset class="FIELDSET240">
									<legend>Content</legend>
									<select class="smalltext" name="list1" size="10">
										<%
											try{
												StringBuffer contentBuffer = ContentDB.getContents(conn,campus,alpha,num,"PRE");
												if ( contentBuffer != null )
													out.println(contentBuffer.toString());
											}
											catch (Exception e){
												out.println( e.toString() );
											}
										%>
									</select>
								</fieldset>
							 </td>

							 <td align="left" valign="bottom" width="33%">
								<fieldset class="FIELDSET240">
									<legend>Competency (SLO)</legend>
									<select class="smalltext" name="list2" size="10">
										<%
											try{
												//TODO: coursetype?
												StringBuffer compBuffer = CompDB.getCompsAsHTMLOptions(conn,alpha,num,campus,"PRE");
												if ( compBuffer != null )
													out.println(compBuffer.toString());
											}
											catch (Exception e){
												out.println( e.toString() );
											}
										%>
									</select>
								</fieldset>
							 </td>

							 <td align="left" valign="bottom" width="33%">
								<fieldset class="FIELDSET240">
									<legend>Assessment</legend>
									<select class="smalltext" name="list3" size="10">
										<%
											try{
												StringBuffer assessmentBuffer = AssessDB.getAssessmentsAsHTMLOptions(conn,campus);
												if ( assessmentBuffer != null )
													out.println(assessmentBuffer.toString());
											}
											catch (Exception e){
												out.println( e.toString() );
											}
										%>
									</select>
								</fieldset>
							 </td>
						</tr>
						<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
							 <td class="textblackTHCenter" align="center" colspan="3"><br/>
									<input type="submit" name="aseSubmit" value="Add" class="inputsmallgray" onClick="return validateForm('a')">
									<input type="submit" name="aseRemove" value="Remove" class="inputsmallgray" onClick="return validateForm('r')">
									<input type="submit" name="aseCancel" value="Close" class="inputsmallgray" onClick="return cancelForm()">
							 </td>
						</tr>
					</table>
