// validation for forum forms

	function validateForm(){

		if (document.aseForm.subject && document.aseForm.subject.value == ''){
			alert( "Please enter your subject.");
			document.aseForm.subject.focus();
			return false;
		}

		var ckContent = CKEDITOR.instances["message"].getData();
		if(ckContent == ""){
			alert( "Message is a required field.");
			return false;
		}

		return true;
	}

	function cancelForm(){

		var fid = 0;
		var emid = 0;
		var rmid = 0;
		var item = 0;

		if (document.aseForm.fid){
			fid = document.aseForm.fid.value;
		}

		if (document.aseForm.emid){
			rmid = document.aseForm.rmid.value;
		}

		if (document.aseForm.item){
			item = document.aseForm.item.value;
		}

		aseForm.action = "displayusrmsg.jsp?fid="+fid+"&mid="+rmid+"&item="+item;
		aseForm.submit();

		return true;
	}

	function editForm(){

		aseForm.action = "edit.jsp";
		aseForm.submit();

		return true;
	}

	function aseSubmitClick(dest) {

		var kix = document.aseForm.kix.value;
		aseForm.action = "../gnrcmprt.jsp?src=" + dest + "&kix=" + kix;
		aseForm.submit();

		return true;
	}
