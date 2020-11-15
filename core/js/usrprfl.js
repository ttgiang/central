<!--
		function checkForm(){

			var lid = document.aseForm.lid.value;

			if ( document.aseForm.department.value == '' ){
				alert( "Department is required.");
				document.aseForm.department.focus();
				return false;
			}

			if ( document.aseForm.division.value == '' ){
				alert( "Division is required.");
				document.aseForm.division.focus();
				return false;
			}

			if ( document.aseForm.title.value == '' ){
				alert( "Invalid title.");
				document.aseForm.title.focus();
				return false;
			}

			if ( document.aseForm.position.value == '' ){
				alert( "Invalid position.");
				document.aseForm.position.focus();
				return false;
			}

			if ( document.aseForm.email.value == '' ){
				if (!IsEmail(document.aseForm.email.value)){
					alert( "Invalid email format.");
					document.aseForm.email.focus();
					return false;
				}
			}

			return true;
		}
//-->