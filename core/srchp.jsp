<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	srch.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Central Program Search";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<style>

		.highlightWordYellow { background-color: #ff2; }
		.highlightWordGreen { background-color: #adff2f; }
		.highlightWordPink { background-color: #ffb6c1; }
		.highlightWordAqua { background-color: #00ffff; }
		.highlightWordAlmond { background-color: #ffebcd; }

		div {
			float: left;
		}

		#divLeft {
			width:20%;
			float: left;
			background-color:#f0ffff;
			border: 1px solid #FF8855;
			 -moz-border-radius: 10px;
			 -webkit-border-radius: 10px;
			 border-radius: 10px;
		}

		#divRight {
			width:76%;
			float: right;
			background-color:#f0ffff;
			border: 1px solid #FF8855;
			 -moz-border-radius: 10px;
			 -webkit-border-radius: 10px;
			 border-radius: 10px;
		}

		divLegend {
			float: left;
		}

		#divLegendLeft {
			width:10%;
			float: left;
			margin-bottom:10px;
		}

		#divLegendRight {
			width:86%;
			float: right;
			margin-bottom:10px;
			text-align: left;
		}

	</style>

	<script type="text/javascript">

		function showProgress(kix){

			var aseWindow = null;
			var w = '600';
			var h = '180';
			var scroll = 'no';
			var pos = 'center';

			if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}

			if(pos=="center"){
				LeftPosition=(screen.width)?(screen.width-w)/2:100;
				TopPosition=(screen.height)?(screen.height-h)/2:100;
			}
			else
				if((pos!="center" && pos!="random") || pos==null){
					LeftPosition=0;TopPosition=20
				}

			settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';

			aseWindow = window.open("srchy.jsp?kix="+kix,"srchy",settings);

			return false;
		}

		var txt1 = "";
		var txt2 = "";
		var txt3 = "";

		function onChangeText(val) {

			link = "";

			txt1 = document.getElementById('txt1').value;
			txt2 = document.getElementById('txt2').value;
			txt3 = document.getElementById('txt3').value;

			if(txt1 != null && txt1.length == 0){
				return false;
			}
			else if(txt1 != null && txt1.length < 3){
				alert("Primary text search requires a minimum of 3 characters.");
				return false;
			}

			//
			// campus
			//
			var cps = "";
			var cpsSel = null;
			try{
				cpsSel = document.aseForm.cps.options[document.aseForm.cps.selectedIndex];
				cps = cpsSel.value;
			} catch(e) {}

			//
			// type
			//
			var type = "";
			var typeSel = null;
			try{
				typeSel = document.aseForm.type.options[document.aseForm.type.selectedIndex];
				type = typeSel.value;
			} catch(e) {}

			//
			// term
			//
			var term = document.getElementById('term').value;

			link = "txt1="+txt1+"&txt2="+txt2+"&txt3="+txt3+"&term="+term+"&cps="+cps+"&type="+type;

			var destURL = "/central/core/srchpx.jsp?" + link;

			document.getElementById("divRight").innerHTML = "<br><img src=\"../images/spinner11.gif\"><br><br>";

			try {
				xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}

			xmlhttp.onreadystatechange = triggered;
			xmlhttp.open("GET", destURL);
			xmlhttp.send(null);

			return false;

		}

		function triggered() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					document.getElementById("divRight").innerHTML = xmlhttp.responseText;

					if(txt1 != ""){
						$("#divRight *").highlight(txt1,"highlightWordYellow");
					}

					if(txt2 != ""){
						$("#divRight *").highlight(txt2,"highlightWordGreen");
					}

					if(txt3 != ""){
						$("#divRight *").highlight(txt3,"highlightWordPink");
					}

				}
			}
		}

	</script>

</head>
<body topmargin="0" leftmargin="0" onLoad="javascript:onChangeText(this);">

<%@ include file="../inc/header.jsp" %>

