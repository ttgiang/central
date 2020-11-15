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

			if (document.aseForm.campusUser && document.aseForm.campusUser.value==''){
				alert("Invalid approver selection");
				document.aseForm.campusUser.focus();
				return false;
			}

			return true;
		}
//-->