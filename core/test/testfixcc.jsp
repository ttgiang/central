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
	String kixNew = "752g28k91872945";
	String kixOld = "230j28k947";

	out.println("Start<br/>");

	// added route to tblCourseCC2
	// added compare argument
	//msg = compareOutline(conn,kixNew,kixOld,Constant.COURSETYPE_PRE,user);
	//out.println(msg.getErrorLog());

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	/*
	 * compareOutline
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kixNew	String
	 *	@param	kixOld	String
	 * @param	section	int
	 *	@param	user		String
	 *	<p>
	 * @return Msg
	 */
	public static Msg compareOutline(Connection conn,String kixNew,String kixOld,int section,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		String row1 = "<tr bgcolor=\"" + Constant.ODD_ROW_BGCOLOR + "\">"
			+"<td height=\"20\" class=textblackTH width=\"2%\" align=\"right\" valign=\"top\"><| counter |>.&nbsp;</td>"
			+"<td colspan=\"3\" class=\"textblackTH\" valign=\"top\"><| question |></td>"
			+"</tr>";

		String row2 = "<tr>"
			+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
			+"<td class=\"dataColumn\" bgcolor=\"LIGHTBLUE\" valign=\"top\" width=\"45%\"><| answer1 |></td>"
			+"<td align=\"center\" bgcolor=\"LIGHTGRAY\" valign=\"top\" width=\"8%\">"
			+ "<input type=\"checkbox\" class=\"input\"></td>"
			+"<td class=\"dataColumn\" bgcolor=\"LIGHTYELLOW\" valign=\"top\" width=\"45%\"><| answer2 |></td>"
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
		String temp = "";												// date for processing

		String[] info = Helper.getKixInfo(conn,kixNew);
		alpha = info[0];
		num = info[1];
		type = info[2];
campus = "LEE";
		hid = kixNew;

		logger.info(kixNew + " - " + user + " - CourseDB - compareOutline - STARTS");

		AseUtil aseUtil = new AseUtil();

		// collect all columns from course and campus table
		String f1 = aseUtil.lookUp(conn, "tblCampus", "courseItems", "campus='" + campus + "'" );
		String f2 = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );

		// how many fields are we working with
		String[] c3 = (f1 + "," + f2).split(",");
		String[] dataOld = new String[c3.length];
		String[] dataNew = new String[c3.length];

		Msg msg = new Msg();
		int i = 0;

		String question = "";

		try {
			// delete any existing pdf data
			PDFDB.delete(conn,user,"Outline");

			dataOld = getOutlineData(conn,kixNew,section,user,true);
			dataNew = getOutlineData(conn,kixOld,section,user,false);

			// clear place holder or items without any data from the template
			for(i=0;i<c3.length;i++){
				t1 = row1;
				t2 = row2;

				question = aseUtil.lookUp(conn, "vw_AllQuestions", "question", "campus='" + campus + "' AND question_friendly = '" + c3[i] + "'" );

				t1 = t1.replace("<| counter |>",(""+(i+1)));
				t1 = t1.replace("<| question |>",question+"<br/><br/>");
				t2 = t2.replace("<| answer1 |>",dataOld[i]+"<br/><br/>");
				t2 = t2.replace("<| answer2 |>",dataNew[i]+"<br/><br/>");

				buf.append(t1);
				buf.append(t2);

				temp = dataOld[i].replace("<br/>","<br>");
				PDFDB.insert(conn,new PDF("Outline",user,kixOld,question,temp,i));
			}

			if (AttachDB.attachmentExists(conn,kixNew)){
				t1 = "<tr>"
					+"<td height=\"20\" colspan=\"4\" class=\"textblackTH\" valign=\"top\">Attachments<br/><br/></td>"
					+"</tr>";
				t2 = row2;

				t2 = t2.replace("<| answer1 |>",AttachDB.getAttachmentAsHTMLList(conn,kixNew)+"<br/><br/>");

				buf.append(t1);
				buf.append(t2);
			}

			msg.setErrorLog("<form name=\"\" action=\"\"  method=\"post\">"
								+ "<table width=\"100%\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"4\">"
								+ "<tr bgcolor=\"#e1e1e1\">"
								+"<td height=\"20\" class=\"textblackTH\" width=\"2%\" align=\"right\" valign=\"top\">&nbsp;</td>"
								+"<td class=\"textblackth\" bgcolor=\"LIGHTBLUE\" valign=\"top\">OLD</td>"
								+"<td align=\"center\" bgcolor=\"LIGHTGRAY\" valign=\"top\">COPY</td>"
								+"<td class=\"textblackth\" bgcolor=\"LIGHTYELLOW\" valign=\"top\">NEW</td>"
								+"</tr>"
								+ buf.toString()
								+ "</table>"
								+ "</form>");

		} catch (Exception e) {
			msg.setMsg("Exception");
			System.out.println("CourseDB: compareOutline - " + e.toString());
		}

		logger.info(kixNew + " - " + user + " - CourseDB - compareOutline - ENDS");

		return msg;
	} // compareOutline

	/*
	 * getOutlineData
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	kixNew	String
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

		String junk = "";
		String alpha = "";
		String num = "";
		String campus = "";
		String type = "";

		String[] info = Helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
campus = "LEE";

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
		String[] c3 = (f1 + "," + f2).split(",");

		String[] data = new String[c3.length];

		// append to columns with aliasing for select statement below
		String x1 = "c." + f1.replace(",",",c.");
		String x2 = "s." + f2.replace(",",",s.");

		int i = 0;

		try {
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
						+ "FROM " + table + " c LEFT OUTER JOIN " + tableCampus + " s ON c.historyid = s.historyid "
						+ "WHERE c.historyid=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					ResultSet rs = ps.executeQuery();
					if (rs.next()){

						for(i=0;i<c3.length;i++){
							temp = aseUtil.nullToBlank(rs.getString(c3[i]));
							temp = Html.fixHTMLEncoding(temp);
							temp = Outlines.formatOutline(conn,c3[i],campus,alpha,num,"PRE",kix,temp);

							if (temp != null && temp.length() > 0)
								data[i] = temp;
							else
								data[i] = "";
						}	// for
					}	// if
					rs.close();
					ps.close();
				}

			} finally {
			}
		} catch (Exception e) {
System.out.println("CourseDB: compareOutline - " + e.toString());
		}

		logger.info(kix + " - " + user + " - CourseDB - compareOutline - ENDS");

		return data;
	} // compareOutline

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

