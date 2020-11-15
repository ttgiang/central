<!--

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

		// are there any selections?
		if ( 	aseForm.alpha.value == "" &&
				aseForm.alpha2.value == "" &&
				aseForm.alpha3.value == "" &&
				aseForm.numbers.value == "" &&
				aseForm.numbers2.value == "" &&
				aseForm.numbers3.value == "" ){
			alert("Please select course alpha.");
			aseForm.alpha.focus();
			return false;
		}

		// one of 2 items selected
		if (	( aseForm.alpha.value != "" && aseForm.numbers.value == "" ) ||
				( aseForm.numbers.value != "" && aseForm.alpha.value == "" ) ){
			alert("Incomplete selection.");
			//aseForm.alpha.focus();
			return false;
		}

		if (	( aseForm.alpha2.value != "" && aseForm.numbers2.value == "" ) ||
				( aseForm.numbers2.value != "" && aseForm.alpha2.value == "" ) ){
			alert("Incomplete selection.");
			//aseForm.alpha2.focus();
			return false;
		}

		if (	( aseForm.alpha3.value != "" && aseForm.numbers3.value == "" ) ||
				( aseForm.numbers3.value != "" && aseForm.alpha3.value == "" ) ){
			alert("Incomplete selection.");
			//aseForm.alpha3.focus();
			return false;
		}

		// check for completion
		if ( aseForm.alpha.value != "" && aseForm.numbers.value != "" ){
			// don't need to set fields because this pair is already in the
			// correct value
			count++;
		}

		if ( aseForm.alpha2.value != "" && aseForm.numbers2.value != "" ){
			// set these fields for form processing
			aseForm.alpha_ID.value = aseForm.alpha2_ID.value;
			aseForm.numbers_ID.value = aseForm.numbers2_ID.value;
			count++;
		}

		if ( aseForm.alpha3.value != "" && aseForm.numbers3.value != "" ){
			// set these fields for form processing
			aseForm.alpha_ID.value = aseForm.alpha3_ID.value;
			aseForm.numbers_ID.value = aseForm.numbers3_ID.value;
			count++;
		}

		if ( count !=  1 ){
			alert("Please provide only 1 set of data");
			return false;
		}

		return true;
	}

	function checkCourseType()
	{
		var nButton = -1;

		for (counter = 0; counter < aseForm.viewOption1.length; counter++)
		{
			if ( aseForm.viewOption1[counter].checked)
				nButton = counter;
		}

		aseForm.thisOption.value = "CUR";
		if ( nButton != -1 ){
			aseForm.thisOption.value = aseForm.viewOption1[nButton].value;
		}

		return true;
	}

-->
