
	function cancelForm(){
		aseForm.action = "tasks.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		aseForm.formAction.value = action;

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
