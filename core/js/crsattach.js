<!--
	function aseSubmitClick(dest) {

		document.aseForm.act.value = "a";

		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		return true;
	}

	// this approach does not work with form enctype=\"multipart/form-data\"
	// need to send over as links
	function aseSubmitClick2x(kix,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.id.value = id;
		document.aseForm.act.value = "r";
		document.aseForm.action = "crsattachx.jsp";
		document.aseForm.submit();
		return false;
	}

	function aseSubmitClick2(kix,id) {
		var act = "r";
		var r2 = document.aseForm.r2.value;
		aseForm.action = "crsattachx.jsp?kix="+kix+"&act="+act+"&id="+id+"&r2="+r2;
		document.aseForm.submit();
		return true;
	}

	function cancelForm(caller,kix,tab,no){

		aseForm.action = caller + ".jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
		aseForm.submit();

	}

-->
