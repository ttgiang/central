<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	bnr.jsp
	*	2007.09.01
	**/

	String pageTitle = "Banner";
	fieldsetTitle = pageTitle;

	asePool.freeConnection(conn);
%>

<html>
<head>
	<title>Softcomplex CMS - free download</title>
	<%@ include file="ase2.jsp" %>
</head>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" bgcolor="white" marginheight="0" marginwidth="0">

<table bgcolor="#4682b4" border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	<tbody>
		<tr>
			<td height="100%">
				<table border="0" cellpadding="0" cellspacing="1" width="100%" height="100%">
					<tbody>
						<tr>
							<td bgcolor="#ffffff" valign="top" height="100%">
								<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
									<!-- header -->
									<tr>
										<td class="intd" height="05%">
											<%@ include file="../inc/header2.jsp" %>
										</td>
									</tr>
									<!-- header -->
									<tr>
										<td class="intd" height="90%" valign="center">
											<%@ include file="body.jsp" %>
											<p>&nbsp;</p>
											<p>&nbsp;</p>
											<p>&nbsp;</p>
											<p>&nbsp;</p>
										</td>
									</tr>
									<!-- footer -->
									<tr>
										<td class="intd" height="05%">
											<%@ include file="copyright.jsp" %>
										</td>
									</tr>
									<!-- footer -->
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>

<script type="text/javascript">
	tabdropdown.init("bluemenu")
</script>

</body>
</html>