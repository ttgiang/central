					<tr><td>
						<br/>
							<input type="hidden" value="" name="questions">
								<TABLE cellSpacing=0 cellPadding=3 width="100%" border=0>
									<TBODY>
										<TR><TD class="textblackTH" width="15%">INSTITUTION:</TD><TD class="dataColumn" colspan="5"><%=banner.getINSTITUTION()%></TD></TR>
										<TR><TD class="textblackTH">ALPHA:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_ALPHA()%></TD></TR>
										<TR><TD class="textblackTH">NUMBER:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_NUMBER()%></TD></TR>
										<TR><TD class="textblackTH">EFFECTIVE_TERM:</TD><TD class="dataColumn" colspan="5"><%=banner.getEFFECTIVE_TERM()%></TD></TR>
										<TR><TD class="textblackTH">TITLE:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_TITLE()%></TD></TR>
										<TR><TD class="textblackTH">LONG_TITLE:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_LONG_TITLE()%></TD></TR>
										<TR><TD class="textblackTH">DIVISION:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_DIVISION()%></TD></TR>
										<TR><TD class="textblackTH">DEPT:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_DEPT()%></TD></TR>
										<TR><TD class="textblackTH">COLLEGE:</TD><TD class="dataColumn" colspan="5"><%=banner.getCRSE_COLLEGE()%></TD></TR>
										<TR><TD class="textblackTH">MAX_RPT_UNITS:</TD><TD class="dataColumn" colspan="5"><%=banner.getMAX_RPT_UNITS()%></TD></TR>
										<TR><TD class="textblackTH">REPEAT_LIMIT:</TD><TD class="dataColumn" colspan="5"><%=banner.getREPEAT_LIMIT()%></TD></TR>
										<TR>
											<TD class="textblackTH" width="15%">CREDIT_HIGH:</TD><TD class="dataColumn" width="15%"><%=banner.getCREDIT_HIGH()%></TD>
											<TD class="textblackTH" width="15%">CREDIT_LOW:</TD><TD class="dataColumn" width="15%"><%=banner.getCREDIT_LOW()%></TD>
											<TD class="textblackTH" width="15%">CREDIT_IND:</TD><TD class="dataColumn" width="15%"><%=banner.getCREDIT_IND()%></TD>
										</TR>
										<TR>
											<TD class="textblackTH" width="15%">CONT_HIGH:</TD><TD class="dataColumn" width="15%"><%=banner.getCONT_HIGH()%></TD>
											<TD class="textblackTH" width="15%">CONT_LOW:</TD><TD class="dataColumn" width="15%"><%=banner.getCONT_LOW()%></TD>
											<TD class="textblackTH" width="15%">CONT_IND:</TD><TD class="dataColumn" width="15%"><%=banner.getCONT_IND()%></TD>
										</TR>
										<TR>
											<TD class="textblackTH" width="15%">LAB_HIGH:</TD><TD class="dataColumn" width="15%"><%=banner.getLAB_HIGH()%></TD>
											<TD class="textblackTH" width="15%">LAB_LOW:</TD><TD class="dataColumn" width="15%"><%=banner.getLAB_LOW()%></TD>
											<TD class="textblackTH" width="15%">LAB_IND:</TD><TD class="dataColumn" width="15%"><%=banner.getLAB_IND()%></TD>
										</TR>
										<TR>
											<TD class="textblackTH" width="15%">LECT_HIGH:</TD><TD class="dataColumn" width="15%"><%=banner.getLECT_HIGH()%></TD>
											<TD class="textblackTH" width="15%">LECT_LOW:</TD><TD class="dataColumn" width="15%"><%=banner.getLECT_LOW()%></TD>
											<TD class="textblackTH" width="15%">LECT_IND:</TD><TD class="dataColumn" width="15%"><%=banner.getLECT_IND()%></TD>
										</TR>
										<TR>
											<TD class="textblackTH" width="15%">OTH_HIGH:</TD><TD class="dataColumn" width="15%"><%=banner.getOTH_HIGH()%></TD>
											<TD class="textblackTH" width="15%">OTH_LOW:</TD><TD class="dataColumn" width="15%"><%=banner.getOTH_LOW()%></TD>
											<TD class="textblackTH" width="15%">OTH_IND:</TD><TD class="dataColumn" width="15%"><%=banner.getOTH_IND()%></TD>
										</TR>
									</TBODY>
								</TABLE>
					</td></tr>
					<tr>
						<td align="right"><div class="hr"></div>
							<input type="hidden" value="<%=currentTab%>" name="currentTab">
							<input type="submit" value="Close" class="inputsmallgray" onClick="return checkForm('f')">
							<input type="submit" value="Review" class="inputsmallgray" onClick="return checkForm('r')">
							<input type="submit" value="Approval" <%=approvalDisabled%> class="inputsmallgray<%=approvalClass%>" onClick="return checkForm('a')">
							<input type="hidden" value="q" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
							<input type="hidden" value="<%=courseAlpha%>" name="alpha">
							<input type="hidden" value="<%=courseNum%>" name="num">
						</td>
					</tr>
