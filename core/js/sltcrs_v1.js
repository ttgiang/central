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

	function checkForm_1()
	{
		var nButton = -1;

		if ( aseForm.alpha.value == "" )
		{
			alert("Please select by course alpha.");
			aseForm.alpha.focus();
			return false;
		}

		if ( aseForm.edt.value == "1" ){
			for (counter = 0; counter < aseForm.view.length; counter++)
			{
				if ( aseForm.view[counter].checked)
					nButton = counter;
			}

			if ( nButton == -1 ){
				alert("Please select course type.");
				aseForm.view[0].focus();
				return false;
			}
			else{
				aseForm.view.value = aseForm.view[nButton].value;
			}
		}

		return true;
	}


	function checkForm_2()
	{
		aseForm.formDirection.value = "Submit";

		if ( aseForm.courseNum.value == "" )
		{
			alert("Please select by course number.");
			aseForm.courseNum.focus();
			return false;
		}

		return true;
	}

-->
