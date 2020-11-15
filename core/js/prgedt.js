<!--
	function aseSubmitClick(dest) {

		var kix = document.aseForm.kix.value;
		document.aseForm.action = "gnrcmprt.jsp?src=" + dest + "&kix=" + kix;
		document.aseForm.submit();

		return true;
	}

	function otherDepartment() {

		var kix = document.aseForm.kix.value;
		var src = document.aseForm.src.value;
		document.aseForm.action = "crsX29.jsp?src=" + src + "&kix=" + kix;
		document.aseForm.submit();

		return true;
	}

	function aseApprovalClick(action) {

		document.aseForm.formAction.value = action;

		var kix = document.aseForm.kix.value;

		aseForm.action = "prgedt6.jsp?kix=" + kix;

		aseForm.submit();

		return true;
	}

	function aseReviewClick(action) {

		aseApprovalClick(action);

		return true;
	}

	function cancelForm(){
		document.aseForm.action = "tasks.jsp";
		aseForm.submit();
	}

	function confirmDelete(){
		if ( document.aseForm.aseDelete ){
			if ( document.aseForm.aseDelete.value == "Delete" )
			  return confirm('Delete record?');
		}

		return false;
	}

	function checkForm(action){

		document.aseForm.formAction.value = action;

		return true;
	}

	var element = "";

	//
	//
	//
	function hidePost(element){

		document.getElementById(element).innerHTML = "";
		document.getElementById(element).style.visibility = "hidden";

		return false;

	}

	//
	//
	//
	function showPost(fid,item){

		element = "reviewerComments"+item;

		document.getElementById(element).style.visibility = "hidden";

		var destURL = "./forum/prtpst.jsp?fid="+fid+"&itm="+item;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = trigger;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);

		document.getElementById(element).style.visibility = "visible";

		return false;

	}

	//
	//trigger
	//
	function trigger() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById(element).innerHTML = xmlhttp.responseText;
			}
		}
	}

//-->