<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>

<%@ page import="com.ase.aseutil.xml.CreateXml"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ANTH";
	String num = "215";
	String type = "CUR";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "B59b26j12237";
	String message = "";

	String proposer = "";
	String historyid = "";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{
			if (!kix.equals(Constant.BLANK)){
				String[] info = helper.getKixInfo(conn,kix);
				alpha = info[0];
				num = info[1];
				type = info[2];
				proposer = info[3];
				campus = info[4];
				historyid = info[5];
				createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);
			}
		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!
	public static void createOutlines(Connection conn,
													String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx,
													String type,
													boolean includeCourseInFileName,
													boolean print,
													boolean rawEdit) throws Exception {

		Logger logger = Logger.getLogger("test");

		boolean methodCreatedConnection = false;

		// WARNING
		//
		// Do not call createOutlines with forceCreate as the last parameter outside of this routine
		// this routine ensures that only the correct outlines are created
		// creation of outlines should be done only on PRE since they are not yet approved.
		// once approved, they should not be altered to preserve data in use at the time

		try{
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			if (conn != null){
				String currentDrive = AseUtil.getCurrentDrive();
				String documents = SysDB.getSys(conn,"documents");

				// if kix is available, determine proper type to avoid recreating
				// an outline once approved as CUR
				if (kix != null){
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
					info = null;
				}

				// file name with complete path
				String fileName = currentDrive
											+ ":"
											+ documents
											+ "outlines\\"
											+ campus
											+ "\\";

				if (includeCourseInFileName){
					fileName = fileName + alpha + "_" + num + "_";
				}

				fileName = fileName + kix + ".html";

				boolean createOutline = false;

				// does it exist?
				File file = new File(fileName);
				boolean exists = file.exists();

				// check for the file's existence. if it is found and the outline is in PRE, allow creation
				// else, if not found, create regardless of type

				if(rawEdit){
					createOutline = true;
				}
				else if (exists && type.equals(Constant.PRE)) {
					createOutline = true;
				}
				else if (!exists) {
					createOutline = true;
				}

				if(createOutline){
					createOutlines(conn,campus,kix,alpha,num,task,idx,type,includeCourseInFileName,print,true,rawEdit);
				}
			} // conm

			// only if the connection was created here
			if (methodCreatedConnection){

				try{
					conn.close();
					conn = null;
				}
				catch(Exception e){
					logger.fatal("Tables: createOutlines - " + e.toString());
				}

			} // methodCreatedConnection

		}
		catch(Exception e){
			logger.fatal("Tables: createOutlines - " + e.toString());
		}

	}

	public static void createOutlines(Connection conn,
													String campus,
													String kix,
													String alpha,
													String num,
													String task,
													String idx,
													String type,
													boolean includeCourseInFileName,
													boolean print,
													boolean forceCreate,
													boolean rawEdit) throws Exception {

		Logger logger = Logger.getLogger("test");

		// SEE NOTE in above routine - DO NOT CALL this routine directly

		boolean debug = true;

		Msg msg = null;

		boolean compressed = true;

		FileWriter fstream = null;
		BufferedWriter output = null;

		String sql = "";
		String holdCampus = "";
		String documents = "";

		String html = "";
		boolean createHTML = false;

		String xml = "";
		boolean createXML = false;

		int rowsAffected = 0;

		PreparedStatement ps = null;

		String currentDrive = AseUtil.getCurrentDrive();

		boolean methodCreatedConnection = false;

		String table = "tblCourse";
		String outlineYear = "";

		try {

			debug = DebugDB.getDebug(conn,"Tables");

debug = true;

			if (debug){
				if (debug) logger.info("-------------------- CREATEOUTLINES - START");
				logger.info("campus: " + campus);
				logger.info("kix: " + kix);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("type: " + type);
				logger.info("task: " + task);
				logger.info("idx: " + idx);
				logger.info("includeCourseInFileName: " + includeCourseInFileName);
				logger.info("print: " + print);
				logger.info("forceCreate: " + forceCreate);
				logger.info("rawEdit: " + rawEdit);
			}

			// let's hope we have a valid connection
			// depending on where this is called, there is an option to use the connection pool
			// or create a manual connection. This is true for SearchDB.createSearchData
			// when null, that's because we didn't provide a connection. if we don't provide one,
			// then we should close the connection when it's created here.
			if (conn == null){
				conn = AsePool.createLongConnection();
				methodCreatedConnection = true;
			}

			// let's hope we have a valid connection
			if (conn != null){

				// just in case a KIX didn't make it in
				if(kix != null && type.length() > 0){
					String[] info = Helper.getKixInfo(conn,kix);
					type = info[Constant.KIX_TYPE];
				}

				if (type == null || type.length() == 0){
					type = "CUR";
				}

				documents = SysDB.getSys(conn,"documents");

				// when updating the HTML table, should HTML file be created also? If yes, this will run a lot longer
				createHTML = false;
				html = SysDB.getSys(conn,"createHTML");
				if (html.equals(Constant.ON)){
					createHTML = true;
				}

				// creating XML is part of practice to create PDF. So far not working
				createXML = false;
				xml = SysDB.getSys(conn,"createXML");
				if (xml.equals(Constant.ON)){
					createXML = true;
				}

				if (debug){
					logger.info("obtained HTML template");
					logger.info("documents: " + documents);
					logger.info("createHTML: " + createHTML);
					logger.info("createXML: " + createXML);
				}

				String htmlHeader = Util.getResourceString("header.ase");
				String htmlFooter = "";

				//
				// outline stamp in footer (ER00038 - HAW)
				//
				String showAuditStampInFooter = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","showAuditStampInFooter");
				if(showAuditStampInFooter.equals(Constant.ON)){
					htmlFooter = Util.getResourceString("footer_stamp.ase");
					Calendar calendar = Calendar.getInstance();
					outlineYear = "" + calendar.get(Calendar.YEAR);
				}
				else{
					htmlFooter = Util.getResourceString("footer.ase");
				}

				// campus is null when running as a scheduled job (CreateOulinesJob.java).
				// otherwise, campus is available for creation of a single outline
				if (campus == null || campus.length() == 0){

					// prepare the table for process (delete jobs first)
					JobsDB.deleteJob("CreateOutlines");

					// tasks are htm or html. htm is for all outlines and html is differential from a certain date
					if (task.equals("all")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,c.coursetype,'System',getdate() "
							+ "FROM tblCourse c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,c.coursetype,'System',getdate() "
							+ "FROM tblCourseARC c, tblhtml h "
							+ "WHERE c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "ORDER BY c.campus, c.coursealpha, c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();


					} // "all".equals(task)
					else if (task.equals("diff")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "AND (NOT auditdate IS NULL) "
							+ "AND DateDiff(day,[auditdate],getdate()) < 30 "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "AND (NOT auditdate IS NULL) "
							+ "AND DateDiff(day,[auditdate],getdate()) < 30 "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "diff".equals(task)
					else if (task.equals("frce")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE (NOT campus IS NULL) "
							+ "AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "frce".equals(task)
					else if (task.equals("idx")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,'System',getdate() "
							+ "FROM tblCourse c, tblHtml h "
							+ "WHERE  c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND c.coursealpha like '" + idx + "%' "
							+ "ORDER BY c.campus,c.coursealpha,c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',c.historyid,c.campus,c.coursealpha,c.coursenum,c.coursetype,'System',getdate() "
							+ "FROM tblCourseARC c, tblHtml h "
							+ "WHERE  c.historyid=h.historyid "
							+ "AND (NOT c.campus IS NULL) "
							+ "AND (NOT c.historyid IS NULL) "
							+ "AND c.coursealpha like '" + idx + "%' "
							+ "ORDER BY c.campus,c.coursealpha,c.coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "idx".equals(task)
					else if (task.equals("pre")){

						// regenerate for all PRE outlines
						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'PRE','System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE coursetype='PRE' AND (NOT campus IS NULL) AND (NOT historyid IS NULL) "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					}
					else if (task.equals("test")){

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE coursealpha='ENG' "
							+ "AND coursenum='100' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected = ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE coursealpha='ENG' "
							+ "AND coursenum='100' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,coursetype,'System',getdate() "
							+ "FROM tblCourse "
							+ "WHERE coursealpha='ACC' "
							+ "AND coursenum='201' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

						sql = "INSERT INTO tblJobs(job,historyid,campus,alpha,num,type,auditby,auditdate) "
							+ "SELECT 'CreateOutlines',historyid,campus,coursealpha,coursenum,'ARC','System',getdate() "
							+ "FROM tblCourseARC "
							+ "WHERE coursealpha='ACC' "
							+ "AND coursenum='201' "
							+ "ORDER BY campus,coursealpha,coursenum";
						ps = conn.prepareStatement(sql);
						rowsAffected += ps.executeUpdate();
						ps.close();

					} // "test".equals(task)

					if (debug) logger.info("outlines to process: " + rowsAffected + " rows");

					sql = "SELECT historyid, campus, alpha, num, type FROM tbljobs ORDER BY campus,alpha, num, type";

					ps = conn.prepareStatement(sql);
				}
				else{ // else campus == null

					if (type.equals(Constant.ARC)){
						table = "tblCourseARC";
					}
					else{
						table = "tblCourse";
					}

					if (kix !=null && kix.length() > 0){
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num, coursetype AS type "
								+ "FROM " + table + " WHERE campus=? AND historyid=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,kix);
					}
					else if (alpha != null && num != null && type != null && alpha.length() > 0 && num.length() > 0 && type.length() > 0){
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num, coursetype AS type "
								+ "FROM " + table + " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=?";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						ps.setString(4,type);
					}
					else{
						sql = "SELECT historyid, campus, coursealpha AS alpha, coursenum AS num, coursetype AS type "
								+ "FROM " + table + " WHERE campus=? ORDER BY coursealpha, coursenum";
						ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
					}

				} // set up sql

				if (debug){
					logger.info("obtained document folder");
					logger.info("creating outlines - " + task);
					logger.info("table - " + table);
					logger.info("sql - " + sql);
				}

debug = false;
boolean tracker = true;

				ResultSet rs = ps.executeQuery();
				while (rs.next() && !debug) {
					kix = AseUtil.nullToBlank(rs.getString("historyid"));
					campus = AseUtil.nullToBlank(rs.getString("campus"));
					alpha = AseUtil.nullToBlank(rs.getString("alpha"));
					num = AseUtil.nullToBlank(rs.getString("num"));
					type = AseUtil.nullToBlank(rs.getString("type"));

					if (!campus.equals("TTG")){

						try {
							String fileName = currentDrive
														+ ":"
														+ documents
														+ "outlines\\"
														+ campus
														+ "\\";

							if (includeCourseInFileName){
								fileName = fileName + alpha + "_" + num + "_";
							}

							fileName = fileName + kix + ".html";
							if (tracker) logger.info("fileName: " + fileName);

							// display log of campus being processed
							if (!campus.equals(holdCampus)){
								holdCampus = campus;
								if (tracker) logger.info("processing outlines for: " + holdCampus);
							}

							try{
								// write the HTML
								if (createHTML){
									fstream = new FileWriter(fileName);
									output = new BufferedWriter(fstream);
									output.write(htmlHeader);
									if (tracker) logger.info("processing outline: " + alpha + " " + num);
if (tracker) logger.info("writing header");
									output.write("<p align=\"center\" class=\"outputTitleCenter\">" + CampusDB.getCampusName(conn,campus) + "<br/>\n");
									output.write(CourseDB.getCourseDescriptionByTypePlus(conn,campus,alpha,num,type) + "</p>");
									msg = Outlines.viewOutline(conn,kix,"",compressed,print,createHTML);
									String junk = msg.getErrorLog().replace("<br>","<br/>");
									output.write(junk);
if (tracker) logger.info("writing content");

									//
									// outline stamp in footer (ER00038 - HAW)
									//

htmlFooter = "</td></tr></table>";
									String tempFooter = htmlFooter;
									if(showAuditStampInFooter.equals(Constant.ON)){
										tempFooter = tempFooter.replace("[FOOTER_COPYRIGHT]","Copyright ©1999-"+outlineYear+" All rights reserved.")
																		.replace("[FOOTER_STATUS_DATE]",Outlines.footerStatus(conn,kix,type));
									} // showAuditStampInFooter

									output.write(tempFooter);

String aphist = "<br/>"
	+"<table border=\"0\" width=\"660\" class=\"tableCaption\">"
	+"<tr>"
	+"<td align=\"left\"><hr size=1><a style=\"text-decoration:none\" name=\"approval_history\"  class=\"goldhighlights\">Approval History</a></td>"
	+"</tr>"
	+"<tr bgcolor=\"#ffffff\">"
	+"<td>"
	+"<table border=\"0\" cellpadding=\"2\" width=\"100%\">";
output.write(aphist);

String histText = "";
ArrayList list = HistoryDB.getHistories(conn,kix,type);
if (list != null){
	History history;
	for (int i=0; i<list.size(); i++){
		history = (History)list.get(i);
		histText += "<tr class=\"textblackTH\"><td valign=top>" + history.getDte() + " - " + history.getApprover() + "</td></tr>"
					+ "<tr><td valign=top>" + history.getComments() + "</td></tr>";
	}
	output.write(histText);
}

aphist = "</table>"
+"</td>"
+"</tr>"
+"</table>";

output.write(aphist);

htmlFooter = "</body></html>";
output.write(tempFooter);

if (tracker) logger.info("writing footer: ");

									//
									// tidy up html
									//
									if (createXML){
										CreateXml outlineXML = new CreateXml();
										outlineXML.createXML(conn,campus,kix);
										outlineXML = null;
									} // createXML

								}
// TTGIANG
// WE DO NOT WANT TO DO THIS

//Html.updateHtml(conn,Constant.COURSE,kix);

// refresh HTML for quick access
//Tables.updateCampusOutline(conn,"Outline",campus,kix);

							}
							catch(Exception e){
								logger.fatal("Tables: createOutlines - fail to create outline - "
										+ campus + " - " + kix  + " - " + alpha  + " - " + num
										+ "\n"
										+ e.toString());
							}

						}
						catch(Exception e){
							logger.fatal("Tables: createOutlines - fail to open/create file - "
									+ campus + " - " + kix  + " - " + alpha  + " - " + num
									+ "\n"
									+ e.toString());
						} finally {
							if (createHTML){
								output.close();
							}
						}

						JobsDB.deleteJobByKix(conn,kix);

					} // campus != ttg

				} // while

				rs.close();
				rs = null;

				ps.close();
				ps = null;

				// only if the connection was created here
				if (methodCreatedConnection){
					conn.close();
					conn = null;
				}

				if (debug) logger.info("connection closed");

			} // if conn != null

			if (debug) logger.info("-------------------- CREATEOUTLINES - END");

		} catch (Exception e) {
			logger.fatal("Tables: createOutlines FAILED3 - "
					+ campus + " - " + kix  + " - " + alpha  + " - " + num
					+ "\n"
					+ e.toString());
		}
		finally{
			// only if the connection was created here
			if (methodCreatedConnection){
				try{
					if (conn != null){
						conn.close();
						conn = null;
					}
				}
				catch(Exception e){
					logger.fatal("Tables: createOutlines - " + e.toString());
				}
			}
		}

		return;
	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
