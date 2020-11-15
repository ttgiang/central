<!--
		function confirmDelete(){
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function cancelForm(){
			document.aseForm.action = "appridx.jsp?pageClr=1";
			document.aseForm.submit();
		}

		function checkForm(){

			if ( document.aseForm.note.value == '' ){
				alert( "Note is a required field.");
				document.aseForm.note.focus();
				return false;
			}

			return true;
		}
//-->