
var CAS_Server = "https://login.its.hawaii.edu/cas/";
var MyServer = "http://166.122.36.251:8080/central/core/cas.jsp";

var greeting = "World"; // In case I fail
var line0 = "";
var line1 = "";
var line2 = "";
var line3 = "";
var line4 = "";

function getCas(uid,ticket) {
	if (!uid) {
		// Check for ticket returned by CAS redirect
		if (!ticket) {
			// No session, no ticket, Redirect to CAS Logon page
			var url = CAS_Server+"login?"+"service="+MyServer;
			window.location = url;
			//Response.End;
		} else {
			// Back from CAS, validate ticket and get userid
			var http = new ActiveXObject("Microsoft.XMLHTTP");
			var url = CAS_Server+"validate?ticket="+ticket+"&"+"service="+MyServer;
			http.open("GET",url,false); // HTTP transaction to CAS server
			http.send();

			var resp=http.responseText.split('\n'); // Lines become array members
			if (resp[0]=="yes") {  // Logon successful
				greeting = resp[1]; // get userid for message
				line0 = resp[0] + "\n";
				line1 = resp[1] + "\n";
				line2 = resp[2] + "\n";
				line3 = resp[3] + "\n";
				line4 = resp[4] + "\n";
				// Save for subsequent calls
				//Session.Contents("Netid")=resp[1];
				//Session.Contents("Name")=resp[3];
			}
		}
	}
	else {
		//greeting = Session.Contents("Name");
	}

}
