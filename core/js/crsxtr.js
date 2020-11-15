<!--
	function aseSubmitClick(dest) {

		var alphax = document.aseForm.alpha_ID.value;
		var numx = document.aseForm.numbers_ID.value;

		var alpha = document.aseForm.alpha.value;
		var num = document.aseForm.numbers.value;

		if(alphax == "" && alpha != "")
			alphax = alpha;

		if(numx == "" && num != "")
			numx = num;

		if(alphax == ""){
			alert("Please select existing course alpha.");
			document.aseForm.alpha.focus();
			return false;
		}

		if(numx == ""){
			alert("Invalid or missing course number.");
			document.aseForm.numbers.focus();
			return false;
		}

		document.aseForm.alpha_ID.value = alphax;
		document.aseForm.numbers_ID.value = numx;

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick2(id,alpha,num) {
		document.aseForm.reqID.value = id;
		document.aseForm.alpha_ID.value = alpha;
		document.aseForm.numbers_ID.value = num;

		if (confirm('Delete Record?')){
			document.aseForm.act.value = "r";
			document.aseForm.submit();
			return true;
		}

		return false;
	}

	function aseSubmitClick3(id,alphax,numx,grading) {

		document.aseForm.reqID.value = id;

		document.aseForm.alpha_ID.value = alphax;
		document.aseForm.numbers_ID.value = numx;

		document.aseForm.alpha.value = alphax;
		document.aseForm.numbers.value = numx;

		document.aseForm.grading.value = grading;
	}

	function aseOnLoad() {
		var alpha = document.aseForm.thisAlpha.value;
		var num = document.aseForm.thisNum.value;
		var table = document.aseForm.thisTable.value;
		var type = document.aseForm.thisType.value;

		var destURL = "?alpha=" + alpha + "&num=" + num + "&table=" + table + "&type=" + type;

		loadData(destURL);
	}

	function cancelForm(kix,tab,no,caller,campus){

		if(caller == 'crsedt'){
			aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
		}
		else if(caller == 'crsfldy'){
			aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
		}

		aseForm.submit();

	}

	function loadData(dest) {
		var destURL = "/central/core/crsxtridx.jsp" + dest;

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
