<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	myq.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String pageTitle = "Curriculum Central Answers!";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String srch = website.getRequestParameter(request,"srch","");
	if (!srch.equals(Constant.BLANK)){
		session.setAttribute("aseFormSearchValue",srch);
	}

	String answered = website.getRequestParameter(request,"a","0");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<%@ include file="../accordion.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">

	<style type="text/css">
		.highlightWordYellow { background-color: #ff2; }
		.highlightWordGreen { background-color: #adff2f; }
		.highlightWordPink { background-color: #ffb6c1; }
		.highlightWordAqua { background-color: #00ffff; }
		.highlightWordDarkkhaki { background-color: #bdb76b; }

		div p {color: #E87B10;}

		div.demo p.question {
			color: #E87B10;
		}

		div.demo p.preview {
			color: #083772;
		}

	</style>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<div class="demo">

<%
	boolean mine = true;

	if (processPage){
		if (srch.equals(Constant.BLANK)){
			out.println(com.ase.aseutil.faq.FaqDB.getCategoryCountJQuery(conn,user,answered,mine));
		}
		else{
			out.println(com.ase.aseutil.faq.FaqDB.searchFaqs(conn,user,srch,mine));
		}
	}
%>

</div>

<%
	asePool.freeConnection(conn,"myq",user);
%>

