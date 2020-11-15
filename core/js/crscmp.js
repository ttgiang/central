<!--
	function returnToProposer() {
		document.aseApprovalForm.action = "crsrwslox.jsp";
		document.aseApprovalForm.submit();
		return false;
	}

	function checkForm(action){
		return true;
	}

	function aseSubmitClick(dest) {

		var comp = document.aseForm.comp.value;

		if(comp==""){
			alert( "SLO content is required.");
			document.aseForm.comp.focus();
			return false;
		}
		else{

			var len = 900;

			if(comp.length > 0){

				var diff = comp.length - len;

				if (comp.length > len){
					alert( "Content length is " + diff + " character(s) over the " + len + " characters limit.");
					document.aseForm.comp.focus();
					return false;
				}
			}
		}

		document.aseForm.act.value = "a";

		return true;
	}

	function aseSubmitClick0(kix,src,dst,keyid) {
		document.aseForm.kix.value = kix;
		document.aseForm.src.value = src;
		document.aseForm.dst.value = dst;
		document.aseForm.keyid.value = keyid;
		aseForm.action = "crslnkr.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick2(comp) {
		document.aseForm.compID.value = comp;
		document.aseForm.act.value = "r";
		aseForm.action = "crscmpw.jsp";
		document.aseForm.submit();
		return true;
	}

	function aseSubmitClick3(id) {
		var alpha = document.aseForm.alpha.value;
		var num = document.aseForm.num.value;
		document.aseForm.compID.value = id;
		aseForm.action = "crscmp.jsp?id=" + id;
		aseForm.submit();
	}

	function proceed(dest) {
		var alpha = document.aseForm.alpha.value;
		var num = document.aseForm.num.value;
		var comp = document.aseForm.comp.value;
		var compID = document.aseForm.compID.value;
		var destURL = "?act=" + dest;

		if (comp.length>0){
			document.cookie = "comp=" + comp;
			loadData(destURL + "&alpha=" + alpha + "&num=" + num + "&type=PRE" + "&compID=" + compID + "&comp=" + comp);
		}
		else{
			alert( "SLO content is required.");
			document.aseForm.comp.focus();
		}
	}

	function aseOnLoad(alpha,num,sh,caller) {
		if (caller=="crsedt" || caller=="crscmp"){
			var destURL = "?alpha=" + alpha + "&num=" + num + "&sh=" + sh + "&type=PRE";
			loadData(destURL);
		}
	}

	function cancelForm(kix,tab,no,caller,campus){

		if ((tab=="" && no=="") || (tab=="0" && no=="0")){
			aseForm.action = "index.jsp";
		}
		else{

			if(caller == 'crsedt'){
				aseForm.action = "crsedt.jsp?ts=" + tab + "&no=" + no + "&kix=" + kix;
			}
			else if(caller == 'crsfldy'){
				aseForm.action = caller + ".jsp?cps=" + campus + "&kix=" + kix;
			}

		}

		aseForm.submit();

		return false;

	}

	function aseReviewClick(dest) {
		var alpha = document.aseForm.alpha.value;
		var num = document.aseForm.num.value;
		var campus = document.aseForm.campus.value;

		var url = alpha + "-" + num + "-" + campus;

		var destURL = "/central/core/crscmpz.jsp"

		window.location = destURL;

		// use false to prevent form submission
		return false;
	}

	function loadData(dest) {
		var destURL = "/central/core/crsassr.jsp" + dest;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = triggered;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);

		document.aseForm.comp.value = "";
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
