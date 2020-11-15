<%
	// reset this page with each visit. if an announcement is available,
	// show the help icon in the footer (see footerx.jsp)
	session.setAttribute("aseAnnouncement",null);
%>

<table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
	<tbody>
		<tr>
			<td bgcolor="#ffffff" valign="top" height="100%">
				<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" background="/central/core/images/stripes.png">
					<!-- header -->
					<tr>
						<td class="intd" height="05%">
							<%@ include file="../inc/headerx.jsp" %>
						</td>
					</tr>
					<!-- header -->
					<tr>
						<td class="intd" height="90%" align="center" valign="top">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="center" valign="top">

									<%
										String announcement = "";
										int hr = 0;
										int mn = 0;
										String hour = "";			// used by ccjobsX
										String minute = "";		// used by ccjobsX

										try{
											java.util.Date today = new java.util.Date();
											java.sql.Date date = new java.sql.Date(today.getTime());
											java.util.GregorianCalendar cal = new java.util.GregorianCalendar();
											cal.setTime(date);

											int day = cal.get(java.util.Calendar.DAY_OF_WEEK);

											Format formatter;

											formatter = new SimpleDateFormat("m");
											minute = formatter.format(date);
											if (minute != null && minute.length() > 0)
												mn = Integer.parseInt(minute);

											formatter = new SimpleDateFormat("HH");
											hour = formatter.format(date);
											if (hour != null && hour.length() > 0)
												hr = Integer.parseInt(hour);

											// 1 = sunday and 7 = saturday & 20 is 8pm. This gives 2 hours of warning before 9pm
											if (day==7 && hr >= 19){
												announcement = "</br>>>> <a href=\"ccmaint.jsp\" class=\"linkcolumn\">CC will not be available from 9pm Saturday to 8am Sunday for maintenance</a>. <<<";
											}
										}
										catch(Exception z){
											// System.out.println(z.toString());
										}
									%>

									<%=announcement%>
										<!-- PAGE CONTENT GOES HERE -->
										<fieldset class="FIELDSET100">

											<%
												String helpPage = AseUtil.nullToBlank((String)session.getAttribute("aseThisPage"));
												String thisAnnouncements = HelpDB.getHelpAnnouncements(conn,"SYS","Announcement",helpPage);
												if(!thisAnnouncements.equals(Constant.BLANK)){

													session.setAttribute("aseAnnouncement","1");

											%>

													<div id="announcements" style="width: 100%; display:none;">
														<TABLE class=page-help border=0 cellSpacing=0 cellPadding=3 width="100%">
															<TBODY>
																<TR>
																	<TD class=title-bar width="50%"><font class="textblackth">Announcements</font></TD>
																	<td class=title-bar width="50%" align="right">
																		<img src="../images/images/buttonClose.gif" border="0" alt="close window" title="close window" onclick="switchMenu('announcements');">
																	</td>
																</TR>
																<TR>
																	<TD colspan="2">
																		<%
																			out.println(thisAnnouncements);
																		%>
																	</TD>
																</TR>
															</TBODY>
														</TABLE>
													</div>

											<%
												}
											%>

											<legend><%=fieldsetTitle%></legend>

