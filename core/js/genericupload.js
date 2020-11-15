<!--
	function aseSubmitClick(dest) {
		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		return true;
	}

	// this approach does not work with form enctype=\"multipart/form-data\"
	// need to send over as links
	function aseSubmitClick2x(kix,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.id.value = id;
		document.aseForm.action = "crsattachx.jsp";
		document.aseForm.submit();
		return false;
	}

	function aseSubmitClick2(kix,id) {
		var act = "r";
		aseForm.action = "crsattachx.jsp?kix="+kix+"&act="+act+"&id="+id;
		document.aseForm.submit();
		return true;
	}

	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function cancelFormX(src,kix){

		aseForm.action = src+".jsp?kix="+kix;
		aseForm.submit();
	}

-->
