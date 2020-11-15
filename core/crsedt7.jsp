					<TABLE id=tabs_tda cellSpacing=0 cellPadding=0 summary="course edit" border=0>
						<TBODY>
							<TR>
								<TD class="<%=sTabs[0]%>" noWrap height=20>
									<A href="?ts=0&kix=<%=kix%>" title="display banner data for <%=courseAlpha%> <%=courseNum%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Banner
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[0]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[1]%>" noWrap height=20>
									<A href="?ts=1&kix=<%=kix%>" title="display course data items for <%=courseAlpha%> <%=courseNum%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Course
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>

								<TD class="<%=sTabBg[1]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[2]%>" noWrap height=20>
								<%
									if(maxNoCampus > 0){
								%>
										<A href="?ts=2&kix=<%=kix%>" title="display campus specific data items for <%=courseAlpha%> <%=courseNum%>" target=_top>
											<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0><%=campus%>
											<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
										</A>
								<%
									}
									else{
								%>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0><font color="#c0c0c0"><%=campus%></font>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
								<%
									}
								%>
								</TD>

								<TD class="<%=sTabBg[2]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[3]%>" noWrap height=20>
									<A href="?ts=3&kix=<%=kix%>" title="display progress for <%=courseAlpha%> <%=courseNum%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Progress
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[3]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[4]%>" noWrap height=20>
									<A href="?ts=4&kix=<%=kix%>" title="display forms attached for <%=courseAlpha%> <%=courseNum%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Additional Forms
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[4]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
								<TD class="<%=sTabs[5]%>" noWrap height=20>
									<A href="?ts=5&kix=<%=kix%>" title="display attachments for <%=courseAlpha%> <%=courseNum%>" target=_top>
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>Attachments
										<IMG height=5 alt="" src="../images/tab.gif" width=11 border=0>
									</A>
								</TD>
								<TD class="<%=sTabBg[5]%>" vAlign=top align=right height=20><IMG height=20 src="../images/tab_corner_right.gif" width=8></TD>
							</TR>
						</TBODY>
					</TABLE>
