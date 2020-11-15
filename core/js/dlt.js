<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm()	{

		if (document.aseForm.alpha.value == "" ){
			alert("Please select course alpha.");
			aseForm.alpha.focus();
			return false;
		}

		if (document.aseForm.num.value == "" ){
			alert("Please enter course number.");
			aseForm.num.focus();
			return false;
		}

		if (document.aseForm.type.value == "" ){
			alert("Please select course type.");
			aseForm.type.focus();
			return false;
		}

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
		var destURL = "/central/core/dltx.jsp" + dest;

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
