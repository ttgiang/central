var stOpenDateTime = null;
var dtmRegistrationOpen = null;
var dtmRegistrationOpen = null;
var dtmLocalTime = null;
var dtmServerTime = null;
var dtmOffset = null;

function setRegDate(strOpenDateTime,strServerTime) {
	stOpenDateTime = strOpenDateTime;
	// set up times in javascript based on machine local time AND difference between local machine and server
	// registration open
	dtmRegistrationOpen = new Date(strOpenDateTime);
	// get current computer time, compare to server time
	dtmLocalTime = new Date();
	//var localTime = localTime.getDate();
	dtmServerTime = new Date(strServerTime);	
	// offset
	dtmOffset = (dtmLocalTime.getTime() - dtmServerTime.getTime());
	if (document.getElementById("reg_countdown")) {
		if (document.getElementById('reg_timer')) {start();}
	}
	return true;
}


function start() {
	setup("reg_timer");
	repeat();
}

function repeat() {
	countdown("reg_timer");
	setTimeout("repeat()",900);
}

function setup(timer) {
	time = dtmRegistrationOpen.getTime() - dtmLocalTime.getTime() + dtmOffset;
	document.getElementById(timer).innerHTML=time;
}

function countdown(timer) {
	// keeps referencing the form for the next iteration of time and thus loses track
	//document.forms[timer].time_open.value = document.forms[timer].time_open.value - 1000;
	//time = document.forms[timer].time_open.value;
	// instead, get local machine time, use offset and calculate difference from that.
	var dtmLocalTimeCounter = new Date();
	time = dtmRegistrationOpen.getTime() - dtmLocalTimeCounter.getTime() + dtmOffset;
	days = (time - (time % 86400000)) / 86400000;
	time = time - (days * 86400000);
	hours = (time - (time % 3600000)) / 3600000;
	time = time - (hours * 3600000);
	mins = (time - (time % 60000)) / 60000;
	time = time - (mins * 60000);
	secs = (time - (time % 1000)) / 1000;
	if (days==1) out = "1 day, ";
	else out = days+" days, ";
	if (hours < 10) out = out+"0";
	out = out+hours+":";
	if (mins < 10) out = out+"0";
	out = out+mins+":";
	if (secs < 10) out = out+"0";
	out = out+secs;
	if (days+hours+mins+secs > 0) {
		document.getElementById(timer).innerHTML = out;
	} else if (document.getElementById("reg_countdown")) {
		document.getElementById("reg_countdown").innerHTML = '';
		document.getElementById(timer).innerHTML = strRegistrationOpenBanner;
	}
} 
