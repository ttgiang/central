<!--

	function cancelForm()
	{
		document.aseForm.action = "prgsts.jsp";
		document.aseForm.submit();
	}

	function checkForm()
	{
		var nButton = -1;

		if (aseForm.appr.length){
			for (counter = 0; counter < aseForm.appr.length; counter++){
				if ( aseForm.appr[counter].checked)
					nButton = counter;
			}

			if ( nButton == -1 ){
				alert("Please select approver to fast track.");
				aseForm.appr[0].focus();
				return false;
			}
		}
		else{
			if (aseForm.appr && !aseForm.appr.checked){
				alert("Please select approver to fast track.");
				return false;
			}
		}

		return true;
	}
-->
