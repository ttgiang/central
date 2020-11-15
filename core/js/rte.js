<!--
	function cancelForm(){

		var rtn = "appridx.jsp";

		if (document.aseForm.rtn && document.aseForm.rtn.value=='rpt'){
			rtn = "crssts.jsp";
		}

		aseForm.action = rtn;
		aseForm.submit();

	}

	function checkForm(action){

		document.aseForm.formAction.value = action;

		if (document.aseForm.routeX && document.aseForm.routeX.value==''){
			alert("Please select new routing sequence");
			document.aseForm.routeX.focus();
		}
		else{
			// turn on progress
			if (document.getElementById("spinner")){
				document.getElementById("spinner").style.visibility = "visible";
			}

			// turn off buttons
			if(document.aseForm.cmdChange){
				document.aseForm.cmdChange.disabled = true;
				document.getElementById("cmdChange").setAttribute("class", "inputsmallgrayoff");
			}

			if(document.aseForm.cmdCancel){
				document.aseForm.cmdCancel.disabled = true;
				document.getElementById("cmdCancel").setAttribute("class", "inputsmallgrayoff");
			}

			// set processing page
			document.aseForm.action = "rtex.jsp";

			// submit for processing
			document.aseForm.submit();
		}

		return true;

	}

-->
