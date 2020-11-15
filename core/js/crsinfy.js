<!--
	function moreHistory(c,a,n,t) {

		document.getElementById("moreHistory").style.visibility = "visible";

		var destURL = "/central/core/crsinfw.jsp?c="+c+"&a="+a+"&n="+n+"&t="+t;

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
				document.getElementById("moreHistory").innerHTML =xmlhttp.responseText;
				document.getElementById("moreHistory").style.visibility = "visible";
			}
		}
	}

	function lessHistory() {

		document.getElementById("moreHistory").innerHTML = "";
		document.getElementById("moreHistory").style.visibility = "hidden";

	}

-->
