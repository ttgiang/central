<!--
	function returnToSLO(kix,tab,no){
		aseForm.action = "crscmp.jsp?kix="+kix;
		aseForm.submit();
	}

	function returnToEdit(kix,tab,no){

		if ((tab=="" && no=="") || (tab=="0" && no=="0"))
			aseForm.action = "index.jsp";
		else
			aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;

		aseForm.submit();
	}

	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function aseSubmitClick(dest) {
		return true;
	}

-->
