<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		if (document.aseForm.alpha && document.aseForm.alpha.value == '' ){
			alert( "Alpha is required.");
			document.aseForm.alpha.focus();
			return false;
		}

		if (document.aseForm.lst && document.aseForm.lst.value == '' ){
			alert( "Program SLO content is required.");
			document.aseForm.lst.focus();
			return false;
		}

		return true;
	}

	function alphaOnChange() {

		var alpha = document.aseForm.alpha.value;

		if (alpha != ""){
			var destURL = "?alpha=" + alpha;
			loadData(destURL);
		}
	}

	function loadData(dest) {

		var destURL = "/central/core/crspslow.jsp" + dest;

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
