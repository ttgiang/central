<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
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
		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		// turn off buttons
		document.aseForm.cmdSubmit.disabled = true;
		document.getElementById("cmdSubmit").setAttribute("class", "inputsmallgrayoff");

		document.aseForm.cmdCancel.disabled = true;
		document.getElementById("cmdCancel").setAttribute("class", "inputsmallgrayoff");

		// set processing page
		document.aseForm.action = "apprrqstx.jsp";

		// submit for processing
		document.aseForm.submit();

		return true;
	}

-->
