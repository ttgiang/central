<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cql.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "cql";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String chromeWidth = "60%";
	String pageTitle = "Admin Work";
	fieldsetTitle = "Admin Work";

	boolean isSysadm = SQLUtil.isSysAdmin(conn,user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/cql.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage && isSysadm && Skew.confirmEncodedValue(request)){
		try{
			out.println("		<form method=\'post\' name=\'aseForm\' action=\'cql.jsp\'>" );
			out.println("			<table height=\'90\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'asetable\" align=\'center\'  border=\'0\'>" );

			out.println("				<tr>" );
			out.println("					 <td nowrap>" );

			String cql = website.getRequestParameter(request,"content","",false);

			out.println(SQLUtil.executeCQL(conn,cql,false,user));

			out.println("					</td>" );
			out.println("				</tr>" );

			out.println("				<tr>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'4\'><hr size=\'1\'>" );
			out.println("							<input type=\'submit\' name=\'aseView\' value=\'View Result\' class=\'inputsmallgray\' onClick=\"return viewCQL(\'s\')\">" );
			out.println("							<input type=\'submit\' name=\'aseNew\' value=\'New CQL\' class=\'inputsmallgray\' onClick=\"return newCQL(\'s\')\">" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			out.println("			</table>" );
			out.println("		</form>" );
		}
		catch( Exception e ){
			//out.println(e.toString());
		}
	}
	else{
		out.println("unauthorized operation");
	}

	asePool.freeConnection(conn,"cql",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
