<!--
		function cancelForm(table){
			aseForm.action = "dfqst.jsp?t=" + table;
			aseForm.submit();
		}

		function confirmDelete(){
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function checkForm(){
			var questionseq = document.aseForm.questionseq.value;
			var question = document.aseForm.question.value;

			if (document.aseForm.include_0[0] && document.aseForm.include_0[0].checked){

				if ( questionseq == '' ) {
					alert( "Question sequence is a required field.");
					document.aseForm.questionseq.focus();
					return false;
				}
				else{
					if (parseInt(questionseq) < 1){
						alert( "Invalid question sequence.");
						document.aseForm.questionseq.focus();
						return false;
					}
				}

				if ( question == '' ) {
					alert( "Question is a required field.");
					document.aseForm.question.focus();
					return false;
				}

			}

			return true;
		}
//-->