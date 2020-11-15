<table border="0" cellpadding="3" cellspacing="0" height="22" width="100%">
	<tbody>
		<tr class="<%=(String)session.getAttribute("aseBGColor")%>BGColor">
		<%
			String aseConfig = "";
			int yearFooter = 0;

			try{
				java.util.Date todayFooter = new java.util.Date();
				java.sql.Date dateFooter = new java.sql.Date(todayFooter.getTime());
				java.util.GregorianCalendar calFooter = new java.util.GregorianCalendar();
				calFooter.setTime(dateFooter);
				yearFooter = calFooter.get(java.util.Calendar.YEAR);

				// identify a screen as cnfigurable
				aseConfig = (String)session.getAttribute("aseConfig");
				if (aseConfig != null && "1".equals(aseConfig))
					aseConfig = "<a href=\"/central/core/crscfg.jsp\" class=\"linkcolumn\" onclick=\"asePopUpWindow(this.href,'aseWinFooter','800','600','no','center');return false\" onfocus=\"this.blur()\"><font class=\"copyright\">configurable</font></a>";
			}
			catch(Exception z){
			}

			String helpLinkPage = "";
			try{
				helpLinkPage = (String)session.getAttribute("aseThisPage");
			}
			catch(Exception z){
			}
		%>

			<td nowrap="nowrap" class="copyright" width="35%">Copyright &copy; 1997-<%=yearFooter%>. All rights reserved</td>
			<td align="center" nowrap="nowrap" class="copyright" width="30%">Curriculum Central (CC) - <%=(String)session.getAttribute("aseCampusName")%></td>
			<td align="right" width="35%">
				<%=aseConfig%>
				<font class="copyright">|</font>&nbsp;<a href="/central/core/contact.jsp" class="linkcolumn"><font class="copyright">contact</font></a>
				<font class="copyright">|</font>&nbsp;<a href="/central/core/support.jsp" class="linkcolumn"><font class="copyright">support</font></a>
				<font class="copyright">|</font>&nbsp;<a href="/central/core/vwhlp.jsp?page=<%=helpLinkPage%>" class="linkcolumn" onclick="asePopUpWindow(this.href,'aseHelpWin','600','600','yes','center');return false" onfocus="this.blur()"><font class="copyright">help</font></a>
				<%
					if ( (String)session.getAttribute("aseUserRights") != null &&
						Integer.parseInt((String)session.getAttribute("aseUserRights")) == 3 ){
				%>
					<font class="copyright">|</font>&nbsp;<a href="/central/core/sess.jsp" class="linkcolumn"><font class="copyright">profile</font></a>
				<%
					}

					// userLevel comes from headerx
					int userLevelFooter = com.ase.aseutil.NumericUtil.getNumeric(session,"aseUserRights");
					if (userLevelFooter == com.ase.aseutil.Constant.CAMPADM || userLevelFooter == com.ase.aseutil.Constant.SYSADM){
				%>
					<font class="copyright">|</font>&nbsp;<a href="/central/core/ini.jsp?category=system" class="linkcolumn"><font class="copyright">settings</font></a>
				<%
					}

					if (userLevelFooter == com.ase.aseutil.Constant.SYSADM){
				%>
					<font class="copyright">|</font>&nbsp;<a href="/central/core/sa.jsp" class="linkcolumn"><font class="copyright">sysadm</font></a>
					<font class="copyright">|</font>&nbsp;<a href="/central/core/ccjobs.jsp" class="linkcolumn"><font class="copyright">jobs</font></a>
				<%
					}

				%>

				<%
					String aseAnnouncement = "";

					try{
						aseAnnouncement = com.ase.aseutil.AseUtil.nullToBlank((String)session.getAttribute("aseAnnouncement"));

						if(aseAnnouncement.equals("1")){
					%>
						<font class="copyright">|</font>&nbsp;<img src="/central/core/images/helpicon.gif" border="0" alt="announcements" title="announcements" onclick="switchMenu('announcements');">
					<%
						}
					}
					catch(Exception e){
						//
					}
				%>

				&nbsp;
			</td>
		</tr>
	</tbody>
</table>
