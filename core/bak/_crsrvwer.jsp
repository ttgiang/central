<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrvwer.jsp
	*	2007.09.01	review outline
	*	TODO - allow proposer to comment back to reviewer
	*	TODO remove statement and use arraylist
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	// course to work with
	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");

	// is there a course and number to work with?
	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsrvwer&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "90%";
	String pageTitle = "Review Course Outline";
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="highslide/highslide.js"></script>
	<script type="text/javascript" src="highslide/highslide-html.js"></script>
	<script type="text/javascript" src="highslide/highslide2.js"></script>
	<link rel="stylesheet" type="text/css" href="highslide/highslide.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	String campus = (String)session.getAttribute("aseCampus");
	String type = "PRE";
	String historyID = null;

	if ( alpha != null && num != null ){
		// get course field names
		try{
			Statement stmt = null;
			ResultSet rs = null;
			String sql = "";
			String temp = "";
			int columnCount = 0;
			String[] questions = new String[100];
			int[] question_number = new int[100];
			int j = 0;

			stmt = conn.createStatement();

			// retrieve questions for GUI
			ArrayList list = QuestionDB.getCampusQuestions(conn,campus);
			columnCount = list.size();

			// tack on history to the end and up the column count by 1
			temp = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'") + ",historyid";
			++columnCount;

			// with field names, get data for the course in question
			if ( temp.length() > 0 ){
				// put field names into an array for later use
				String[] aFieldNames = new String[columnCount];
				aFieldNames = temp.split(",");

				sql = "SELECT " + temp + " " +
					"FROM tblCourse " +
					"WHERE coursetype='PRE' AND " +
					"coursealpha=" + aseUtil.toSQL(alpha,1) + " AND " +
					"coursenum=" + aseUtil.toSQL(num,1) + " AND " +
					"campus=" + aseUtil.toSQL(campus,1);
				rs = aseUtil.openRecordSet( stmt, sql );
				java.util.Hashtable rsHash = new java.util.Hashtable();

				out.println( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );
				if ( rs.next() ) {
					aseUtil.getRecordToHash( rs, rsHash, aFieldNames );
					historyID = (String) rsHash.get(aFieldNames[--columnCount]);
					Question question;
					for(j = 0; j < list.size(); j++) {
						question = (Question)list.get(j);
						temp = "<tr><td align=\"left\" width=\"05%\" valign=\"top\" nowrap>" +
							"<a href=\"crscmnt.jsp?hid=" + historyID + "&alpha=" + alpha + "&num=" + num + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" alt=\"add comments\" id=\"add_comments\"></a>&nbsp;" +
							"<a href=\"crsrvwcmnts.jsp?hid=" + historyID + "&qn=" + question.getNum() + "\" onclick=\"return hs.htmlExpand(this, { contentId: 'highslide-html', objectType: 'ajax'} )\"><img src=\"../images/reviews.gif\" alt=\"review comments\" id=\"review_comments\"></a></td>" +
							"<td width=\"95%\" valign=\"top\"><b>" + question.getQuestion() + "</b></td></tr>" +
							"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\">" + (String) rsHash.get(aFieldNames[j]) + "</td></tr>";
						out.println( temp );
					}	// for
				}	// if rs.next
				out.println( "</table>" );

				rs.close();
			}

			rs = null;
			stmt.close();
			stmt = null;
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
		%>
			<a href="crsrvwcmnts.jsp?hid=<%=historyID%>&qn=0" class="linkcolumn" onclick="return hs.htmlExpand(this, { contentId: 'highslide-html', objectType: 'ajax'} )">view all comments</a>
		<%
		out.println( "&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'crsrvwer1.jsp?hid=" + historyID + "&alpha=" + alpha + "&num=" + num + "\' class=\'linkColumn\'>I'm done reviewing</a></p>");
		out.println( "</p>");
	}	// if alpha and num not null
%>

<div class="highslide-html-content" id="highslide-html" style="width: 700px">
	<div class="highslide-move" style="border: 0; height: 18px; padding: 2px; cursor: default">
		 <a href="#" onclick="return hs.close(this)" class="control">Close</a>
	</div>
	<div class="highslide-body"></div>
</div>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
