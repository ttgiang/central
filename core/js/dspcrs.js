<!--

	function cancelForm()
	{
		document.aseForm.action = "index.jsp";
		document.aseForm.submit();
	}

	function checkForm()
	{
		var nButton = -1;

		for (counter = 0; counter < aseForm.radioSelection.length; counter++)
		{
			if ( aseForm.radioSelection[counter].checked)
				nButton = counter;
		}

		switch( nButton )
        {
        	case 0:	if ( aseForm.alphabet.value == "" )
						{
							alert("Please select by alphabet.");
							aseForm.alphabet.focus();
							return false;
						}
        				break;

        	case 1:	if ( aseForm.alphanumber.value == "" )
						{
							alert("Please select by course alpha.");
							aseForm.alphanumber.focus();
							return false;
						}

        				if ( aseForm.courseNum.value == "" )
						{
							alert("Please enter course number.");
							aseForm.courseNum.focus();
							return false;
						}
        				break;

        	case 2:	if ( aseForm.discipline.value == "" )
						{
							alert("Please select by discipline.");
							aseForm.discipline.focus();
							return false;
						}
        				break;
        }

		nButton = -1;
		for (counter = 0; counter < aseForm.viewOption.length; counter++)
		{
			if ( aseForm.viewOption[counter].checked)
				nButton = counter;
		}

      if ( nButton == -1 ){
			alert("Please select course status.");
			aseForm.viewOption[0].focus();
			return false;
		}
		else{
			aseForm.courseType.value = aseForm.viewOption[nButton].value;
		}

		return (true);
	}
-->
