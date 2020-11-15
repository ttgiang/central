<!--
	function aseSubmitClick(dest) {

		var genContent = CKEDITOR.instances["genContent"].getData();
		if(genContent == ""){
			alert("Please enter content.");
			return false;
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick0(kix,src,dst,keyid) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		document.aseForm.caller.value = "crsgen";
		aseForm.action = "crslnkr.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick2(keyid) {
		document.aseForm.keyid.value = keyid;
		document.aseForm.act.value = "r";
		aseForm.action = "crsgenx.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick2X(keyid) {
		document.aseForm.keyid.value = keyid;

		if (confirm('Delete Record?')){
			document.aseForm.act.value = "r";
			document.aseForm.submit();
			return true;
		}

		return false;
	}

	function aseSubmitClick3(kix,keyid) {
		document.aseForm.keyid.value = keyid;
		var kix = document.aseForm.kix.value;
		var src = document.aseForm.src.value;
		aseForm.action = "crsgen.jsp?kix="+kix+"&src="+src+"&dst="+src+"&id=" + keyid;
		aseForm.submit();
	}

	function aseOnLoad() {
		var alpha = document.aseForm.thisAlpha.value;
		var num = document.aseForm.thisNum.value;
		var table = document.aseForm.thisTable.value;
		var type = document.aseForm.thisType.value;

		var destURL = "?alpha=" + alpha + "&num=" + num + "&table=" + table + "&type=" + type;

		loadData(destURL);
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

	function loadData(dest) {
		var destURL = "/central/core/crsgenidx.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);

		document.aseForm.alpha_ID.value = "";
		document.aseForm.numbers_ID.value = "";
		document.aseForm.alpha.value = "";
		document.aseForm.numbers.value = "";
		document.aseForm.grading.value = "";
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML =xmlhttp.responseText;
			}
		}
	}

-->
