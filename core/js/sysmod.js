<!--
		function confirmDelete()
		{
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm(){
			if ( document.aseForm.named.value == '' ){
				alert( "Name is a required field.");
				document.aseForm.named.focus();
				return false;
			}

			if ( document.aseForm.valu.value == '' ){
				alert( "Value is a required field.");
				document.aseForm.valu.focus();
				return false;
			}

			return true;
		}
//-->