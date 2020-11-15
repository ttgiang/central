<!--
		function confirmDelete()
		{
			if ( document.aseForm.aseDelete ){
				if ( document.aseForm.aseDelete.value == "Delete" )
				  return confirm('Delete record?');
			}

			return false;
		}

		function printSyllabus(sid)
		{
			if ( sid == null ){
				alert( "Missing syllabus ID");
				return false;
			}
			else{
				var url = "syly.jsp?sid=" + sid;
				var syllabusView = window.open(url,"Syllabus");
			}

			// return false because this launches a new screen
			return false;
		}

		function checkForm()
		{
			if ( document.aseForm.coursealpha ){
				if ( document.aseForm.coursealpha.value == '' ){
					alert( "Please select course alpha.");
					document.aseForm.coursealpha.focus();
					return false;
				}
			}

			if ( document.aseForm.coursenum ){
				if ( document.aseForm.coursenum.value == '' ){
					alert( "Please enter course number.");
					document.aseForm.coursenum.focus();
					return false;
				}
			}

			if ( document.aseForm.semester ){
				if ( document.aseForm.semester.value == '' ){
					alert( "Please select a semester.");
					document.aseForm.semester.focus();
					return false;
				}
			}

			if ( document.aseForm.year ){
				if ( document.aseForm.year.value == '' ){
					alert( "Please enter a year.");
					document.aseForm.year.focus();
					return false;
				}
			}

			return true;
		}
//-->