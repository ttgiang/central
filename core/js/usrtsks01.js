<!--
	function checkForm(){

		if (document.aseForm.code && document.aseForm.code.value == ''){
			alert("Task is required.");
			document.aseForm.code.focus();
			return false;
		}

		if (document.aseForm.alpha && document.aseForm.alpha.value == ''){
			alert("Alpha is required.");
			document.aseForm.alpha.focus();
			return false;
		}

		if (document.aseForm.num && document.aseForm.num.value == ''){
			alert("Number is required.");
			document.aseForm.num.focus();
			return false;
		}

		return true;
	}

	function cancelForm(){
		var sid = "";

		if (document.aseForm.sid && document.aseForm.sid.value != ''){
			sid = document.aseForm.sid.value;
		}

		aseForm.action = "usrtsks.jsp?sid=" + sid;
		aseForm.submit();
	}

//-->