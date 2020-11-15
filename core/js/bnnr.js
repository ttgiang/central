<!--
		function confirmDelete(){
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function deleteBannerData(key,tbl) {
			aseForm.action = "bnnrx.jsp?key="+key+"&tbl="+tbl;
			document.aseForm.submit();
			return true;
		}

		function checkForm(){

			if (document.aseForm.code){
				if (document.aseForm.code.value == '' ){
					alert( "Code is a required field.");
					document.aseForm.code.focus();
					return false;
				}
			}

			if (document.aseForm.descr){
				if ( document.aseForm.descr.value == '' ){
					alert( "Desription is a required field.");
					document.aseForm.descr.focus();
					return false;
				}
			}

			return true;
		}

		function cancelForm(rtn){

			aseForm.action = rtn + ".jsp";
			aseForm.submit();

		}

//-->