<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

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

	String campus = "KAU";
	String alpha = "ITE";
	String num = "390E";
	String type = "ARC";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "H28j30b1334";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{
			//out.println(checkOutLineDates(conn,"enddate")+Html.BR());
			//out.println(checkOutLineDates(conn,"reviewdate")+Html.BR());
			//out.println(checkOutLineDates(conn,"experimentaldate")+Html.BR());

//ApproverDB.setApprovalRouting(conn,campus,alpha,num,1315);
//out.println(setCourseForApprovalX(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,user));

//runReport(request,response);

//setCourseReviewers(conn,campus,alpha,num,"THANHG","THANHG,ACOSTA","11/30/2012","COMMENTS",kix,0);

			campus = "KAU";
			alpha = "ACC";
			num = "358";
			kix = "G17c22e13173";
			type = "PRE";
			user = "CTENNBER";

out.println(writeSyllabus(conn,931,campus,user));

			/*

			kix = "G52a8c9139538";
			if(kix != null && kix.length() > 0){

				String[] info = helper.getKixInfo(conn,kix);
				String kalpha = info[Constant.KIX_ALPHA];
				String knum = info[Constant.KIX_NUM];
				String ktype = info[Constant.KIX_TYPE];
				String kcampus = info[Constant.KIX_CAMPUS];

				// move entry to archived table
				if(kcampus.equals("LEE") && kalpha.equals("ART") && knum.equals("116")){
					com.ase.aseutil.CourseCurrentToArchive cca = new com.ase.aseutil.CourseCurrentToArchive();
					msg = cca.moveCurrentToArchived(conn,kcampus,kalpha,knum,user);
					cca = null;

					out.println("Msg: " + aseUtil.nullToBlank(msg.getErrorLog()) + Html.BR() + Html.BR());
				}
			}

			*/


		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	/*
	 * xlist
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String courseTitle(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String output = "";

		try{
			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\HAW_CourseTitle.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "select c.historyid, c.coursealpha, c.coursenum, c.coursetitle as CC_BannerTitle, c.x79 as CC_CatTitle, b.CRSE_TITLE, b.CRSE_LONG_TITLE, "
				+ "CAST(b.CREDIT_LOW as varchar) + ' ' + CAST(b.CREDIT_IND as varchar) + ' ' +  CAST (b.CREDIT_HIGH as varchar) as credits "
				+ "FROM tblCourse c inner join haw_course_title b on c.coursealpha=b.CRSE_SUBJ AND c.coursenum=b.CRSE_NUMBER "
				+ "WHERE c.campus='HAW'  AND c.coursetype='CUR' and c.coursedate is null";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String CRSE_TITLE = AseUtil.nullToBlank(rs.getString("CRSE_TITLE"));
				String credits = AseUtil.nullToBlank(rs.getString("credits"));
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));

				sql = "update tblcourse set coursetitle=?,x79=?,credits=? where campus='HAW' AND coursetype='CUR' and coursedate IS NULL and historyid=?";
				PreparedStatement ps3 = conn.prepareStatement(sql);
				ps3.setString(1,CRSE_TITLE);
				ps3.setString(2,CRSE_TITLE);
				ps3.setString(3,credits);
				ps3.setString(4,historyid);
				rowsAffected = ps3.executeUpdate();
				ps3.close();

				if(rowsAffected > 0){
					output = "Updated: " + alpha + " - " + num + ": " + CRSE_TITLE + " ("+credits+")" + "\n";
					++processed;
				}
				else{
					output = "Not updated: " + alpha + " - " + num + ": " + CRSE_TITLE + " ("+credits+")" + "\n";
				}

				out.write(output);

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("banner - courseTitle: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("banner - courseTitle: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("banner - courseTitle: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("banner - courseTitle: " + e.toString());
			}

		}

		String junk = "banner: " + processed + " of " + read + " rows processed";

		return junk;

	}

	/*
	 * xlist
	 *	<p>
	 * @param	conn		Connection
	 */
	public static String courseDescr(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int processed = 0;
		int read = 0;

		Writer out = null;

		String output = "";

		try{
			out = new OutputStreamWriter(new FileOutputStream(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\HAW_courseDescr.txt"));
			out.write("campus: " + campus + "\n");
			out.write("------------\n");

			String sql = "SELECT c.coursetitle, c.historyid, c.coursealpha, c.coursenum, c.coursedescr, CRSE_SUBJ, CRSE_NUMBER, CATALOG_DESC as bannercat "
				+ "FROM tblcourse c inner join HAWCC_Cat b on c.coursealpha = b.crse_subj and c.coursenum = b.crse_number "
				+ "WHERE c.campus='HAW' and c.coursetype='CUR' and c.coursedescr is null and c.coursedate is null ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				String bannercat = AseUtil.nullToBlank(rs.getString("bannercat"));
				String historyid = AseUtil.nullToBlank(rs.getString("historyid"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));

				bannercat = bannercat.replace((char)13,(char)20);

				sql = "update tblcourse set coursedescr=? where campus='HAW' AND coursetype='CUR' and coursedescr IS NULL and coursedate is null and historyid=?";
				PreparedStatement ps3 = conn.prepareStatement(sql);
				ps3.setString(1,bannercat);
				ps3.setString(2,historyid);
				rowsAffected = ps3.executeUpdate();
				ps3.close();

				if(rowsAffected > 0){
					output = "Updated: " + alpha + " - " + num + "\n" + bannercat + "\n";
					++processed;
				}
				else{
					output = "Not Updated: " + alpha + " - " + num + "\n" + bannercat + "\n";
				}

				out.write(output);

			}
			rs.close();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("banner - courseDescr: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("banner - courseDescr: " + e.toString());
		}
		finally {
			try{
				out.close();
			}
			catch(IOException e){
				logger.fatal("banner - courseDescr: " + e.toString());
			}
			catch(Exception e){
				logger.fatal("banner - courseDescr: " + e.toString());
			}

		}

		String junk = "banner: " + processed + " of " + read + " rows processed";

		return junk;

	}

	/**
	 * reads the syllabus template file and formulate new content
	 *
	 * @param conn 	Connection
	 * @param sid		syllabus id
	 * @param campus	String
	 * @param user		String
	 */
	public static String writeSyllabus(Connection conn,int sid,String campus,String user) {

Logger logger = Logger.getLogger("test");

		StringBuffer contents = new StringBuffer();
		String content = "";
		String kix = "";
		String template = "";
		String temp = "";

		String division = "";
		String title = "";
		String credits = "";
		String prereq = "";
		String coreq = "";
		String recprep = "";
		String objectives = "";
		String descr = "";

		boolean LEE_ENG100 = false;

		try {
			// use buffering, reading one line at a time
			// FileReader always assumes default encoding is OK!
			// TODO file mapping and getting course data below (asepool as well)

			AseUtil aseUtil = new AseUtil();
			String currentDrive = aseUtil.getCurrentDirectory().substring(0, 1);

			Syllabus syllabus = SyllabusDB.getSyllabus(conn,campus,sid);

			kix = Helper.getKix(conn,campus,syllabus.getAlpha(),syllabus.getNum(),Constant.CUR);

			if (campus.equals(Constant.CAMPUS_LEE) && "ENG".equals(syllabus.getAlpha()) && "100".equals(syllabus.getNum())){
				template = "_syllabus_eng100.tpl";
				LEE_ENG100 = true;
			}
			else{
				template = "_syllabus.tpl";
			}

			File aFile = new File(currentDrive + ":\\tomcat\\webapps\\central\\core\\templates\\" + campus + template);
			BufferedReader input = new BufferedReader(new FileReader(aFile));

			try {
				String line = null; // not declared within while loop
				/*
				 * readLine is a bit quirky : it returns the content of a line
				 * MINUS the newline. it returns null only for the END of the
				 * stream. it returns an empty String if two newlines appear in
				 * a row.
				 */
				while ((line = input.readLine()) != null) {
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}

				/*
				 * 1) If all is OK, replace holders with data 2) Get remaining
				 * items 3) Get instructor info 4) Get disability statement
				 */
				if (contents != null) {
					String campusName = aseUtil.lookUp(conn, "tblCampus", "campusdescr", "campus='" + campus + "'");

					content = contents.toString();

					content = content.replace("@@campus@@", campusName)
								.replace("@@semester@@", syllabus.getSemester())
								.replace("@@year@@", syllabus.getYear())
								.replace("@@alpha@@", syllabus.getAlpha())
								.replace("@@number@@", syllabus.getNum());

					String sql = "SELECT division,title,credits,prereq,coreq,CoursePreReq,CourseCoReq,recprep,coursedescr "
						+ "FROM vw_WriteSyllabus WHERE campus=? AND CourseAlpha=? AND CourseNum=?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,syllabus.getAlpha());
					ps.setString(3,syllabus.getNum());
					ResultSet rs = ps.executeQuery();
					if (rs.next()) {
						division = AseUtil.nullToBlank(rs.getString("division"));
						title = AseUtil.nullToBlank(rs.getString("title"));
						credits = AseUtil.nullToBlank(rs.getString("credits"));

						prereq = AseUtil.nullToBlank(rs.getString("CoursePreReq"));
						String displayOrConsentForPreReqs = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","DisplayOrConsentForPreReqs");
						if (displayOrConsentForPreReqs.equals(Constant.ON)){
							prereq = Outlines.drawPrereq(prereq,"",true);
						}

						prereq = prereq
									+ "<br/>"
									+ AseUtil.nullToBlank(rs.getString("prereq"));

						String coreqButton = RequisiteDB.getRequisites(conn,
																						campus,
																						syllabus.getAlpha(),
																						syllabus.getNum(),
																						Constant.CUR,
																						Constant.REQUISITES_COREQ,
																						kix);

						if(!coreqButton.equals(Constant.BLANK)){
							//
							// KAU
							//
							coreq = coreqButton;
						}
						else{
							coreq = AseUtil.nullToBlank(rs.getString("CourseCoReq"))
										+ "<br/>"
										+ AseUtil.nullToBlank(rs.getString("coreq"));
						}

						recprep = AseUtil.nullToBlank(rs.getString("recprep"));
						content = content.replace("@@course@@", syllabus.getAlpha() + " " + syllabus.getNum() + ": " + title);
						descr = AseUtil.nullToBlank(rs.getString("coursedescr"));
					} else {
						content = content.replace("@@course@@", syllabus.getAlpha() + " " + syllabus.getNum());
					}
					rs.close();
					ps.close();

					//
					// prereq
					//
					if (prereq.equals(Constant.BLANK)){
						prereq = "None";
					}
					else{
						prereq = removeBRInFront(prereq);
					}

					//
					// coreq
					//
					if (coreq.equals(Constant.BLANK)){
						coreq = "None";
					}
					else{
						coreq = removeBRInFront(coreq);
					}

					//
					// rec prep
					//
					if (recprep.equals(Constant.BLANK)){
						recprep = "None";
					}
					else{
						recprep = removeBRInFront(recprep);
					}

					//
					// content
					//
					content = content.replace("@@division@@", division)
								.replace("@@title@@", title)
								.replace("@@credit@@", credits);

					String instructor[] = new String[5];
					instructor = aseUtil.lookUpX(conn,
														"tblUsers",
														"lastname,firstname,hours,location,phone,email",
														"userid='" + user + "'");

					if ("NODATA".equals(instructor[0])) {
						content = content.replace("@@instructor@@","[MISSING INFO]")
									.replace("@@hours@@", "[MISSING INFO]")
									.replace("@@office@@","[MISSING INFO]")
									.replace("@@contact@@","[MISSING INFO]");
					} else {
						content = content.replace("@@instructor@@",instructor[1] + " " + instructor[0])
									.replace("@@hours@@", instructor[2])
									.replace("@@office@@", instructor[3])
									.replace("@@contact@@", instructor[4])
									.replace("@@email@@", instructor[5]);
					}

					String textbooks = syllabus.getTextBooks();
					if(campus.equals(Constant.CAMPUS_KAU)){
						textbooks = CourseDB.getCourseItem(conn,kix,Constant.COURSE_TEXTMATERIAL)
							+ Html.BR()
							+ TextDB.getTextAsHTMLList(conn,kix);
					}

					content = content.replace("@@catdesc@@", wrapWithPTag(descr))
								.replace("@@coreq@@", wrapWithPTag(coreq))
								.replace("@@prereq@@", wrapWithPTag(prereq))
								.replace("@@recprep@@", wrapWithPTag(recprep))
								.replace("@@textbooks@@", wrapWithPTag(textbooks));

					//
					// grading options
					//
					if(campus.equals(Constant.CAMPUS_KAU)){
						String gradingOptions = Outlines.formatOutline(conn,"gradingoptions",campus,syllabus.getAlpha(),syllabus.getNum(),Constant.CUR,kix,syllabus.getGrading(),true,"");
						content = content.replace("@@grading@@",wrapWithPTag(gradingOptions));
					}
					else{
						content = content.replace("@@grading@@", wrapWithPTag(syllabus.getGrading()));
					}

					//
					// method of instructions
					//
					if(campus.equals(Constant.CAMPUS_KAU)){
						String methods = Outlines.formatOutline(conn,
																			"X68",
																			campus,
																			syllabus.getAlpha(),
																			syllabus.getNum(),
																			Constant.CUR,
																			kix,
																			CourseDB.getCourseItem(conn,kix,"X68"),
																			true,
																			user);
						content = content.replace("@@methods@@", wrapWithPTag(methods));
					}

					//
					// SLO
					//
					if(campus.equals(Constant.CAMPUS_KAU)){
						//
						// KAU - only need the list
						//
						objectives = "";
					}
					else{
						// objectives may be pulled from the main course table or from line item entries
						objectives = CompDB.getObjectives(conn,kix);
						if (objectives != null && objectives.length() > 0){
							objectives += Html.BR();
						}
					}

					objectives += CompDB.getCompsAsHTMLList(conn,syllabus.getAlpha(),syllabus.getNum(),campus,"CUR",kix,false,"");

					content = content.replace("@@objectives@@", wrapWithPTag(objectives));

					if (LEE_ENG100){
						temp = aseUtil.lookUp(conn, "tblStatement","statement", "type='ENG100' AND campus='" + campus + "'");
						content = content.replace("@@eng100@@", wrapWithPTag(temp));
					}

					String comments = syllabus.getComments();
					if (comments.equals(Constant.BLANK)){
						comments = "N/A";
					}

					content = content.replace("@@comments@@", wrapWithPTag(comments));

					String disability = aseUtil.lookUp(conn, "tblStatement","statement", "type='Disability' AND campus='" + campus + "'");
					content = content.replace("@@disability@@", wrapWithPTag(disability));
				}
			} finally {
				input.close();
			}
		} catch (IOException ex) {
			logger.fatal("SyllabusDB IOException: writeSyllabus - " + ex.toString());
			content = null;
		} catch (Exception e) {
			logger.fatal("SyllabusDB Exception: writeSyllabus - " + e.toString());
			content = null;
		}

		if(content != null && !content.equals(Constant.BLANK)){
			content = content.replace("datacolumn","");
		}

		return content;
	}

	/**
	 * removeBRInFront
	 *
	 * @param text	String
	 * @return String
	 */
	private static String removeBRInFront(String str){

Logger logger = Logger.getLogger("test");

		try{
			if(str != null){
				while(str.toLowerCase().startsWith("<br>")){
					str = str.replace("<br>","");
				}
			}
			else{
				str = "";
			}
		}
		catch(Exception e){
			logger.fatal("removeBRInFront - " + e.toString());
		}

		return str;

	}

	/**
	 * wrapWithPTag
	 *
	 * @param str	String
	 * @return String
	 */
	private static String wrapWithPTag(String str) {

		return "<p>" + str + "</p>";

	}

////

	private static Msg setCourseForApprovalX(Connection conn,
														String campus,
														String alpha,
														String num,
														String proposer,
														String mode,
														String user) throws Exception {

Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		int lastSequence = 0;
		int nextSequence = 1;
		int numberOfApproversThisSequence = 0;

		String lastApprover = "";
		String nextApprover = "";

		String lastDelegate = "";
		String nextDelegate = "";

		String completeList = "";

		String sql = "";

		boolean approvalCompleted = false;

		Approver approver = new Approver();
		boolean approved = false;
		boolean experimental = false;
		PreparedStatement ps = null;

		long count = 0;

		String packetApproval = "";

		String[] info = Helper.getKixRoute(conn,campus,alpha,num,"PRE");
		String kix = info[0];
		int route = Integer.parseInt(info[1]);
		info = null;

		boolean deleteApproval = false;

		boolean debug = false;

		try {

			debug = DebugDB.getDebug(conn,"CourseDB");

debug = true;

			if (debug) logger.info("-------------------- CourseDB - setCourseForApproval START");

			packetApproval = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

			// for courses going through deletion as packets, we need to adjust
			// data before moving on here. data for the course was adjusted when
			// the approval process began
			if(kix != null && packetApproval.equals(Constant.ON)){

				info = Helper.getKixInfo(conn,kix);
				String progress = info[Constant.KIX_PROGRESS];
				String subprogress = info[Constant.KIX_SUBPROGRESS];
				info = null;

				if(progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT) && subprogress.equals(Constant.COURSE_DELETE_TEXT) ){

					deleteApproval = true;

					sql = "UPDATE tblcourse SET progress=?,subprogress='' WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,Constant.COURSE_DELETE_TEXT);
					ps.setString(2,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();

					mode = Constant.COURSE_DELETE_TEXT;
				}

				progress = "";
				subprogress = "";
				sql = "";

			} // kix and packetApproval

			String taskText = "";
			if (mode.equals(Constant.COURSE_DELETE_TEXT)){
				taskText = Constant.DELETE_TEXT;
			}
			else{
				taskText = Constant.APPROVAL_TEXT;
			}

			experimental = Outlines.isExperimental(num);

			//----------------------------------------------------------------------------
			// FORUM
			//----------------------------------------------------------------------------
			String enableMessageBoard = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableMessageBoard");
			if (enableMessageBoard.equals(Constant.ON)){
				if(ForumDB.getForumID(conn,campus,kix) == 0){
					// create the new forum and add proposer to access
					int fid = ForumDB.createMessageBoard(conn,campus,user,kix);
					if(fid > 0){
						Board.addBoardMember(conn,fid,user);
					}
				}
			} // board is enabled

			// get list of names. if approved, find next, else resend
			approver = ApproverDB.getApprovers(conn,campus,alpha,num,proposer,experimental,route);
			if (debug){
				logger.info("experimental: " + experimental);
				logger.info("route: " + route);
				logger.info("packetApproval: " + packetApproval);
				//logger.info("approver: " + approver);
			} // debug

			if (approver != null){
				// break into array
				String[] approvers = new String[20];
				approvers = approver.getAllApprovers().split(",");

				String[] delegates = new String[20];
				delegates = approver.getAllDelegates().split(",");

				completeList = approver.getAllCompleteList();

				if (debug){
					logger.info("approvers: " + approver.getAllApprovers());
					logger.info("delegates: " + approver.getAllDelegates());
					logger.info("completeList: " + approver.getAllCompleteList());
				}

				// if nothing is in history, send mail to first up else who's next
				// get max sequence and determine who was last
				// if last approved, send to next; if last reject, resend
				count = ApproverDB.countApprovalHistory(conn,kix);
				if (count == 0){
					if (debug) logger.info("countApprovalHistory count is 0 or no one started");

					lastSequence = 1;
					nextSequence = 1;
					approved = false;

					numberOfApproversThisSequence = ApproverDB.getApproverCount(conn,campus,lastSequence,route);
					String ApprovalSubmissionAsPackets = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

					// when only a single approver at sequence 1, use it
					if (numberOfApproversThisSequence == 1){
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						if (debug) logger.info("only 1 approver this sequence");
					}
					else if (numberOfApproversThisSequence > 1 && ApprovalSubmissionAsPackets.equals(Constant.ON)){
						// at start up, if this is the first person then check for department chair
						// if the chair is there, then get the delegate
						nextApprover = ChairProgramsDB.getChairName(conn,campus,alpha);
						if (nextApprover != null && nextApprover.length() > 0){
							nextDelegate = ChairProgramsDB.getDelegatedName(conn,campus,alpha);
							if (debug) logger.info("department chair found - " + nextApprover + "/" + nextDelegate);
						}
					} // numberOfApproversThisSequence

					// however, if department chair not set up, use approver sequence
					if (nextApprover == null || nextApprover.length() == 0){
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
						if (debug) logger.info("department chair not found");
					}

					lastApprover = nextApprover;
					lastDelegate = nextDelegate;

					// TrackItemChanges
					Outlines.trackItemChanges(conn,campus,kix,user);
				}
				else{
					sql = "SELECT approver,approved " +
						"FROM tblApprovalHist WHERE seq IN " +
						"(SELECT MAX(seq) AS Expr1 FROM tblApprovalHist WHERE historyid=?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1,kix);
					ResultSet rs = ps.executeQuery();
					if (rs.next()) {
						lastApprover = AseUtil.nullToBlank(rs.getString("approver"));
						approved = rs.getBoolean("approved");
						lastSequence = ApproverDB.getApproverSequence(conn,lastApprover,route);
						if (debug) logger.info("lastSequence: " + lastSequence);
					}
					rs.close();
					ps.close();
				}	// if count

				numberOfApproversThisSequence = ApproverDB.getApproverCount(conn,campus,nextSequence,route);

				// if approved and not the last person, get next; else where do we go back to
				if (approved){
					if (debug) logger.info("approved");

					if (!lastApprover.equals(approvers[approvers.length-1])){
						nextSequence = lastSequence + 1;

						// adjust for 0th based array
						nextApprover = approvers[--nextSequence];

						approvalCompleted = false;
					}
					else
						approvalCompleted = true;
				}
				else{
					if (debug) logger.info("not approved");

					String whereToStartOnOutlineRejection = IniDB.getWhereToStartOnOutlineRejection(conn,campus);
					if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_WITH_REJECTER)){
						if (debug) logger.info("Constant.REJECT_START_WITH_REJECTER");
						nextApprover = lastApprover;
						nextDelegate = lastDelegate;
					}
					else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_START_FROM_BEGINNING)){
						if (debug) logger.info("Constant.REJECT_START_FROM_BEGINNING");
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}
					else if (whereToStartOnOutlineRejection.equals(Constant.REJECT_STEP_BACK_ONE)){
						if (debug) logger.info("Constant.REJECT_STEP_BACK_ONE");
						// a step back would be the last person to approve this outline in history.
						// since this is rejection, we have to look for the last person to approve
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}
					else {
						// in case whereToStartOnOutlineRejection was not set
						nextApprover = approvers[0];
						nextDelegate = delegates[0];
					}

					approvalCompleted = false;
				}	// if approved

				if (debug){
					logger.info("taskText " + taskText);
					logger.info("lastApprover: " + lastApprover);
					logger.info("nextApprover: " + nextApprover);
					logger.info("nextDelegate: " + nextDelegate);
					logger.info("nextSequence: " + nextSequence);
					logger.info("completeList: " + completeList);
					logger.info("numberOfApproversThisSequence: " + numberOfApproversThisSequence);
				}

				if (!approvalCompleted){
					sql = "UPDATE tblCourse "
							+ "SET edit=0,edit0='',edit1='3',edit2='3',progress=?,reviewdate=null "
							+ "WHERE campus=? "
							+ "AND coursealpha=? "
							+ "AND coursenum=? "
							+ "AND coursetype='PRE'";
					ps = conn.prepareStatement(sql);
					ps.setString(1,mode);
					ps.setString(2,campus);
					ps.setString(3,alpha);
					ps.setString(4,num);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("course set for approval");

					// delete modify or revise task for author
					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,
															Constant.MODIFY_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("modify task removed - rowsAffected " + rowsAffected);

					rowsAffected = TaskDB.logTask(conn,proposer,proposer,alpha,num,
															Constant.REVISE_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("revise task removed - rowsAffected " + rowsAffected);

					// delete review tasks for all in this outline
					rowsAffected = TaskDB.logTask(conn,"ALL",proposer,alpha,num,
															Constant.REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_REMOVE,
															Constant.PRE);
					if (debug) logger.info("review tasks removed - rowsAffected " + rowsAffected);

					// delete approval pending for user who is likely to be the DC
					if(deleteApproval){
						rowsAffected = TaskDB.logTask(conn,proposer,user,alpha,num,
																Constant.DELETE_APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}
					else{
						rowsAffected = TaskDB.logTask(conn,proposer,user,alpha,num,
																Constant.APPROVAL_PENDING_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_REMOVE,
																Constant.PRE);
					}

					if (debug) logger.info("approval pending tasks removed - rowsAffected " + rowsAffected);

					//	if the approver list is not complete and there is no approval yet, it's because the division
					//	chair was not decided or known.
					//	if numberOfApproversThisSequence = 1, then there is only one person this sequence
					//	so just send it. If more than one, show a list.
					//
					//	above is overridden by packetApproval is ON. In which case, the chair of the department is first up

					if (	completeList.equals(Constant.OFF) &&
							count== 0 &&
							numberOfApproversThisSequence > 1 &&
							packetApproval.equals(Constant.OFF)){
						msg.setCode(1);
						msg.setMsg("forwardURL");
					}
					else{

						rowsAffected = TaskDB.logTask(conn,
																nextApprover,
																proposer,
																alpha,
																num,
																taskText,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																Constant.PRE,
																proposer,
																Constant.TASK_APPROVER);

						if (nextDelegate != null && nextDelegate.length() > 0){
							rowsAffected = TaskDB.logTask(conn,
																	nextDelegate,
																	proposer,
																	alpha,
																	num,
																	taskText,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_ADD,
																	Constant.PRE,
																	proposer,
																	Constant.TASK_APPROVER);
						}

						if (debug) logger.info("approval task created - rowsAffected " + rowsAffected);

						MailerDB mailerDB = new MailerDB(conn,
																	proposer,
																	nextApprover,
																	nextDelegate,
																	Constant.BLANK,
																	alpha,
																	num,
																	campus,
																	"emailOutlineApprovalRequest",
																	kix,
																	proposer);

						if (debug) logger.info("mail sent");
					}
				}
			} // if (approver != null){

			if (debug) logger.info("-------------------- CourseDB - setCourseForApproval END");

		} catch (SQLException ex) {
			logger.fatal(kix + " - CourseDB: setCourseForApprovalX - " + ex.toString());
			msg.setMsg("CourseApprovalError");
		} catch (Exception e) {
			logger.fatal(kix + " - CourseDB: setCourseForApprovalX - " + e.toString());
		}

		return msg;
	} // CourseDB: setCourseForApprovalX

//
// DO NOT TOUCH BELOW HERE
//

	/**
	 * setItemDependencies - set items dependent on other items on
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	table		int
	 * @param	edits		String
	 * <p>
	 * @return	String
	 */
	public static String setItemDependencies(Connection conn,String campus,String edits){

edits = "80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49,0,0,0,0";

Logger logger = Logger.getLogger("test");

		/*
			1 - [5,4,13,27,28,29]
			2 - [6,4,13,28,29,31,32]
			3 - [7,4,13,28,29]
			4 - [8,4,18,19,20,21,22,28,29]
			5 - [9,4,19,24,25,28,29]
			6 - [10,4,11,28,29]
			7 - [11,4,10]
			8 - [14,28,29]
			9 - [16,28,29]
			10 - [18,4,19,20,21,22,23,28,29,31,32]
			11 - [26,28,29]
		*/

		// with 4
		//edits = "0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
		// 0,0,0,29,1,2,3,13,73,4,32,0,9,15,0,16,0,18,23,76,75,19,20,24,72,12,37,7,49,0,8,1,0

		// with 16
		//edits = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
		// 0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,16,0,18,23,76,75,19,20,0,0,12,0,7,49,0,8,1,0

		// with 4 & 16
		//edits = "0,0,0,29,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0";
		// 0,0,0,29,1,2,3,13,73,4,32,0,9,15,0,16,0,18,23,76,75,19,20,24,72,12,37,7,49,0,8,1,0


		// edits comes in like this "0,0,0,0,8,0,0,0,0,55,0,0,0,0,15,0,0,0,0,96,0"
		// numbers not zero are actual question numbers as created in CCCM6100.

		// need to look at dependencies and turn on any other items for modifiction
		//
		// system setting OutlineItemDependencies looks something like this: [2,5,6],[7,8,20]
		//
		// we go through all items and if any grouped item is enabled, we enable all items in the group
		//
		// for example, for grouping 1 (2,5,6), if 2 or 5 or 6 is enabled, then 2, 5, and 6 are all enabled.

		String outlineItemDependencies = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","OutlineItemDependencies");

		if(outlineItemDependencies != null && outlineItemDependencies.length() > 0){

			outlineItemDependencies = outlineItemDependencies.replace(" ","");

			// the original edit string (what user selected)
			String[] aSystem = edits.split(",");

			// include comma at the end to help split work properly since we use
			// commas within brackets; example: [1,2,3],[4,5,6]
			// in this scenario, enable items 1, 2, 3, 4, 5, and 6 along
			// with all that has been enabled in edits
			outlineItemDependencies = outlineItemDependencies + ",";

			// break apart grouping into array elements
			String[] enabled = outlineItemDependencies.split("],");

			int table = Constant.TAB_COURSE;
			int maxCourseItems = 0;

			// get the number of questions on the course tab. we use this value
			// to help retrieve the sequence for the item we need to work with
			try{
				maxCourseItems = CourseDB.countCourseQuestions(conn,campus,"Y","",table);
			}
			catch(Exception e){
				maxCourseItems = 0;
			}

			int j = 0;

			int idx = 0;

			for(int i = 0; i <enabled.length ; i++){

System.out.println("------------------------");

				try{

					// break apart grouping
					enabled[i] = enabled[i].replace("[","");

					// check each grouping to see if items were enabled
					// if found, then enable all items in grouping
					// one grouping at a time
					String[] dependencies = enabled[i].split(",");

					if(dependencies != null){

						// for each group, start with fresh listing. this makes each group
						// independent of the ones before and after
						String[] grouping = edits.split(",");

						j = 0;

						boolean dependencyFound = false;

						while(j < dependencies.length && dependencyFound == false){

							idx = NumericUtil.getInt(dependencies[j],0);

							// user selected items are by sequence
							// and array elements are 0-based so we adjust here
							if(idx > 0 && !grouping[idx-1].equals(Constant.OFF)){
System.out.println("group: " + (i+1) + "; idx: " + idx);
								dependencyFound = true;
							} // valid idx

							++j;

						} // while j

						// if item in grouping found, enable all other items in group
						if(dependencyFound){

							for(j = 0; j < dependencies.length; j++){
								// get the item or sequence and retrieve the
								// actual question number to enable
								idx = NumericUtil.getInt(dependencies[j],0);

								int seq = idx;

								if (idx < maxCourseItems){
									table = Constant.TAB_COURSE;
								}
								else{
									// when on campus tab, subtract to
									// realign seq based on number of items on tab
									// for example if the array element is 23
									// and course tab has 21, then the seq on
									// campus is 2
									table = Constant.TAB_CAMPUS;
									seq = seq - maxCourseItems;
								}

								int questionNumber = QuestionDB.getQuestionNumber(conn,campus,table,seq);

								aSystem[idx-1] = "" + questionNumber;

System.out.println("dep: " + j + "; s: " + seq + "; q: " + questionNumber);

							} // for j

						} // dependencyFound


					} // dependencies

				}
				catch(ArrayIndexOutOfBoundsException e){
					logger.fatal("EditFieldServlet.outlineItemDependencies: " + e.toString());
				}
				catch(Exception e){
					logger.fatal("EditFieldServlet.outlineItemDependencies: " + e.toString());
				}

			} // for i

			// put enabled items back into string
			edits = "";
			for(j=0; j<aSystem.length; j++){

				if(j==0){
					edits = aSystem[j];
				}
				else{
					edits = edits + "," + aSystem[j];
				}

			} // j

		} // outlineItemDependencies

		return edits;

	}

	/*
	 * A course is copyable if it's in the right progress
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	toAlpha	String
	 *	@param	toNum		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg isCourseCopyable(Connection conn,
													String campus,
													String toAlpha,
													String toNum) throws SQLException {

Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		/*
			to copy, the following must be true

			1) user belonging to same discipline
			2) from/to alpha and number may not be the same
			3) TO outline may not be in existence at the campus
			4) FROM outline may not be going through modifications
		*/

		boolean debug = false;
		try {
			debug = DebugDB.getDebug(conn,"CourseDB");

			if (debug) logger.info("CourseDB - isCourseCopyable: " + campus + " - " + toAlpha + " - " + toNum);

			if (	!CourseDB.courseExistByTypeCampus(conn,campus,toAlpha,toNum,"PRE") &&
					!CourseDB.courseExistByTypeCampus(conn,campus,toAlpha,toNum,"CUR")) {
				msg.setMsg("");
			}
			else{
				msg.setMsg("NotAllowToCopyOutline");
				logger.info("CourseDB - isCourseCopyable NOT at this time: " + campus + " - " + toAlpha + " - " + toNum);
			}

		} catch (Exception e) {
			logger.fatal("CourseDB: isCourseCopyable - " + e.toString());
		}

		return msg;
	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
