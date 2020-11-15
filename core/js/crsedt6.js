<!--
	function cancelForm(){

		aseForm.action = "tasks.jsp";
		aseForm.submit();

	}

	function checkForm(action){

		// when more than one approval routing is available, check for a selection

		if (document.aseForm.route){

			var routeCounter = 0;

			if(document.aseForm.routeCounter){

				routeCounter = document.aseForm.routeCounter.value;

			}

			if(routeCounter > 1){
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
			else{
				if(document.aseForm.route.checked){
					document.aseForm.selectedRoute.value = document.aseForm.route.value;
				}
				else{
					alert( "Please select approval routing");
					return false;
				}
			} // routeCounter
		} // route exists

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
		document.aseForm.action = "crsedt6x.jsp";

		// submit for processing
		document.aseForm.submit();

		return false;
	}

-->
