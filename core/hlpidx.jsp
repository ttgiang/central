<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	hlpidx.jsp
	*	2007.09.01
	**/

	String thisPage = "hlp";
	session.setAttribute("aseThisPage",thisPage);

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Help Index";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#hlpidx").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
		String sql = aseUtil.getPropertySQL( session, "helpidxcat" );
		String category = website.getRequestParameter(request,"category", "");

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
		out.println("			<table width=\'" + session.getAttribute("aseTableWidth") + "\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					<td>" + aseUtil.createSelectionBox(conn, sql, "category", category,false) );
		out.println( "						<input type=\"submit\" value=\"Go\" name=\"cmdGo\" class=\"inputsmallgray\"></td>" );
		out.println("				</tr>" );
		out.println("		</table>" );
		out.println("		</form>" );

		out.println(HelpDB.getHelpPages(conn,campus,category));
	}

	asePool.freeConnection(conn,"hlpidx",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

