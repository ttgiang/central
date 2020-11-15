<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprhst.jsp		approval history
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Approval History";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/crssts.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/headerli.jsp" %>

<%
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String history = ApproverDB.getApprovalHistory(conn,kix);
		out.println(history);
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footerli.jsp" %>
</body>
</html>