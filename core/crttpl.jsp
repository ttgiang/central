<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crttpl.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String sql = "";
	String campus = "KAU";

	StringBuffer html = new StringBuffer();
	int i = 0;
	int j = 1;

	String t2 = "";
	String t3 = "";
	String question = "";

	/* print template */
	String s1 = "<!-- line print -->";
	String s2 = "<tr><td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\">@@COUNTER@@&nbsp;</td><td class=\"textblackTH\" valign=\"top\">@Q@@@Q000@@</td></tr>";
	String s3 = "<tr><td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td><td class=\"dataColumn\" valign=\"top\">@A@@@A000@@<br/><br/></td></tr>";

	String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
	String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
	String indent = "0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0";

	String x1 = "c." + f1.replace(",",",c.");
	String x2 = "s." + f2.replace(",",",s.");

	String[] c1 = (f1 + "," + f2).split(",");

	html.append("<table border=\"0\" width=\"100%\">\n");

	for(i=0;i<c1.length;i++){
		html.append(s1+"\n");

		t2 = s2.replace("@@COUNTER@@",String.valueOf(j++)+".");
		t2 = t2.replace("@@Q000@@",c1[i]);
		t3 = s3.replace("@@A000@@",c1[i]);

		html.append(t2+"\n");
		html.append(t3+"\n");
	}

	html.append("</table>"+"\n");

	out.println(html.toString());

	asePool.freeConnection(conn);
%>