<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crshst.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approval History";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<script type="text/javascript" src="js/crssts.js"></script>

	<script type="text/javascript" src="js/crsinfy.js"></script>

</head>
<body topmargin="0" leftmargin="0">

<%
	if (processPage){

		String kix = website.getRequestParameter(request,"hid","");

		String[] info = helper.getKixInfo(conn,kix);
		String alpha = info[0];
		String num = info[1];
		String type = info[2];

		out.println(HistoryDB.displayVotingHistory(conn,campus,kix));
%>

		<p>&nbsp;</p><p><a href="##" class="linkcolumn" onClick="return moreHistory('<%=campus%>','<%=alpha%>','<%=num%>','ARC');">&nbsp;show archived history</a></p>
		<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="moreHistory">
			<img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...
		</div>
<%
	}

	asePool.freeConnection(conn,"crshst",user);
%>

</body>
</html>
