<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	sess.jsp
	*	2007.09.01
	**/

	ServletContext context = getServletContext();
%>

<%@ include file="sessz.jsp" %>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
	<table border="0" width="80%" id="table01" cellspacing="0" cellpadding="3">
		<tr>
			<td valign="top">
				<table border="0" width="100%" id="table02" cellspacing="0" cellpadding="3">
					<tr><td>SessionID</td><td><%=session.getId().toString()%></td></tr>
						<%
							if ( (String)session.getAttribute("aseUserRights") != null ){

								String sql = "";
								String campus = website.getRequestParameter(request,"aseCampus","",true);
								int i;
								int aseUserRights = Integer.parseInt((String)session.getAttribute("aseUserRights"));

								// show all campuses only for system admin
								if ( aseUserRights == 3 )
									sql = "SELECT campus, campusdescr FROM tblCampus WHERE campus <> 'ALL' ORDER BY campus ";
								else
									sql = "SELECT campus, campusdescr FROM tblCampus WHERE campus='" + campus + "'";

								out.println( "<form name=\"myForm\" method=\"post\" action=\"sessx.jsp\">" );
								out.println( "<input type=\"hidden\" value=\"submit\" name=\"submit\">" );
								for ( i = 0; i < sessField.length; i++ ){
									out.println("<tr valign=\"top\">");
									out.println("<td width=\"30%\">" + sessField[i] + "</td>" );
									try{
										if ( sessType[i].equals("s") )
											if ( "aseCampus".equals(sessField[i]) ){
												out.println("<td width=\"70%\">" + (String)session.getAttribute(sessField[i]) + "</td>" );
											}
											else if ( "aseUserRights".equals(sessField[i]) ){
												out.println("<td width=\"70%\">" + (String)session.getAttribute(sessField[i]) + "</td>" );
											}
											else{
												out.println("<td width=\"70%\"><input type='text' class='input' value='" + (String)session.getAttribute(sessField[i]) + "' name='" + sessField[i] + "'></td>" );
											}
										else
											out.println("<td width=\"70%\"><input type='text' class='input' value='" + (Integer)session.getAttribute(sessField[i]) + "' name='" + sessField[i] + "'></td>" );
									}
									catch( Exception e ){
										out.println("<td width=\"70%\"><input type='text' class='input' value='0' name='" + sessField[i] + "'></td>" );
									}
									out.println("</tr>" );
								}
								if ( aseUserRights == 3){
									out.println("<tr valign=\"top\">");
									out.println("<td colspan=\"2\"><input type=\"submit\" class=\"input\" name=\"cmdSubmit\" value=\"Save\"></td>" );
									out.println("</tr>" );
								}

								out.println("</form>" );
							}
						%>
					</table>
			</td>
			<td valign="top">
				<table border="0" width="100%" id="table02" cellspacing="0" cellpadding="3">
					<%
					Cookie cookies[] = request.getCookies();
					Cookie myCookie = null;
					if (cookies != null){
						out.println( "<tr><td>Number of Cookies:</td><td>" + cookies.length + "</td></tr>");
						for (int i = 0; i < cookies.length; i++){
							out.println( "<tr><td>" + cookies[i].getName() + "</td><td>" + cookies[i].getValue() + "</td></tr>");
						}
					}
					%>

				</table>
			</td>
		</tr>
	</table>

</body>
</html>