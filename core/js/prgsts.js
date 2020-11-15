<!--
	var divID = "";

	function aseOnLoad(id,divName) {
		var alpha = "";
		var num = "";

		// the id coming over onclick is ALPHA_NUM
		// this section splits up the 2 and sets alpha and num
		if ( id.length > 0 ) {
			var pos = 0;
			pos = id.indexOf("_");
			if ( pos > 0 ) {
				alpha = id.substring(0,pos);
				num = id.substring(pos+1);
			}
		}

		/*
			when called by sltcrs, the divID is the alpha_num;
			when called from ApproverDB.showApprovalProgress, the id is output
		*/
		if (divName=="") divName = id;
		divID = divName;

		var destURL = "/central/core/prgstsh.jsp?help=0&alpha=" + alpha + "&num=" + num;

		loadData(destURL);
	}

	function aseOnLoadX(id) {
		aseOnLoad(id);

		divID = "APPROVER_LISTING";

		loadData("/central/core/appridx.jsp?dsp=1");
	}

	function loadData(dest) {

		var destURL = dest;

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
				document.getElementById(divID).innerHTML =xmlhttp.responseText;
			}
		}
	}
-->
