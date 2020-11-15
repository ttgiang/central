<!--
		function confirmDelete()
		{
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.debuge == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm(){
			if ( document.aseForm.named.value == '' ){
				alert( "Page is a required field.");
				document.aseForm.named.focus();
				return false;
			}

			if ( document.aseForm.debug.value == '' ){
				alert( "Debug is a required field.");
				document.aseForm.debug.focus();
				return false;
			}

			return true;
		}
//-->