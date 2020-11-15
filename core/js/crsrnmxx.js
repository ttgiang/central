<!--
	function cancelForm(){

		var ts = document.aseForm.ts.value;	// editing tab
		var no = document.aseForm.no.value;	// editing item
		var st = document.aseForm.st.value;	// alpha or number change
		var kix = document.aseForm.kix.value;

		// st comes from crsedt to change alpha or number
		// if there is a value, we go back there. if not,
		// send back to main
		if (st == ''){
			aseForm.action = "index.jsp";
		}
		else{
			if (kix == ''){
				aseForm.action = "index.jsp";
			}
			else{
				aseForm.action = "crsedt.jsp?ts="+ts+"&no="+no+"&kix="+kix;
			}
		}

		aseForm.submit();
	}

	function checkForm(action){

		var alphax = document.aseForm.alpha.value;
		var numx = document.aseForm.toNum.value;

		if (alphax != null && alphax == "" ){
			alert("Please select course alpha.");
			document.aseForm.alpha.focus();
			return false;
		}

		if (numx != null && numx == "" ){
			alert("Please select course number.");
			document.aseForm.toNum.focus();
			return false;
		}

		var ckContent = CKEDITOR.instances["justification"].getData();
		if(ckContent == ""){
			alert( "Justification is required.");
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

		document.aseForm.formAction.value = action;

		// turn on progress
		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		// turn off buttons
		document.aseForm.cmdYes.disabled = true;
		document.getElementById("cmdYes").setAttribute("class", "inputsmallgrayoff");

		document.aseForm.cmdNo.disabled = true;
		document.getElementById("cmdNo").setAttribute("class", "inputsmallgrayoff");

		// set processing page
		document.aseForm.action = "crscpyy.jsp";

		// submit for processing
		document.aseForm.submit();

		return false;
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
