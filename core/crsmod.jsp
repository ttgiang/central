<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsmod.jsp	outline modifications
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Modify Proposed Outline";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">

		$(document).ready(function () {
			$("#crsmodappr").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 20,
				 "bJQueryUI": true,
					"aoColumns": [
					{ sWidth: '15%' },
					{ sWidth: '55%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' } ]
			});
		});

	</script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' align=\'center\'  border=\'0\'>" );
	out.println("		<tr>" );
	out.println("			 <td colspan=2 align=left>" );

	if (processPage){
		out.println(helper.listOutlineModifications(conn,campus,"PRE","crsmody",user));
	}

	out.println("			 </td>" );
	out.println("		</tr>" );

	out.println("	</table>" );

	asePool.freeConnection(conn,"crsmod",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
