<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		var aseList = document.aseForm.aseList.value;
		var alpha = document.aseForm.alpha2.value;
		var num = document.aseForm.num.value;

		if (aseList == "" && alpha == "" && num == ""){
			if (!confirm('Not making a selection is equivalent to generating the entire catalog.\n\nDo you wish to continue?')){
				return false;
			}
			else{
				document.getElementById("output").style.visibility = "visible";

				return true;
			}
		}

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

	function aseOnLoad(type,access) {
		var destURL = "?type=" + type;
		loadData3(destURL);
	}

	function aseOnLoad2() {
		var type = document.aseForm.aseList.value;
		var destURL = "?type=" + type;
		loadData(destURL);
	}

	function loadData(dest) {
		var destURL = "/central/core/crscatx.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML =xmlhttp.responseText;
			}
		}
	}

	// ER00025
	function aseOnLoad3() {

		document.getElementById("output").style.visibility = "visible";

		var type = document.aseForm.aseList.value;

		var destURL = "?type=" + type;

		loadData3(destURL);
	}

	function loadData3(dest) {
		var destURL = "/central/core/crscatz.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered3;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);
	}

	function triggered3() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML = xmlhttp.responseText;
			}
		}
	}

-->
