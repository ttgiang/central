<!--
		function confirmDelete() {
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm(){
			if ( document.aseForm.category.value == '' ){
				alert( "Category is a required field.");
				document.aseForm.category.focus();
				return false;
			}

			if ( document.aseForm.title.value == '' ){
				alert( "Title is a required field.");
				document.aseForm.title.focus();
				return false;
			}

			return true;
		}
//-->