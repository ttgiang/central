var xmlHttp

function stateChanged()
{
	if (xmlHttp.readyState==4)
	{
		document.getElementById("txtReviewers").innerHTML=xmlHttp.responseText;
	}
}

function GetXmlHttpObject()
{
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

function checkForm(action){
	return true;
}

function validateForm(action){

	var result;
	var deleteEntry = false;
	var requiredList1 = false;
	var requiredList2 = false;
	var requiredList3 = false;

	var list1Value = 0;
	var list2Value = 0;
	var list3Value = 0;

	if (document.aseForm.contentGroup){
		for (var i=0; i<document.aseForm.contentGroup.length; i++)  {
			if (document.aseForm.contentGroup[i].checked)  {
				list1Value = document.aseForm.contentGroup[i].value
			}
		}
	}

	if (document.aseForm.compGroup){
		for (var i=0; i<document.aseForm.compGroup.length; i++)  {
			if (document.aseForm.compGroup[i].checked)  {
				list2Value = document.aseForm.compGroup[i].value
			}
		}
	}

	if (document.aseForm.assessGroup){
		for (var i=0; i<document.aseForm.assessGroup.length; i++)  {
			if (document.aseForm.assessGroup[i].checked)  {
				list3Value = document.aseForm.assessGroup[i].value
			}
		}
	}

	var alpha = document.aseForm.alpha.value;
	var num = document.aseForm.num.value;
	var type = document.aseForm.type.value;
	var dest = "?act=" + action + "&alpha=" + alpha + "&num=" + num + "&type=" + type + "&l1=" + list1Value + "&l2=" + list2Value + "&l3=" + list3Value

	if (action=="r"){
		result = confirm('Continue and delete assessment?');
		if (result){
			deleteEntry = true;
		}
	}
	else if (action=="a"){
		deleteEntry = true;
	}

	if (deleteEntry){
		loadData(dest);
	}
}

/*
	for dynamic list of content-slo-assessment connection
*/
function aseOnLoad(kix) {
	loadData("?kix=" + kix);
}

function cancelForm(){
	aseForm.action = "index.jsp";
	aseForm.submit();
}

function loadData(dest) {

	var destURL = "/central/core/crscntidx.jsp" + dest;

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
			document.getElementById("output").innerHTML = xmlhttp.responseText;
		}
	}
}

function reLoadPage(kix,cid){

	aseForm.action = "crsslo.jsp?kix="+kix+"&cid="+cid;

	aseForm.submit();

}
