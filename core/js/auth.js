<!--
	function cancelForm(){
		aseForm.action = "authidx.jsp";
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
		if (document.aseForm.code && document.aseForm.code.value == '' ){
			alert( "Code is a required field.");
			document.aseForm.code.focus();
			return false;
		}

		if (document.aseForm.descr && document.aseForm.descr.value == '' ){
			alert( "Name is a required field.");
			document.aseForm.descr.focus();
			return false;
		}

		return true;
	}
//-->