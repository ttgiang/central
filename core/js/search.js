var currentRequest = "";
var lastRequest = "";
var lastActivityCode = "";
var dest = 'content';
var rqArray = new Array();
var userOnlinePreference = 0;
var currentBox = "";
var nextBox = "";
var headerBox = "";

function getResults(filter,activityCode) {

	if (filter == undefined) {
		return false;
	}

	lastRequest = currentRequest;
	currentRequest = filter;

	var thisFilter = document.getElementById(filter);

	if (thisFilter) {
		document.title = strTitlePreamble+thisFilter.innerHTML;
	}

	var dataUrl = null;

	switch (activityCode){
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
			dataUrl = 'getdata.jsp?i=' + activityCode + '&q='+filter;
			break;
		default:
			dest = '';
			document.getElementById('loadingresults').className = 'popShow';
			var cnt = document.getElementById('content');
			setScroll(0,findPosY(cnt));
	}

	if ( activityCode < 4 ){
		// when on the 3rd box, we clear the 4th. but nothing more
		headerBox = "hdr" + (activityCode+1);
		currentBox = "p" + (activityCode+1);
		if ( activityCode <= 2 )
			nextBox = "p" + (activityCode+2)
		else
			nextBox = "";

		document.getElementById(headerBox).innerHTML = filter;
		document.getElementById('loadingresults').className = 'popHide';
		document.getElementById(currentBox).innerHTML = strP2Loading;
		document.getElementById('browse_start').className = 'popHide';

		if ( nextBox != null && nextBox.length > 0 )
			document.getElementById(nextBox).innerHTML = '';
		ajaxCall(dataUrl,displayResults,0,0,currentRequest);
	}
	else{
		ajaxCall(dataUrl,displayDetails,0,0,currentRequest);
	}

	var tc = document.getElementById('mainContent');
	return false;
}

function displayResults(http,returnRequest) {
	//only process the update visually if the returnRequest variable matches
	if (returnRequest == currentRequest) {
		//If remote page returns session timeout, get them to log in again
		if (http.responseText == "Session timed out") {
			alert(strDisplayResultsSessionTimeout);
		} else if (http.responseText == "Bad request") {
			return false;
		} else {
			document.getElementById(currentBox).innerHTML = http.responseText;

			if ( nextBox != null && nextBox.length > 0 )
				document.getElementById(nextBox).innerHTML = '';

			var tc = document.getElementById('theContent');
			var te = document.getElementById('theContent');
			if (rqArray.length > 0) {getResultArray();};
		}
	} else {
		//request has been surpassed
	}
}
