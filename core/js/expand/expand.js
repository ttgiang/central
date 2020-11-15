
	ddaccordion.init({
		headerclass: "technology", //Shared CSS class name of headers group
		contentclass: "thelanguage", //Shared CSS class name of contents group
		revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click" or "mouseover"
		collapseprev: false, //Collapse previous content (so only one open at any time)? true/false
		defaultexpanded: [], //index of content(s) open by default [index1, index2, etc]. [] denotes no content.
		animatedefault: false, //Should contents open by default be animated into view?
		persiststate: false, //persist state of opened contents within browser session?
		toggleclass: ["closedlanguage", "openlanguage"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
		togglehtml: ["prefix", "<img src='../images/expand/minus.gif' style='width:13px; height:13px' /> ", "<img src='../images/expand/plus.gif' style='width:13px; height:13px' /> "], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
		animatespeed: "fast", //speed of animation: "fast", "normal", or "slow"
		oninit:function(expandedindices){ //custom code to run when headers have initalized
			//do nothing
		},
		onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
			//do nothing
		}
	})
