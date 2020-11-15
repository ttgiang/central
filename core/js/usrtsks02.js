<!--
	function checkForm(){

		if (document.aseForm.task && document.aseForm.task.value == ''){
			alert( "Task is required.");
			document.aseForm.task.focus();
			return false;
		}

		return true;
	}

	function cancelForm(){
		var sid = "";

		if (document.aseForm.user && document.aseForm.user.value != ''){
			sid = document.aseForm.user.value;
		}

		aseForm.action = "usrtsks.jsp?sid=" + sid;
		aseForm.submit();
	}

//-->