<!--
	function aseSubmitClick(dest) {

		var alphax = document.aseForm.alpha_ID.value;

		var alpha = document.aseForm.alpha.value;

		if(alphax == "" && alpha != "")
			alphax = alpha;

		if(alphax == ""){
			alert("Please select existing course alpha.");
			document.aseForm.alpha.focus();
			return false;
		}

		document.aseForm.alpha_ID.value = alphax;

		document.aseForm.ack.value = "a";

		return true;
	}

	function aseSubmitClick2(alphax,numx) {
		document.aseForm.alpha_ID.value = alphax;

		if (confirm('Delete Record?')){
			document.aseForm.ack.value = "r";
			document.aseForm.submit();
			return true;
		}

		return false;
	}

	function aseSubmitClick3(id,alphax,numx,grading,consent) {

		document.aseForm.reqID.value = id;

		document.aseForm.alpha_ID.value = alphax;

		document.aseForm.alpha.value = alphax;


		if (document.aseForm.consent && consent)
			document.aseForm.consent.checked = true;
	}

	function cancelForm(kix,tab,no){

		var src = document.aseForm.src.value;

		if (src=="X29")
			src="crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
		else if (src=="rationale")
			src="prgedt.jsp?kix=" + kix;

		aseForm.action = src;

		aseForm.submit();
	}

	function loadData(dest) {
		var destURL = "/central/core/crsX29idx.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);

		document.aseForm.alpha_ID.value = "";
		document.aseForm.numbers_ID.value = "";
		document.aseForm.alpha.value = "";
		document.aseForm.numbers.value = "";
		document.aseForm.grading.value = "";
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML =xmlhttp.responseText;
			}
		}
	}

-->
