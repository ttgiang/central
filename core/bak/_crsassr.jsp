<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassr.jsp
	*	2007.09.01	Assess and outline
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	// course to work with
	String alpha = session.getAttribute("aseAlpha").toString();
	String num = session.getAttribute("aseNum").toString();
	String type = "PRE";
	String currentTab = session.getAttribute("aseCurrentTab").toString();
	String currentNo = session.getAttribute("asecurrentSeq").toString();

	// is there a course and number to work with?
	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsassr&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "90%";
	String pageTitle = "Assess Course Outline";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>
<%
	String campus = session.getAttribute("aseCampus").toString();
	String historyID = "";
	String temp = "";

	if ( alpha != null && num != null ){
		try{

			temp =	"coursealpha=" + aseUtil.toSQL(alpha,1) + " AND " +
						"coursenum=" + aseUtil.toSQL(num,1) + " AND " +
						"campus=" + aseUtil.toSQL(campus,1);
			historyID = aseUtil.lookUp(conn, "tblCourse", "historyid", temp);

			ArrayList list = CompDB.getComps(conn,alpha,num,campus);
			if ( list != null ){
				out.println( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );
				Comp comp;
				for (int i=0; i<list.size(); i++){
					comp = (Comp)list.get(i);
					temp = "<tr><td align=\"left\" width=\"03%\" valign=\"top\" nowrap>" +
						"<a href=\"crsasslnk.jsp?alpha=" + alpha + "&num=" + num + "&comp=" + comp.getID() + "\"><img src=\"../images/reviews.gif\" alt=\"assessment\" id=\"assessment\"></a></td>" +
						"<td width=\"95%\" valign=\"top\" class=\"dataColumn\">" + comp.getComp() + "</td></tr>";
					out.println( temp );
				}	// for
				out.println( "</table>" );
			}
		}
		catch( SQLException e ){
			out.println( e.toString());
		}
		catch( Exception e ){
			out.println( e.toString());
		}

		out.println( "<br><hr size=\'1\'>");
		out.print( "<p align=\'center\'>");
		if ( historyID != null )
		out.println( "</p>");
	}	// if alpha and num not null
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
