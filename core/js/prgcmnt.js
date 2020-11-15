<!--


	function checkForm(){
		if ( document.aseForm.comments.value == '' ){
			alert( "Comment is required. Click the cancel button to abort.");
			document.aseForm.comments.focus();
			return false;
		}

		return true;
	}

	function cancelForm(){

		var kix = document.aseForm.kix.value;
		var md = document.aseForm.md.value;

		if (md==3 || md==4)
			document.aseForm.action = "prgrvwer.jsp?kix=" + kix;
		else
			document.aseForm.action = "prgappr.jsp?kix=" + kix;

		document.aseForm.submit();

		return false;
	}

	function aseSubmitClick0(kix,item,source,acktion,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.item.value = item;
		document.aseForm.tb.value = source;
		document.aseForm.mode.value = acktion;
		document.aseForm.id.value = id;
		aseForm.action = "prgcmnt.jsp?kix="+kix+"&qn="+item+"&c="+source+"&md="+acktion+"&id="+id;
		aseForm.submit();
		return true;
	}

	function aseSubmitClick1(kix,item,source,acktion,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.item.value = item;
		document.aseForm.tb.value = source;
		document.aseForm.mode.value = acktion;
		document.aseForm.id.value = id;
		aseForm.action = "prgcmntx.jsp";
		document.aseForm.submit();
		//return true;
	}


//-->