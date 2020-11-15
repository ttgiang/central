<!--

	function cancelForm(idx){

		aseForm.action = "usridx.jsp?idx="+idx;

		aseForm.submit();

		return false;
	}

	function confirmDelete(){
		if ( document.aseForm.aseDelete ){
			if ( document.aseForm.aseDelete.value == "Delete" )
			  return confirm('Delete record?');
		}

		return false;
	}

	function checkForm(){

		var lid = document.aseForm.lid.value;

		if ( document.aseForm.userid.value == '' ){
			alert( "User ID is required.");
			document.aseForm.userid.focus();
			return false;
		}

		if (lid=="0" || lid==""){
			if (document.aseForm.uh_0[1].checked){
				if ( document.aseForm.pw.value == '' ){
					alert( "Password is required.");
					document.aseForm.pw.focus();
					return false;
				}
				else{
					if ( document.aseForm.pw.value != document.aseForm.pw2.value ){
						alert( "Passwords do not match.\nPlease re-enter your passwords.");
						document.aseForm.pw.focus();
						return false;
					}
				}
			}
		}

		if ( document.aseForm.fullname.value == '' ){
			alert( "Full name is required.");
			document.aseForm.fullname.focus();
			return false;
		}

		if ( document.aseForm.department.value == '' ){
			alert( "Department is required.");
			document.aseForm.department.focus();
			return false;
		}

		if ( document.aseForm.division.value == '' ){
			alert( "Division is required.");
			document.aseForm.division.focus();
			return false;
		}

		if ( document.aseForm.userlevel.value == '' ){
			alert( "Invalid user level.");
			document.aseForm.userlevel.focus();
			return false;
		}

		if ( document.aseForm.title.value == '' ){
			alert( "Invalid title.");
			document.aseForm.title.focus();
			return false;
		}

		if ( document.aseForm.position.value == '' ){
			alert( "Invalid position.");
			document.aseForm.position.focus();
			return false;
		}

		if ( document.aseForm.email.value == '' ){
			if (!IsEmail(document.aseForm.email.value)){
				alert( "Invalid email format.");
				document.aseForm.email.focus();
				return false;
			}
		}

		if ( document.aseForm.campus.value == '' ){
			alert( "Invalid campus selection.");
			document.aseForm.campus.focus();
			return false;
		}

		return true;
	}

	function showWorkInProgress(usr){

		var aseWindow = null;
		var w = '600';
		var h = '400';
		var scroll = 'no';
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

		aseWindow = window.open("usry.jsp?usr="+usr,"usr",settings);

		return false;
	}

//-->

