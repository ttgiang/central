<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndvwidx.jsp - difference between this and prgidx is this is CUR and the other is PRE
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Search Foundation Course";

	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<style>

		#divSearch{
			width:98%;
			float: right;
			 -moz-border-radius: 10px;
			 -webkit-border-radius: 10px;
			 border-radius: 10px;
			text-align: left;
		}

		#divSearch2{
			width:98%;
			text-align: left;
		}

		#divSearch2Left {
			width:40%;
			float: left;
			margin-bottom:10px;
		}

		#divSearch2Right {
			width:56%;
			float: right;
			text-align: right;
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
			text-align: left;
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

		.new_line{ clear: left; padding: 2px 2px;  }

		.wrapperD{	margin: 0px auto;	width: 800px;	}
		.wrapperH{	margin: 0px auto;	width: 800px;	background-color: #FDEDC1;	font-size:14px; }

	</style>

	<script type="text/javascript">

		//
		// basic or simple search
		//
		function doBasicSearch() {

			var go = 1;

			var txt = document.getElementById('txt').value;

			//txt = encodeURIComponent(txt)

			if(txt != null && txt.length > 0 && txt.length < 3){
				alert("Search requires a minimum of 3 characters.");
				go = 0;;
			}

			if(go==1){
				var link = "txt="+txt;
 				doSearch(link);
			}

			return false;

		}

		//
		// basic or simple search
		//
		function doSearch(link) {

			var destURL = "fndsrchx.jsp?" + link;

			document.getElementById("divSearch").innerHTML = "<br><p align=\"center\"><img src=\"../images/spinner11.gif\"></p>";

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
					document.getElementById("divSearch").innerHTML = xmlhttp.responseText;
				}
			}
		}

	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

	<div id="wrp2" class="wrapperSearch">
		<div id="divSearch2Left">
			<form action="fndsrch.jsp" method="post" id="aseForm" name="aseForm">
				<font class="textblackth">Search: <input type="text" id="txt" name="txt" value="" size="60">
				<input class="inputgo" type="submit" value="Go" onClick="return doBasicSearch(this);">
			</form>
		</div>
		<div id="divSearch2Right">
			<!--
			<a href="#" id="advanced-form" class="linkcolumn">Advanced Search</a>
			-->
		</div>
	</div>

	<div id="divSearch">
	</div>
<%
	paging = null;
	asePool.freeConnection(conn,"fndvwidx",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

