<!--
	var divContent = "";
	var returnContent = "";

	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkFormX(action)
	{
		document.aseForm.formAction.value = action;

		// when confirmation using skew is involved, check here
		if (document.aseForm.passLine && document.aseForm.passLineEncoded){
			if (document.aseForm.passLine.value=="" || document.aseForm.passLineEncoded.value==""){
				alert( "Invalid or missing security code.");
				document.aseForm.passLine.focus();
				return false;
			}
		}

		return true;
	}

	function aseOnLoad(idx) {
		if (idx!=""){
			var destURL = "?idx=" + idx;
			loadData(destURL);
		}
	}

	function loadData(dest) {
		var destURL = "/central/core/crslnkdx.jsp" + dest;

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

	function aseOnLoadX() {

		// course and number x-listing to
		var alpha = document.aseForm.fromAlpha.value;
		var num = document.aseForm.fromNum.value;

		var destURL = "";

		destURL = "crsxrfidx.jsp?alpha=" + alpha + "&num=" + num;
		divContent = "xlisting";
		loadData(destURL);

		destURL = "crsreqidx.jsp?alpha=" + alpha + "&num=" + num + "&type=2";
		divContent = "Co-Requisites";
		loadData(destURL);

		destURL = "crsreqidx.jsp?alpha=" + alpha + "&num=" + num + "&type=1";
		divContent = "Pre-Requisites";
		loadData(destURL);
		document.getElementById(divContent).innerHTML=returnContent;
	}

	function loadDataX(dest) {
		var destURL = "/central/core/" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);
	}

	function triggeredX() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				returnContent = xmlhttp.responseText;
				document.getElementById(divContent).innerHTML=returnContent;
			}
		}
	}

-->
