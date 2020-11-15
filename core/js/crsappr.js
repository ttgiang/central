	function showHistory(kix){

		var aseWindow = null;
		var w = '800';
		var h = '600';
		var scroll = 'yes';
		var pos = 'center';

		if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}

		if(pos=="center"){
			LeftPosition=(screen.width)?(screen.width-w)/2:100;
			TopPosition=(screen.height)?(screen.height-h)/2:100;
		}
		else
			if((pos!="center" && pos!="random") || pos==null){
				LeftPosition=0;TopPosition=20
			}

		settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';

		aseWindow=window.open("crshst.jsp?t=PRE&hid="+kix,"crsappr",settings);

		return false;
	}

	function cancelForm(){
		aseApprovalForm.action = "tasks.jsp";
		aseApprovalForm.submit();
	}

	function checkForm(action){

		aseApprovalForm.formAction.value = action;

		if (aseApprovalForm.voteFor && aseApprovalForm.voteFor.value != ''){
			if (!IsNumber(aseApprovalForm.voteFor.value)){
				alert("Invalid input.");
				aseApprovalForm.voteFor.focus();
				return false;
			}
		}

		if (aseApprovalForm.voteAgainst && aseApprovalForm.voteAgainst.value != ''){
			if (!IsNumber(aseApprovalForm.voteAgainst.value)){
				alert("Invalid input.");
				aseApprovalForm.voteAgainst.focus();
				return false;
			}
		}

		if (aseApprovalForm.voteAbstain && aseApprovalForm.voteAbstain.value != ''){
			if (!IsNumber(aseApprovalForm.voteAbstain.value)){
				alert("Invalid input.");
				aseApprovalForm.voteAbstain.focus();
				return false;
			}
		}

		// when confirmation using skew is involved, check here
		if (document.aseApprovalForm.passLine && document.aseApprovalForm.passLineEncoded){
			if (document.aseApprovalForm.passLine.value=="" || document.aseApprovalForm.passLineEncoded.value==""){
				alert( "Invalid or missing security code.");
				document.aseApprovalForm.passLine.focus();
				return false;
			}
		}

		return true;
	}
