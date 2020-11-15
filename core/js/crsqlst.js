<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		var division = "";
		var alpha = "";
		var type = "";

		if (document.aseForm.type && document.aseForm.type.value != '' ){
			type = document.aseForm.type.value;
		}

		if (type == ''){
			alert( "Import type is required.");
			document.aseForm.type.focus();
			return false;
		}

		if (document.aseForm.division && document.aseForm.division.value != '' ){
			division = document.aseForm.division.value;
		}

		if (document.aseForm.alpha && document.aseForm.alpha.value != '' ){
			alpha = document.aseForm.alpha.value;
		}

		if ((alpha == '' && division == '' && divisionX == '') && type != 'X81'){
			alert( "Division or Alpha is required.");
			document.aseForm.division.focus();
			return false;
		}

		if (	(document.aseForm.lst && document.aseForm.lst.value == '') &&
				(document.aseForm.fileName && document.aseForm.fileName.value == '')
			){
			alert( "Content is required.");
			document.aseForm.lst.focus();
			return false;
		}

		return true;
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML =xmlhttp.responseText;
			}
		}
	}

-->
