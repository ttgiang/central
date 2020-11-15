<!--
	function cancelForm(){
		aseForm.action = "faq.jsp";
		aseForm.submit();
	}

	function checkForm(){

		/*
		if (document.aseForm.faq___Frame && document.aseForm.faq___Frame.value != '' ){
			document.aseForm.faq.value = document.aseForm.faq___Frame.value;
		}

		if (document.aseForm.faq && document.aseForm.faq.value == '' ){
			alert( "Question is required.");
			document.aseForm.faq.focus();
			return false;
		}
		*/

		if (	(document.aseForm.cat && document.aseForm.cat.value == '') &&
				(document.aseForm.cat2 && document.aseForm.cat2.value == '') ){
			alert( "Category is required.");
			document.aseForm.cat.focus();
			return false;
		}

		if (	(document.aseForm.cat && document.aseForm.cat.value != '') &&
				(document.aseForm.cat2 && document.aseForm.cat2.value != '') ){
			alert( "Only 1 category is permitted.");
			document.aseForm.cat.focus();
			return false;
		}

		return true;
	}

-->
