<!--
	function cancelForm(action,alpha,num,tab,no){

		var src = document.aseForm.src.value;
		var kix = document.aseForm.kix.value;

		if (src=="X43"){
			aseForm.action = "crslnks.jsp?z=1&kix="+kix+"&src=X43&dst=SLO";
		}
		else{
			aseForm.action = "crscntnt.jsp";
		}

		aseForm.submit();
	}

	function checkForm(action){
		document.aseForm.formAction.value = action;
		return true;
	}

-->
