<!--
	function aseSubmitClick(dest) {
		document.aseForm.act.value = "a";
		return true;
	}

	function aseSubmitClick2(kix,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.id.value = id;
		document.aseForm.act.value = "r";
		aseForm.action = "crsattachx.jsp?kix="+kix+"&act="+act+"&id="+id;
		document.aseForm.submit();
		return true;
	}

	function cancelForm(){
		var kix = document.aseForm.kix.value;
		var id = document.aseForm.id.value;
		var r2 = document.aseForm.r2.value;

		var page = "";

		if (r2 != null){
			if (r2 == "ah")
				page = "attchst";
			else if (r2 == "pedt")
				page = "prgedt";
			else if (r2 == "crsedt")
				page = "crsedt";
			else if (r2 == "crsfldy")
				page = "crsfldy";
			else if (r2 == "crsattach")
				page = "crsattach";
		}

		aseForm.action = page+".jsp?kix="+kix+"&id="+id;
		document.aseForm.submit();
		return true;
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

		document.aseForm.formAction.value = action;

		return true;
	}

-->
