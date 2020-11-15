<!--

var xmlHttp
var returnedValue;

function cancelForm(){
	aseForm.action = "index.jsp";
	aseForm.submit();
}

function checkForm(action){

	if ( document.aseForm.alpha && document.aseForm.alpha.value == "" ){
		alert( "Course Alpha is required" );
		document.aseForm.alpha.focus();
		return false;
	}

	if ( document.aseForm.num && document.aseForm.num.value == "" ){
		alert( "Course number is required" );
		document.aseForm.num.focus();
		return false;
	}

	if ( document.aseForm.title && document.aseForm.title.value == "" ){
		alert( "Title is required" );
		document.aseForm.title.focus();
		return false;
	}

	document.aseForm.formAction.value = action;

	return true;
}


function alphaOnChange() {

	var alpha = document.aseForm.alpha.value;

	if (alpha != ""){
		var destURL = "?alpha=" + alpha;
		loadData(destURL);
	}
}

function loadData(dest) {

	var destURL = "/central/core/crscrtw.jsp" + dest;

	try {
		xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
	} catch (e) {}

	xmlhttp.onreadystatechange = triggered;
	xmlhttp.open("GET", destURL);
	xmlhttp.send(null);
}

function triggered() {
	if (xmlhttp.readyState == 4) {
		if (xmlhttp.status == 200) {
			document.getElementById("output").innerHTML =xmlhttp.responseText;
		}
	}
}

function checkData(dest) {

	returnedValue = "";

	var destURL = "/central/core/chk.jsp";
	try {
		xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
	} catch (e) {}

	xmlhttp.onreadystatechange = triggered;
	xmlhttp.open("GET", destURL);
	xmlhttp.send(null);
}

-->
