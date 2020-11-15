<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	inicon.jsp	ini jobs
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");

		processPage = false;
	}

	String kid = website.getRequestParameter(request,"kid","");

	String chromeWidth = "70%";
	String pageTitle = "System Setting - " + kid;
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/sndr.js"></script>
	<script language="JavaScript" type="text/javascript" src="wysiwyg.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	try{
		String c = website.getRequestParameter(request,"c","0");
		if (kid.equals("EnableMessageBoard") && c.equals("0")){
			session.setAttribute("aseProcessed","NO");

			%>
				Switching to the message board system requires conversion of in-progress reviews and approvals to the new format.
				<br><br><font class="goldhighlightsbold">WARNING</font>: After the conversion, you will not have the option to disable the message board. This is a one time process.
				<br><br>Click <a href="?kid=<%=kid%>&c=1" class="linkcolumn">here</a> to convert your data
				or <a href="ini.jsp?category=system" class="linkcolumn">here</a> for system settings
			<%
		}
		else{

			// check to prevent reposting
			String processed = aseUtil.nullToBlank((String)session.getAttribute("aseProcessed"));
			if (processPage && !processed.equals("YES")){
				if(com.ase.aseutil.conversion.ER00018.createMessageBoard(session,conn,campus,user) > 0){
					out.println("Conversion completed successfullly");
					session.setAttribute("aseProcessed","YES");
				}
				else{
					out.println("There was an error during the conversion process. Contact system administrator for assistance.");
				}
			}
			else{
				out.println("Conversion already completed and may not be reprocessed.");
			}

		}// if kid
	}
	catch( Exception e ){
		//out.println(e.toString());
	}

	asePool.freeConnection(conn,"inicon",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
