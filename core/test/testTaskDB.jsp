<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HIL";
	String alpha = "BURM";
	String num = "555";
	String type = "PRE";
	String user = "SIMMONS";
	String task = "Modify_outline";
	String kix = "u42k31i102";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			//removeStrayReviewers(conn,campus);

			//removeStrayTasks(conn,campus,user);

			out.println(showUserTasks(conn,campus,user));

			// out.println(CourseDB.isNextApprover(conn,campus,alpha,num,user));
			//addMissingApprovalTask(conn,campus,user);
			//createMissingModifyTasks(conn,campus,"");
		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/*
	 * showUserTasks
	 * <p>
	 * @param	Connection	conn
	 * @param	String		userCampus
	 * @param	String		user
	 * <p>
	 * @return String
	 */
	public static String showUserTasks(Connection conn,String userCampus,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		// HTML tags
		String tableStart = "<table class=\"" + userCampus + "BGColor\" width=\"98%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">";
		String tableEnd = "</table>";

		String headerRowStart = "<tr class=\"" + userCampus + "BGColor\">";
		String headerRowEnd = "</tr>";

		String headerCellStart = "<td align=\"\">";
		String headerCellEnd = "</td>";

		String dataRowStart = "<tr class=\"" + userCampus + "BGColorRow\" bgcolor=\"#__XXX__\">";
		String dataRowEnd = "</tr>";

		String dataCellStart = "<td valign=\"top\" height=\"24\" align=\"\">";
		String dataCellEnd = "</td>";

		String oddRow = "e1e1e1";
		String evenRow = "ffffff";

		// loop counter
		int counter = 0;

		// number of columns from database
		int columns = 7;

		// HTML table header
		String colHeader[] = "Submitted For,Submitted By,Progress,Outline/Program,Task,Date,Campus".split(",");

		String temp = "";
		StringBuffer bf = new StringBuffer();
		StringBuffer data = new StringBuffer();

		String taskLower = "";
		String linkLower = "";

		int idx = 0;
		boolean found = false;
		boolean foundSource = false;

		String[] task = (Constant.TASK_TEXT).split(",");
		String[] srce = (Constant.TASK_SOURCE).split(",");
		String[] tpe = (Constant.TASK_TYPE).split(",");
		int totalSrce = task.length;

		String alpha = "";
		String num = "";
		String campus = "";
		String kix = "";
		String msg = "";
		String displayedTask = "";
		String link = "";
		String source = "";
		String type = "";
		String outlineType = "";
		String progress = "";
		String proposer = "";
		String actions = "";
		String submittedFor = "";
		String submittedBy = "";
		String href = "";
		String category = "";
		int route = 0;

		// final output to table
		String[] output = new String[columns];

		String[] info = null;

		int outputRows = 0;

		// CC chair gets extra links
		boolean isCCChair = SQLUtil.isCCChair(conn,user);

		boolean debug = false;
		boolean test = false;

		boolean courseExistByTypeCampus = false;
		boolean programExistByTitleCampus = false;

		String sql = "";
		String degree = "";

		try{
			CourseDB courseDB = new CourseDB();
			AseUtil au = new AseUtil();

			test = true;

			if (test){
				sql = "SELECT submittedfor,submittedby,Coursealpha,Coursenum,Message,dte,Campus,historyid "
					+ "FROM tblTasks "
					+ "WHERE campus=? "
					+ "AND coursealpha='PHYS' "
					+ "AND coursenum='211' "
					+ "AND submittedfor=? ";

				debug = true;
			}
			else{
				sql = "SELECT submittedfor,submittedby,Coursealpha,Coursenum,Message,dte,Campus,historyid "
					+ "FROM tblTasks "
					+ "WHERE campus=? "
					+ "AND submittedfor=? "
					+ "ORDER BY coursealpha,coursenum";
			}

			if (debug) logger.info("------------------- showUserTasks START");

System.out.println(sql);

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,userCampus);
			ps.setString(2,user);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				found = true;

				// alternating row color
				temp = dataRowStart;
				if (outputRows % 2 == 0)
					temp = temp.replace("__XXX__",evenRow);
				else
					temp = temp.replace("__XXX__",oddRow);
				bf.append(temp);

				campus = AseUtil.nullToBlank(rs.getString("campus"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				msg = AseUtil.nullToBlank(rs.getString("message"));
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				submittedFor = AseUtil.nullToBlank(rs.getString("submittedFor"));
				submittedBy = AseUtil.nullToBlank(rs.getString("submittedby"));

				if (debug) logger.info("kix: " + kix);

				// locate the task to create proper HREF tags
				idx = 0;
				foundSource = false;
				source = "";
				type = "";
				while (idx<totalSrce && foundSource==false){
					taskLower = task[idx].toLowerCase();
					linkLower = msg.toLowerCase();
					if (taskLower.equals(linkLower)){
						source = srce[idx];
						type = tpe[idx];
						foundSource = true;
					}
					++idx;
				}

				href = "";
				actions = "";

				courseExistByTypeCampus = false;
				programExistByTitleCampus = false;

				if (kix == null || (Constant.BLANK).equals(kix))
					kix = Helper.getKix(conn,campus,alpha,num,type);

				// outline or program
				boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
				if (debug) logger.info("isAProgram: " + isAProgram);
				if (!isAProgram){
					info = Helper.getKixInfo(conn,kix);
					proposer = info[Constant.KIX_PROPOSER];
					progress = info[Constant.KIX_PROGRESS];
					route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
					category = Constant.COURSE;
					courseExistByTypeCampus = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR");
				}
				else if (!(Constant.BLANK).equals(kix) && msg.toLowerCase().indexOf("program") > -1){
					info = ProgramsDB.getKixInfo(conn,kix);
					alpha = info[Constant.KIX_PROGRAM_TITLE];
					num = info[Constant.KIX_PROGRAM_DIVISION];
					type = info[Constant.KIX_TYPE];
					proposer = info[Constant.KIX_PROPOSER];
					progress = info[Constant.KIX_PROGRESS];
					route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
					category = Constant.PROGRAM;
					degree = ProgramsDB.getProgramDegreeDescr(conn,kix);
					programExistByTitleCampus = programExistByTitleCampus;
				}
				else
					href = "&alpha=" + alpha + "&num=" + num + "&campus=" + campus + "&view=" + type;

				// outline can be modified as new or existing, or deleted
				// if CUR exists, then it's either modify or delete
				outlineType = Constant.BLANK;
				if ((Constant.APPROVED_TEXT).equals(msg)){
					outlineType = Constant.COURSE_APPROVAL_TEXT;
				}
				else{
					if (courseExistByTypeCampus){
						if ((Constant.COURSE_DELETE_TEXT).equals(progress))
							outlineType = Constant.COURSE_DELETE_TEXT;
						else
							outlineType = Constant.COURSE_MODIFY_TEXT;
					}
					else
						outlineType = Constant.COURSE_CREATE_TEXT;
				}

				if (debug) logger.info("category: " + category);
				if (debug) logger.info("outlineType: " + outlineType);
				if (debug) logger.info("msg: " + msg);

				/*
					if modify outline is text and this is a sent back for revision,
					change text to display revise outline

					we know it's going through approval because there is a route number,
					and there is text in approval history.

					ttgiang - 2010.06.23 per s.pope
				*/
				if ((Constant.APPROVED_TEXT).equals(msg)){
					outlineType = Constant.COURSE_APPROVED_TEXT;

					if (debug) logger.info("task progress: 0");
				}
				else if ((Constant.PROGRAM_APPROVED_TEXT).equals(msg)){
					outlineType = Constant.PROGRAM_APPROVED_PROGRESS;

					if (debug) logger.info("task progress: 0");
				}
				else if ((Constant.MAIL_LOG_TEXT).equals(msg)){
					outlineType = Constant.MAIL_LOG;

					if (debug) logger.info("task progress: 1");
				}
				else if ((Constant.MODIFY_TEXT).equals(msg)){
					long approvalHistory = ApproverDB.countApprovalHistory(conn,kix);
					if (route > 0 && approvalHistory > 0){
						msg = Constant.REVISE_TEXT;
						outlineType = Constant.COURSE_REVISE_TEXT;
					}

					if (debug) logger.info("task progress: 2");
				}
				else if ((Constant.APPROVAL_TEXT).equals(msg)){
					outlineType = Constant.COURSE_APPROVAL_TEXT;
				}
				else if (	(Constant.APPROVAL_PENDING_TEXT).equals(msg) ||
								(Constant.APPROVE_REQUISITE_TEXT).equals(msg) ||
								(Constant.APPROVE_PROGRAM_TEXT).equals(msg) ||
								(Constant.APPROVE_CROSS_LISTING_TEXT).equals(msg)
							){
					outlineType = Constant.COURSE_PENDING_TEXT;

					if (debug) logger.info("task progress: 3");
				}
				else if ((Constant.REVIEW_TEXT).equals(msg)){
					outlineType = Constant.COURSE_REVIEW_TEXT;

					if (debug) logger.info("task progress: 4");
				}
				else if ((Constant.PROGRAM_CREATE_TEXT).equals(msg)){
					outlineType = Constant.PROGRAM_CREATE_PROGRESS;

					if (debug) logger.info("task progress: 5");
				}
				else if ((Constant.PROGRAM_APPROVAL_TEXT).equals(msg)){
					outlineType = Constant.PROGRAM_APPROVAL_PROGRESS;

					if (debug) logger.info("task progress: 6");
				}
				else if ((Constant.PROGRAM_MODIFY_TEXT).equals(msg)){
					outlineType = Constant.PROGRAM_MODIFY_PROGRESS;

					if (debug) logger.info("task progress: 7");
				}
				else if ((Constant.PROGRAM_REVIEW_TEXT).equals(msg)){
					outlineType = Constant.PROGRAM_REVIEW_PROGRESS;

					if (debug) logger.info("task progress: 8");
				}

				/*
					properly display message to avoid confusions
				*/
				displayedTask = "";
				if ((Constant.COURSE_APPROVED_TEXT).equals(outlineType)){
					displayedTask = msg;

					if (debug) logger.info("outline/program progress: 00");
				}
				else if ((Constant.PROGRAM_APPROVED_TEXT).equals(outlineType)){
					displayedTask = msg;

					if (debug) logger.info("outline/program progress: 00");
				}
				else if ((Constant.COURSE_PENDING_TEXT).equals(outlineType)){
					displayedTask = msg;

					if (debug) logger.info("outline/program progress: 00");
				}
				else if ((Constant.COURSE_PENDING_TEXT).equals(outlineType)){
					displayedTask = msg;

					if (debug) logger.info("outline/program progress: 11");
				}
				else if ((Constant.MAIL_LOG).equals(outlineType)){
					displayedTask = msg;

					if (debug) logger.info("outline/program progress: 21");
				}
				else if ((Constant.COURSE).equals(category)){
					if ((Constant.COURSE_APPROVAL_TEXT).equals(outlineType)){
						if (courseExistByTypeCampus)
							displayedTask = Constant.TASK_APPROVE_MODIFIED_OUTLINE;
						else
							displayedTask = Constant.TASK_APPROVE_PROPOSED_OUTLINE;

						if (debug) logger.info("outline/program progress: 31");
					}
					else if ((Constant.COURSE_CREATE_TEXT).equals(outlineType)){
						displayedTask = Constant.TASK_MODIFY_PROPOSED_OUTLINE;
						if (debug) logger.info("outline/program progress: 41");
					}
					else if ((Constant.COURSE_MODIFY_TEXT).equals(outlineType)){
						if (courseExistByTypeCampus)
							displayedTask = Constant.TASK_MODIFY_APPROVED_OUTLINE;
						else
							displayedTask = Constant.TASK_MODIFY_PROPOSED_OUTLINE;

						if (debug) logger.info("outline/program progress: 51");
					}
					else if ((Constant.COURSE_REVISE_TEXT).equals(outlineType)){
						if (courseExistByTypeCampus)
							displayedTask = Constant.TASK_MODIFY_APPROVED_OUTLINE;
						else
							displayedTask = Constant.TASK_MODIFY_PROPOSED_OUTLINE;

						if (debug) logger.info("outline/program progress: 52");
					}
					else if ((Constant.COURSE_REVIEW_TEXT).equals(outlineType)){
						if (courseExistByTypeCampus)
							displayedTask = Constant.TASK_REVIEW_APPROVED_OUTLINE;
						else
							displayedTask = Constant.TASK_REVIEW_PROPOSED_OUTLINE;

						if (debug) logger.info("outline/program progress: 61");
					}
				}
				else if ((Constant.PROGRAM).equals(category)){
					if ((Constant.PROGRAM_APPROVAL_PROGRESS).equals(outlineType)){
						if (programExistByTitleCampus)
							displayedTask = Constant.TASK_APPROVE_MODIFIED_PROGRAM;
						else
							displayedTask = Constant.TASK_APPROVE_PROPOSED_PROGRAM;

						if (debug) logger.info("outline/program progress: 71");
					}
					else if ((Constant.PROGRAM_CREATE_PROGRESS).equals(outlineType)){
						if (programExistByTitleCampus)
							displayedTask = Constant.TASK_MODIFY_APPROVED_PROGRAM;
						else
							displayedTask = Constant.TASK_MODIFY_PROPOSED_PROGRAM;

						if (debug) logger.info("outline/program progress: 81");
					}
					else if ((Constant.PROGRAM_MODIFY_PROGRESS).equals(outlineType)){
						if (programExistByTitleCampus)
							displayedTask = Constant.TASK_MODIFY_APPROVED_PROGRAM;
						else
							displayedTask = Constant.TASK_MODIFY_PROPOSED_PROGRAM;

						if (debug) logger.info("outline/program progress: 82");
					}
					else if ((Constant.PROGRAM_REVIEW_PROGRESS).equals(outlineType)){
						if (programExistByTitleCampus)
							displayedTask = Constant.TASK_REVIEW_APPROVED_OUTLINE;
						else
							displayedTask = Constant.TASK_REVIEW_PROPOSED_PROGRAM;

						if (debug) logger.info("outline/program progress: 91");
					}
				}

				// for programs, we don't need to include other arguments
				if (isAProgram)
					href = "";

				actions = "<a class=\"linkcolumn\" href=\"" + source + ".jsp?kix=" + kix + href + "\">"+displayedTask+"</a>";

				output[0] = submittedFor;
				output[1] = submittedBy;
				output[2] = outlineType;

				/*
					create links
				*/
				if ((Constant.PROGRAM).equals(category)){
					link = "vwhtml.jsp?cps="+campus+"&kix="+kix;
					output[3] = "<a href=\"" + link + "\" class=\"linkColumn\" title=\"view program\">" + alpha + " (" + degree + ")</a>";
				}
				else{
					link = "vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t="+type;
					output[3] = "<a href=\"" + link + "\" class=\"linkColumn\" title=\"view outline\">" + alpha + " " + num + "</a>";
				}

				/*
					set up for output
				*/
				output[4] = actions;
				output[5] = au.ASE_FormatDateTime(au.nullToBlank(rs.getString("dte")),Constant.DATE_DATETIME);
				output[6] = campus;

				for (counter=0;counter<columns;counter++){
					bf.append(dataCellStart);
					bf.append(output[counter]);
					bf.append(dataCellEnd);
				}

				bf.append(dataRowEnd);

				++outputRows;

				if (debug) logger.info("--->");

			} // while
			rs.close();
			ps.close();

			// append the header row to the output
			data.append(tableStart);
			data.append(headerRowStart);
			for (counter=0;counter<columns;counter++){
				data.append(headerCellStart);
				data.append(colHeader[counter]);
				data.append(headerCellEnd);
			}
			data.append(headerRowEnd);

			// format output
			if (found){
				data.append(bf.toString());
			}
			else{
				temp = dataRowStart;
				temp = temp.replace("__XXX__",evenRow);
				data.append(temp);
				for (counter=0;counter<columns;counter++){
					data.append(dataCellStart);
					if (counter==0)
						data.append("Task not found");
					else
						data.append(Constant.BLANK);
					data.append(dataCellEnd);
				}
				data.append(dataRowEnd);
			}

			// close the HTML table
			data.append(tableEnd);
			temp = data.toString();

			if (debug) logger.info("------------------- showUserTasks END");

		} catch (Exception e) {
			logger.fatal("TaskDB: showUserTasks - " + e.toString());
		}

		return temp;
	} // showUserTasks

	/*
	 * addMissingApprovalTask
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 *	<p>
	 * @return int
	 */
	public static void addMissingApprovalTask(Connection conn,String campus,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		String sql = "";
		String alpha = "";
		String num = "";
		String proposer = "";

		try {
			sql = "SELECT coursealpha,coursenum,proposer "
					+ "FROM tblCourse "
					+ "WHERE campus=? "
					+ "AND (progress='APPROVAL' OR (progress='APPROVAL' AND subprogress='REVIEW_IN_APPROVAL')) "
					+ "AND rtrim(coursealpha)+rtrim(coursenum) "
					+ "IN  "
					+ "( "
					+ "SELECT outline FROM vw_ApprovalsWithoutTasks "
					+ ") ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));

System.out.println("==================");
System.out.println("alpha: " + alpha);
System.out.println("num: " + num);
System.out.println("proposer: " + proposer);

				if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){

System.out.println("1");

					if (CourseDB.isNextApprover(conn,campus,alpha,num,user)){

System.out.println("2");

						TaskDB.logTask(conn,
											user,
											proposer,
											alpha,
											num,
											Constant.APPROVAL_TEXT,
											campus,
											Constant.BLANK,
											Constant.TASK_ADD,
											Constant.PRE);

						logger.info("Missing approval task added for " + user + " (" + alpha + " " + num + ")");
					}
				}
			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("TaskDB: addMissingApprovalTask - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TaskDB: addMissingApprovalTask - " + e.toString());
		}

		return;
	}


	public static void removeStrayTasks(Connection conn,String campus,String user) throws SQLException {

Logger logger = Logger.getLogger("test");

		String message = "";
		String alpha = "";
		String num = "";
		String type = "";
		String kix = "";
		String outlineProgress = "";
		String taskProgress = "";
		String taskProgressStep = "";
		String outlineProgressStep = "";
		int rowsAffected = 0;
		int cleaned = 0;
		String reason = "";
		String sql = "";
		String category = "";

		int id = 0;

		boolean delete = false;
		boolean reviewDuringApprovalAllowed = false;
		boolean debug = false;
		boolean test = false;
		boolean isAProgram = false;

		PreparedStatement ps = null;

		String today = (new SimpleDateFormat("MM/dd/yyyy")).format(new java.util.Date());
		String reviewDate = "";
		String subprogress = "";

		// stray tasks are tasks not found with corresponding coures work
		try{
			logger.info("------------------- removeStrayTasks START");

			// always true so that this is tracked
			debug = true;

			test = true;

			if (test){
				sql = "SELECT id,coursealpha,coursenum,coursetype,message,historyid,category "
					+ "FROM tblTasks "
					+ "WHERE campus=? "
					+ "AND submittedfor=? "
					+ "AND coursealpha='BURM' "
					+ "AND coursenum='555' "
					+ "ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
			}
			else{
				sql = "SELECT id,coursealpha,coursenum,coursetype,message,historyid,category "
					+ "FROM tblTasks "
					+ "WHERE campus=? "
					+ "AND submittedfor=? "
					+ "ORDER BY coursealpha,coursenum";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setString(2,user);
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()){

				reviewDuringApprovalAllowed = false;
				isAProgram = false;
				outlineProgressStep = "";
				taskProgressStep = "";

				id = rs.getInt("id");

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				type = AseUtil.nullToBlank(rs.getString("coursetype"));
				category = AseUtil.nullToBlank(rs.getString("category"));
				message = AseUtil.nullToBlank(rs.getString("message"));

				// historyid does not always exists in task. if so, use alpha, num to find kix
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (kix == null || kix.length() == 0)
					kix = Helper.getKix(conn,campus,alpha,num,type);

				isAProgram = ProgramsDB.isAProgram(conn,kix);

				if (debug) System.out.println("kix: " + kix);
				if (debug) System.out.println("isAProgram: " + isAProgram);
				if (debug) System.out.println("message: " + message);

				if (!isAProgram)
					subprogress = Outlines.getSubProgress(conn,kix);

				if (debug) System.out.println("subprogress: " + subprogress);

				// set to proper type for task progress
				if (isAProgram){
					if (("Approve program").equals(message)){
						type = "PRE";
						taskProgress = "APPROVAL";
						taskProgressStep = "task step: 5";
					}
					else if (("Create program").equals(message)){
						type = "PRE";
						taskProgress = "CREATE";
						taskProgressStep = "task step: 6";
					}
					else if (("Delete program").equals(message)){
						type = "PRE";
						taskProgress = "DELETE";
						taskProgressStep = "task step: 8";
					}
					else if (("Modify program").equals(message)){
						type = "PRE";
						taskProgress = "MODIFY";
						taskProgressStep = "task step: 7";
					}
					else if (("Approve added program").equals(message)){
						type = "PRE";
						taskProgress = "APPROVAL";
						taskProgressStep = "task step: 9";
					}
				} // isAProgram
				else{
					if (("Approve outline").equals(message)){
						type = "PRE";
						taskProgress = "APPROVAL";
						taskProgressStep = "task step: 1";
					}
					else if (("Delete outline").equals(message)){
						type = "PRE";
						taskProgress = "APPROVAL";
						taskProgressStep = "task step: 2";
					}
					else if (("Modify outline").equals(message)){
						type = "PRE";
						taskProgress = "MODIFY";
						taskProgressStep = "task step: 3";
					}
					else if (("Review outline").equals(message)){
						type = "PRE";
						taskProgress = "REVIEW";
						reviewDate = CourseDB.getCourseItem(conn,kix,"reviewdate");
						taskProgressStep = "task step: 4";
					}
				} // isAProgram

				// get current progress
				if ((Constant.PROGRAM).equals(category)){
					outlineProgress = ProgramsDB.getProgramProgress(conn,campus,kix);
				}
				else{
					outlineProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);

					if (("REVIEW_IN_APPROVAL").equals(subprogress))
						reviewDuringApprovalAllowed = true;
				}

				if (debug) System.out.println("taskProgress: " + taskProgress);
				if (debug) System.out.println("taskProgressStep: " + taskProgressStep);
				if (debug) System.out.println("outlineProgress: " + outlineProgress);

				reason = "";
				delete = false;

				// if the task is there but the user is not the proposer of the item in modify progress, delete
				// if review task exists but not in review, delete only if not a review within approval
				// if approval task exists but not in approval, delete

				/*
					11 - for approval or create and not exist program, delete
					21 - if delete and outline is not delete, delete
					31 - if both not modify, delete
					41 - if a program but missing progress, delete
					51 - 11
					61 - if reviewing but not in review or review in approval, delete
					71 - if approval but not in approval or delete, delete
				*/
				if (isAProgram){
					if (	(("APPROVAL").equals(taskProgress) || ("CREATE").equals(outlineProgress)) &&
							!ProgramsDB.programExistByTitleCampus(conn,campus,kix,type)){

						// if the text message from task id Approval program but the actual
						// program progress is not APPROVAL, then delete
						delete = true;
						reason = "not allowed to approve";
						outlineProgressStep = "outline/program progress: 11";
					}
					else if (("DELETE").equals(taskProgress) && !("DELETE").equals(outlineProgress)){
						delete = true;
						reason = "not allowed to approve";
						outlineProgressStep = "outline/program progress: 21";
					}
					else if (("MODIFY").equals(taskProgress) && !("MODIFY").equals(outlineProgress)){
						delete = true;
						reason = "not allowed to approve";
						outlineProgressStep = "outline/program progress: 31";
					}
					else if (category.equals(Constant.PROGRAM) && (Constant.BLANK).equals(outlineProgress)){
						delete = true;
						reason = "not allowed to approve";
						outlineProgressStep = "outline/program progress: 41";
					}
				}
				else{
					if ((("MODIFY").equals(taskProgress) && ("MODIFY").equals(outlineProgress)) &&
							!CourseDB.courseExistByProposer(conn,campus,user,alpha,num,type)){
						delete = true;
						reason = "modify text but not proposer";
						outlineProgressStep = "outline/program progress: 51";
					}
					else if ((("REVIEW").equals(taskProgress) || ("REVIEW_IN_APPROVAL").equals(subprogress)) &&
								DateUtility.compare2Dates(reviewDate,today) < 0 ){
						delete = true;
						reason = "In review but review date has expired";
						outlineProgressStep = "outline/program progress: 52";
					}
					else if (("REVIEW").equals(taskProgress) &&
								((!reviewDuringApprovalAllowed	&& !(("REVIEW").equals(outlineProgress)))
									&& !("APPROVAL").equals(outlineProgress))){
						delete = true;
						reason = "not allowed to review";
						outlineProgressStep = "outline/program progress: 61";
					}
					else if (("REVIEW").equals(taskProgress) && !ReviewerDB.isReviewer(conn,kix,user)){
						delete = true;
						reason = "not a reviewer";
						outlineProgressStep = "outline/program progress: 63";
					}
					else if (
									("APPROVAL").equals(taskProgress)
									&&
									(!("APPROVAL").equals(outlineProgress) && !("DELETE").equals(outlineProgress))
							){
						delete = true;
						reason = "not allowed to approve";
						outlineProgressStep = "outline/program progress: 71";
					}
				} // isAProgram

				if (debug) System.out.println("delete: " + delete);
				if (debug) System.out.println("outlineProgressStep: " + outlineProgressStep);

				if (delete){
					++cleaned;

					boolean run = true;

					if (run){
						if ((Constant.COURSE).equals(category))
							rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,message,campus,"stray","REMOVE",type);
						else
							rowsAffected = TaskDB.logTask(conn,user,user,"","",message,campus,"","REMOVE",type,"","",kix,Constant.PROGRAM);

						// if we were unable to remove the task, use ID instead
						if (rowsAffected == 0)
							rowsAffected = TaskDB.deleteTaskByID(conn,id);

						logger.info("Stray task removed for " + user + ": " + alpha + " " + num + " (" + rowsAffected + ")");
					} // run
				} // delete

			}	// while
			rs.close();
			ps.close();

			logger.info("Stray task(s) cleaned up for " + user + " (" + cleaned + " rows)");

			logger.info("------------------- removeStrayTasks END");
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: removeStrayTasks - " + ex.toString());
		}
	} // removeStrayTasks

	public static void removeStrayReviewers(Connection conn,String campus) throws SQLException {

Logger logger = Logger.getLogger("test");

		/*
			read through reviewer table and check on the outline progress.
			if the progress is not review or subprogress not review in approval
			delete the reviewers from table.

			progress of MODIFY can have subprogress of REVIEW_IN_APPROVAL
		*/

		try{
			logger.info("--------------------------------------- removeStrayReviewers - START");

			int rowsAffected = 0;
			String alpha = "";
			String num = "";
			String type = "PRE";
			String progress = "";
			String subprogress = "";
			String kix = "";
			String sReviewDate = "";

			java.util.Date reviewDate = null;

			int counter = 0;

			String today = (new SimpleDateFormat("MM/dd/yyyy")).format(new java.util.Date());

			String sql = "SELECT DISTINCT r.coursealpha, r.coursenum, c.reviewdate, c.historyid, c.progress, c.subprogress "
					+ "FROM tblReviewers r INNER JOIN "
					+ "tblCourse c ON r.coursealpha = c.CourseAlpha "
					+ "AND r.coursenum = c.CourseNum "
					+ "AND r.campus = c.campus "
					+ "WHERE r.campus=? "
					+ "AND c.CourseType='PRE' "
					+ "ORDER BY r.coursealpha, r.coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				++counter;

				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				kix = rs.getString("historyid");
				reviewDate = rs.getDate("reviewdate");
				progress = rs.getString("progress");
				subprogress = rs.getString("subprogress");

				sReviewDate = (new SimpleDateFormat("MM/dd/yyyy")).format(reviewDate);

				//System.out.println("counter: " + counter);
				//System.out.println("kix: " + kix);
				//System.out.println("alpha: " + alpha);
				//System.out.println("num: " + num);
				//System.out.println("progress: " + progress);
				//System.out.println("subprogress: " + subprogress);
				//System.out.println("today: " + today);
				//System.out.println("sReviewDate: " + sReviewDate);
				//System.out.println("compare2Dates: " + DateUtility.compare2Dates(sReviewDate,today));

				// review is valid only when the progress is review or the subprogress is review and
				// the review date is greater than today
				if (
						(	(Constant.COURSE_REVIEW_TEXT).equals(progress) ||
							(Constant.COURSE_REVIEW_IN_APPROVAL).equals(subprogress))
							&& DateUtility.compare2Dates(sReviewDate,today) >= 0
					){
					//valid
				}
				else{
					rowsAffected = ReviewerDB.deleteReviewers(conn,campus,alpha,num,false);

					rowsAffected = TaskDB.logTask(conn,
															"ALL",
															"ALL",
															alpha,
															num,
															Constant.REVIEW_TEXT,
															campus,
															Constant.BLANK,
															Constant.REMOVE,
															type);
				}

			}	// while
			rs.close();
			ps.close();

			logger.info("--------------------------------------- removeStrayReviewers - END");

		}
		catch(SQLException se ){
			logger.fatal("TaskDB: removeStrayReviewers - " + se.toString());
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: removeStrayReviewers - " + ex.toString());
		}
	}

	/*
	 * createMissingModifyTasks
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 * <p>
	 *	@return String
	 */
	public static void createMissingModifyTasks(Connection conn,String campus,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int created = 0;

		String alpha = "";
		String num = "";

		try{
			String sql = "DELETE FROM tblTasks WHERE campus=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

			if (rowsAffected > 0){

				rowsAffected = 0;

				sql = "SELECT CourseAlpha,CourseNum,proposer "
								+ "FROM tblCourse  "
								+ "WHERE campus=? "
								+ "AND progress='MODIFY' "
								+ "AND CourseType='PRE' ";

				if (!(Constant.BLANK).equals(user))
					sql = sql + "AND proposer=? ";

				sql = sql + "ORDER BY proposer,CourseAlpha,CourseNum ";

				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);

				if (!(Constant.BLANK).equals(user))
					ps.setString(2,user);

				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					alpha = rs.getString("coursealpha");
					num = rs.getString("coursenum");
					user = rs.getString("proposer");
					rowsAffected = TaskDB.logTask(conn,
															user,
															user,
															alpha,
															num,
															Constant.MODIFY_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE);
					if (rowsAffected > 0)
						++created;

				}
				rs.close();
				ps.close();

				logger.info("createMissingModifyTasks -  created " + created + " rows");

			} // rowsAffected

		}
		catch(Exception e){
			logger.fatal("TaskDB createMissingModifyTasks - " + e.toString());
		}

		return;
	}

	public static String createMissingProgramTasks(Connection conn,String campus,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int created = 0;

		String kix = "";
		String title = "";
		String divisioncode = "";
		String action = "";

		/*
			create missing program task. If there is a CUR, then the task is MODIFY.

			if not, then it's a create.
		*/

		try{
			String sql = "SELECT historyid, title, divisioncode "
				+ "FROM vw_ProgramForViewing "
				+ "WHERE campus=? "
				+ "AND proposer=? "
				+ "AND type='PRE' "
				+ "AND progress='MODIFY' "
				+ "AND historyid NOT IN "
				+ "( "
				+ "SELECT historyid "
				+ "FROM tblTasks "
				+ "WHERE campus=? "
				+ "AND submittedfor=? "
				+ "AND category='program' "
				+ "AND NOT historyid IS NULL "
				+ "AND historyid <> '' "
				+ ")";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.setString(3,campus);
			ps.setString(4,user);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				kix = rs.getString("historyid");
				title = rs.getString("title");
				divisioncode = rs.getString("divisioncode");

				if (ProgramsDB.programExistByTitleCampus(conn,campus,kix,"CUR"))
					action = Constant.PROGRAM_MODIFY_TEXT;
				else
					action = Constant.PROGRAM_CREATE_TEXT;

				rowsAffected = TaskDB.logTask(conn,
														user,
														user,
														title,
														divisioncode,
														action,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.TASK_PROPOSER,
														Constant.TASK_PROPOSER,
														kix,
														Constant.PROGRAM);
				if (rowsAffected>0)
					++created;
			}
			rs.close();
			ps.close();

			logger.info("Missing program task created for " + user + " (" + created + " rows)");
		}
		catch(Exception e){
			logger.fatal("TaskDB createMissingProgramTasks - " + e.toString());
		}

		return "Missing modify task created for " + user + " (" + created + " rows)";
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>