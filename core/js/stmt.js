<!--
		function confirmDelete(){
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm(){

			if ( document.aseForm.type && document.aseForm.type.value == '' ){
				alert( "Name is a required field.");
				document.aseForm.type.focus();
				return false;
			}

			var ckContent = CKEDITOR.instances["statement"].getData();
			if(ckContent == ""){
				alert( "Statement is a required field.");
				return false;
			}

			return true;
		}
//-->