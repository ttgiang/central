<!--

	var lastButton = -99;

	function goBack()
	{
		aseForm.formDirection.value = "Back";
		return true;
	}

	function cancelForm()
	{
		document.aseForm.action = "index.jsp";
		document.aseForm.submit();
	}

	function checkForm()
	{
		var nButton = -1;
		var count = 0;

		if ( aseForm.edt.value == "1" ){
			for (counter = 0; counter < aseForm.viewOption1.length; counter++)
			{
				if ( aseForm.viewOption1[counter].checked)
					nButton = counter;
			}

			if ( nButton == -1 ){
				alert("Please select course type.");
				aseForm.viewOption1[0].focus();
				return false;
			}
			else{
				aseForm.thisOption.value = aseForm.viewOption1[nButton].value;
			}
		}

		if (	aseForm.thisCampus.value == "" ){
			alert("Invalid campus selection.");
			aseForm.thisCampus.focus();
			return false;
		}

		// are there any selections?
		if ( 	aseForm.alpha.value == "" &&
				aseForm.alpha3.value == "" &&
				aseForm.numbers2.value == "" ){
			alert("Please select course alpha.");
			aseForm.alpha.focus();
			return false;
		}

		// check for completion
		if ( aseForm.alpha.value != "" ){
			// don't need to set fields because this pair is already in the
			// correct value
			count++;
		}

		if ( aseForm.numbers2.value != "" ){
			// set these fields for form processing
			count++;
		}

		if ( aseForm.alpha3.value != "" ){
			// set these fields for form processing
			count++;
		}

		if ( count !=  1 ){
			alert("Please provide only 1 set of data");
			return false;
		}

		if ( aseForm.alpha3_ID.value != "" && aseForm.alpha_ID.value == "" )
			aseForm.alpha_ID.value = aseForm.alpha3_ID.value;

		getCourses( aseForm.alpha_ID,aseForm.numbers2_ID,aseForm.thisCampus,aseForm.thisOption);

		return false;
	}

	function checkCourseType()
	{
		var nButton = -1;

		for (counter = 0; counter < aseForm.viewOption1.length; counter++)
		{
			if ( aseForm.viewOption1[counter].checked)
				nButton = counter;
		}

		if ( nButton != -1 ){
			aseForm.thisOption.value = aseForm.viewOption1[nButton].value;

			if ( lastButton != nButton ){
				lastButton = nButton;
				aseForm.thisCampus.value = "";
				aseForm.alpha.value = "";
				aseForm.alpha_ID.value = "";
				aseForm.numbers2.value = "";
				aseForm.numbers2_ID.value = "";
				aseForm.alpha3.value = "";
				aseForm.alpha3_ID.value = "";
			}
		}

		return true;
	}

	//display the page content
	function displayHelp(http) {
		var helpPanel = document.getElementById('txtCourses');
		helpPanel.innerHTML = http.responseText;
	}

	function getCourses(alpha,num,campus,view) {
		var cr = alpha.value;
		var cn = num.value;
		var cp = campus.value;
		var cv = view.value;
		var dataUrl = 'crslst2.jsp?cr='+cr+'&cn='+cn+'&cp='+cp+'&cv='+cv;
		ajaxCall(dataUrl,displayHelp,1);
		var helpPanel = document.getElementById('txtCourses');
		helpPanel.innerHTML = 'Loading results';
		helpPanel.className = 'popShow';
		return false;
	}

	function closeTaskWindow() {
		var helpPanel = document.getElementById('txtCourses');
		helpPanel.innerHTML = "";
		helpPanel.className = 'popHide';
	}

-->
