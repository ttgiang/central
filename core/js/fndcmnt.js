<!--
	function checkForm(){

		/*

		with ER19 in place, we don't have to force content
		checking since users may return to toggle enable edit without commenting.

		var ckContent = CKEDITOR.instances["comments"].getData();
		if(ckContent == ""){
			alert( "Comment is required. Click the cancel button to abort.");
			return false;
		}
		*/

		/*
		if ( document.aseForm.comments.value == '' ){
			alert( "Comment is required. Click the cancel button to abort.");
			document.aseForm.comments.focus();
			return false;
		}
		*/

		return true;
	}

	function cancelForm(){
		//var kix = document.aseForm.kix.value;
		//var source = document.aseForm.tb.value;
		//var item = document.aseForm.item.value;
		//var mode = document.aseForm.mode.value;
		//aseForm.action = "crscmnt.jsp?kix="+kix+"&qn="+item+"&c="+source+"&md="+mode+"&id="+id;
		//aseForm.submit();
		//return false;

		return true;
	}

	function aseSubmitClick0(kix,sq,en,qn,acktion,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.sq.value = sq;
		document.aseForm.en.value = en;
		document.aseForm.qn.value = qn;
		document.aseForm.mode.value = acktion;
		document.aseForm.id.value = id;
		aseForm.action = "fndcmnt.jsp?kix="+kix+"&sq="+sq+"&en="+en+"&qn="+qn+"&md="+acktion+"&id="+id;
		aseForm.submit();
		return true;
	}

	function aseSubmitClick1(kix,sq,en,qn,acktion,id) {
		document.aseForm.kix.value = kix;
		document.aseForm.sq.value = sq;
		document.aseForm.en.value = en;
		document.aseForm.qn.value = qn;
		document.aseForm.mode.value = acktion;
		document.aseForm.id.value = id;
		aseForm.action = "fndcmntx.jsp";
		document.aseForm.submit();
		//return true;
	}


//-->