<!--
		function confirmDelete(){
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm(){
			if (document.aseForm.lid && document.aseForm.lid.value == '' ){
				alert( "Alpha is a required field.");
				document.aseForm.lid.focus();
				return false;
			}

			if ( document.aseForm.discipline.value == '' ){
				alert( "Discipline is a required field.");
				document.aseForm.discipline.focus();
				return false;
			}

			return true;
		}
//-->