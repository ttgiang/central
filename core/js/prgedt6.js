<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		// when more than one approval routing is available, check for a selection
		if (document.aseForm.route){
			var numberOfRoutes = document.aseForm.route.length;
			var i = 0;
			var found = false;

			while(i < numberOfRoutes && !found){
				if (document.aseForm.route[i].checked){
					document.aseForm.selectedRoute.value = document.aseForm.route[i].value;
					found = true;
				}

				++i;
			}

			if (found == false){
				alert( "Please select approval routing");
				return false;
			}
		}

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
		var submissionForm = "prgedt6x";
		if (document.aseForm.submissionForm){
			submissionForm = document.aseForm.submissionForm.value;
		}
		document.aseForm.action = submissionForm + ".jsp";

		// submit for processing
		document.aseForm.submit();

		return true;
	}

-->
