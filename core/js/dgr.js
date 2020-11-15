<!--
	function cancelForm(){
		aseForm.action = "dgridx.jsp";
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
		if (document.aseForm.degreeCode && document.aseForm.degreeCode.value == '' ){
			alert( "Degree Code is a required field.");
			document.aseForm.degreeCode.focus();
			return false;
		}

		if (document.aseForm.degreeTitle && document.aseForm.degreeTitle.value == '' ){
			alert( "Degree Title is a required field.");
			document.aseForm.degreeTitle.focus();
			return false;
		}

		return true;
	}
//-->