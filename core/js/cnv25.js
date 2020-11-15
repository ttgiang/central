<!--

	var debug = "";

	//////////////////////
	function addToTemplate() {

		var itemList = document.getElementById('itemList');

		var selectedIndex = itemList.selectedIndex;

		if (selectedIndex > -1){

			var text = itemList.options[selectedIndex].text;
			var value = itemList.options[selectedIndex].value;

			if (document.aseForm.bold && document.aseForm.bold.checked){
				text = "<b>" + text + "</b>";
				value = "<b>" + value + "</b>";
			}

			if (document.aseForm.italics && document.aseForm.italics.checked){
				text = "<i>" + text + "</i>";
				value = "<i>" + value + "</i>";
			}

			var underline = "";
			if (document.aseForm.underline && document.aseForm.underline.checked){
				text = "<u>" + text + "</u>";
				value = "<u>" + value + "</u>";
			}

			var omit = "";
			if (document.aseForm.omit && document.aseForm.omit.checked){
				text = "<cc_nb>" + text + "</cc_nb>";
				value = "<cc_nb>" + value + "</cc_nb>";
			}

			if (itemList.options[selectedIndex].text != ''){
				insertLine(value,text);

				debug = debug + value;
			}

		} // valid item selected

		if (document.aseForm.rtn && document.aseForm.rtn.checked){
			debug = debug + "<br>";
			insertLine("rtn","Append RETURN key");
		}

		if (document.aseForm.spc && document.aseForm.spc.checked){
			debug = debug + "&nbsp;";
			insertLine("spc","Append SPACE");
		}

		// update debug view
		if (document.getElementById("debug")){
			document.getElementById("debug").innerHTML = debug;
		}

		return false;

	}

	function insertLine(value,text){

		var elOptNew = document.createElement('option');
		elOptNew.text = text;
		elOptNew.value = value;
		var elSel = document.getElementById('templateList');

		try {
			elSel.add(elOptNew, null); // standards compliant; doesn't work in IE
		}
		catch(ex) {
			elSel.add(elOptNew); // IE only
		}

		return false;
	}

	function removeFromTemplate(){

		var elSel = document.getElementById('templateList');

		var i;

		for (i = elSel.length - 1; i >= 0; i--) {
			if (elSel.options[i].selected) {
				elSel.remove(i);
			}
		}

		return false;
	}

	//////////////////

	function insertOptionBefore(num)
	{
	  var elSel = document.getElementById('templateList');
	  if (elSel.selectedIndex >= 0) {
		 var elOptNew = document.createElement('option');
		 elOptNew.text = 'Insert' + num;
		 elOptNew.value = 'insert' + num;
		 var elOptOld = elSel.options[elSel.selectedIndex];
		 try {
			elSel.add(elOptNew, elOptOld); // standards compliant; doesn't work in IE
		 }
		 catch(ex) {
			elSel.add(elOptNew, elSel.selectedIndex); // IE only
		 }
	  }
	}

	function removeOptionLast()
	{
	  var elSel = document.getElementById('templateList');
	  if (elSel.length > 0)
	  {
		 elSel.remove(elSel.length - 1);
	  }
	}


-->
