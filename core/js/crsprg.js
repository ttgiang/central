<!--

	function cancelForm(kix,tab,no,caller,campus){

		if(caller == 'crsedt'){
			aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
		}
		else if(caller == 'crsfldy'){
			aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
		}

		aseForm.submit();
	}

-->
