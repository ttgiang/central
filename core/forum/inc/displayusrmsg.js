<!--

	var g_Div;

	function notifiedOff(div) {

		g_Div = div;

		var url = "/central/core/forum/notified.jsp?div=" + div;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", url);
		xmlhttp.send(null);
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				if (document.getElementById(g_Div)){
					document.getElementById(g_Div).style.visibility = "hidden";
				}
			}
		}
	}

	function processedOff(div) {

		g_Div = div;

		var url = "/central/core/forum/processed.jsp?div=" + div;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggeredProcessedOff;
		xmlhttp.open("GET", url);
		xmlhttp.send(null);
	}

	function triggeredProcessedOff() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				if (document.getElementById(g_Div)){
					document.getElementById(g_Div).style.visibility = "hidden";
				}
			}
		}
	}

	//
	//
	//
	function collapseResponse(){

		document.getElementById("proposerResponse").innerHTML = "";
		document.getElementById("proposerResponse").style.visibility = "hidden";

		return false;

	}

	//
	// userResponse
	//
	function expandResponse(kix,tab,item){

		document.getElementById("proposerResponse").style.visibility = "hidden";

		var url = "dspitm.jsp?kix="+kix+"&tab="+tab+"&itm="+item;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggerResponse;
		xmlhttp.open("GET", url);
		xmlhttp.send(null);

		document.getElementById("proposerResponse").style.visibility = "visible";

		return false;

	}

	//
	//trigger
	//
	function triggerResponse() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("proposerResponse").innerHTML = xmlhttp.responseText;
			}
		}
	}


-->
