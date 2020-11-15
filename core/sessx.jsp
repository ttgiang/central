<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sessx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Session Variables";
	fieldsetTitle = pageTitle;
	ServletContext context = getServletContext();
%>

<%@ include file="sessz.jsp" %>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="60%" id="table15" cellspacing="0" cellpadding="3">
	<tr><td>SessionID</td><td><%=(String)session.getId()%></td></tr>
	<%
		String campus = "";
		String user = "";
		String sessionUser = "";

		Cookie cookie;
		int i;

		String submit = website.getRequestParameter(request,"submit", "");
		if ( submit.length() > 0 ){
			sessionUser = (String)session.getAttribute("aseUserName");
			for (i=0; i<sessField.length; i++){
				try{

					if ( sessType[i].equals("s") )
						session.setAttribute(sessField[i],website.getRequestParameter(request,sessField[i],""));
					else
						session.setAttribute(sessField[i],new Integer(website.getRequestParameter(request,sessField[i])));

					if ("aseCampus".equals(sessField[i])){
						campus = website.getRequestParameter(request,"aseCampus","");
						cookie = new Cookie ("CC_Campus", campus);
						response.addCookie(cookie);
						session.setAttribute("aseBGColor",campus);
					}
					else if ("aseUserName".equals(sessField[i])){
						user = website.getRequestParameter(request,"aseUserName","");
						if (!user.equals(sessionUser)){
							cookie = new Cookie ("CC_User", user);
							response.addCookie(cookie);
							user = UserDB.getUserFullname(conn,user);
							session.setAttribute("aseUserFullName",user);
						}
					}
				}
				catch( Exception e ){
					out.println( "***" + i + "***" );
				}
			}
		}

		for ( i = 0; i < sessField.length; i++ ){
			out.println("<tr valign=\"top\">");
			out.println("<td width=\"30%\">" + sessField[i] + "</td>" );
			try{
				if ( sessType[i].equals("s") )
					out.println("<td width=\"70%\">" + (String)session.getAttribute(sessField[i]) + "</td>" );
				else
					out.println("<td width=\"70%\">" + ((Integer)session.getAttribute(sessField[i])).intValue() + "</td>" );
			}
			catch( Exception e ){
				out.println("<td width=\"70%\">&nbsp;</td>" );
			}
			out.println("</tr>" );
		}

		asePool.freeConnection(conn);
	%>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>