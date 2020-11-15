<TABLE class=epi-chromeBorder cellSpacing=0 cellPadding=1 width="<%=chromeWidth%>" border=0>
	<TBODY>
		<TR>
			<TD>
				<TABLE class=epi-chromeHeaderBG cellSpacing=0 cellPadding=4 width="100%" background=Home_files/chrome_bg.gif border=0>
					<TBODY>
						<TR>
							<TD width="30%" align="left">
								&nbsp;&nbsp;<%=outlineView%>
							</TD>
							<TD class=epi-chromeHeaderFont id="" width="40%">
								<B><div align="center"><%=pageTitle%></div></B>
							</TD>
							<TD width="30%" align="right">
								<%=printerFriendly%>&nbsp;&nbsp;
							</TD>
						</TR>
					</TBODY>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD>
				<TABLE class=epi-chromeHeaderBG cellSpacing=0 cellPadding=4 width="100%" background=Home_files/chrome_bg.gif border=0>
					<TBODY>
						<TR>
							<TD colspan="3" align="center">
								&nbsp;&nbsp;<%=detailView%>

								<%
									if(dtl==1){
								%>
									&nbsp;&nbsp;
									(
									<a class="linkcolumn" href="_vwcrsx.jsp#" onclick="ddaccordion.collapseall('technology'); return false">Collapse</a>
									<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
									<a class="linkcolumn" href="_vwcrsx.jsp#" onclick="ddaccordion.expandall('technology'); return false">Expand</a>
									)
								<%
									}
								%>

							</TD>
						</TR>
					</TBODY>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD>
				<TABLE class=epi-chromeBG cellSpacing=0 cellPadding=3 width="100%" border=0>
					<TBODY>
						<TR>
							<TD>