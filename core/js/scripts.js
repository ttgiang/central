//function to locate an object
function findPosY(obj) {
	var curtop = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;
	return curtop;
}
//get window height
function findWindowHeight() {
	var y
	if (window.innerHeight) // all except Explorer
	{
		y = window.innerHeight;
	}
	else if (document.documentElement && document.documentElement.offsetHeight)
		// Explorer 6 Strict
	{
		y = document.documentElement.offsetHeight;
	}
	else if (document.body) // all other Explorers
	{
		y = document.body.offsetHeight;
	}	
	return y;
	//return winH = (navigator.appName=="Netscape" ? window.innerHeight : document.body.offsetHeight);
}
//slide the screen to include an object
function slide(obj) {
	if (obj) {
		var sTop = getScroll();
		var sBot = sTop + findWindowHeight();
		var objTop = findPosY(obj);
		var objBot = findPosY(obj)+obj.scrollHeight;
		if (objBot > (sBot-30)) {
			setScroll(0,sTop+(objBot-sBot));
		} else if (objTop < sTop) {
			setScroll(0,objTop);
		}
	}
}
//cross browser to get the current page scroll
function getScroll() {
	var x,y;
	if (self.pageYOffset) // all except Explorer
	{
		x = self.pageXOffset;
		y = self.pageYOffset;
	}
	else if (document.documentElement && document.documentElement.scrollTop)
		// Explorer 6 Strict
	{
		x = document.documentElement.scrollLeft;
		y = document.documentElement.scrollTop;
	}
	else if (document.body) // all other Explorers
	{
		x = document.body.scrollLeft;
		y = document.body.scrollTop;
	}
	return y;
}
function setScroll(x,y) {
	if (document.documentElement && document.documentElement.scrollTop)
		// Explorer 6 Strict
	{
		document.documentElement.scrollLeft = x;
		document.documentElement.scrollTop = y;
	}
	else if (document.body) // all other Explorers
	{
		document.documentElement.scrollLeft = x;
		document.documentElement.scrollTop = y;
		document.body.scrollLeft = x;
		document.body.scrollTop = y;
	}
	else if (self.pageYOffset) // all except Explorer
	{
		self.pageXOffset = x;
		self.pageYOffset = y;
		
	}
	return;
}

//clears the default text in an input
function clearText(elem) {
	elem.value = '';
}
function checkText(elem) {
	if (elem.value.length == 0) {
		elem.value = elem.defaultValue;
	}
}

function checkMail(emAddress)
{
	var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if (filter.test(emAddress)) {
		return true;
	} else {
		return false;
	}
}
function isNumber(a) {
    return typeof a == 'number' && isFinite(a);
}
/* toggles between show/hide */
function toggleIt(theBlock) {
	var blk = document.getElementById(theBlock);
	if (!blk) { return false;}
	var currentState = blk.className;
	var currentResults = document.getElementById('currentResults');
	var detailDivArray = currentResults.getElementsByTagName('div');
	if (theBlock.indexOf('det') == 0) {
		//alert(detailDivArray[0].id);
		for (var dv=0;dv<detailDivArray.length;dv++) {
		//for (dv in detailDivArray) {
			//alert(dv);
			var divName = detailDivArray[dv].id;
			if (divName != null && divName.indexOf('det') == 0) {
				detailDivArray[dv].className = 'popHide';
			}		
		}
	} else 	if (theBlock.indexOf('reg') == 0) {
		for (var dv=0;dv<detailDivArray.length;dv++) {
		//for (dv in detailDivArray) {
			var divName = detailDivArray[dv].id;
			if (divName != null && divName.indexOf('reg') == 0) {
				detailDivArray[dv].className = 'popHide';
			}		
		}
	} else 	if (theBlock.indexOf('pdesc') == 0) {
		for (var dv=0;dv<detailDivArray.length;dv++) {
		//for (dv in detailDivArray) {
			var divName = detailDivArray[dv].id;
			if (divName != null && divName.indexOf('pdesc') == 0) {
				detailDivArray[dv].className = 'popHide';
			}		
		}
	} else 	if (theBlock.indexOf('restrict') == 0) {
		for (var dv=0;dv<detailDivArray.length;dv++) {
		//for (dv in detailDivArray) {
			var divName = detailDivArray[dv].id;
			if (divName != null && divName.indexOf('restrict') == 0) {
				detailDivArray[dv].className = 'popHide';
			}		
		}
	}
	
	currentState == 'popHide' ? document.getElementById(theBlock).className = 'popShow' : document.getElementById(theBlock).className = 'popHide';
	return false;
}
/* toggles between show/hide */
function toggleRegBlock(activityCode) {
	var blk = document.getElementById('reg'+activityCode);
	if (!blk) { return false;}
	var currentState = blk.className;
	var currentResults = document.getElementById('currentResults');
	var detailDivArray = currentResults.getElementsByTagName('div');
	for (var dv=0;dv<detailDivArray.length;dv++) {
		var divName = detailDivArray[dv].id;
		if (divName != null && (divName.indexOf('det'+activityCode) == 0 || divName.indexOf('reg'+activityCode) == 0 ||
			divName.indexOf('pdesc'+activityCode) == 0 || divName.indexOf('restrict'+activityCode) == 0)) {
			currentState == 'popHide' ? detailDivArray[dv].className = 'popShow' : detailDivArray[dv].className = 'popHide';
		} else {
			detailDivArray[dv].className = 'popHide';
		}		
		
	}
	return (currentState == 'popHide' ? 'popShow' : 'popHide');
}

function openIt(theBlock) {
	var blk = document.getElementById(theBlock);
	if (!blk) { return false;}
	blk.className = 'popShow';
}
function closeIt(theBlock) {
	var blk = document.getElementById(theBlock);
	if (!blk) { return false;}
	blk.className = 'popHide';
}



function openClose(theBlock) {
	document.getElementById(theBlock).className == 'arrow' ? document.getElementById(theBlock).className = 'arrowdn' : document.getElementById(theBlock).className = 'arrow';
	return false;
}

/* sends a specific class to a specific block */
function switchClass(theBlock, theClass) {
	document.getElementById(theBlock).className = theClass;
	return false;
}
