<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crstpl.jsp
	*	2007.09.01
	**/

	String alpha = "ICS";
	String num = "241";
	String type = "CUR";
	String campus = "KAP";

		StringBuffer outline = new StringBuffer();

		String historyID = null;
		String sql = "";
		String temp = "";

		String[] questions = new String[100];
		int[] question_number = new int[100];

		int columnCount = 0;
		int j = 0;

		try{
			// retrieve questions for GUI
			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			columnCount = list.size();

			// tack on history to the end and up the column count by 1
			temp = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'") + ",historyid";
			++columnCount;

			// with field names, get data for the course in question
			if ( temp.length() > 0 ){
				// put field names into an array for later use
				String[] aFieldNames = new String[columnCount];
				long reviewerComments = 0;
				aFieldNames = temp.split(",");

				sql = "SELECT " + temp + " FROM tblCourse WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				ResultSet rs = ps.executeQuery();
				java.util.Hashtable rsHash = new java.util.Hashtable();

				outline.append( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );
				if ( rs.next() ) {
					aseUtil.getRecordToHash(rs,rsHash,aFieldNames);
					historyID = (String)rsHash.get(aFieldNames[--columnCount]);
					Question question;
					for(j = 0; j < list.size(); j++) {
						question = (Question)list.get(j);

out.println("campus: " + campus + "<br>");
out.println("alpha: " + alpha + "<br>");
out.println("num: " + num + "<br>");
out.println("question.getNum(): " + question.getNum() + "<br>");
out.println("-----------<br>");

						reviewerComments = ReviewerDB.countReviewerComments(conn,campus,alpha,num,Integer.parseInt(question.getNum()),"reviewing");
						outline.append("<tr><td align=\"left\" width=\"05%\" nowrap>" +
							"<a href=\"crscmnt.jsp?hid=" + historyID + "&alpha=" + alpha + "&num=" + num + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" alt=\"add comments\" id=\"add_comments\"></a>&nbsp;" +
							"<a href=\"crsrvwcmnts.jsp?hid=" + historyID + "&qn=" + question.getNum() + "\" onclick=\"return hs.htmlExpand(this, { contentId: 'highslide-html', objectType: 'ajax'} )\"><img src=\"images/comment.gif\" alt=\"review comments\" id=\"review_comments\"></a>&nbsp;(" + reviewerComments + ")</td>" +
							"<td width=\"95%\" valign=\"top\"><b>" + question.getQuestion() + "</b></td></tr>" +
							"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\">" + (String) rsHash.get(aFieldNames[j]) + "</td></tr>");
					}	// for
				}	// if rs.next
				outline.append("</table>");

				rs.close();
				rs = null;

				ps.close();

				outline.append("<br><hr size=\'1\'>");
				outline.append("<p align=\'center\'>");

				if ( historyID != null )
					outline.append("<a href=\"crsrvwcmnts.jsp?hid=" + historyID + "&qn=0\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, { contentId: \'highslide-html\', objectType: \'ajax\'} )\">view all comments</a>");

				outline.append("&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'crsrvwer1.jsp?hid=" + historyID + "&alpha=" + alpha + "&num=" + num + "\' class=\'linkColumn\'>I'm done reviewing</a></p>");
				outline.append("</p>");

				msg.setErrorLog(outline.toString());
			}
		}
		catch( SQLException e ){
			msg.setMsg("Exception");
			out.println("CourseDB: reviewOutline\n" + e.toString());
		}
		catch( Exception ex ){
			msg.setMsg("Exception");
			out.println("CourseDB: reviewOutline\n" + ex.toString());
		}

	//out.println(msg.toString());
%>