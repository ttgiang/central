<!--

	var req;

	function ajaxFunction(){
		var url = "/central/servlet/upload";

		if (window.XMLHttpRequest) {
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
		else if (window.ActiveXObject){
			req = new ActiveXObject("Microsoft.XMLHTTP");

			if (req)
			{
				req.onreadystatechange = processStateChange;
				req.open("GET", url, true);
				req.send();
			}
		}
	}

	function processStateChange() {
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

					if (myPercent != null){
						myPercent = myPercent.firstChild.data;

						document.getElementById("progressBar").style.width = myPercent + "%";
						document.getElementById("bytesRead").innerHTML = myBytesRead + " of " + myContentLength + " bytes read";
						document.getElementById("percentComplete").innerHTML = myPercent + "%";

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
-->
