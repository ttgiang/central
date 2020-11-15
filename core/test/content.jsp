<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	String chromeWidth = "60%";
	String campus = (String)session.getAttribute("aseCampus");
	String pageTitle = "Course Cancelled";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript">
		function loadurl(dest) {
			try {
				xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}

			xmlhttp.onreadystatechange = triggered;
			xmlhttp.open("GET", dest);
			xmlhttp.send(null);
		}

		function triggered() {
			if (xmlhttp.readyState == 4) {
				if (xmlhttp.status == 200) {
					document.getElementById("output").innerHTML =xmlhttp.responseText;
				}
			}
		}
	</script>

	<link type=text/css rel=stylesheet href="styles/tabs.css">
	<link type=text/css rel=stylesheet href="../inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

	<div style="border: 3px solid rgb(204, 204, 204); overflow: height: 400px; width: 600px;" id="output" onclick="loadurl('/central/core/usridx.jsp')">
		click here to load</div>
	</div>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

