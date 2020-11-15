<!--

	function cancelMatrixForm(){

		if(caller == 'crsfldy'){
			aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
		}
		else
			aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
		}

		aseForm.submit();
	}

	function cancelForm(action,alpha,num,tab,no){
		var linkedPage = "";
		var kix = document.aseForm.kix.value;

		linkedPage = "crslnks.jsp";
		aseForm.action = linkedPage;
		aseForm.submit();
	}

	function cancelFormX(action,alpha,num,tab,no,caller){
		var linkedPage = "";

		if (caller.length > 0)
			linkedPage = caller;
		else
			linkedPage = "crslnks.jsp";

		aseForm.action = linkedPage;
		aseForm.submit();
	}

	function checkForm(action){
		document.aseForm.formAction.value = action;
		return true;
	}

-->
