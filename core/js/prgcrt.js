<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(){

		if (document.aseForm.degree && document.aseForm.degree.value == '' ){
			alert( "Degree is required.");
			document.aseForm.degree.focus();
			return false;
		}

		if (document.aseForm.division && document.aseForm.division.value == '' ){
			alert( "Division is required.");
			document.aseForm.division.focus();
			return false;
		}

		if (document.aseForm.title && document.aseForm.title.value == '' ){
			alert( "Title is required.");
			document.aseForm.title.focus();
			return false;
		}

		if (document.aseForm.effectiveDate && document.aseForm.effectiveDate.value == '' ){
			alert( "Effective Date is required.");
			document.aseForm.effectiveDate.focus();
			return false;
		}

		if (document.aseForm.year && document.aseForm.year.value == '' ){
			alert( "Year is required.");
			document.aseForm.year.focus();
			return false;
		}

		return true;
	}
//-->