var nocookies = null;

function setNoCookies(strCookie) {
	nocookies = strCookie;
	return true;
}

function ajaxCall(dataUrl,returnFunction,nocache,debug,returnVar) {
	//create a variable for handling requests to be reused
	var http = null;
	//If nocache is passed, make each call unique
	if (nocache != null && nocache == 1) {
		var dt = new Date();
		var dtString = ''+dt.getFullYear()+dt.getMonth()+dt.getDate()+dt.getHours()+dt.getMinutes()+dt.getMilliseconds();
		//check for cookie - if disabled then append request.nocookies
		dataUrl = dataUrl + '&dtm='+dtString;
	}
	if (document.cookie == "") {
		dataUrl = dataUrl + '&' + nocookies;
	}
	//prompt('',dataUrl);
	if (debug != null && debug == 1 ) {prompt('',dataUrl);};

	//try to create the xmlHttpRequest object with non-IE code first, else fallback on IE
	try {
		http = new XMLHttpRequest(); // non-IE
		} catch (error){
			try {
				http = new ActiveXObject("Microsoft.XMLHTTP"); // IE
			} catch (error) {
				return false;
			}
	}
	// more error checking
	try {
		//open the http page
		http.open("GET", dataUrl , true);
	} catch (error) {
		alert(strHttpError);
		return false;
	}
	//upon a change of status of the request for the lookup page, call the javascript handler
	http.onreadystatechange = function() {
		//readystate of 4 means the request is complete
		if (http.readyState == 4) {
			//status code of 200 means OK (regular status codes)
			if (http.status != 200) {
				alert(strBadResponseCode);
				return false;
			} else {
				returnFunction(http,returnVar);
			}
		}
	}
	//close the connection (very important for memory leaks)
	http.send(null);
	return false;
}

