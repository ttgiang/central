var xmlHttp

function showPrograms(programid){
	showBannerAlphas(programid);
	showSelectedAlphas(programid);

	document.aseForm.programid.value = programid;
}

function showBannerAlphas(programid){
	xmlHttp=GetXmlHttpObject();

	if (xmlHttp==null){
		alert ("Your browser does not support AJAX!");
		return;
	}

	var newDate = new Date();

	var url = "pgrchrz.jsp?programid=" + programid;
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}


function stateChanged()
{
	if (xmlHttp.readyState==4)
	{
		document.getElementById("txtAlphas").innerHTML=xmlHttp.responseText;
	}
}

function showSelectedAlphas(programid){
	xmlHttp=GetXmlHttpObject();

	if (xmlHttp==null){
		alert ("Your browser does not support AJAX!");
		return;
	}

	var url = "pgrchrw.jsp?programid=" + programid;
	xmlHttp.onreadystatechange=stateChanged2;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChanged2()
{
	if (xmlHttp.readyState==4)
	{
		document.getElementById("txtSelectedAlphas").innerHTML=xmlHttp.responseText;
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

function cancelForm(){
	aseForm.action = "dividx.jsp";
	aseForm.submit();
}

function cancelForm2(){
	aseForm.action = "authidx.jsp";
	aseForm.submit();
}

function checkForm(action)
{
	return true;
}

//
// for selecting from source to destination
//

sortitems = 1;  // Automatically sort items within lists? (1 or 0)

function addSelectedItemsToParent(){
	submitWindow();
	addToSelectedList(document.aseForm.toList);
	return true;
}

function move(fbox,tbox)
{
	for(var i=0; i<fbox.options.length; i++){
		if(fbox.options[i].selected && fbox.options[i].value != ""){
			var no = new Option();
			no.value = fbox.options[i].value;
			no.text = fbox.options[i].text;
			tbox.options[tbox.options.length] = no;
			fbox.options[i].value = "";
			fbox.options[i].text = "";
		}
	}

	BumpUp(fbox);

	if (sortitems)
		SortD(tbox);
}

function BumpUp(box){
	for(var i=0; i<box.options.length; i++)
	{
		if(box.options[i].value == "")
		{
			for(var j=i; j<box.options.length-1; j++)
			{
				box.options[j].value = box.options[j+1].value;
				box.options[j].text = box.options[j+1].text;
			}
			var ln = i;
			break;
	}
	}

	if(ln < box.options.length)
	{
		box.options.length -= 1;
		BumpUp(box);
	}
}

function SortD(box)
{
	var temp_opts = new Array();
	var temp = new Object();

	for(var i=0; i<box.options.length; i++)
	{
		temp_opts[i] = box.options[i];
	}

	for(var x=0; x<temp_opts.length-1; x++)
	{
		for(var y=(x+1); y<temp_opts.length; y++)
		{
			if(temp_opts[x].text > temp_opts[y].text)
			{
				temp = temp_opts[x].text;
				temp_opts[x].text = temp_opts[y].text;
				temp_opts[y].text = temp;
				temp = temp_opts[x].value;
				temp_opts[x].value = temp_opts[y].value;
				temp_opts[y].value = temp;
			}
	}
	}

	for(var i=0; i<box.options.length; i++)
	{
		box.options[i].value = temp_opts[i].value;
		box.options[i].text = temp_opts[i].text;
	}
}

// force selection of all items
function submitWindow(){
	selectList(	document.aseForm.toList );
}

function selectList(sourceList){

	for(var i = 0; i < sourceList.options.length; i++)
	{
		if (sourceList.options[i] != null)
			sourceList.options[i].selected = true;
	}

	return true;
}

function addToSelectedList(sourceList)
{
	var newList = "";
	var i = 0;
	var bDone = 0;

	while ( i < sourceList.options.length && bDone == 0 ){
		if (sourceList.options[i] != null){
			if ( newList == "" )
				newList = sourceList.options[i].value;
			else
				newList = newList + "," + sourceList.options[i].value;
		}
		++i;
	}

	document.aseForm.formSelect.value = newList;
}

function findSelectedItem(sourceList)
{
	var found = "";
	var i = 0;

	while (i < sourceList.options.length && found == ""){
		if (sourceList.options[i] != null){
			found = sourceList.options[i].value;
		}
		++i;
	}

	return found;
}

function validateForm(action){

	var toList = document.aseForm.toList;
	var rtn = false;

	/*

	2010.04.15 - OK to have empty list. Deal with it in programming

	if ( toList.options.length == 0 ){
		alert( "Please select at least 1 reviewer." );
		rtn = false;
	}
	else{
		addSelectedItemsToParent();
		rtn = true;
	}
	*/

	addSelectedItemsToParent();
	rtn = true;

	return rtn;
}

function validateForm0(action){

	return true;
}
