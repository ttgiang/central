<!--
	function cancelForm(){
		aseForm.action = "dsplst.jsp";
		aseForm.submit();
	}

	function checkForm(action){

		document.aseForm.formAction.value = action;

		if (document.aseForm.src && document.aseForm.src.value == '' ){
			alert( "Category is required.");
			document.aseForm.src.focus();
			return false;
		}

		if (document.aseForm.forumName && document.aseForm.forumName.value == '' ){
			alert( "Title is required.");
			document.aseForm.forumName.focus();
			return false;
		}

		var ckContent = CKEDITOR.instances["forumDescr"].getData();
		if(ckContent == ""){
			alert( "Description is a required field.");
			return false;
		}

		return true;
	}

	function categoryOnChange() {

		var controlName = document.aseForm.src;

		var controlValue = controlName.value;

		var controlIndex = controlName.selectedIndex;

		var selectedText = controlName.options[controlIndex].text;

		var ckEditor = "forumDescr";

		var message = "";

		if(selectedText=='Defect Reporting'){

			message = "Browser name/version:&nbsp;<br/><br/>"
						+ "Course alpha/Number or Program Title:&nbsp;<br/><br/>"
						+ "Affected user:&nbsp;<br/><br/>"
						+ "Date of defect:&nbsp;<br/><br/>"
						+ "Defect description:&nbsp;<br/><br/>"
						;
		}
		else{

			message = "";

		}

		CKEDITOR.instances[ckEditor].setData(message);

	}

-->
