	function cancelForm(){
		document.aseForm.action = "index.jsp";
		document.aseForm.submit();
	}

	function validateForm(action){

		// is there a valid list ( > 0 ); If so, was anything selected ( < 0 )
		if ( document.aseForm.fromList.selectedIndex < 1 ){
			alert( "Current Owner is invalid." );
			aseForm.fromList.focus();
			return false;
		}

		if ( document.aseForm.toList.selectedIndex < 1 ){
			alert( "New Owner is invalid." );
			aseForm.toList.focus();
			return false;
		}

		 var item = document.aseForm.fromList.selectedIndex;
		 var fromName = document.aseForm.fromList.options[item].text;
		 item = document.aseForm.toList.selectedIndex;
		 var toName = document.aseForm.toList.options[item].text;

		if ( fromName == toName ){
			alert("From and To Owners may not be the same names");
			return false;
		}

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


