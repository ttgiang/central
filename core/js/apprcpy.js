<!--

	function cancelForm(route){
		aseForm.action = "appridx.jsp?route="+route;
		aseForm.submit();
	}

	function checkForm(action){

		if (document.aseForm.shortName && document.aseForm.shortName.value == "" ){
			alert("Short name is required.");
			document.aseForm.shortName.focus();
			return false;
		}

		if (document.aseForm.longName && document.aseForm.longName.value == "" ){
			document.aseForm.longName.value = document.aseForm.shortName.value;
		}

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

		return true;
	}

-->
