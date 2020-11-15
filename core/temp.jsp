<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	search.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Central Search";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<style>
		div {
			float: left;
		}

		#divLeft {
			width:20%;
			float: left;
			background-color:#FFEEDD;
			border: 1px solid #FF8855;
			 -moz-border-radius: 10px;
			 -webkit-border-radius: 10px;
			 border-radius: 10px;
		}

		#divRight {
			width:78%;
			float: right;
			background-color:#FFEEDD;
			border: 1px solid #FF8855;
			 -moz-border-radius: 10px;
			 -webkit-border-radius: 10px;
			 border-radius: 10px;
		}

	</style>

	<script type="text/javascript">

		function onChangeText(val) {

			link = "";

			var txt1 = document.getElementById('txt1').value;
			var txt2 = document.getElementById('txt2').value;
			var txt3 = document.getElementById('txt3').value;

			//
			// term
			//
			var cps = "";
			var cpsSel = null;
			try{
				cpsSel = document.aseForm.cps.options[document.aseForm.cps.selectedIndex];
				cps = cpsSel.value;
			} catch(e) {}

			//
			// term
			//
			var term = "";
			var wildCardTerm = true;
			if(wildCardTerm){
				term = document.getElementById('term').value;
			}
			else{
				var termSel = null;
				try{
					termSel = document.aseForm.term.options[document.aseForm.term.selectedIndex];
					term = termSel.value;
				} catch(e) {}
			}

			//
			// alpha
			//
			var alpha = "";
			var wildCardAlpha = true;
			if(wildCardAlpha){
				alpha = document.getElementById('alpha').value;
			}
			else{
				var alphaSel = null;
				try{
					alphaSel = document.aseForm.alpha.options[document.aseForm.alpha.selectedIndex];
					alpha = alphaSel.value;
				} catch(e) {}
			}

			link = "txt1="+txt1+"&txt2="+txt2+"&txt3="+txt3+"&term="+term+"&alpha="+alpha+"&cps="+cps;

			var destURL = "/central/core/tempx.jsp?" + link;

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
					document.getElementById("divRight").innerHTML =xmlhttp.responseText;
				}
			}
		}

	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%

	if (processPage){

		String sql = "";

		String txt1 = website.getRequestParameter(request,"txt1","");
		String txt2 = website.getRequestParameter(request,"txt2","");
		String txt3 = website.getRequestParameter(request,"txt3","");
		String term = website.getRequestParameter(request,"term","");
		String alpha = website.getRequestParameter(request,"alpha","");
		String radio1 = website.getRequestParameter(request,"radio1","");
		String radio2 = website.getRequestParameter(request,"radio2","");
		String type = website.getRequestParameter(request,"type","");
		String cps = website.getRequestParameter(request,"cps","");

		out.println("<div id=\"divLeft\"><form action=\"./temp.jsp\" method=\"post\" id=\"aseForm\" name=\"aseForm\">");
		out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\" width=\"280px\">");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Campus:<br>");
		sql = aseUtil.lookUp(conn, "tblINI", "kval1", "kid = " + aseUtil.toSQL("campus", 1));
		out.println(aseUtil.createSelectionBox(conn,sql,"cps",cps,"","",false,"onChange=\"javascript:onChangeText(this);\""));
		out.println("</td>");
		out.println("</tr>");

		out.println("<tr>");
		out.println("<td class=\"textblackth\">Outline Type:<br>");
		out.println(aseUtil.createStaticSelectionBox("Archived,Current,Proposed,ALL","ARC,CUR,PRE,ALL","type",type,"","","BLANK","1"));
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

		boolean wildCardTerm = true;
		if(wildCardTerm){
			out.println("<tr>");
			out.println("<td class=\"textblackth\">Effective Term:<br>");
			out.println("<input class=\"input\" type=\"text\" id=\"term\" name=\"term\" value=\""+term+"\" onchange=\"onChangeText(this);\"></input>");
			out.println("</td>");
			out.println("</tr>");
		}
		else{
			sql = aseUtil.lookUp(conn, "tblINI", "kval1", "kid = " + aseUtil.toSQL("EffectiveTerms", 1));
			out.println("<tr>");
			out.println("<td class=\"textblackth\">Effective Term:<br>");
			out.println(aseUtil.createSelectionBox(conn,sql,"term",term,"","",false,"onChange=\"javascript:onChangeText(this);\""));
			out.println("</td>");
			out.println("</tr>");
		}

		boolean wildCardAlpha = true;
		if(wildCardAlpha){
			out.println("<tr>");
			out.println("<td class=\"textblackth\">Alpha:<br>");
			out.println("<input class=\"input\" type=\"text\" id=\"alpha\" name=\"alpha\" value=\""+alpha+"\" onchange=\"onChangeText(this);\"></input>");
			out.println("</td>");
			out.println("</tr>");
		}
		else{
			sql = aseUtil.getPropertySQL(session,"alphas3");
			out.println("<tr>");
			out.println("<td class=\"textblackth\">Alpha:<br>");
			out.println(aseUtil.createSelectionBox(conn,sql,"alpha",alpha,"","",false,"onChange=\"javascript:onChangeText(this);\""));
			out.println("</td>");
			out.println("</tr>");
		}

		//
		// does not work at this time. it will bel ike a refresh of the page
		//
		//out.println("<tr>");
		//out.println("<td class=\"textblackth\">&nbsp;<br>");
		//out.println("<input class=\"input\" type=\"submit\" value=\"Go\" onClick=\"javascript:onChangeText(this);\">");
		//out.println("</td>");
		//out.println("</tr>");

		out.println("</table>");
		out.println("</form></div>");

		out.println("<div id=\"divRight\">enter search criteria to view results</div>");

	} // processPage

	asePool.freeConnection(conn,"srch",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
