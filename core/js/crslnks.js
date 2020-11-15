<!--
	function cancelForm(kix,tab,no,caller,campus){

		if ((tab=="" && no=="") || (tab=="0" && no=="0")){
			aseForm.action = "index.jsp";
		}
		else{

			if(caller == 'crsedt'){
				aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
			}
			else if(caller == 'crsfldy'){
				aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
			}

		}

		document.aseForm.submit();

		return false;
	}

	function checkForm(action){
		return true;
	}

	function aseSubmitClick(dest,len) {


		//if(content==""){
		//	alert( "Content is required.");
		//	document.aseForm.content.focus();
		//	return false;
		//}

		var diff;
		var ckContent = CKEDITOR.instances["content"].getData();

		diff = ckContent.length - len;

		if(ckContent == ""){
			alert( "content is a required field.");
			return false;
		}
		else{
			if (ckContent.length > len){
				alert( "Content length is " + diff + " character(s) over the " + len + " characters limit.");
				document.aseForm.content.focus();
				return false;
			}
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick0(kix,src,dst,keyid) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		aseForm.action = "crslnkr.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick2(kix,src,dst,keyid) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		document.aseForm.act.value = "r";
		aseForm.action = "crslnksx.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick3(kix,src,dst,keyid) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		aseForm.action = "crslnks.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick4(kix,src,dst,keyid) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		aseForm.action = "crsslolnk.jsp?kix="+kix+"&cid="+keyid+"&src="+src;
		document.aseForm.submit();
		return true;
	}
-->
