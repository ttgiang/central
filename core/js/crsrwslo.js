<!--
	function checkForm(action){

		var i = 0;
		var j = 0;
		var activeControls = 0;

		if (document.aseApprovalForm.numberOfControls){
			var numberOfControls = document.aseApprovalForm.numberOfControls.value;
			var hiddenRadioFields = document.aseApprovalForm.allRadios.value;
			var radios = hiddenRadioFields.split(",");
			activeControls = radios.length;

			/*
				cycel through all active controls and check if they were set to Y or N.

				The number of selected controls must match the number of activeControls
				or don't allow the form to be submitted.
			*/

			for (i=0; i<activeControls; i++){
				var radio0 = eval("document.aseApprovalForm.radio_" + radios[i] + "_0[0]");
				var radio1 = eval("document.aseApprovalForm.radio_" + radios[i] + "_0[1]");
				if (radio0.checked || radio1.checked)
					++j;
			}

			if (j != activeControls){
				alert("Please select Y or N for each SLO before saving.");
				return false;
			}

		}

		return true;
	}

	function aseSubmitClick(dest) {
		return true;
	}

	function returnToProposer() {
		document.aseApprovalForm.action = "crsrwslox.jsp";
		document.aseApprovalForm.submit();
		return false;
	}

	function cancelForm(alpha,num,tab,no){
		document.aseApprovalForm.action = "index.jsp";
		document.aseApprovalForm.submit();
		return false;
	}
-->
