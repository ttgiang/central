					<!-- additional forms tab -->
					<tr>
						<td align="right"><div class="hr"></div>
							<input type="hidden" value="<%=currentTab%>" name="currentTab">
							<input title="attach documents" type="submit" value="Attachment" <%=submitDisabled%> class="inputsmallgray<%=submitClass%>"  onClick="return extraForm('<%=extraForm%>','<%=extraArg%>','<%=kix%>')">
							<input title="save entered data" type="submit" value="Save" <%=submitDisabled%> class="inputsmallgray<%=submitClass%>" onClick="return checkForm('s')">
							<input type="submit" value="Close" class="inputsmallgray" onClick="return checkForm('f')">
							<input type="submit" value="Review" <%=reviewDisabled%> class="inputsmallgray<%=reviewClass%>" onClick="return checkForm('r')">
							<input type="submit" value="Approval" <%=approvalDisabled%> class="inputsmallgray<%=approvalClass%>" onClick="return checkForm('a')">
							<input type="hidden" value="q" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
							<input type="hidden" value="<%=courseAlpha%>" name="alpha">
							<input type="hidden" value="<%=courseNum%>" name="num">
						</td>
					</tr>
