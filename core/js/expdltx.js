<!--
	function cancelForm(){

		aseForm.action = "expdlt.jsp";
		aseForm.submit();

	}

	function checkForm(action){

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
		if (document.getElementById("spinner")){
			document.getElementById("spinner").style.visibility = "visible";
		}

		// turn off buttons
		document.aseForm.cmdYes.disabled = true;
		document.getElementById("cmdYes").setAttribute("class", "inputsmallgrayoff");

		document.aseForm.cmdNo.disabled = true;
		document.getElementById("cmdNo").setAttribute("class", "inputsmallgrayoff");

		// set processing page
		document.aseForm.action = "expdltxx.jsp";

		// submit for processing
		document.aseForm.submit();

		return false;
	}

-->