<%
	String txt1 = website.getRequestParameter(request,"txt1","");
	String txt2 = website.getRequestParameter(request,"txt2","");
	String txt3 = website.getRequestParameter(request,"txt3","");

	if (processPage){

		String sql = "";

		String term = website.getRequestParameter(request,"term","");
		String radio1 = website.getRequestParameter(request,"radio1","");
		String radio2 = website.getRequestParameter(request,"radio2","");
		String type = website.getRequestParameter(request,"type","");
		String cps = website.getRequestParameter(request,"cps","");

		out.println("<div id=\"divLeft\"><form action=\"./srchp.jsp\" method=\"post\" id=\"aseForm\" name=\"aseForm\">");
		out.println("<br><table border=\"0\" cellspacing=\"0\" cellpadding=\"2\" width=\"280px\">");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Campus:<br>");
		sql = aseUtil.lookUp(conn, "tblINI", "kval1", "kid = " + aseUtil.toSQL("campus", 1));
		out.println(aseUtil.createSelectionBox(conn,sql,"cps",cps,"","",false,"onChange=\"javascript:onChangeText(this);\""));
		out.println("</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Program Type:<br>");

			String courseTypes = "ARC,CUR,PRE,ALL";
			String courseTypesText = "Archived,Approved,Modified,All";
			String[] aCourseTypes = courseTypes.split(",");
			String[] aCourseTypesText = courseTypesText.split(",");

		%>
			<select name="type" size="1" class="smalltext" onchange="onChangeText(this);">
				<option value=""></option>
		<%
				for(int x = 0; x < aCourseTypes.length; x++){
					String selected = "";
					if(type.equals(aCourseTypes[x])){
						selected = "selected";
					}
					out.println("<option value=\""+aCourseTypes[x]+"\" "+selected+">"+aCourseTypesText[x]+"</option>");
				}
		%>
			</select>
		<%

		out.println("</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Search Text:<br>");
		out.println("<input class=\"input\" type=\"text\" id=\"txt1\" name=\"txt1\" value=\""+txt1+"\" onchange=\"onChangeText(this);\"></input>");
		out.println(Html.drawANDORRadio("radio1","AND"));
		out.println("</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Search Text:<br>");
		out.println("<input class=\"input\" type=\"text\" id=\"txt2\" name=\"txt2\" value=\""+txt2+"\" onchange=\"onChangeText(this);\"></input>");
		out.println(Html.drawANDORRadio("radio2","AND"));
		out.println("</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Search Text:<br>");
		out.println("<input class=\"input\" type=\"text\" id=\"txt3\" name=\"txt3\" value=\""+txt3+"\" onchange=\"onChangeText(this);\"></input>");
		out.println("</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Effective Date:<br>");
		out.println("<input class=\"input\" type=\"text\" id=\"term\" name=\"term\" value=\""+term+"\" onchange=\"onChangeText(this);\"></input>");
		out.println("</td>");
		out.println("</tr>");

		//
		// does not work at this time. it will be like a refresh of the page
		//
		out.println("<tr>");
		out.println("<td class=\"textblackth\">&nbsp;<br>");
		out.println("<input class=\"inputgo\" type=\"submit\" value=\"Go\" onClick=\"javascript:onChangeText(this);\">");
		out.println("</td>");
		out.println("</tr>");

		out.println("</table><br>");
		out.println("</form><hr size=\"1\">");
%>

<p align="left">

	<div id="divLegend">

		<div id="divLegendLeft">
			<img src="../images/edit.gif" alt="modified/proposed outline" title="modified/proposed program">
		</div>
		<div id="divLegendRight">modified/proposed program</div>

		<div id="divLegendLeft">
			<img src="../images/ext/zip.gif" alt="archived program" title="archived program">
		</div>
		<div id="divLegendRight">archived program</div>

		<div id="divLegendLeft">
			<img src="../images/fastrack.gif" alt="approved program" title="approved program">
		</div>
		<div id="divLegendRight">approved program</div>

		<div id="divLegendLeft">
			<img src="../images/del.gif" alt="deleted program" title="deleted program">
		</div>
		<div id="divLegendRight">deleted program</div>

		<div id="divLegendLeft">
			<img src="../images/insert_table.gif" width="16" alt="view program status" title="view program status">
		</div>
		<div id="divLegendRight">view program status</div>

		<div id="divLegendLeft">
			<img src="../images/ext/pdf.gif" alt="view in pdf format" title="view in pdf format">
		</div>
		<div id="divLegendRight">view in PDF format</div>

	</div>

</p>

<%
		out.println("</div>");
		out.println("<div id=\"divRight\"><br>enter search criteria to view results<br><br></div>");

	} // processPage

	asePool.freeConnection(conn,"srchp",user);

%>

<%@ include file="../inc/footer.jsp" %>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>
<script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>

<script type="text/javascript">

	jQuery.fn.highlight = function (str, className) {
		 var regex = new RegExp(str, "gi");
		 return this.each(function () {
			  $(this).contents().filter(function() {
					return this.nodeType == 3;
			  }).replaceWith(function() {
					return (this.nodeValue || "").replace(regex, function(match) {
						 return "<span class=\"" + className + "\">" + match + "</span>";
					});
			  });
		 });
	};

	$(document).ready(function () {
		//
	});

</script>

</body>
</html>
