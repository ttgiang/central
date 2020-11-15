<!--
	function cancelForm(){

		var originalsrc = document.aseForm.originalsrc.value;
		var dst = document.aseForm.dst.value;
		var rtn = document.aseForm.rtn.value;
		var kix = document.aseForm.kix.value;

		aseForm.action = rtn + ".jsp?kix="+kix+"&src="+originalsrc+"&dst="+dst;

		aseForm.submit();

	}

	function checkForm(action){

		document.aseForm.formAction.value = action;

		var nButton = -1;
		var counter = 0;

		if(aseForm.list.length){
			for (counter = 0; counter < aseForm.list.length; counter++){
				if ( aseForm.list[counter].checked)
					nButton = counter;
			}

			if (nButton < 0){
				alert("Please select a list");
				document.aseForm.list.focus();
				return false;
			}
			else{
				document.aseForm.subtopic.value = document.aseForm.list[nButton].value;
			}
		}
		else{
			document.aseForm.subtopic.value = document.aseForm.list.value;
		}

		// turn on progress
		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		// turn off buttons
		if (document.getElementById("cmdSubmit")){
			document.aseForm.cmdSubmit.disabled = true;
			document.getElementById("cmdSubmit").setAttribute("class", "inputsmallgrayoff");
		}

		if (document.getElementById("cmdCancel")){
			document.aseForm.cmdCancel.disabled = true;
			document.getElementById("cmdCancel").setAttribute("class", "inputsmallgrayoff");
		}

		// set processing page
		document.aseForm.action = "slctlstx.jsp";

		// submit for processing
		document.aseForm.submit();

		return false;

	}

	//
	// loadContent
	//
	function loadContent(topic,subtopic) {

		var url = "slctlstz.jsp?t=" + topic + "&s=" + subtopic;

		document.getElementById("content").innerHTML = "";

		document.getElementById("content").style.visibility = "hidden";

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", url);
		xmlhttp.send(null);
	}

	//
	// triggered
	//
	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("content").style.visibility = "visible";
				document.getElementById("content").innerHTML = xmlhttp.responseText;
			}
		}
	}

-->
