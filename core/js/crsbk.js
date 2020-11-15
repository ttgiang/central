<!--
	function aseSubmitClick(dest) {

		if(document.aseForm.title && document.aseForm.title.value == ""){
			alert("Title is required.");
			document.aseForm.title.focus();
			return false;
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick2(kix,seq) {
		document.aseForm.kix.value = kix;
		document.aseForm.seq.value = seq;
		document.aseForm.act.value = "r";
		aseForm.action = "crsbkx.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick3(kix,seq) {
		document.aseForm.kix.value = kix;
		document.aseForm.seq.value = seq;
		aseForm.action = "crsbk.jsp";
		document.aseForm.submit();
		return true;
	}

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
