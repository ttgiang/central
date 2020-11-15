<!--
		function confirmDelete(){
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function deleteNews(id) {
			aseForm.action = "newsx.jsp?lid="+id;
			document.aseForm.submit();
			return true;
		}

		function checkForm(){

			if (document.aseForm.mnu && document.aseForm.mnu.value == '1'){
				if (document.aseForm.infotitle){
					if (document.aseForm.infotitle.value == '' ){
						alert( "Title is a required field.");
						document.aseForm.infotitle.focus();
						return false;
					}
				}

				var ckContent = CKEDITOR.instances["infocontent"].getData();
				if(ckContent == ""){
					alert( "Content is a required field.");
					return false;
				}

			}

			return true;
		}

		function cancelForm(){
			aseForm.action = "newsidx.jsp";
			aseForm.submit();
		}

//-->