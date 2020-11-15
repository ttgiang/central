<!--
	function checkFormX(src,task){

		// when confirmation using skew is involved, check here
		if (document.aseForm.passLine && document.aseForm.passLineEncoded){
			if (document.aseForm.passLine.value=="" || document.aseForm.passLineEncoded.value==""){
				alert( "Invalid or missing security code.");
				document.aseForm.passLine.focus();
				return false;
			}
		}

		// turn on progress
		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		// set processing page
		document.aseForm.action = src + ".jsp?tsk=" + task;

		// submit for processing
		document.aseForm.submit();

		return false;
	}

-->
