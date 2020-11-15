<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "MAU";
	String user = "THANHG";
	String alpha = "JNPS";
	String num = "202";
	String kixSource = "752g28k91872945";
	String kixDestination = "230j28k947";

	out.println("Start<br/>");

	msg = compareOutline(conn,kixSource,kixDestination,Constant.COURSETYPE_PRE,user);
	out.println(msg.getErrorLog());

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

// DO WITH CARE

// INLINE

	/*
	 * compareOutline - compares source and destination kix. The source is the on to be copied from.
	 *	<p>
	 *	@param	conn				Connection
	 *	@param	kixSource		String
	 *	@param	kixDestination	String
	 * @param	section			int
	 *	@param	user				String
	 *	<p>
	 * @return Msg
	 */
	public static Msg compareOutline(Connection conn,String kixSource,String kixDestination,int section,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"dataColumn\" bgcolor=\""+Constant.COLOR_LEFT+"\" valign=\"top\" width=\"45%\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"LIGHTGRAY\" valign=\"top\" width=\"8%\">"
			+ "<input type=\"checkbox\" class=\"input\" value=\"1\" name=\"<| inputName |>\"></td>"
			+"<td class=\"dataColumn\" bgcolor=\""+Constant.COLOR_RIGHT+"\" valign=\"top\" width=\"45%\"><| answer2 |></td>"
			+"</tr>";

		int i = 0;

		Msg msg = new Msg();

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String question = "";
		String junk = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";
		String temp = "";												// date for processing

		String[] info = Helper.getKixInfo(conn,kixSource);
		alpha = info[0];
		num = info[1];
		type = info[2];
campus = Constant.CAMPUS_LEE;

		logger.info(kixSource + " - " + user + " - CourseDB - compareOutline - STARTS");

		AseUtil aseUtil = new AseUtil();

		// how many fields are we working with
		String[] columns = QuestionDB.getCampusColumms(conn,campus).split(",");
		String[] columnNames = QuestionDB.getCampusColummNames(conn,campus).split(",");
		String[] dataSource = null;
		String[] dataDestination = null;

		try {
			dataSource = getOutlineData(conn,kixSource,section,user,true);
			dataDestination = getOutlineData(conn,kixDestination,section,user,false);

			// clear place holder or items without any data from the template
			for(i=0;i<dataSource.length;i++){
				t1 = row1;
				t2 = row2;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + campus + "' AND question_friendly = '" + columns[i] + "'" );

				t1 = t1.replace("<| counter |>",(""+(i+1)));
				t1 = t1.replace("<| question |>",question+"<br/><br/>");
				t2 = t2.replace("<| answer1 |>",dataSource[i]+"<br/><br/>");
				t2 = t2.replace("<| answer2 |>",dataDestination[i]+"<br/><br/>");
				t2 = t2.replace("<| inputName |>",columnNames[i]);

				buf.append(t1);
				buf.append(t2);

				temp = dataSource[i].replace("<br/>","<br>");
			}

			if (AttachDB.attachmentExists(conn,kixSource)){
				t1 = "<tr>"
					+"<td height=\"20\" colspan=\"4\" class=\"textblackTH\" valign=\"top\">Attachments<br/><br/></td>"
					+"</tr>";
				t2 = row2;

				t2 = t2.replace("<| answer1 |>",AttachDB.getAttachmentAsHTMLList(conn,kixSource)+"<br/><br/>");

				buf.append(t1);
				buf.append(t2);
			}

			msg.setErrorLog("<form name=\"aseForm\" action=\"cmprx.jsp\"  method=\"post\">"
								+ "<table width=\"100%\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"4\">"
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\""+Constant.COLOR_LEFT+"\" valign=\"top\">SOURCE</td>"
								+"<td align=\"center\" bgcolor=\"LIGHTGRAY\" valign=\"top\">COPY</td>"
								+"<td class=\"textblackth\" bgcolor=\""+Constant.COLOR_RIGHT+"\" valign=\"top\">DESTINATION</td>"
								+"</tr>"
								+ buf.toString()
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td colspan=\"4\" align=\"right\">"
								+ "<input type=\"hidden\" name=\"kixDestination\" value=\""+kixDestination+"\">"
								+ "<input type=\"hidden\" name=\"kixSource\" value=\""+kixSource+"\">"
								+ "<input title=\"transfer data\" type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\">"
								+ "<input title=\"cancel current operation\" type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\">"
								+ "</td>"
								+"</tr>"
								+ "</table>"
								+ "</form>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines: compareOutline - " + e.toString());
		}

		logger.info(kixSource + " - " + user + " - CourseDB - compareOutline - ENDS");

		return msg;
	} // compareOutline

	/*
	 * getOutlineData
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kixSource	String
	 *	@param	section	int
	 *	@param	user		String
	 *	@param	compare	boolean
	 *	<p>
	 * @return Msg
	 */
	public static String[] getOutlineData(Connection conn,String kix,int section,String user,boolean compare) throws Exception {

		Logger logger = Logger.getLogger("test");

		String t1 = "";
		String t2 = "";
		StringBuffer buf = new StringBuffer();

		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
campus = Constant.CAMPUS_LEE;

		logger.info(kix + " - " + user + " - CourseDB - compareOutline - STARTS");

		String line = "";												// input line
		String temp = "";												// date for processing
		String sql = "";
		String table = "tblCourse";
		String tableCampus = "tblCampusData";

		// when comparing outlines side by side
		if (compare){
			table = "tblCourseCC2";
			tableCampus = "tblCampusDataCC2";
		}

		AseUtil aseUtil = new AseUtil();

		// collect all columns from course and campus table
		String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
		String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

		// combine columns (f1 & f2) into a single list
		String[] c1 = f1.split(",");
		String[] c2 = f2.split(",");
		String[] columns = (f1 + "," + f2).split(",");

		String[] data = new String[columns.length];

		// append to columns with aliasing for select statement below
		String x1 = "c." + f1.replace(",",",c.");
		String x2 = "s." + f2.replace(",",",s.");

		int i = 0;

		try {
			line = Outlines.getOutlineTemplate(conn,campus,"outline",type);
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
					+ "FROM " + table + " c LEFT OUTER JOIN " + tableCampus + " s ON c.historyid = s.historyid "
					+ "WHERE c.historyid=?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ResultSet rs = ps.executeQuery();
				if (rs.next()){
					for(i=0;i<columns.length;i++){
						temp = aseUtil.nullToBlank(rs.getString(columns[i]));
						temp = Html.fixHTMLEncoding(temp);
						temp = Outlines.formatOutline(conn,columns[i],campus,alpha,num,"PRE",kix,temp,true,user);

						if (temp != null && temp.length() > 0)
							data[i] = temp;
						else
							data[i] = "";
					}	// for
				}	// if
				rs.close();
				ps.close();
			}

		} catch (SQLException se) {
			logger.fatal("Outlines: compareOutline - " + se.toString());
		} catch (Exception e) {
			logger.fatal("Outlines: compareOutline - " + e.toString());
		}

		logger.info(kix + " - " + user + " - CourseDB - compareOutline - ENDS");

		return data;
	} // compareOutline

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

		StringBuffer buf = new StringBuffer();
		Msg msg = new Msg();

		int i = 0;

		String t1 = "";
		String t2 = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		campus = info[4];

		logger.info(kix + " - " + user + " - CourseDB - viewOutline - STARTS");

		String question = "";										// item question
		String temp = "";												// date for processing
		String sql = "";
		String table = "tblCourse";

		AseUtil aseUtil = new AseUtil();

		String[] columns = QuestionDB.getCampusColumms(conn,campus).split(",");
		String[] data = null;

		try {
			PDFDB.delete(conn,user,"Outline");

			data = getOutlineData(conn,kix,section,user,false);

			// clear place holder or items without any data from the template
			for(i=0;i<data.length;i++){
				t1 = row1;
				t2 = row2;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + campus + "' AND question_friendly = '" + columns[i] + "'" );

				t1 = t1.replace("<| counter |>",(""+(i+1)));
				t1 = t1.replace("<| question |>",question+"<br/><br/>");
				t2 = t2.replace("<| answer |>",data[i]+"<br/><br/>");

				buf.append(t1);
				buf.append(t2);

				PDFDB.insert(conn,new PDF("Outline",user,kix,question,temp,i));
			}

			if (AttachDB.attachmentExists(conn,kix)){
				t1 = "<tr>"
					+"<td height=\"20\" colspan=\"2\" class=\"textblackTH\" valign=\"top\">Attachments<br/><br/></td>"
					+"</tr>";
				t2 = row2;

				t2 = t2.replace("<| answer |>",AttachDB.getAttachmentAsHTMLList(conn,kix)+"<br/><br/>");

				buf.append(t1);
				buf.append(t2);
			}

			msg.setErrorLog("<table width=\"680\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
								+ buf.toString()
								+ "</table>");

			// TO DO - this one is not good
			//msg.setErrorLog(HTMLSanitiser.encodeInvalidMarkup(msg.getErrorLog()));

			// TO DO - this requires testing
			//Source source = new Source(msg.getErrorLog());
			//String rawOutput = source.getSourceFormatter().setIndentString("1").setTidyTags(true).setCollapseWhiteSpace(false).setIndentAllElements(true).toString();
			//String output = CharacterReference.encode(rawOutput);

		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("Outlines: viewOutline - " + e.toString());
		}

		logger.info(kix + " - " + user + " - CourseDB - viewOutline - ENDS");

		return msg;
	} // viewOutline

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

