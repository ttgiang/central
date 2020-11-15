<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		var alpha = document.aseForm.alpha.value;
		var alphax = document.aseForm.alpha_ID.value;
		var num = document.aseForm.toNum.value;

		if (alpha != null && alpha.length > 0 ){
			alpha_ID = alpha;
		}
		else if (alpha_ID != null && alpha_ID.length > 0 ){
			alpha = alpha_ID;
		}

		if (alpha != null && alpha == "" ){
			alert("Please select course alpha.");
			document.aseForm.alpha.focus();
			return false;
		}

		if (num != null && num == "" ){
			alert("Please select course number.");
			document.aseForm.toNum.focus();
			return false;
		}

		document.aseForm.formAction.value = action;

		return true;
	}

	function checkFormX(action){
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

	function aseOnLoad(idx,alpha,num) {
		if (idx!=""){
			var destURL = "?idx=" + idx + "&alpha=" + alpha + "&num=" + num;
			loadData(destURL);
		}
	}

	function loadData(dest) {
		var destURL = "/central/core/crscpyx.jsp" + dest;

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
