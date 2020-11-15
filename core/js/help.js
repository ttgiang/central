function getHelpNewsIndex(lid) {
	var dataUrl = 'newsdtlx.jsp?lid=' + lid;
	ajaxCall(dataUrl,displayHelp,1);
	var helpPanel = document.getElementById('help_container');
	helpPanel.innerHTML = 'Loading results';
	helpPanel.className = 'popShow';
	return false;
}

function showCourseStatus(lid) {

	// lid comes over as alpha + number include spaces in between
	// need to separate before showing approval status
	var alpha = "";
	var num = "";
	var link = lid;
	link = Trim(link);

	var npos = link.indexOf(" ");

	if ( npos > 0 ){
		alpha = link.substring(0,3);
		num = Trim(link.substring(3));
	}

	var dataUrl = 'crsstsh.jsp?help=1&alpha=' + alpha + "&num=" + num;
	ajaxCall(dataUrl,displayHelp,1);
	var helpPanel = document.getElementById('help_container');
	helpPanel.innerHTML = 'Loading results';
	helpPanel.className = 'popShow';
	return false;
}

//display the page content
function displayHelp(http) {
	var helpPanel = document.getElementById('help_container');
	helpPanel.innerHTML = http.responseText;
}

function closeTaskWindow() {
	var helpPanel = document.getElementById('help_container');
	helpPanel.innerHTML = "";
	helpPanel.className = 'popHide';
}
