<!--
		function confirmDelete()
		{
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm()
		{
			if ( document.aseForm.assessment.value == '' ){
				alert( "Assessment is a required field.");
				document.aseForm.assessment.focus();
				return false;
			}

			return true;
		}
//-->