<%@ page session="true" buffer="16kb" import="java.util.*"%>
<%
	String styleSheet = "bluetabs";
%>
<title><%=session.getAttribute("aseApplicationTitle")%>: <%=pageTitle%></title>

<style type='text/css'>
	#dhtmlgoodies_tooltip{
		background-color:#EEE;
		border:1px solid #000;
		position:absolute;
		display:none;
		z-index:20000;
		padding:2px;
		font-size:0.9em;
		-moz-border-radius:6px;	/* Rounded edges in Firefox */
		font-family: Arial, sans-serif;
	}

	#dhtmlgoodies_tooltipShadow{
		position:absolute;
		background-color:#555;
		display:none;
		z-index:10000;
		opacity:0.7;
		filter:alpha(opacity=70);
		-khtml-opacity: 0.7;
		-moz-opacity: 0.7;
		-moz-border-radius:6px;	/* Rounded edges in Firefox */
	}
</style>

<!--
<script type="text/javascript" src="<%=request.getContextPath()%>/inc/textsizer.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/inc/tooltip.js"></script>
-->

<script type="text/javascript" src="<%=request.getContextPath()%>/inc/dropdowntabs.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/<%=styleSheet%>.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/site.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/ase.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/ff100.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/menuh.css" />

<!--[if lt IE 7]>
	<style type="text/css" media="screen">
		#menuh{float:none;}
		body{behavior:url(<%=request.getContextPath()%>/inc/csshover.htc); font-size:100%;}
		#menuh ul li{float:left; width: 100%;}
		#menuh a{height:1%;font:bold 0.7em/1.4em arial, sans-serif;}
	</style>
<![endif]-->

<%
	response.setDateHeader("Expires", 0); // date in the past
	response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	response.addHeader("Pragma", "no-cache"); // HTTP/1.0
	Locale locale = Locale.getDefault();
	response.setLocale(locale);
	session.setMaxInactiveInterval(30*60);
%>
