<%
	// hide the menu if we are coming here from any place other than starting with forum
	String origin = AseUtil.nullToBlank((String)session.getAttribute("aseOrigin"));
	if (!origin.equals(Constant.COURSE) && !origin.equals(Constant.PROGRAM)){
%>

<%
	if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") || Util.getSessionMappedKey(session,"CreateDefects").equals(Constant.ON)){
%>
	<div id="forum_wrapper">
		  <div id="forum_header">
				::&nbsp;&nbsp;

					<%
						if (aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") || Util.getSessionMappedKey(session,"CreateDefects").equals(Constant.ON)){
							out.println("<a href=\"auto.jsp?src=add\" class=\"bluelinkcolumn\">add</a>");
						}
					%>

					<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

					<%
						if (src.equals(Constant.ENHANCEMENT)){
					%>
						<font class="copyrightdark">enhancement requests</font>
					<%
						}
						else{
					%>
						<a href="dsplst.jsp?src=<%=Constant.ENHANCEMENT%>" class="bluelinkcolumn">enhancement requests</a>
					<%
						}
					%>

					<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

					<%
						if (src.equals(Constant.DEFECT)){
					%>
						<font class="copyrightdark">defect reporting</font>
					<%
						}
						else{
					%>
							<a href="dsplst.jsp?src=<%=Constant.DEFECT%>" class="bluelinkcolumn">defect list</a>
					<%
						}

					%>

					<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

					<%
						if (src.equals(Constant.COURSE)){
					%>
						<font class="copyrightdark">courses</font>
					<%
						}
						else{
					%>
							<a href="dsplst.jsp?src=<%=Constant.COURSE%>" class="bluelinkcolumn">courses</a>
					<%
						}

					%>

					<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

					<%
						if (src.equals(Constant.PROGRAM)){
					%>
						<font class="copyrightdark">programs</font>
					<%
						}
						else{
					%>
							<a href="dsplst.jsp?src=<%=Constant.PROGRAM%>" class="bluelinkcolumn">programs</a>
					<%
						}

					%>

					<font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>

					<%
						if (src.equals(Constant.TODO)){
					%>
						<font class="copyrightdark">to do</font>
					<%
						}
						else{
					%>
							<a href="dsplst.jsp?src=<%=Constant.TODO%>" class="bluelinkcolumn">to do</a>
					<%
						}

					%>


				<%
					} // origin
				%>

				<%

					if (!src.equals("add") && !src.equals("edt")){
						out.println(Html.BR() + Html.BR() + ForumDB.showSubMenu(conn,campus,user,src,status));
					}
				%>

			</div>

			<div id="forumHelp" style="width: 100%; display:none;">
				<p>&nbsp;</p>
				<TABLE class=page-help border=0 cellSpacing=0 cellPadding=6 width="100%">
					<TBODY>
						<TR>
							<TD class=title-bar width="50%"><font class="textblackth">Message Forum</font></TD>
							<td class=title-bar width="50%" align="right">
								<img src="../../images/images/buttonClose.gif" border="0" alt="close help window" title="close help window" onclick="switchMenu('forumHelp');">
							</td>
						</TR>
						<TR>
							<TD colspan="2">
								<h2>What is a Message Board</h2>
								<p>
									Curriculum Central's (CC) message board is the central point for data collection and discussion. It is a 2-way communication intended
									to give users the opportunity to discuss outlines, programs and other CC related topics.
								</p>

							<br/>
							</TD>
						</TR>
					</TBODY>
				</TABLE>
			</div>

<%
	}
%>

<p align="left">


