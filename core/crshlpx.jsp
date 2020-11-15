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
						out.println(QuestionDB.getScreenHelp(conn,helpArg1,helpArg2,campus));
 					%>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</div>
