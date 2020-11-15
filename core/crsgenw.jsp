<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsgenw.jsp - auto fill PSLO
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String alpha = website.getRequestParameter(request,"alpha","",false);
	String kix = website.getRequestParameter(request,"kix","",false);
	String src = website.getRequestParameter(request,"itm","",false);

	String pageTitle = "Auto Fill Program SLO" + " - " + alpha;

	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){

		// with alpha, show what's currently available
		if (!alpha.equals(Constant.BLANK) && !alpha.equals(Constant.OFF)){

			String[] info = helper.getKixInfo(conn,kix);
			String num = info[1];
			String type = info[2];

			int rowsAffected = ValuesDB.addSrcToOutline(conn,
																		src,
																		kix,
																		campus,
																		alpha,
																		num,
																		type,
																		user);

			out.println("<table width=\"680\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
								+ "<tr><td>"
								+ ValuesDB.getListBySrcSubTopic(conn,campus,src,alpha)
								+ "</td></tr>"
								+ "<tr><td><br/><br/>"
								+ "Program SLOs created successfully.<br/><br/>Click <a href=\"crsgen.jsp?kix="+kix+"&src="+src+"&dst="+src+"\" class=\"linkcolumn\">here</a> to return to outline modification."
								+ "</td></tr>"
								+ "</table>");
		}
	}

	asePool.freeConnection(conn,"prgmidx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>