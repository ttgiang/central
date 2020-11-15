<!--
	function cancelForm(){
		aseForm.action = "tasks.jsp";
		aseForm.submit();
	}

	function newCQL(){
		aseForm.action = "cql.jsp";
		aseForm.submit();
	}

	function viewCQL(){
		var myLink = "/centraldocs/docs/outlines/xml.xml";
		var win2 = window.open(myLink, 'myWindow','toolbar=no,width=600,height=500,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');
		return false;
	}

	function checkForm(action){
		document.aseForm.formAction.value = action;

		// when confirmation using skew is involved, check here
		if (document.aseForm.passLine && document.aseForm.passLineEncoded){
			if (document.aseForm.passLine.value=="" || document.aseForm.passLineEncoded.value==""){
				alert( "Invalid or missing security code.");
				document.aseForm.passLine.focus();
				return false;
			}
		}

		return true;
	}

-->
