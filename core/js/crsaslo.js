<!--
	function aseOnLoad(idx) {
		if (idx!=""){
			var destURL = "?idx=" + idx;
			loadData(destURL);
		}
	}

	function loadData(dest) {
		var destURL = "/central/core/crsaslox.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML =xmlhttp.responseText;
			}
		}
	}
-->
