<!--

	function textCounter(fieldName,cntFieldName,maxLimit) {

		var text = fieldName.value;
		text = text.replace(/^\s*|\s*$/g,'');	//removes whitespace from front and end
		var count_array = text.split(" ");
		var words = count_array.length;
		var chars = fieldName.value.length;

		if (fieldName.value.length > maxLimit){
			fieldName.value = fieldName.value.substring(0, maxLimit);
		}
		else{
			cntFieldName.value = maxLimit - fieldName.value.length;
		}

		var charsleft = cntFieldName.value;
		var charTyped = "<span class=\"w3c\">Characters typed: </span><span class=\"spec\">[int].</span> ";
		var charRemaining = "<span class=\"w3c\">Characters remain: </span><span class=\"spec\">[int].</span> ";
		var wordCounter = "<span class=\"w3c\">Word count: </span><span class=\"spec\">[word].</span> ";
		var statusdiv = document.getElementById("inputCounter");
		if (statusdiv){
			var html = wordCounter.replace("[word]", Math.max(0, words));
			html += charTyped.replace("[int]", Math.max(0, chars));
			html += charRemaining.replace("[int]", Math.max(0, charsleft));
			statusdiv.innerHTML = "<span class=\"block\">"
							+ html
							+ "</span>";
		}
	}

-->
