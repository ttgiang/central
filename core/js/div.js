<!--
	function cancelForm(){
		aseForm.action = "dividx.jsp";
		aseForm.submit();
	}

	function confirmDelete(){
		if ( document.aseForm.aseDelete ){
			if ( document.aseForm.aseDelete.value == "Delete" )
			  return confirm('Delete record?');
		}

		return false;
	}

	function checkForm(){
		if (document.aseForm.divisionCode && document.aseForm.divisionCode.value == '' ){
			alert( "Division Code is a required field.");
			document.aseForm.divisionCode.focus();
			return false;
		}

		if (document.aseForm.divisionName && document.aseForm.divisionName.value == '' ){
			alert( "Division Name is a required field.");
			document.aseForm.divisionName.focus();
			return false;
		}

		return true;
	}
//-->