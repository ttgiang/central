<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

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
		document.aseForm.action = "prgedt6y.jsp";

		// submit for processing
		document.aseForm.submit();

		return true;
	}

-->
