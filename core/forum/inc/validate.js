// validation for forum forms

	function validateForm(){

		if (document.aseForm.subject && document.aseForm.subject.value == ''){
			alert( "Please enter your subject.");
			document.aseForm.subject.focus();
			return false;
		}

		if(CKEDITOR.instances.message){
			var ckContent = CKEDITOR.instances.message.getData();

			if(ckContent.indexOf("<br />") == 0){
				ckContent = ckContent.replace("<br />","");
			}

			if(ckContent == ""){
				alert( "Message is a required field.");
				return false;
			}
		}

		return true;
	}

	function cancelForm(){

		var fid;
		var src;
		var rtn = "display";
		var lnk = "";

		if (document.aseForm.fid){
			fid = document.aseForm.fid.value;
		}

		if (document.aseForm.src){
			src = document.aseForm.src.value;
		}

		if (src=='USR'){

			var tid = "";
			var item = 0;

			if (document.aseForm.tid){
				tid = document.aseForm.tid.value;
			}

			if (document.aseForm.item){
				item = document.aseForm.item.value;
			}

			if (tid != "0"){
				rtn = "displayusrmsg";
				lnk = "&mid="+tid+"&item="+item;
			}
			else{
				rtn = "usrbrd";
				lnk = "";
			}

		}
		else{
			rtn = "display";
		}

		aseForm.action = rtn + ".jsp?fid=" + fid + lnk;
		aseForm.submit();

		return true;
	}

	function editForm(){

		aseForm.action = "post.jsp";

		aseForm.submit();

		return true;
	}

	function aseSubmitClick(dest) {

		var kix = document.aseForm.kix.value;
		aseForm.action = "../gnrcmprt.jsp?src=" + dest + "&kix=" + kix;
		aseForm.submit();

		return true;
	}

	function resetForm(){

		if(document.aseForm.mode.value=='a'){
			if(document.aseForm.subject){
				document.aseForm.subject.value = "";
			}

			if(CKEDITOR.instances.message){
				CKEDITOR.instances.message.setData("");
			}
		}

		return false;
	}

