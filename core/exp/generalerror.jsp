<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
<HEAD>
	<link rel="stylesheet" type="text/css" href="../inc/style.css">
</HEAD>
<body topmargin="0" leftmargin="0" background="../core/images/stripes.png">
	<div id="wrapper">
		<div id="content">
			<table border="0" width="60%">
				<tr>
					<td width="05%">&nbsp;</td>
					<td width="90%">
						<br/>
						<br/>
						<h2>Application Error</h2>
						<br/>
						<br/>
						<p>Your request couldn't be processed at this time. Please try again by
						returning to the <a href="/central">Curriculum Central home page </a></p>
						<p>If you feel this is an error, report this problem to <a href="mailto:helpdesk@central.com">helpdesk@central.com</a>
						<%
							String statusCode = "";
							try{
								Throwable throwable = (Throwable)request.getAttribute("javax.servlet.error.exception");
								statusCode = ((Integer)request.getAttribute("javax.servlet.error.status_code")).toString();
							}
							catch(Exception e){
							}
						%>
						<br/><br/>
						<strong>Detail message</strong>:<br> check your input and confirm that the data entered is correct. If you are working with a selection box, make sure the value selected exists before submitting.
					</td>
					<td width="05%">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</BODY>
</html>