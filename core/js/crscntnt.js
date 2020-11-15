<!--
	function aseSubmitClick0(kix,src,dst,keyid,clr) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		aseForm.action = "crslnkr.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick(dest,len) {

		//var description = document.aseForm.description.value;
		//if(description == ""){
		//	alert("Description is required");
		//	document.aseForm.description.focus();
		//	return false;
		//}

		var content = document.aseForm.content.value;
		var diff;

  		var editorContent = CKEDITOR.instances['content'].getData().replace(/<[^>]*>/gi, '');

		// if and else works the same except if is for CKEditor
  		if(editorContent){
			diff = editorContent.length - len;

			if(editorContent.length == "0"){
				alert("Content is required");
				document.aseForm.content.focus();
				return false;
			}
			else{
				if (editorContent.length > len){
					alert( "Content length is " + diff + " character(s) over the " + len + " characters limit.");
					document.aseForm.content.focus();
					return false;
				}
			}
		}
		else{
			diff = content.length - len;

			if(content == ""){
				alert("Content is required");
				document.aseForm.content.focus();
				return false;
			}
			else{
				if (content.length > len){
					alert( "Content length is " + diff + " character(s) over the " + len + " characters limit.");
					document.aseForm.content.focus();
					return false;
				}
			}
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick2X(id) {
		if (confirm('Delete Record?')){
			document.aseForm.reqID.value = id;
			document.aseForm.act.value = "r";
			document.aseForm.submit();
			return true;
		}

		return false;
	}

	function aseSubmitClick2(keyid) {
		document.aseForm.keyid.value = keyid;
		document.aseForm.act.value = "r";
		aseForm.action = "crscntntx.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick3(id) {
		aseForm.action = "crscntnt.jsp?id=" + id;
		aseForm.submit();
	}

	function aseOnLoad() {
		//var alpha = document.aseForm.thisAlpha.value;
		//var num = document.aseForm.thisNum.value;
		//var destURL = "?alpha=" + alpha + "&num=" + num + "&type=PRE";
		//loadData(destURL);
	}

	function cancelForm(alpha,num,tab,no,caller,campus){

		if(caller == 'crsedt'){
			aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&alpha=" + alpha + "&num=" + num;
		}
		else if(caller == 'crsfldy'){
			aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
		}

		aseForm.submit();
	}

	function loadData(dest) {

		var destURL = "/central/core/crscntntx.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);

		document.aseForm.description.value = "";
		document.aseForm.cnt.value = "";
	}

	function triggered() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById("output").innerHTML =xmlhttp.responseText;
			}
		}
	}

	function get_cookie(Name) {

		var search = Name + "=";
		var returnvalue = "";

		if (document.cookie.length > 0) {
			offset = document.cookie.indexOf(search)

			// if cookie exists
			if (offset != -1) {
				offset += search.length;

				// set index of beginning of value
				end = document.cookie.indexOf(";", offset);

				// set index of end of cookie value
				if (end == -1)
					end = document.cookie.length;

				returnvalue = unescape(document.cookie.substring(offset, end));
			}
		}
		return returnvalue;
	}
-->
