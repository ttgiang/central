<!--
	function aseSubmitClick() {

		var alpha = "";
		var title = "";

		if (aseForm.alpha){
			alpha = aseForm.alpha.value;
		}

		if (aseForm.title){
			title = aseForm.title.value;
		}

		if (alpha != "" && title != ""){
			alert("Only Course Outline or Course Title is permitted");
			aseForm.alpha.focus();
			return false;
		}
		else{
			if (document.getElementById("spinner")){
				document.getElementById("spinner").style.visibility = "visible";
			}
		}

		return true;
	}

	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){
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

	function aseOnLoad(idx,type,alpha,num) {
		if (type!=""){
			var destURL = "?idx=" + idx + "&type=" + type + "&alpha=" + alpha + "&num=" + num;
			loadData(destURL);
		}
	}

	function loadData(dest) {
		var destURL = "/central/core/vwoutlinex.jsp" + dest;

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
-->
