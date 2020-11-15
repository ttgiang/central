<!--
	function cancelForm(){
		aseForm.action = "crsapprpnd.jsp";
		aseForm.submit();
	}

	function checkForm(action,approved){

		var routeCounter = 0;

		if (document.aseForm.routeCounter){
			routeCounter = document.aseForm.routeCounter.value;
		}

		if (approved=="1"){

			if (routeCounter==1){
				if(aseForm.route && !aseForm.route.checked){
					alert("Invalid routing.");
					return false;
				}
			}
			else{
				var nButton = -1;

				for (counter = 0; counter < aseForm.route.length; counter++){
					if (aseForm.route[counter].checked)
						nButton = counter;
				}

				if ( nButton == -1 ){
					alert("Invalid routing.");
					aseForm.route[0].focus();
					return false;
				}
			}
		}
		else if (approved=="0"){

			// for loop to turn all off since we are not approving
			if (routeCounter==1){
				aseForm.route.checked = false;
			}
			else{
				for (counter = 0; counter < aseForm.route.length; counter++){
					aseForm.route[counter].checked = false;
				}
			}

			if (document.aseForm.content && document.aseForm.content.value==""){
				alert("Please provide feedback to proposer.");
				document.aseForm.content.focus();
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
		document.aseForm.action = "crsapprpndy.jsp";

		// submit for processing
		document.aseForm.submit();

		return true;
	}

-->
