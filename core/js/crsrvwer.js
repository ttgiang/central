<!--
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		document.aseForm.formAction.value = action;

		var voteFor = document.aseForm.voteFor.value;
		var voteAgainst = document.aseForm.voteAgainst.value;
		var voteAbstain = document.aseForm.voteAbstain.value;

		if (!IsNumber(voteFor)){
			alert("Invalid value");
			document.aseForm.voteFor.focus();
			return false;
		}

		if (!IsNumber(voteAgainst)){
			alert("Invalid value");
			document.aseForm.voteAgainst.focus();
			return false;
		}

		if (!IsNumber(voteAbstain)){
			alert("Invalid value");
			document.aseForm.voteAbstain.focus();
			return false;
		}

		// when confirmation using skew is involved, check here
		if (document.aseForm.passLine && document.aseForm.passLineEncoded){
			if (document.aseForm.passLine.value=="" || document.aseForm.passLineEncoded.value==""){
				alert( "Invalid or missing security code.");
				document.aseForm.passLine.focus();
				return false;
			}
		}

		return true;
	}

	function quickComments(c,mode,kix,num){

		var aseWindow = null;
		var w = '440';
		var h = '360';
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

		aseWindow=window.open("popup.jsp?c="+c+"&md="+mode+"&kix="+kix+"&qn="+num,"crsrvwer",settings);

		return false;
	}


-->
