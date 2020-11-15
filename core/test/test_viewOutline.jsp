<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "MAU";
	String alpha = "VIET";
	String num = "100D";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "I29f23i973";
	int t = 0;

	String fileName = "this is a test.doc";
	String ext = fileName.toLowerCase();

	out.println("Start<br/>");
	//out.println(viewOutline(conn,kix,Constant.COURSETYPE_PRE,user));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!

	/*
	 * viewOutline
	 *	<p>
	 *	@param	conn	Connection
	 *	@param	kix	String
	 *	@param	user	String
	 *	<p>
	 * @return Msg
	 */
	public static Msg viewOutline(Connection conn,String kix,int section,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		String row1 = "<tr>"
			+"<td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"dataColumn\" valign=\"top\"><| answer |></td>"
			+"</tr>";

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String junk = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";
		String hid = "";
		boolean appendLater = false;								// determines when to append data

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];
		hid = info[5];

		logger.info(kix + " - " + user + " - CourseDB - viewOutline - STARTS");
		AseUtil.loggerInfo(kix + " - " + user + " - " + campus + " - " + alpha + " - " + num);

		StringBuffer contents = new StringBuffer();			// contents of print template

		String line = "";												// input line
		String question = "";										// item question
		String temp = "";												// date for processing
		String sql = "";
		String table = "tblCourse";

		AseUtil aseUtil = new AseUtil();

		// collect all columns from course and campus table
		String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
		String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

		// combine columns (f1 & f2) into a single list
		String[] c1 = f1.split(",");
		String[] c2 = f2.split(",");
		String[] c3 = (f1 + "," + f2).split(",");

		String[][] data = new String[2][c3.length];

		// append to columns with aliasing for select statement below
		String x1 = "c." + f1.replace(",",",c.");
		String x2 = "s." + f2.replace(",",",s.");

		Msg msg = new Msg();
		int i = 0;
		int j = 0;

		String[] reuse;

		try {
			PDFDB.delete(conn,user);

			try {

				line = Outlines.getOutlineTemplate(conn,campus,"outline",type);

				/*
					with template read in, go through and replace holders with data
				*/
				if (line != null){
					temp = f1;

					switch (section) {
						case Constant.COURSETYPE_ARC:
							table = "tblCourseARC";
							break;
						case Constant.COURSETYPE_CAN:
							table = "tblCourseCAN";
							break;
						case Constant.COURSETYPE_CUR:
							break;
						case Constant.COURSETYPE_PRE:
							break;
					} // switch

					// select is now in proper format
					sql = "SELECT " + x1 + "," + x2 + " "
						+ "FROM " + table + " c,tblCampusData s "
						+ "WHERE c.historyid=s.historyid AND c.historyid=?";

					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,hid);
					ResultSet rs = ps.executeQuery();
					if (rs.next()){

						for(i=0;i<c3.length;i++){

							temp = aseUtil.nullToBlank(rs.getString(c3[i])).trim();
							temp = formatOutline(conn,c3[i],campus,alpha,num,"PRE",kix,temp);

							question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + campus + "' AND question_friendly = '" + c3[i] + "'" );

							if (!"".equals(question)){
								data[0][i] = question;
								data[1][i] = temp;
							}

							PDFDB.insert(conn,new PDF("Outline",user,kix,question,temp,i));
						}	// for
					}	// if
					rs.close();
					ps.close();

					// clear place holder or items without any data from the template
					for(i=0;i<c3.length;i++){
						t1 = row1;
						t2 = row2;

						t1 = t1.replace("<| counter |>",(""+(i+1)));
						t1 = t1.replace("<| question |>",data[0][i]+"<br/><br/>");
						t2 = t2.replace("<| answer |>",data[1][i]+"<br/><br/>");

						buf.append(t1);
						buf.append(t2);
					}

					msg.setErrorLog("<table width=\"680\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
										+ buf.toString()
										+ "</table>");
				}

			} finally {
			}
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("CourseDB: viewOutline - " + e.toString());
		}

		logger.info(kix + " - " + user + " - CourseDB - viewOutline - ENDS");

		return msg;
	} // viewOutline

	/*
	 * reviewOutline
	 *	<p>
	 *	@param	conn
	 *	@param	campus
	 *	@param	alpha
	 *	@param	num
	 *	@param	kix
	 *	<p>
	 *	@return Msg
	 */
	public static Msg reviewOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String kix) throws Exception {

		Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();
		AseUtil aseUtil = new AseUtil();
		StringBuffer outline = new StringBuffer();

		String sql = "";
		String temp = "";
		String tempCampus = "";

		String[] questions = new String[100];
		int[] question_number = new int[100];

		int columnCount = 0;
		int columnCountCampus = 0;
		int j = 0;

		Question question;
		String outputData = "";

		try{
			// retrieve questions for GUI
			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			columnCount = list.size();

			ArrayList listCampus = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			columnCountCampus = listCampus.size();

			// tack on history to the end and up the column count by 1
			temp = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'");
			tempCampus = aseUtil.lookUp(conn, "tblCampus", "campusitems", "campus='" + campus + "'");

			// with field names, get data for the course in question
			if (temp.length() > 0){
				// put field names into an array for later use
				String[] aFieldNames = new String[columnCount];
				long reviewerComments = 0;
				aFieldNames = temp.split(",");

				sql = "SELECT " + temp + " FROM tblCourse WHERE historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				java.util.Hashtable rsHash = new java.util.Hashtable();

				outline.append( "<table border=\"0\" width=\"100%\" id=\"table1\" cellspacing=2 cellpadding=8>" );
				if ( rs.next() ) {
					aseUtil.getRecordToHash(rs,rsHash,aFieldNames);
					for(j = 0; j < list.size(); j++) {
						question = (Question)list.get(j);
						reviewerComments = ReviewerDB.countReviewerComments(conn,campus,alpha,num,Integer.parseInt(question.getNum()),"reviewing",Constant.TAB_COURSE);
						outline.append("<tr><td align=\"left\" valign=\"top\" width=\"05%\" nowrap>" + (j+1) + ". " +
							"<a href=\"crscmnt.jsp?c=1&kix=" + kix + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" alt=\"add comments\" id=\"add_comments\"></a>&nbsp;");

						if (reviewerComments>0)
							outline.append("<a href=\"crsrvwcmnts.jsp?c=1&kix=" + kix + "&qn=" + question.getNum() + "\" onclick=\"return hs.htmlExpand(this, { objectType: 'ajax'} )\"><img src=\"images/comment.gif\" alt=\"review comments\" id=\"review_comments\"></a>&nbsp;(" + reviewerComments + ")</td>");
						else
							outline.append("<img src=\"images/no-comment.gif\" alt=\"review comments\" id=\"review_comments\">&nbsp;(" + reviewerComments + ")</td>");

						outputData = (String) rsHash.get(aFieldNames[j]);
						outputData = formatOutline(conn,aFieldNames[j],campus,alpha,num,"PRE",kix,outputData);

						outline.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + question.getQuestion() + "</td></tr>" +
							"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + outputData + "</td></tr>");
					}	// for
				}	// if rs.next
				rs.close();
				rs = null;
				ps.close();

				if (tempCampus.length() > 0){
					reviewerComments = 0;
					aFieldNames = tempCampus.split(",");

					sql = "SELECT " + tempCampus + " FROM tblCampusData WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					rs = ps.executeQuery();
					rsHash = new java.util.Hashtable();
					if ( rs.next() ) {
						aseUtil.getRecordToHash(rs,rsHash,aFieldNames);
						for(j = 0; j<listCampus.size(); j++) {
							question = (Question)listCampus.get(j);
							reviewerComments = ReviewerDB.countReviewerComments(conn,campus,alpha,num,Integer.parseInt(question.getNum()),"reviewing",Constant.TAB_CAMPUS);
							outline.append("<tr><td align=\"left\" valign=\"top\" width=\"05%\" nowrap>" + (j+columnCount+1) + ". " +
								"<a href=\"crscmnt.jsp?c=2&kix=" + kix + "&qn=" + question.getNum() + "\"><img src=\"../images/comment.gif\" alt=\"add comments\" id=\"add_comments\"></a>&nbsp;");

							if (reviewerComments>0)
								outline.append("<a href=\"crsrvwcmnts.jsp?c=2&kix=" + kix + "&qn=" + question.getNum() + "\" onclick=\"return hs.htmlExpand(this, { objectType: 'ajax'} )\"><img src=\"images/comment.gif\" alt=\"review comments\" id=\"review_comments\"></a>&nbsp;(" + reviewerComments + ")</td>");
							else
								outline.append("<img src=\"images/no-comment.gif\" alt=\"review comments\" id=\"review_comments\">&nbsp;(" + reviewerComments + ")</td>");

							outputData = (String) rsHash.get(aFieldNames[j]);
							outputData = formatOutline(conn,aFieldNames[j],campus,alpha,num,"PRE",kix,outputData);

							outline.append("<td width=\"95%\" valign=\"top\" class=\"textblackth\">" + question.getQuestion() + "</td></tr>" +
								"<tr><td align=\"left\" width=\"05%\"&nbsp;</td><td valign=\"top\" class=\"datacolumn\">" + outputData + "</td></tr>");
						}	// for
					}	// if rs.next
					rs.close();
					rs = null;
					ps.close();
				}

				outline.append("</table>");

				outline.append("<br><hr size=\'1\'>");
				outline.append("<p align=\'center\'>");

				if (kix != null)
					outline.append("<a href=\"crsrvwcmnts.jsp?kix=" + kix + "&qn=0\" class=\"linkcolumn\" onclick=\"return hs.htmlExpand(this, { objectType: \'ajax\'} )\">view all comments</a>");

				outline.append("&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'crsrvwerx.jsp?kix=" + kix + "\' class=\'linkColumn\'>I'm finished</a></p>");
				outline.append("</p>");

				msg.setErrorLog(outline.toString());
			}
		}
		catch( SQLException e ){
			msg.setMsg("Exception");
			logger.fatal("CourseDB: reviewOutline\n" + e.toString());
		}
		catch( Exception ex ){
			msg.setMsg("Exception");
			logger.fatal("CourseDB: reviewOutline - " + ex.toString());
		}

		return msg;
	}

	/*
	 * formatOutline
	 *	<p>
	 * @param	conn		Connection
	 * @param	column	String
	 * @param	campus	String
	 * @param	alpha		String
	 * @param	num		String
	 * @param	type		String
	 * @param	kix		String
	 * @param	temp		String
	 *	<p>
	 * @return StringBuffer
	 */
	public static String formatOutline(	Connection conn,
													String column,
													String campus,
													String alpha,
													String num,
													String type,
													String kix,
													String temp) throws Exception {

		Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		int j = 0;
		String junk = "";
		String line = "";
		String[] reuse;

		String lookupData[] = new String[2];
		String questionData[] = new String[2];
		String lookUpCampus = "campus='"+campus+"' AND type='Campus' AND question_friendly='__'";
		String lookUpSys = "campus='SYS' AND type='Course' AND question_friendly='__'";
		String explainField = "";
		String explainSQL = "historyid=" + aseUtil.toSQL(kix,1);

		String department = "";

		// look up the reference for retrieval of checklist/radio data.
		// if not found as a campus item, then it's likely to be a system item
		junk = lookUpCampus;
		junk = junk.replace("__",column);
		questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
		if ("NODATA".equals(questionData[0])){
			junk = lookUpSys;
			junk = junk.replace("__",column);
			questionData = aseUtil.lookUpX(conn,"cccm6100","question_type,question_ini", junk);
		}

		// for items with an explanation, look up the column holding the explanation
		// and print after the content.
		explainField = CCCM6100DB.getExplainColumnValue(conn,column);

		//System.out.println("------------------");
		//System.out.println("column: " + column);
		//System.out.println("question_type: " + questionData[0]);
		//System.out.println("question_ini: " + questionData[1]);
		//System.out.println("explainField: " + explainField);
		//System.out.println("explainSQL: " + explainSQL);
		//System.out.println("temp: " + temp);

		if (column.indexOf("date") > -1) {
			temp = aseUtil.ASE_FormatDateTime(temp, 6);
		} else if ("check".equals(questionData[0])) {
			// take apart semester from CSV format and lookup actual value
			// using campus, category and id

			if ((Constant.COURSE_CCOWIQ).equals(column)) {
				temp = CowiqDB.drawCowiq(conn,campus,kix,true);
			}
			else if ((Constant.COURSE_FUNCTION_DESIGNATION).equals(column)) {
				temp = FunctionDesignation.drawFunctionDesignation(conn,campus,temp,true);
			}
			else{
				if (temp != null && !"".equals(temp)){
					questionData[0] = "";
					reuse = temp.split(",");
					for(j=0;j<reuse.length;j++){
						junk = "campus='"+campus+"' AND category='"+questionData[1]+"' AND id=" + reuse[j];
						lookupData = aseUtil.lookUpX(conn,"tblINI","kid,kdesc",junk);
						junk = lookupData[1];
						if ("".equals(questionData[0]))
							questionData[0] = "<li>" + junk + "</li>";
						else
							questionData[0] = questionData[0] + "<li>" + junk + "</li>";
					}

					temp = "<ul>" + questionData[0] + "</ul>";

					if ("MAU".equals(campus) && (Constant.COURSE_METHODEVALUATION).equals(column)){
						temp = temp + "<br/>" + Outlines.showMethodEval(conn,campus,kix);
					}
				}
			}
		} else if ("radio".equals(questionData[0])) {

			if ((Constant.COURSE_REASONSFORMODS).equalsIgnoreCase(column)){
				if ("1".equals(temp))	temp = "Regular";	else	temp = "Other";
			}
			else if ("status".equalsIgnoreCase(questionData[1])){
				if ("1".equals(temp))	temp = "Active";	else	temp = "Inactive";
			}
			else if ("YESNO".equalsIgnoreCase(questionData[1])){
				if ("1".equals(temp))
					temp = "YES";
				else if ("0".equals(temp))
					temp = "NO";
				else
					temp = "";

				if ("crosslisted".equalsIgnoreCase(column))
					temp = temp + "<br/>" + CourseDB.getCrossListing(conn,kix);
			}

		} else if ("coursealpha".equals(column)) {
			department = DisciplineDB.getDisciplineFromAlpha(conn,campus,temp);
			line = line.replace("@A@department",department);
		} else if ("division".equals(column)) {
			temp = DivisionDB.getDivision(conn,campus,temp);
		} else if ("excluefromcatalog".equals(column)) {
			if ("1".equals(temp))	temp = "YES";	else	temp = "NO";
		} else if ("effectiveterm".equals(column) && temp != null && temp.length() > 0) {
			temp = TermsDB.getTermDescription(conn, temp);
		} else if ((Constant.COURSE_PREREQ).equals(column)) {
			temp = RequisiteDB.getRequisites(conn,campus,alpha,num,type,1,kix) + "<br/>" + temp;
		} else if ((Constant.COURSE_COREQ).equals(column)) {
			temp = RequisiteDB.getRequisites(conn,campus,alpha,num,type,2,kix) + "<br/>" + temp;
		} else if ((Constant.COURSE_OBJECTIVES).equals(column)) {
			temp = temp + "<br/>" + CompDB.getCompsAsHTMLList(conn,alpha,num,campus,type,kix,false,column);
		} else if ((Constant.COURSE_CONTENT).equals(column)) {
			temp = temp + "<br/>" + LinkerDB.getLinkedOutlineContent(conn,kix);
		} else if ((Constant.COURSE_COMPETENCIES).equals(column)) {
			temp = CompetencyDB.getCompetenciesAsHTMLList(conn,kix,false) + "<br/>" + temp;
		} else if ((Constant.COURSE_EXPECTATIONS).equals(column)) {
			temp = IniDB.getIniByCategory(conn,campus,"Expectations",temp,true);
		} else if ((Constant.COURSE_TEXTMATERIAL).equals(column)) {
			temp = temp + "<br/>" + TextDB.getTextAsHTMLList(conn,kix);
		} else if ((Constant.COURSE_GESLO).equals(column)) {
			temp = GESLODB.getGESLO(conn,campus,kix,true);
		} else if ((Constant.COURSE_RECPREP).equals(column)) {
			temp = temp + "<br/>" + ExtraDB.getExtraAsHTMLList(conn,kix,Constant.COURSE_RECPREP);
		} else if ((Constant.COURSE_PROGRAM_SLO).equals(column)) {
			temp = temp + "<br/>" + Outlines.showProgramSLO(conn,kix,Constant.COURSE_PROGRAM_SLO);
		}

		if(explainField != null && explainField.length() > 0)
			temp = temp + "<br/>" + aseUtil.lookUp(conn,"tblCampusData",explainField, explainSQL);

		return temp;
	}

%>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

