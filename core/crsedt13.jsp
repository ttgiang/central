<div id="crshlp" style="width: 100%; display:none;">
	<TABLE class=page-help border=0 cellSpacing=0 cellPadding=3 width="100%">
		<TBODY>
			<TR>
				<TD class=title-bar width="50%"><font class="textblackth">Course Help</font></TD>
				<td class=title-bar width="50%" align="right">
					<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('crshlp');">
				</td>
			</TR>
			<TR>
				<TD colspan="2">
					<%
						out.println(QuestionDB.getCourseHelp(conn,campus,currentTab,currentSeq));
					%>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>

<div id="crshlpABC" style="width: 100%; display:none;">
	<TABLE class=page-help border=1 cellSpacing=0 cellPadding=3 width="100%">
		<TBODY>
			<TR>
				<TD class=title-bar width="50%"><font class="textblackth">Hawaiian Characters Help</font></TD>
				<td class=title-bar width="50%" align="right">
					<img src="../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('crshlpABC');">
				</td>
			</TR>
			<TR>
				<TD colspan="2" align="center">
					<table border=1 cellspacing=0 cellpadding=0 width=400>
					 <tr>
					  <td class=headercolumn>Hawaiian</td>
					  <td class=headercolumn>HTML code</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#256;</td>
					  <td class=datacolumn>&amp;#256;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#257;</td>
					  <td class=datacolumn>&amp;#257;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#274;</td>
					  <td class=datacolumn>&amp;#274;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#275;</td>
					  <td class=datacolumn>&amp;#275;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#298;</td>
					  <td class=datacolumn>&amp;#298;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#299;</td>
					  <td class=datacolumn>&amp;#299;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#332;</td>
					  <td class=datacolumn>&amp;#332;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#333;</td>
					  <td class=datacolumn>&amp;#333;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#362;</td>
					  <td class=datacolumn>&amp;#362;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#363;</td>
					  <td class=datacolumn>&amp;#363;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>&#8216;</td>
					  <td class=datacolumn>&amp;#8216;</td>
					 </tr>
					 <tr>
					  <td colspan=2 class=headercolumn>Usage<span class=apple-converted-space>&nbsp;examples
					  </td>
					 </tr>
					 <tr>
					  <td class=datacolumn>Haleakal&#257;</td>
					  <td class=datacolumn>Haleakal&amp;#257;</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>H&#257;na</td>
					  <td class=datacolumn>H&amp;#257;na</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>K&#299;hei</td>
					  <td class=datacolumn>K&amp;#299;hei</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>M&#257;&#8216;alaea</td>
					  <td class=datacolumn>M&amp;#257;&amp;#8216;alaea</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>L&#257;na&#8216;i</td>
					  <td class=datacolumn>L&amp;#257;na&amp;#8216;i</td>
					 </tr>
					 <tr>
					  <td class=datacolumn>P&#257;&#8216;ia</td>
					  <td class=datacolumn>P&amp;#257;&amp;#8216;ia</td>
					 </tr>
					</table>

				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>
