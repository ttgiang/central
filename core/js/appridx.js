<!--

	//
	// cancelForm
	//
	function cancelForm(){
		aseForm.action = "index.jsp";
		aseForm.submit();
	}

	//
	// loadRoutes
	//
	function loadRoutes(college,level) {

		var url = "appridxx.jsp?c=" + college + "&l=" + level;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", url);
		xmlhttp.send(null);
	}

	//
	// triggered
	//
	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("routeDiv").innerHTML = xmlhttp.responseText;
			}
		}
	}

	//
	// collegeChange
	//
	function collegeChange(){

		if (document.aseForm.college){

			var c = document.getElementById("college");
			var college = c.options[c.selectedIndex].value;

			var x = document.getElementById("level");
			var level = x.options[x.selectedIndex].value;

			if (college != '' && level != ''){

				//var r = document.getElementById("route");
				//r.options[0].selected = true;
				//r.disabled = false;

				loadRoutes(college,level);
			}

		}
	}

	//
	// levelChange
	//
	function levelChange(){

		if (document.aseForm.level){

			collegeChange();

		}

	}

-->

