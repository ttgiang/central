<!--
	function aseSubmitClick(dest) {

		var alphax = document.aseForm.alpha_ID.value;
		var numx = document.aseForm.numbers_ID.value;
		var num = document.aseForm.numbers.value;

		if(alphax == ""){
			alert("Please select existing course alpha.");
			document.aseForm.alpha.focus();
			return false;
		}

		// when entering using ajax, numx is the ajax value
		// and num contains the 100 - description

		// if numx is empty and num is just a number, that's valid
		// if num contains a dash, invalid
		if(numx == "" && num == ""){
			alert("Invalid or missing course number.");
			document.aseForm.numbers.focus();
			return false;
		}
		else{
			if(numx == "" && num != "" && num.indexOf("-")<0)
				document.aseForm.numbers_ID.value = num;
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClickX(dest) {

		// course and number to x-list
		var alphax = document.aseForm.alpha_ID.value;
		var numx = document.aseForm.numbers_ID.value;

		// course and number x-listing to
		var alpha = document.aseForm.thisAlpha.value;
		var num = document.aseForm.thisNum.value;

		var destURL = "?act=" + dest;

		loadData(destURL + "&alpha=" + alpha + "&num=" + num + "&ax=" + alphax + "&nx=" + numx);
	}

	function aseOnLoad() {

		// course and number x-listing to
		var alpha = document.aseForm.thisAlpha.value;
		var num = document.aseForm.thisNum.value;

		var destURL = "?alpha=" + alpha + "&num=" + num;

		loadData(destURL);
	}

	function aseSubmitClick2(alphax,numx) {
		document.aseForm.alpha_ID.value = alphax;
		document.aseForm.numbers_ID.value = numx;

		if (confirm('Delete Record?')){
			document.aseForm.act.value = "r";
			document.aseForm.submit();
			return true;
		}

		return false;
	}

	function aseSubmitClick3(id,alphax,numx) {
		document.aseForm.reqID.value = id;

		document.aseForm.alpha_ID.value = alphax;
		document.aseForm.numbers_ID.value = numx;

		document.aseForm.alpha.value = alphax;
		document.aseForm.numbers.value = numx;
	}

	function cancelFormx(alpha,num,tab,no){
		aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&alpha=" + alpha + "&num=" + num;
		aseForm.submit();
	}

	function cancelForm(kix,tab,no,caller,campus){

		if(caller == 'crsedt'){
			aseForm.action = caller + ".jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
		}
		else if(caller == 'crsfldy'){
			aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
		}

		aseForm.submit();

	}

	function loadData(dest) {

		var destURL = "/central/core/crsxrfidx.jsp" + dest;

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
