<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dspcrs.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "Display Outline Content";
	fieldsetTitle = pageTitle;
	String formName = request.getParameter("formName");

	if ( formName != null && formName.equals("aseForm") ){
		String alphabet = request.getParameter("alphabet");
		int radioSelection = Integer.parseInt(request.getParameter("radioSelection"));
		String alphanumber = request.getParameter("alphanumber");
		String courseNum = request.getParameter("courseNum");
		String discipline = request.getParameter("discipline");
		String courseType = request.getParameter("courseType");
		String view = request.getParameter("v");

		final int ByAlphabet = 0;
		final int ByNumber = 1;
		final int ByDiscipline = 2;

		final int Approved = 0;
		final int Archived = 1;
		final int Proposed = 2;
		int status = 0;

		if ( courseType.equals( "Approved" ) ) status = Approved;
		if ( courseType.equals( "Archived" ) ) status = Archived;
		if ( courseType.equals( "Proposed" ) ) status = Proposed;

		switch ( status ){
			case Approved:
				switch ( radioSelection ){
					case ByAlphabet:
						response.sendRedirect( "listcur.jsp?abc=" + alphabet );
						break;
					case ByNumber:
						response.sendRedirect( "viewcur.jsp?a=" + alphanumber + "&n=" + courseNum + "&v=" + view );
						break;
					case ByDiscipline:
						response.sendRedirect( "listcur.jsp?disc=" + discipline );
						break;
				}
				break;
			case Archived:
				switch( radioSelection ){
					case ByAlphabet:
						response.sendRedirect( "listarc.jsp?abc=" + alphabet );
						break;
					case ByNumber:
						response.sendRedirect( "viewarc.jsp?a=" + alphanumber + "&n=" + courseNum + "&v=" + view );
						break;
					case ByDiscipline:
						response.sendRedirect( "listarc.jsp?disc=" + discipline );
						break;
				}
				break;
			case Proposed:
				switch( radioSelection ){
					case ByAlphabet:
						response.sendRedirect( "listpre.jsp?abc=" + alphabet );
						break;
					case ByNumber:
						response.sendRedirect( "viewpre.jsp?a=" + alphanumber + "&n=" + courseNum + "&v=" + view );
						break;
					case ByDiscipline:
						response.sendRedirect( "listpre.jsp?disc=" + discipline );
						break;
				}
				break;
		}
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/dspcrs.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	showForm(request, response, session, out, conn);
	asePool.freeConnection(conn);
%>

<%!
	//
	// show this form with data
	//
	void showForm(javax.servlet.http.HttpServletRequest request,
						javax.servlet.http.HttpServletResponse response,
						javax.servlet.http.HttpSession session,
						javax.servlet.jsp.JspWriter out,
						Connection conn) throws java.io.IOException {

		try{
			String sql = "";
			String[] alphabet = new String[26];

			com.ase.aseutil.AseUtil aseUtil = new com.ase.aseutil.AseUtil();

			alphabet = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z".split(",");

			out.println("		<form method=\'post\' name=\'aseForm\' action=\'?\'>" );
			out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

			// course by alpha
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td width=\"05%\" class=\'textblackTH\'><input type=\"radio\" name=\"radioSelection\" value=\"0\"></td>" );
			out.println("					 <td width=\"35%\" class=\'textblackTH\'>By Alphabet:&nbsp;</td>" );
			out.println("					 <td width=\"60%\"><select class=\'smalltext\' name=\"alphabet\" size=\"1\">" );
			out.println("							<option selected value=\"\">- select -</option>" );
			for ( int i = 0; i < 26; i++ ){
				out.println( "<option value=\"" + alphabet[i] + "\">" + alphabet[i] + "</option>" );
			}
			out.println("					 </select></td>" );
			out.println("				</tr>" );

			// course by alpha and number
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td width=\"05%\" class=\'textblackTH\'><input type=\"radio\" name=\"radioSelection\" value=\"1\"></td>" );
			out.println("					 <td class=\'textblackTH\' nowrap>By Course Alpha and Number:&nbsp;</td>" );
			out.println("					 <td>" );
			sql = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION FROM BannerAlpha ORDER BY COURSE_ALPHA";
			out.println( aseUtil.createSelectionBox( conn, sql, "alphanumber", "",false ));
			out.println("					 &nbsp;<input type=\'text\' size=\'5\' name=\'courseNum\' maxlength=\'5\' class=\'input\'></td>" );
			out.println("				</tr>" );

			// course by discipline
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td width=\"05%\" class=\'textblackTH\'><input type=\"radio\" name=\"radioSelection\" value=\"2\"></td>" );
			out.println("					 <td class=\'textblackTH\'>By Discipline:&nbsp;</td>" );
			out.println("					 <td>" );
			sql = "SELECT COURSE_ALPHA,ALPHA_DESCRIPTION FROM BannerAlpha ORDER BY COURSE_ALPHA";
			out.println( aseUtil.createSelectionBox( conn, sql, "discipline", "",false ));
			out.println("					 </td>" );
			out.println("				</tr>" );

			// course by status
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td width=\"05%\" class=\'textblackTH\'>&nbsp;</td>" );
			out.println("					 <td class=\'textblackTH\'>By Status:&nbsp;</td>" );
			out.println("					 <td>" );
			out.println("						<input type=\"radio\" value=\"Approved\" name=\"viewOption\">Approved Outline<br>" );
			out.println("						<input type=\"radio\" value=\"Proposed\" name=\"viewOption\">Proposed Outline<br>" );
			out.println("						<input type=\"radio\" value=\"Archived\" name=\"viewOption\">Archived Outline" );
			out.println("					 </td>" );
			out.println("				</tr>" );

			// form buttons
			out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
			out.println("					 <td class=\'textblackTHRight\' colspan=\'3\'><hr size=\'1\'>" );
			out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm()\">" );
			out.println("							<input type=\'hidden\' name=\'v\' value=\'s\'>" );
			out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
			out.println("							<input type=\'hidden\' name=\'courseType\' value=\'\'>" );
			out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
			out.println("					 </td>" );
			out.println("				</tr>" );
			out.println("			</table>" );
			out.println("		</form>" );

			aseUtil = null;
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
