var xmlHttp
var divID

function getDetail(lid) {
	var dataUrl = 'detail.asp?lid=' + lid;
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

function showAjax(str,action)
{
	xmlHttp=GetXmlHttpObject();

	if (xmlHttp==null){
		alert ("Your browser does not support AJAX!");
		return;
	}

	var x = parseInt(action);
	var url = "";
	var dataPage = "";

	switch (x){
		case 1 :
			dataPage = "crsassrpt01.jsp";
			divID = "crsassrpt01";
			break;
		case 2 :
			dataPage = "crsassrpt02.jsp";
			divID = "crsassrpt02";
			break;
		case 11 :
			dataPage = "crsassrpt11.jsp";
			divID = "crsassrpt11";
			break;
		case 12 :
			dataPage = "crsassrpt12.jsp";
			divID = "crsassrpt12";
			break;
		case 13 :
			dataPage = "crsassrpt13.jsp";
			divID = "crsassrpt13";
			break;
	}

	url = dataPage + "?q=" + str;
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChanged(){
	if (xmlHttp.readyState==4){
		document.getElementById(divID).innerHTML=xmlHttp.responseText;
	}
}

function GetXmlHttpObject(){
	var xmlHttp=null;
	try
	{
		// Firefox, Opera 8.0+, Safari
		xmlHttp=new XMLHttpRequest();
	}
	catch (e)
	{
		// Internet Explorer
		try
		{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)
		{
			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	}

	return xmlHttp;
}