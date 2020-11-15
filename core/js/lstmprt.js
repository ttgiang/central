<!--
	function aseSubmitClick(dest) {

		// turn on progress
		if (document.getElementById("spinner")){
			document.getElementById("spinner").style.visibility = "visible";
		}

		return true;

		var nButton = -1;

		if (document.aseForm.aseListImportField){

			for (counter = 0; counter < aseForm.aseListImportField.length; counter++) {
				if ( aseForm.aseListImportField[counter].checked)
					nButton = counter;
			}

			if ( nButton == -1 ){
				alert("Invalid or missing selection.");
				return false;
			}

		}

		return true;
	}

	function aseSubmitBackClick() {

		if (document.aseForm.lastStep && document.aseForm.nextStep){

			document.aseForm.nextStep.value = document.aseForm.lastStep.value;

		}

		return true;
	}

	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

-->
