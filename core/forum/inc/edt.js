<!--
	function cancelForm(){
		aseForm.action = "dsplst.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		document.aseForm.formAction.value = action;

		if (document.aseForm.status && document.aseForm.status.value == '' ){
			alert( "Status is a required field.");
			document.aseForm.status.focus();
			return false;
		}

		if (document.aseForm.src && document.aseForm.src.value == '' ){
			alert( "Category is a required field.");
			document.aseForm.src.focus();
			return false;
		}

		if (document.aseForm.forumName && document.aseForm.forumName.value == '' ){
			alert( "Title is a required field.");
			document.aseForm.forumName.focus();
			return false;
		}

		return true;
	}

-->
