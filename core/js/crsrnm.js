<!--
	var divContent = "";
	var returnContent = "";

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

	function checkForm(action)
	{
		if ( aseForm.alpha.value == "" )
		{
			alert("Please select course alpha.");
			aseForm.alpha.focus();
			return false;
		}

		if ( aseForm.toNum.value == "" )
		{
			alert("Please select course number.");
			aseForm.toNum.focus();
			return false;
		}

		document.aseForm.formAction.value = action;

		return true;
	}

	function checkFormX(action){
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
		document.aseForm.action = "crsrnmy.jsp";

		// submit for processing
		document.aseForm.submit();

		return false;

	}

	function aseOnLoad(idx,type) {
		if (idx!="" && type!=""){
			var destURL = "?idx=" + idx + "&type=" + type;
			loadData(destURL);
		}
	}

	function loadData(dest) {
		var destURL = "/central/core/crsrnmx.jsp" + dest;

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
