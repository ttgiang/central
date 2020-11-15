<!--

	function checkForm(){
		if ( document.aseForm.comp.value == '' ){
			alert( "SLO is required.");
			document.aseForm.comp.focus();
			return false;
		}

		return true;
	}

	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function returnToAssessment(campus,kix){
		aseForm.action = "crsslo.jsp?cps="+campus+"&kix="+kix;
		aseForm.submit();
		return false;
	}

//-->