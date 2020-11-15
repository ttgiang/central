<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndvw.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "fndvw";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Edit Foundation Course";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = "";
	String alpha = "";
	String num = "";
	String courseTitle = "";
	String fndType = "";

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	int id = website.getRequestParameter(request,"id", 0);
	if(id > 0){
		kix = fnd.getFndItem(conn,id,"historyid");
		if(!kix.equals(Constant.BLANK)){
			String[] info = fnd.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			courseTitle = info[Constant.KIX_COURSETITLE];
			fndType = info[Constant.KIX_ROUTE];
		}
	}

	String srch = website.getRequestParameter(request,"srch", "");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link type="text/css" href="./_fndedit.css" rel="Stylesheet" />

	<style>
		.highlightWordYellow { background-color: #ff2; }
		.highlightWordGreen { background-color: #adff2f; }
		.highlightWordPink { background-color: #ffb6c1; }
		.highlightWordAqua { background-color: #00ffff; }
		.highlightWordDarkkhaki { background-color: #bdb76b; }
	</style>

</head>

<body topmargin="0" leftmargin="0">

<div id="container">

	<%
		if(processPage){
			out.println(com.ase.aseutil.fnd.FndDB.viewFoundation(conn,kix));
		} // process page

		paging = null;

	%>

</div>

<%
	fnd = null;

	asePool.freeConnection(conn,"fndvw",user);
%>

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

		<%
			//
			// highlighter
			//
			String[] aHighlights = "highlightWordYellow,highlightWordGreen,highlightWordDarkkhaki,highlightWordAqua,highlightWordPink".split(",");

			if(!srch.equals(Constant.BLANK)){

				String[] aSrch = srch.split(Constant.SPACE);
				for(int z=0; z<aSrch.length; z++){
					%>
						$("#container *").highlight("<%=aSrch[z]%>", "<%=aHighlights[z]%>");
					<%
				}

			} // highlight
		%>


	});

</script>

</body>
</html>
