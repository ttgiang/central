<!--
	function cancelForm(){
		var rtn2 = document.aseForm.rtn2.value;
		var kix = document.aseForm.kix.value;
		var itm = document.aseForm.itm.value;
		var src = "";

		if (rtn2=="edt" || rtn2=="edtslo" || rtn2=="edtpslo" || rtn2=="edtcnt"){

			if (itm=="X18")
				src = "crscmp";
			else if (itm=="X19")
				src = "crscntnt";
			else if (itm=="X43")
				src = "crslnks";
			else if (itm=="X72")
				src = "crsgen";
			else if (itm=="X86")
				src = "crsgen";

			aseForm.action = src+".jsp?s=c&kix=" + kix + "&src=" + itm + "&dst=" + itm;
		}
		else
			aseForm.action = "qlst0.jsp";

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

	function aseOnLoad(idx,type) {
		if (type!=""){
			var destURL = "?idx=" + idx + "&type=" + type;
			loadData(destURL);
		}
	}

	function loadData(dest) {
		var destURL = "/central/core/qlstx.jsp" + dest;

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
