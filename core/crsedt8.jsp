					<!-- progress tab -->
					<tr><td>
						<br/>
							<input type="hidden" value="" name="questions">
							<%@ include file="crsedt9.jsp" %>
					</td></tr>
					<tr>
						<td align="right"><div class="hr"></div>
							<input type="hidden" value="<%=currentTab%>" name="currentTab">
							<input type="submit" value="Close" class="inputsmallgray" onClick="return checkForm('f')">
							<input type="submit" value="Review" <%=reviewDisabled%> class="inputsmallgray<%=reviewClass%>" onClick="return checkForm('r')">
							<input type="submit" value="Approval" <%=approvalDisabled%> class="inputsmallgray<%=approvalClass%>" onClick="return checkForm('a')">
							<input type="hidden" value="q" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
							<input type="hidden" value="<%=courseAlpha%>" name="alpha">
							<input type="hidden" value="<%=courseNum%>" name="num">
							<br/>
							<p align="left">Note: If the above does not display properly, it is likely that required outline data is missing.</p>
						</td>
					</tr>
