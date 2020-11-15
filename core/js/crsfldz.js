<!--
	function closeForm(){
		var kix = document.aseForm.kix.value;
		aseForm.action = "crsfldy.jsp?kix="+kix;
		aseForm.submit();
	}

	function checkForm(action){

		// when confirmation using skew is involved, check here
		if (document.aseForm.passLine && document.aseForm.passLineEncoded){
			if (document.aseForm.passLine.value=="" || document.aseForm.passLineEncoded.value==""){
				alert( "Invalid or missing security code.");
				document.aseForm.passLine.focus();
				return false;
			}
		}

		/*
			for check boxes, go through and save values of all selected items.
			the result is saved to the database.
		*/
		if (document.aseForm.numberOfControls){
			var numberOfControls = document.aseForm.numberOfControls.value;
			var j = 0;
			var selected = "";

			for (i=0; i<numberOfControls; i++){
				var chkBox = eval("document.aseForm.questions_" + i);
				if (chkBox.checked){
					if (selected == "")
						selected = chkBox.value;
					else
						selected = selected + "," + chkBox.value;
				}
			}

			document.aseForm.selectedCheckBoxes.value = selected;
		}

		return true;
	}

	function extraForm(formName,formArg,kix){
		aseForm.action = formName + ".jsp?kix="+kix+"&"+formArg;
		aseForm.submit();
	}

-->
