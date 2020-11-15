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
			//alert( document.aseForm.formAction.value );

			if ( document.aseForm.kid.value == '' ){
				alert( "Configuration key is a required field.");
				document.aseForm.kid.focus();
				return false;
			}

			return true;
		}
//-->