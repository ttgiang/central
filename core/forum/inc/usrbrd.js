<!--
	var element = "";
	var mids = "";
	var itms = "";
	var gMidCounter = 0;
	var gFid = 0;

	//
	//
	//
	function createNewPost(){

		var fid = document.aseFormNewPost.fid.value;
		var kix = document.aseFormNewPost.kix.value;
		var items = document.aseFormNewPost.item.value;

		var n = items.split("_");
		var tab = n[0];
		var item = n[1];

		var link = "post.jsp?src=USR&rtn=&tab="+tab+"&fid="+fid+"&mid=0&item="+item+"&kix="+kix+"&level=2";

		document.aseFormNewPost.action = link;
		document.aseFormNewPost.submit();

		return false;

	}

	//
	//
	//
	function hidePost(fid,mid,item){

		element = fid+"_"+mid+"_"+item;

		document.getElementById(element).innerHTML = "";
		document.getElementById(element).style.visibility = "hidden";

		return false;

	}

	//
	//
	//
	function hideAllPosts(fid){

		if(document.aseForm2.mid){

			var mid = document.aseForm2.mid.value;
			var itm = document.aseForm2.itm.value;

			mids = mid.split(",");
			itms = itm.split(",");

			for(m=0;m<mids.length;m++){
				mid = mids[m];
				itm = itms[m];

				element = fid+"_"+mid+"_"+itm;
				document.getElementById(element).innerHTML = "";
				document.getElementById(element).style.visibility = "hidden";
			}

		}

		return false;

	}

	//
	//
	//
	function showAllPosts(fid){

		if(document.aseForm2.mid){

			var mid = document.aseForm2.mid.value;
			var itm = document.aseForm2.itm.value;

			mids = mid.split(",");
			itms = itm.split(",");

			gFid = fid;
			gMidCounter = 0;

			showPostX();

		}

		return false;

	}

	//
	//
	//
	function showPostX(){

		if (gMidCounter <= mids.length){

			var mid = mids[gMidCounter];
			var itm = itms[gMidCounter];

			element = gFid+"_"+mid+"_"+itm;

			document.getElementById(element).style.visibility = "hidden";

			var destURL = "dsppst.jsp?fid="+gFid+"&mid="+mid+"&itm="+itm;

			try {
				xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}

			xmlhttp.onreadystatechange = triggerAll;
			xmlhttp.open("GET", destURL);
			xmlhttp.send(null);

			document.getElementById(element).style.visibility = "visible";

		} // valid mid item

		return false;

	}

	//
	//trigger
	//
	function triggerAll() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById(element).innerHTML = xmlhttp.responseText;

				++gMidCounter;

				if(gMidCounter <= mids.length){
					showPostX();
				}
			}
		}
	}

	//
	//
	//
	function showPost(fid,mid,item){

		element = fid+"_"+mid+"_"+item;

		document.getElementById(element).style.visibility = "hidden";

		var destURL = "dsppst.jsp?fid="+fid+"&mid="+mid+"&itm="+item;

		try {
			xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {}

		xmlhttp.onreadystatechange = trigger;
		xmlhttp.open("GET", destURL);
		xmlhttp.send(null);

		document.getElementById(element).style.visibility = "visible";

		return false;

	}

	//
	//trigger
	//
	function trigger() {
		if (xmlhttp.readyState == 4) {
			if (xmlhttp.status == 200) {
				document.getElementById(element).innerHTML = xmlhttp.responseText;
			}
		}
	}

-->

