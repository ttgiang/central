<!--
	function cancelForm(){

		var alpha = document.aseForm.alpha.value;
		var num = document.aseForm.num.value;
		var campus = document.aseForm.campus.value;

		aseForm.action = "/central/core/crsslo.jsp?alpha=" + alpha + "&num=" + num + "&campus=" + campus + "&view=PRE";
		aseForm.submit();
	}

	function checkForm(action){

		var isApprover = document.aseForm.approver.value;
		var wantsNotification = document.aseForm.wantsNotification.value;

		document.aseForm.formAction.value = action;

		/*
			if is the approver, make sure to warn when not all have been approved.
			it doesn't stop them from moving on, just a reminder.

			selectedCheckBoxes - counts number of check boxes selected
			selectedHiddenCheckBoxes - counts the hidden fields not showing because already selected
		*/
		if (isApprover=="true" && wantsNotification=="1"){
			if (document.aseForm.controls){
				var numberOfControls = document.aseForm.controlsToShow.value;
				var selectedCheckBoxes = 0;
				var selectedHiddenCheckBoxes = 0;
				var chkBox;

				for (i=0; i<numberOfControls; i++){
					chkBox = eval("document.aseForm.chk" + i);
					if (chkBox.checked){
							++selectedCheckBoxes;
					} // if
				}	// for

				for (i=0; i<numberOfControls; i++){
					chkBox = eval("document.aseForm.chk" + i);
					if (chkBox.value=="1"){
							++selectedHiddenCheckBoxes;
					} // if
				}	// for

			}	// if

			if ((selectedCheckBoxes+selectedHiddenCheckBoxes)!=numberOfControls){
				return confirm('You have not approved all SLOs.\nDo you wish to continue?');
			}

		}	// if

		return true;

	}

-->
