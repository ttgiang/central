<!--
	function cancelForm(){
		aseForm.action = "ccslo.jsp";
		aseForm.submit();
	}

	function checkForm(action){
		return true;
	}

	function checkCourseType(){
		var nButton = -1;

		for (counter=0; counter<aseForm.viewOption.length; counter++)
		{
			if (aseForm.viewOption[counter].checked)
				nButton = counter;
		}

		aseForm.type.value = "CUR";
		if ( nButton != -1 ){
			aseForm.type.value = aseForm.viewOption[nButton].value;
		}

		var destURL = "test.jsp?type=" + aseForm.type.value;

		aseForm.action = destURL;
		aseForm.submit();

		return false;
	}
-->
