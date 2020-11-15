<!--
	function aseSubmitClick(dest) {

		if(document.aseForm.title && document.aseForm.title.value == ""){
			alert("Title is required.");
			document.aseForm.title.focus();
			return false;
		}

		if(document.aseForm.link && document.aseForm.link.value == ""){
			alert("Link is required.");
			document.aseForm.link.focus();
			return false;
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick2(kix,seq) {
		document.aseForm.kix.value = kix;
		document.aseForm.seq.value = seq;
		document.aseForm.act.value = "r";
		aseForm.action = "crsfrmsx.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick3(kix,seq) {
		document.aseForm.kix.value = kix;
		document.aseForm.seq.value = seq;
		aseForm.action = "crsfrms.jsp";
		document.aseForm.submit();
		return true;
	}

	function cancelForm(){
		aseForm.action = "crsfrmsidx.jsp";
		aseForm.submit();
	}

-->
