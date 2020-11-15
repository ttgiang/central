<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// NEED TO WORK OUT PROGRESS BAR

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Test Upload";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script language="javascript">
	var req;

	function ajaxFunction()
	{
		var url = "/central/servlet/upload";

		if (window.XMLHttpRequest) // Non-IE browsers
		{
			req = new XMLHttpRequest();
			req.onreadystatechange = processStateChange;

			try
			{
				req.open("GET", url, true);
			}
			catch (e)
			{
				alert(e);
			}
			req.send(null);
		}
		else if (window.ActiveXObject) // IE Browsers
		{
			req = new ActiveXObject("Microsoft.XMLHTTP");

			if (req)
			{
				req.onreadystatechange = processStateChange;
				req.open("GET", url, true);
				req.send();
			}
		}
	}

	function processStateChange()
	{
		/**
		 *	State	Description
		 *	0		The request is not initialized
		 *	1		The request has been set up
		 *	2		The request has been sent
		 *	3		The request is in process
		 *	4		The request is complete
		 */
		if (req.readyState == 4)
		{
			if (req.status == 200) // OK response
			{
				var xml = req.responseXML;

				// No need to iterate since there will only be one set of lines
				var isNotFinished = xml.getElementsByTagName("finished")[0];
				var myBytesRead = xml.getElementsByTagName("bytes_read")[0];
				var myContentLength = xml.getElementsByTagName("content_length")[0];
				var myPercent = xml.getElementsByTagName("percent_complete")[0];

				// Check to see if it's even started yet
				if ((isNotFinished == null) && (myPercent == null))
				{
					document.getElementById("initializing").style.visibility = "visible";

					// Sleep then call the function again
					window.setTimeout("ajaxFunction();", 100);
				}
				else
				{
					document.getElementById("initializing").style.visibility = "hidden";
					document.getElementById("progressBarTable").style.visibility = "visible";
					document.getElementById("percentCompleteTable").style.visibility = "visible";
					document.getElementById("bytesRead").style.visibility = "visible";

					myBytesRead = myBytesRead.firstChild.data;
					myContentLength = myContentLength.firstChild.data;

					if (myPercent != null) // It's started, get the status of the upload
					{
						myPercent = myPercent.firstChild.data;

						document.getElementById("progressBar").style.width = myPercent + "%";
						document.getElementById("bytesRead").innerHTML = myBytesRead + " of " +
							myContentLength + " bytes read";
						document.getElementById("percentComplete").innerHTML = myPercent + "%";

						// Sleep then call the function again
						window.setTimeout("ajaxFunction();", 100);
					}
					else
					{
						document.getElementById("bytesRead").style.visibility = "hidden";
						document.getElementById("progressBar").style.width = "100%";
						document.getElementById("percentComplete").innerHTML = "Done!";
					}
				}
			}
			else
			{
				alert(req.statusText);
			}
		}
	}
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	if (processPage){
%>

	<iframe id="uploadFrameID" name="uploadFrame" height="0" width="0" frameborder="0" scrolling="yes"></iframe>
	<form id="myForm" enctype="multipart/form-data" method="post" target="uploadFrame" action="/central/servlet/upload" onsubmit="ajaxFunction()">
	    <input type="file" name="txtFile" id="txtFile" class="input" size="100" /><br/>
	    <input type="submit" id="submitID" name="submit" class="input" value="Upload" />
	</form>

	<!-- Add hidden DIVs for updating and the progress bar (just a table) below the form -->
	<div id="initializing" style="visibility: hidden; position: absolute; top: 100px;">
		<table width="100%" style="border: 1px; background-color: black;">
			<tr>
				<td>
					<table width="100%" style="border: 1px; background-color: black; color: white;">
						<tr>
							<td align="center">
								<b>Initializing Upload...</b>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>

	<div id="progressBarTable" style="visibility: hidden; position: absolute; top: 100px;">
		<table width="100%" style="border: 1px; background-color: black; color: white;">
			<tr>
				<td>
					<table id="progressBar" width="0px"
						style="border: 1px; width: 0px; background-color: lightblue;">
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table width="100%" style="background-color: white; color: black;">
			<tr>
				<td align="center" nowrap="nowrap">
					<span id="bytesRead" style="font-weight: bold;">&nbsp;</span>
				</td>
			</tr>
		</table>
	</div>

	<div id="percentCompleteTable" align="center"
		style="visibility: hidden; position: absolute; top: 100px;">
		<table width="100%" style="border: 1px;">
			<tr>
				<td>
					<table width="100%" style="border: 1px;">
						<tr>
							<td align="center" nowrap="nowrap">
 								<span id="percentComplete" style="color: white; font-weight: bold;">&nbsp;</span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
   	</div>

<%

	}

	asePool.freeConnection(conn,"","");
%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
