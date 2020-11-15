<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		if (document.getElementById("spinner"))
			document.getElementById("spinner").style.visibility = "visible";

		document.aseForm.formAction.value = action;

		var chkBox;

		/*
			for check boxes, go through and save values of all selected items.
			the result is saved to the database.

			this is no longer relied upon. it is now handled in code

			if (document.aseForm.numberOfControls){
				var numberOfControls = document.aseForm.numberOfControls.value;
				var j = 0;
				var selected = "";

				for (i=0; i<numberOfControls; i++){
					chkBox = eval("document.aseForm.questions_" + i);

					if (chkBox.checked){
						if (selected == "")
							selected = chkBox.value;
						else
							selected = selected + "," + chkBox.value;
					}
				}

				document.aseForm.selectedCheckBoxes.value = selected;
			}

		*/

		// validation
		var validate = document.aseForm.validate.value;

		return true;
	}

	function showIndexWindow(id){
		var myLink = "crsqst_" + id + ".htm";
		var win2 = window.open(myLink, 'myWindow','toolbar=no,width=600,height=500,directories=no,status=no,scrollbars=yes,resizable=yes,menubar=no');
	}

	function extraForm(formName,formArg,kix){
		aseForm.action = formName + ".jsp?kix="+kix+"&"+formArg;
		aseForm.submit();
	}

	var xmlHttp
	var divID = "";

	function getDetail(lid) {
		var dataUrl = 'detail.asp?lid=' + lid;
		ajaxCall(dataUrl,displayHelp,1);
		var helpPanel = document.getElementById('help_container');
		helpPanel.innerHTML = 'Loading results';
		helpPanel.className = 'popShow';
		return false;
	}

	//display the page content
	function displayHelp(http) {
		var helpPanel = document.getElementById('help_container');
		helpPanel.innerHTML = http.responseText;
	}

	function closeTaskWindow() {
		var helpPanel = document.getElementById('help_container');
		helpPanel.innerHTML = "";
		helpPanel.className = 'popHide';
	}

	function wait(delay) {
		//setTimeout("fixHeight()", delay);
		setTimeout("", delay);
	}

	function fixHeight() {
	  //if ((document.getElementById) && (document.getElementById("bodyPanel").scrollHeight > 500)) {
		//document.getElementById("docMenu").style.height = document.getElementById("bodyPanel").scrollHeight + 'px';
	  //}
	}

	//--------------------------------------------
	// error screen
	//--------------------------------------------
	function showError(dest) {
		var destURL = "/central/core/index.jsp";

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = errorTriggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);
	}

	function errorTriggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("validationMsg").innerHTML = "<img src=\"../images/err_alert.gif\" border=\"0\" alt=\"input error\" title=\"input error\">";
			}
		}
	}

	//--------------------------------------------
	// Help screen
	//--------------------------------------------
	function loadData(dest) {
		var destURL = "/central/core/index.jsp";

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
				//document.getElementById("validationMsg").innerHTML = xmlhttp.responseText;
				document.getElementById("validationMsg").innerHTML = "<img src=\"../images/err_alert.gif\" border=\"0\" alt=\"input error\" title=\"input error\">";
			}
		}
	}
-->
