<!--
	function cancelForm(){
		var kix = document.aseForm.kix.value;
		aseForm.action = "crsbk.jsp?kix="+kix;
		document.aseForm.submit();
		return true;
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

		return true;
	}

-->
