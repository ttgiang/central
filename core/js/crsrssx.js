	function cancelForm(){
		document.aseForm.action = "index.jsp";
		document.aseForm.submit();
	}

	function checkForm(action){
		document.aseForm.formAction.value = action;
		return true;
	}

	function toggleAll(theElement) {

		var theForm = theElement.form;
		var z = 0;

		for(z=0; z<theForm.length;z++){
			if(theForm[z].type == 'checkbox' && theForm[z].name != 'checkAll'){
				theForm[z].checked = theElement.checked;
			}
		}
	}
