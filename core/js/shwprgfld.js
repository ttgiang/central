<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){
		document.aseForm.formAction.value = action;

		if (action=="s" && countSelections() == 0){
			alert("You must enable at least 1 item for modification.");
			return false;
		}

		return true;
	}

	function countSelections(){

		var fieldCountSystem = document.aseForm.fieldCountSystem.value;
		var hiddenFieldSystem = document.aseForm.hiddenFieldSystem.value;
		var system = hiddenFieldSystem.split(",");
		var j = 0;

		for (i=0; i<fieldCountSystem; i++){
			var chkBox = eval("document.aseForm.Program_" + system[i]);
			if (chkBox.checked)
				++j;
		}

		document.aseForm.totalEnabledFields.value = j;

		return j;
	}

	function selectAll(){

		var fieldCountSystem = document.aseForm.fieldCountSystem.value;
		var hiddenFieldSystem = document.aseForm.hiddenFieldSystem.value;
		var system = hiddenFieldSystem.split(",");
		var buf = "";

		for(i=1;i<=fieldCountSystem;i++){
			buf += system[i] + "\n";
			eval("document.aseForm.Program_" + system[i] + ".checked = action");
		}
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

-->

