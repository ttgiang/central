<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sa.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String sendMail = "";

	String mail = website.getRequestParameter(request,"mail","");
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		if ("0".equals(mail) || "1".equals(mail)){
			if ("0".equals(mail))
				mail = "NO";
			else
				mail = "YES";

			SysDB.updateSys(conn,"sendMail",mail);
		}

		// only the system admin can tweak certain settings
		if (SQLUtil.isSysAdmin(conn,user))
			sendMail = MailerDB.getSendMail(conn);
	} // processPage

	String pageTitle = "System Administrations";
	fieldsetTitle = pageTitle;

	asePool.freeConnection(conn,"sa",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/sa.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
%>
<form method="post" action="sax.jsp" name="aseForm">

	<table align="center" width="98%" border="0" id="table2" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table align="center" width="100%" border="0" id="table3" cellspacing="0" cellpadding="0">
					<tr bgcolor="#E0E0E0">
						<td width="33%"><b>Monitoring</b></td>
						<td width="34%"><b>Clean Up</b></td>
						<td width="33%"><b>Fixing Data</b></td>
					</tr>
					<tr>
						<td>
							<ul>
								<li><a href="/central/core/tg00000.jsp" class="linkcolumn">General data correction (tg00000)</a></li>
								<li><a href="/central/core/df00126.jsp" class="linkcolumn">Correct Course Progress (DF00126)</a></li>
							</ul>
						</td>
						<td>
							<ul>
								<li><a href="samllg.jsp" class="linkcolumn">Clean Mail Log</a></li>
								<li><a href="sahstlg.jsp" class="linkcolumn">Clean History Logs</a></li>
							</ul>
						</td>
						<td>
							<ul>
								<li><a href="crsxprt.jsp" class="linkcolumn" target="_blank">Export Campus Data</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<tr>
			<td>
				<table align="center" width="100%" border="0" id="table3" cellspacing="0" cellpadding="0">
					<tr bgcolor="#E0E0E0">
						<td colspan="2"><b>Table Maintenance</b></td>
						<td width="33%">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2">
							<ul>
								<li>Create HTML&nbsp;&nbsp;
									<ul>
										<li><a href="##" onClick="return checkFormX('sax','all')" class="linkcolumn">All</a></li>
										<li><a href="##" onClick="return checkFormX('sax','diff')" class="linkcolumn">Differential</a></li>
										<li><a href="##" onClick="return checkFormX('sax','frce')" class="linkcolumn">Force</a></li>
										<li><a href="df00000.jsp?type=CUR" class="linkcolumn">CUR</a> (re-create CUR HTML for a campus)</li>
										<li><a href="df00000.jsp?type=PRE" class="linkcolumn">PRE</a> (re-create PRE HTML for a campus)</li>

										<!--
										<li><a href="##" onClick="return checkFormX('sax','pre')" class="linkcolumn">PRE</a></li>
										-->

										<li>
											<%
												String alphabets = Constant.ALPHABETS;
												String[] aAlphabets = alphabets.split(",");

												for(int z=0; z<aAlphabets.length; z++){
													out.println("<a href=\"sax.jsp?tsk=idx&idx="+aAlphabets[z]+"\" class=\"linkcolumn\">" + aAlphabets[z] + "</a>"
																	+ "&nbsp;<font class=\"copyright\">|</font>&nbsp;");
												}
											%>
										</li>
										<li>
											<form method="post" action="sax.jsp" name="aseFormOutlines">
												Campus:&nbsp;&nbsp;<input type="text" name="cps" class="input50" maxlength="4">&nbsp;&nbsp;
												Alpha:&nbsp;&nbsp;<input type="text" name="alpha" class="input50" maxlength="4">&nbsp;&nbsp;
												Number:&nbsp;&nbsp;<input type="text" name="num" class="input50" maxlength="4">&nbsp;&nbsp;
												Type:&nbsp;&nbsp;<input type="text" name="type" class="input50" maxlength="4">&nbsp;&nbsp;
												<input type="hidden" value="outline" name="tsk">
												&nbsp;&nbsp;<input type="submit" name="cmdGo" class="input" value="Go">
											</form>
										</li>
									</ul>
								</li>
							</ul>
						</td>
						<td>
							<ul>
								<li><a href="##" onClick="return checkFormX('sax','fco')" class="linkcolumn">Fill Campus Outlines</a></li>
								<li><a href="/central/servlet/sa?c=fill" class="linkcolumn">Fill Missing Questions to Campuses</a></li>
								<li><a href="##" onClick="return checkFormX('sax','ft')" class="linkcolumn">Fill Tabs</a></li>
								<li><a href="##" onClick="return checkFormX('sax','fd')" class="linkcolumn">Fill Debugs</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<!-- MAINTENANCE -->
		<tr bgcolor="#E0E0E0">
			<td>
				<table align="center" width="100%" border="0" id="table2" cellspacing="0" cellpadding="0">
					<tr>
						<td width="33%"><b>Maintenance</b></td>
						<td width="34%"><b>&nbsp;</b></td>
						<td width="33%"><b>Sandbox</b></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table align="center" width="100%" border="0" id="table2" cellspacing="0" cellpadding="0">
					<tr>
						<td width="33%" valign="top">
							<ul>
								<li><a href="/central/core/dfqsts.jsp" class="linkcolumn">Course Item Definition</a></li>
								<li><a href="/central/core/crttpl.jsp" class="linkcolumn">Create Outline Template</a></li>
								<li><a href="/central/core/crsfld.jsp" class="linkcolumn">Display Course Content (raw data)</a></li>
								<li><a href="/central/servlet/sa?c=cccm" class="linkcolumn">Reset Course Questions To CCCM</a></li>
								<li><a href="/central/core/lsttsks.jsp" class="linkcolumn">User Tasks</a></li>
								<li><a href="/central/core/verifySQL.jsp" class="linkcolumn">Verify SQL</a></li>
							</ul>
						</td>
						<td width="34%" valign="top">
							<ul>
								<li><a href="/central/core/cccm6100.jsp" class="linkcolumn">View Available CCCM Questions</a></li>
								<li>Update Banner
									<ul>
										<li>
												<a href="/central/core/updbnr.jsp?x=af" class="linkcolumn">alpha (test)</a>
												&nbsp;|&nbsp;
												<a href="/central/core/updbnr.jsp?x=at" class="linkcolumn">alpha (write)</a>
										</li>
										<li><a href="/central/core/updbnr.jsp?x=b" class="linkcolumn">banner</a></li>
										<li><a href="/central/core/updbnr.jsp?x=st" class="linkcolumn">banner supporting tables</a></li>
										<li><a href="/central/core/updbnr.jsp?x=o" class="linkcolumn">outlines</a></li>
									</ul>
								</li>
							</ul>
						</td>
						<td width="33%" valign="top">
							<ul>
								<li><a href="faq/faq.jsp" class="linkcolumn">CC Answers!</a></li>
								<li><a href="ccsetup.jsp" class="linkcolumn">CC Setup<a></li>
								<li><a href="forum/dsplst.jsp" class="linkcolumn">Message Board</a></li>
								<li><a href="srch.jsp" class="linkcolumn">Search...</a></li>
								<li><a href="/central/core/dbg.jsp" class="linkcolumn">Debug Settings</a></li>
								<li><a href="/central/core/sys.jsp" class="linkcolumn">Global Settings</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</td>
		</tr>

		<!-- LOGS -->
		<tr>
			<td bgcolor="#E0E0E0"><b>Logs</b></td>
		</tr>
		<tr>
			<td>
				<ul>
					<li><a href="/central/core/crslg.jsp" class="linkcolumn">CC Logs</a></li>
					<li><a href="/central/servlet/sa?c=lgs&l=" class="linkcolumn">CCv2</a></li>
				</ul>
			</td>
		</tr>

		<!-- TEMPLATES -->
		<tr>
			<td bgcolor="#E0E0E0"><b>Templates</b></td>
		</tr>
		<tr>
			<td>
				<ul>
					<li><a href="crttpl.jsp" class="linkcolumn">Create Outline Template</a></li>
				</ul>
			</td>
		</tr>

		<!-- WORK IN PROGRESS -->
		<tr>
			<td bgcolor="#E0E0E0"><b>Work in Progress</b></td>
		</tr>
		<tr>
			<td>
				<table align="center" width="100%" border="0" id="table2" cellspacing="0" cellpadding="0">
					<tr>
						<td width="33%" valign="top">
							<ul>
								<li><a href="ntfidx.jsp" class="linkcolumn">Email Properties</a></li>
								<li><a href="expand.jsp" class="linkcolumn">One Page Course Outline</a></li>
								<li><a href="testupld.jsp" class="linkcolumn">File Upload</a></li>
							</ul>
						</td>
						<td width="34%" valign="top">
							<ul>
								<li><a href="stats.jsp" class="linkcolumn">Outline Status</a></li>
								<li><a href="dlt.jsp" class="linkcolumn">Permanently Delete Outline</a></li>
							</ul>
						</td>
						<td width="33%" valign="top">
							<ul>
								<li><a href="testlogs.jsp" class="linkcolumn">Process Logs</a></li>
								<li><a href="rqstidx.jsp" class="linkcolumn">Request</a></li>
								<li><a href="xml.jsp" class="linkcolumn">XML Export</a></li>
								<li><a href="export.jsp" class="linkcolumn">System Export</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<input type="hidden" value="c" name="formAction">
	<input type="hidden" value="aseForm" name="formName">
</form>

<%
	}
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
