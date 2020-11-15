<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>
<%@
	page import="com.itextpdf.text.*,com.itextpdf.text.pdf.*,com.itextpdf.text.html.*,com.itextpdf.text.html.simpleparser.*"
%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="stickytooltip.jsp" %>
	<%@ include file="highslide.jsp" %>
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ICS";
	String num = "100";
	String type = "PRE";
	String user = "MLANE";
	String task = "Modify_outline";
	String kix = "e17j2f10174";
	String message = "";
	String sql = "";
	int i = 0;
	String error = "";

	int jobCount = 0;

	int rowsAffected = 0;

	boolean bRunApprovalTest = false;
	boolean bAddRemoveRequisites = false;
	boolean bRunMailTest = false;
	boolean bRunInsertProgram = false;
	boolean bRunReviewInApprovalTest = false;
	boolean bShowUserTasks = false;
	boolean bPageNameIndex = false;
	boolean bRunPacketTest = false;
	boolean bCreatePrograms = false;
	boolean bTestPrograms = false;
	boolean bTestCourses = false;
	boolean bFasttrack = true;

	asePool.freeConnection(conn,"","");

	if (processPage){
		conn = asePool.createLongConnection();
		out.println((++jobCount) + ": got connection..." + Html.BR());

		//approveUserOutlines(conn,"MLANE");
		//approveUserOutlines(conn,"SOTA");
		//approveUserOutlines(conn,"MPECSOK");

		alpha = "KAP";
		num = "101";
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
		out.println((++jobCount) + ":kix: " + kix + Html.BR());

		// ======================> COURSES
		if (bRunApprovalTest){
			alpha = "ICS";
			num = "101";
			kix = helper.getKix(conn,campus,alpha,num,"PRE");
			out.println((++jobCount) + ":kix: " + kix + Html.BR());

			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": approval test..." + Html.BR());
			msg = runApprovalTest(conn,campus,alpha,num,user);		// testing approval
			out.println(msg);

			alpha = "ENG";
			num = "100";
			kix = helper.getKix(conn,campus,alpha,num,"PRE");
			out.println((++jobCount) + ":kix: " + kix + Html.BR());

			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": approval test..." + Html.BR());
			msg = runApprovalTest(conn,campus,alpha,num,user);		// testing approval
			out.println(msg);

			alpha = "ENG";
			num = "209";
			kix = helper.getKix(conn,campus,alpha,num,"PRE");
			out.println((++jobCount) + ":kix: " + kix + Html.BR());

			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": approval test..." + Html.BR());
			msg = runApprovalTest(conn,campus,alpha,num,user);		// testing approval
			out.println(msg);

			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": updateCourse..." + Html.BR());
			out.println(courseDB.updateCourse(conn,"4",campus,alpha,num,"coursetitle","coursetitle","","",session.getId().toString(),1,user));

			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": update tabs table..." + Html.BR());
			Tables.tabs();												// recreate tabs table
		}

		alpha = "ICS";
		num = "101";
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
		out.println((++jobCount) + ":kix: " + kix + Html.BR());

		// 88 is known id from table
		if (bAddRemoveRequisites){
			rowsAffected = RequisiteDB.addRemoveRequisites(conn,
																			kix,
																			"a",
																			campus,
																			alpha,
																			num,
																			"ENG",
																			"100X",
																			"grading",
																			"1",
																			user,
																			88,
																			false);
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": addRemoveRequisites test... " + rowsAffected + " rows" + Html.BR());
		}

		// ======================> MAIL
		if (bRunMailTest){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": mail test..." + Html.BR());
			out.println(runMailTest(conn));
		}

		// ======================> PROGRAMS
		if (bRunInsertProgram){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": insert program test..." + Html.BR());
			runInsertProgram(conn,campus);
		}

		// ======================> REVIEW IN APPROVAL
		if (bRunReviewInApprovalTest){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": approval review test..." + Html.BR());
			msg = runReviewInApprovalTest(conn,campus,alpha,num,user);
			out.println(msg);
		}

		// ======================
		if (bShowUserTasks){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": show user task test..." + Html.BR());
			TaskDB.showUserTasks(conn,campus,user);
			out.println(msg);
		}

		// ======================
		if (bPageNameIndex){
			out.println("------------------------" + Html.BR());
			String[] pageNames = "alphaidx,catidx,collegeidx,assessmentidx,frmsidx,crsxrfidx,dgridx,disciplineidx,dividx,distribution,emaillist,helpidxcat,newsidx,propidx,programSLO,posidx,prgidx,requestidx2,requestidx,stmtidx,sylidx,useridx".split(",");
			int pageNameIndex = pageNames.length;
			for(i = 0; i<pageNameIndex; i++){
				try{
					error = showPaging(conn,pageNames[i],session,request,response,paging);
					System.out.println(i + " - " + pageNames[i]);
				}
				catch(SQLException e){
					System.out.println("***" + pageNames[i]);
				}
				if ("".equals(error))
					out.println((++jobCount) + ": show "+pageNames[i]+"..." + Html.BR());
				else
					out.println((++jobCount) + ": show "+pageNames[i]+" error..." + error + Html.BR());
			}
			out.println(msg);
		}

		// ======================
		if (bRunPacketTest){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": runPacketTest..." + Html.BR());
			out.println(runPacketTest(conn,campus,user));
		}

		// ======================
		if (bCreatePrograms){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": createPrograms..." + Html.BR());
			Tables.createPrograms(null,kix,alpha,num);
			out.println(msg);
		}

		// ======================
		if (bTestPrograms){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": testPrograms..." + Html.BR());
			testPrograms(conn,campus,user);
			out.println(msg);
		}

		// ======================
		if (bTestCourses){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": testCourses..." + Html.BR());
			testCourses(conn,campus,user);
			out.println(msg);
		}

		// ======================
		if (bFasttrack){
			out.println("------------------------" + Html.BR());
			out.println((++jobCount) + ": bFasttrack..." + Html.BR());
			fastTrackTest(conn,campus,user);
			out.println(msg);
		}

		try{
			if (conn != null){
				conn.close();
				conn = null;
			}
		}
		catch(Exception e){
			//logger.fatal("Tables: campusOutlines - " + e.toString());
		}

		out.println((++jobCount) + ": disconnect..." + Html.BR());
	} // processpage

%>

<%!
	public static int approveUserOutlines(Connection conn,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try {
			rowsAffected = 0;
			String sql = "SELECT t.coursealpha, t.coursenum, t.campus, t.historyid, c.proposer "
							+ "FROM tblTasks t INNER JOIN "
							+ "tblCourse c ON t.campus = c.campus "
							+ "AND t.coursealpha = c.CourseAlpha "
							+ "AND t.coursenum = c.CourseNum "
							+ "WHERE t.submittedfor=? AND c.CourseType='PRE'";

			sql = "SELECT coursealpha, coursenum, campus, historyid, submittedby FROM tblTasks WHERE submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,user);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				++rowsAffected;
				String alpha = rs.getString(1);
				String num = rs.getString(2);
				String campus = rs.getString(3);
				String kix = rs.getString("historyid");
				String proposer = rs.getString("submittedby");
				if (alpha != null && alpha.length() > 0){
					CourseDB.updateCourseItem(conn,"route","708",kix);
					System.out.println("approveUserOutlines: " + rowsAffected + ": " + alpha + " - " + num);
					System.out.println("approveUserOutlines: "
											+
											CourseDB.setCourseForApproval(conn,
																					campus,
																					alpha,
																					num,
																					proposer,
																					Constant.COURSE_APPROVAL_TEXT,
																					708,
																					proposer));
					outlineApproval(conn,campus,alpha,num,user);
				}
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TestRun: approveUserOutlines - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TestRun: approveUserOutlines - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * runPacketTest
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static String runPacketTest(Connection conn,String campus,String user) throws Exception {

		String[] alphas = "ICS,ICS,ICS".split(",");
		String[] nums = "101,102,110".split(",");

		int loop = alphas.length;

		String alpha = "";
		String num = "";
		String message = "";

		int route = 868;

		Msg msg = new Msg();

		for(int i = 0; i < loop; i++){

			alpha = alphas[i];
			num = nums[i];

			// submit for approval
			msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,user);
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Request for outline approval failed.<br><br>"
					+ msg.getErrorLog();
			}
			else if (!"".equals(msg.getMsg())){
				message = "Unable to initiate outline approval.<br><br>"
					+ MsgDB.getMsgDetail(msg.getMsg());
			}

			System.out.println(message);
		}

		return msg.toString();
	}

	/*
	 * runReviewInApprovalTest
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static Msg runReviewInApprovalTest(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		int route = 1316;
		int rowsAffected = 0;
		String message = "";

		Msg msg = new Msg();

		alpha = "ICS";
		num = "100";

		String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

		if (kix != null){
			System.out.println("runReviewInApprovalTestkix: " + kix + Html.NewLine());

			System.out.print("runReviewInApprovalTestmodifyOutline " + alpha + " " + num + Html.NewLine());
			msg = CourseModify.modifyOutline(conn,campus,alpha,num,user,Constant.COURSE_MODIFY_TEXT);

			System.out.print("runReviewInApprovalTestoutlineApproval " + alpha + " " + num + Html.NewLine());
			msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,user);
			if ("Exception".equals(msg.getMsg()) ){
				message = "Request for outline approval failed.<br><br>"
					+ msg.getErrorLog();
			}
			else if (!"".equals(msg.getMsg())){
				message = "Unable to initiate outline approval.<br><br>"
					+ MsgDB.getMsgDetail(msg.getMsg());
			}

			System.out.print("runReviewInApprovalTestinsertReview " + alpha + " " + num + Html.NewLine());
			Review reviewDB = new Review();
			reviewDB.setId(0);
			reviewDB.setUser(user);
			reviewDB.setAlpha(alpha);
			reviewDB.setNum(num);
			reviewDB.setHistory(kix);
			reviewDB.setComments("This is a test");
			reviewDB.setItem(3);
			reviewDB.setCampus(campus);
			reviewDB.setEnable(true);
			reviewDB.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
			rowsAffected = ReviewDB.insertReview(conn,reviewDB,"1",Constant.REVIEW);

			reviewDB.setId(0);
			reviewDB.setUser(user);
			reviewDB.setAlpha(alpha);
			reviewDB.setNum(num);
			reviewDB.setHistory(kix);
			reviewDB.setComments("This is a test");
			reviewDB.setItem(4);
			reviewDB.setCampus(campus);
			reviewDB.setEnable(true);
			reviewDB.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
			rowsAffected = ReviewDB.insertReview(conn,reviewDB,"1",Constant.REVIEW);
		}
		else{
			System.out.println("Outline not available");
		}

		return msg;
	}

	/*
	 * runInsertProgram
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static void runInsertProgram(Connection conn,String campus) throws Exception {

		Logger logger = Logger.getLogger("test");

		Programs program = new Programs();

		program.setCampus(campus);
		program.setHistoryId(SQLUtil.createHistoryID(1));
		program.setType("PRE");
		program.setDegree(6);
		program.setEffectiveDate("Fall 2050");
		program.setTitle(AseUtil.getCurrentDateTimeString());
		program.setDescription(AseUtil.getCurrentDateTimeString());
		program.setAuditBy("TestRun");
		program.setAuditDate(AseUtil. getCurrentDateTimeString());
		program.setProposer("TestRun");
		program.setProgress(Constant.COURSE_MODIFY_TEXT);
		program.setRegentsApproval(true);
		program.setDivision(7);
		ProgramsDB.insertProgram(conn,program);

		return;
	}

	/*
	 * runMailTest
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static String runMailTest(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		String error = "";

		try{
			Mailer mailer = new Mailer();
			mailer.setSubject("emailApproveOutline");
			mailer.setFrom("thanhg@hawaii.edu");
			mailer.setTo("thanhg@hawaii.edu");
			mailer.setAlpha("alpha");
			mailer.setNum("num");
			mailer.setCampus("campus");
			MailerDB mailerDB = new MailerDB();
			mailerDB.sendMail(conn,mailer,"emailApproveOutline");
		}
		catch(Exception e){
			error = e.toString();
		}

		return error;
	}

	/*
	 * runApprovalTest
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static Msg runApprovalTest(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		String toAlpha = "ENG";
		String toNum = "142";
		String kixToDelete = "";
		boolean run = true;
		int route = 1316;

		Msg msg = new Msg();

		alpha = "ENG";
		num = "100";

		String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
		kixToDelete = Helper.getKix(conn,campus,toAlpha,toNum,"CUR");

		if (kix != null){
			System.out.println("runApprovalTest kix: " + kix + Html.NewLine());

			// delete the to alpha/num if it's there
			System.out.print("runApprovalTest deleteOutline " + toAlpha + " " + toNum + Html.NewLine());
			if (run)
				msg = deleteOutline(conn,kixToDelete,user,route);

			System.out.print("runApprovalTest outlineApproval " + toAlpha + " " + toNum + Html.NewLine());
			if (run)
				msg = outlineApproval(conn,campus,toAlpha,toNum,user);

			// copy starts here
			System.out.print("runApprovalTest copyOutline FROM: " + alpha + " " + num + " TO: " + toAlpha + " " + toNum + Html.NewLine());
			if (run)
				msg = copyOutline(conn,campus,kix,toAlpha,toNum,user,"TestRun: Copy outline");

			if ("".equals(msg.getMsg())){
				System.out.print("runApprovalTest cancelOutline " + toAlpha + " " + toNum + Html.NewLine());
				if (run)
					msg = cancelOutline(conn,campus,toAlpha,toNum,user);
			}
			else{
				System.out.print("runApprovalTest copyOutline fail " + msg.getMsg() + Html.NewLine() + msg.getErrorLog() + Html.NewLine());
			}

			if ("".equals(msg.getMsg())){
				System.out.print("runApprovalTest copyOutline FROM: " + alpha + " " + num + " TO: " + toAlpha + " " + toNum + Html.NewLine());
				if (run)
					msg = copyOutline(conn,campus,kix,toAlpha,toNum,user,"TestRun: Copy outline again");
			}
			else{
				System.out.print("runApprovalTest cancelOutline fail " + msg.getMsg() + Html.NewLine() + msg.getErrorLog() + Html.NewLine());
			}

			if ("".equals(msg.getMsg())){
				System.out.print("runApprovalTest outlineApproval " + toAlpha + " " + toNum + Html.NewLine());
				if (run)
					msg = outlineApproval(conn,campus,toAlpha,toNum,user);
			}
			else{
				System.out.print("runApprovalTest copyOutline fail " + msg.getMsg() + Html.NewLine() + msg.getErrorLog() + Html.NewLine());
			}

			if (!"".equals(msg.getMsg())){
				System.out.print("runApprovalTest outlineApproval fail " + msg.getMsg() + Html.NewLine() + msg.getErrorLog() + Html.NewLine());
			}

		}
		else{
			System.out.println("Outline not available");
		}

		return msg;
	}

	/*
	 * outlineApproval
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static Msg outlineApproval(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		boolean enabled = false;
		Msg msg = new Msg();
		String message = "";

		try{
			// submit for approval
			msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,1316,user);
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Request for outline approval failed.<br><br>"
					+ msg.getErrorLog();
			}
			else if ("forwardURL".equals(msg.getMsg()) ){
				//sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
			}
			else if (!"".equals(msg.getMsg())){
				message = "Unable to initiate outline approval.<br><br>"
					+ MsgDB.getMsgDetail(msg.getMsg());
			}

			// actual approval
			String comments = "unit testing";
			int voteFor = 0;
			int voteAgainst = 1;
			int voteAbstain = 2;

			msg = CourseApproval.approveOutline(conn,campus,alpha,num,user,true,comments,voteFor,voteAgainst,voteAbstain);
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Outline approval failed.<br><br>" + msg.getErrorLog();
			}
			else if ("forwardURL".equals(msg.getMsg()) ){
				//sURL = "lstappr.jsp?kix="+kix+"&s="+msg.getCode();
			}
			else if (!"".equals(msg.getMsg())){
				message = "Unable to approve outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
			}
			else{
				if (msg.getCode() == 2)
					message = "Outline was approved and finalized.";
				else
					if (msg.getErrorLog() != null && msg.getErrorLog().length() > 0)
						message = "Outline was approved and next approver (" + msg.getErrorLog() + ") has been notified.";
					else
						message = "Outline was approved.";
			}

			logger.info("TestRun: outlineApproval\n" + message+"<br/>");
		}
		catch(Exception ce){
			msg.setMsg("Exception");
			logger.fatal("TestRun: outlineApproval: " + ce.toString());
		}

		return msg;
	}

	/*
	 * copyOutline
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static Msg copyOutline(Connection conn,String campus,String kix,String toAlpha,String toNum,String user,String comments) throws Exception {

		Logger logger = Logger.getLogger("test");

		String message = "";
		Msg msg = new Msg();

		try{

			msg = CourseCopy.copyOutline(conn,campus,kix,kix,toAlpha,toNum,user,comments);
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Outline copied failed.<br><br>";
			}
			else if ( !"".equals(msg.getMsg()) ){
				message = "Unable to copy outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
			}
			else{
				message = "Outline copied successfully";
			}
		}
		catch(Exception ce){
			msg.setMsg("Exception");
			logger.fatal("TestRun: copyOutline: " + ce.toString());
		}

		return msg;
	}

	/*
	 * cancelOutline
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static Msg cancelOutline(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		Logger logger = Logger.getLogger("test");

		String message = "";
		Msg msg = new Msg();

		try{

			msg = CourseCancel.cancelOutline(conn,campus,alpha,num,user);
			if ("Exception".equals(msg.getMsg())){
				message = "Outline cancellation failed.<br><br>" + msg.getErrorLog();
			}
			else if ( !"".equals(msg.getMsg()) ){
				message = "Unable to cancel outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
			}
			else{
				message = "Outline cancelled successfully<br>";
			}
		}
		catch(Exception ce){
			msg.setMsg("Exception");
			logger.fatal("TestRun: cancelOutline: " + ce.toString());
		}

		return msg;
	}

	/*
	 * deleteOutline
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static Msg deleteOutline(Connection conn,String kix,String user,int route) throws Exception {

		Logger logger = Logger.getLogger("test");

		String message = "";
		Msg msg = new Msg();

		try{
			msg = CourseDelete.setCourseForDelete(conn,kix,user,route);
			if ( "Exception".equals(msg.getMsg()) ){
				message = "Outline delete failed.<br><br>";
			}
			else if ( !"".equals(msg.getMsg()) ){
				message = "Unable to delete outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
			}
			else{
				message = "Outline deleted successfully";
			}
		}
		catch(Exception ce){
			msg.setMsg("Exception");
			logger.fatal("TestRun: deleteOutline: " + ce.toString());
		}

		return msg;
	}

	/*
	 * showPaging
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static String showPaging(Connection conn,
									String pageName,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response,
									com.ase.paging.Paging paging) throws Exception {

		Logger logger = Logger.getLogger("test");

		AseUtil aseUtil = new AseUtil();

		WebSite website = new WebSite();

		String error = "";

		try{
			String sql = aseUtil.getPropertySQL(session,pageName);
			if (sql != null && sql.length() > 0 ) {
				paging = new com.ase.paging.Paging();
				paging.setSQL(sql);
				paging.setAllowAdd(false);
				paging.setRecordsPerPage(15);
				paging.showRecords( conn, request, response );
				paging = null;
			}
			else
				error = "<b>" + pageName + "</b>";
		}
		catch(Exception e){
			logger.fatal("showPaging" + e.toString());
			error = "<b>error</b> showing page " + pageName;
		}

		return error;
	}

	/*
	 * testPrograms
	 *	<p>
	 *	@param	conn		Connection
	 *	<p>
	 */
	public static int testPrograms(Connection conn,String campus,String user) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Msg msg = new Msg();

		int route = 708;
		String kix = "";
		String title = "";

		String[] aUsers = "THANHG,MLANE,LOCOCO,GOODMANJ,UMEHIRA,MPECSOK".split(",");

		try {
			// set programs for approval
			rowsAffected = 0;
			String sql = "SELECT historyid,title FROM tblPrograms WHERE type='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				++rowsAffected;
				kix = rs.getString(1);
				title = rs.getString(2);
				System.out.println(rowsAffected + ": " + kix + " - " + title);
				msg = ProgramsDB.setProgramForApproval(conn,campus,kix,user,user,route,"1");
				for (int i=0; i<aUsers.length; i++)
					ProgramApproval.approveProgramX(conn,campus,kix,aUsers[i],true,AseUtil.getCurrentDateTimeString(),1,2,3);

				System.out.println("testPrograms - enablingDuringApproval: " + ProgramsDB.enablingDuringApproval(conn,campus,kix) + Html.BR());
				System.out.println("testPrograms - getProgramEdit1: " + ProgramsDB.getProgramEdit1(conn,campus,kix) + Html.BR());
				System.out.println("testPrograms - getProgramEdit2: " + ProgramsDB.getProgramEdit2(conn,campus,kix) + Html.BR());
				System.out.println("testPrograms - getProgramEdits: " + ProgramsDB.getProgramEdits(conn,campus,kix) + Html.BR());
				System.out.println("testPrograms - enableProgramItems: " + ProgramsDB.enableProgramItems(conn,campus,kix,user) + Html.BR());
				System.out.println("testPrograms - isEditable: " + ProgramsDB.isEditable(conn,campus,kix,user) + Html.BR());
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("TestRun: testPrograms - " + e.toString());
		} catch (Exception e) {
			logger.fatal("TestRun: testPrograms - " + e.toString());
		}

		return rowsAffected;
	}

	public static int testCourses(Connection conn,String campus,String user) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Msg msg = new Msg();

		int route = 708;
		String kix = "";
		String alpha = "";
		String num = "";

		String[] aUsers = "THANHG,MLANE,LOCOCO,GOODMANJ,UMEHIRA,MPECSOK".split(",");

		try {
			// set programs for approval
			rowsAffected = 0;
			String sql = "SELECT historyid,coursealpha,coursenum FROM tblCourse WHERE campus=? AND coursetype='PRE' AND progress='APPROVAL' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				++rowsAffected;
				kix = rs.getString(1);
				alpha = rs.getString(2);
				num = rs.getString(3);
				System.out.println("testCourses: " + rowsAffected + ": " + kix + " - " + alpha + " - " + num);
				msg = CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,user);
				for (int i=0; i<aUsers.length; i++)
					CourseApproval.approveOutlineX(conn,campus,alpha,num,user,true,AseUtil.getCurrentDateTimeString(),3,2,1);
			}
			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("ProgramApproval: testCourses - " + e.toString());
		} catch (Exception e) {
			logger.fatal("ProgramApproval: testCourses - " + e.toString());
		}

		return rowsAffected;
	}

	/*
	 * fastTrackTest
	 *	<p>
	 */
	public static String fastTrackTest(Connection conn,String campus,String user){

		Logger logger = Logger.getLogger("test");

		String alpha = "";
		String num = "";
		String progress = "";
		String proposer = "";
		String subprogress = "";
		String dateproposed = "";
		String auditdate = "";
		String kix = "";
		String link = "";
		String linkOutline = "";
		String linkHistory = "";
		String linkComments = "";
		String linkDetails = "";
		String divID = "";
		String rowColor = "";
		String temp = "";
		String fastTrack = "";
		String routingSequence = "";

		Approver ap = null;

		int i = 0;
		int j = 0;
		int route = 0;

		int lastApproverSeq = 0;
		String lastApprover = "";
		String nextApprover = "";
		String[] arr = null;

		boolean found = false;
		boolean debug = false;
		boolean processOutline = false;
		boolean approved = false;

		int rowsAffected = 0;

		String sql = "";
		String type = "PRE";

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

			AseUtil aseUtil = new AseUtil();

			boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
			boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

			boolean testing = false;

			if (testing){
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? AND coursealpha='ART' AND coursenum='116'";

				debug = true;
			}
			else{
				sql = "SELECT campus,id,CourseAlpha,CourseNum,proposer,Progress,dateproposed,auditdate,route,subprogress,kid "
								+ "FROM vw_ApprovalStatus "
								+ "WHERE campus=? ";
			}

debug = true;

			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				progress = AseUtil.nullToBlank(rs.getString("progress"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				subprogress = AseUtil.nullToBlank(rs.getString("subprogress"));
				kix = AseUtil.nullToBlank(rs.getString("id"));
				routingSequence = AseUtil.nullToBlank(rs.getString("kid"));
				dateproposed = AseUtil.nullToBlank(rs.getString("dateproposed"));
				auditdate = AseUtil.nullToBlank(rs.getString("auditdate"));
				route = rs.getInt("route");

				if (debug) logger.info("--------------------------");

				processOutline = true;

				if ((Constant.COURSE_APPROVAL_TEXT).equals(progress) &&
					(Constant.COURSE_REVIEW_IN_APPROVAL).equals(subprogress)){

					progress = "REVIEW";

					/*
						resetting to approval progress when no reviewer remains
						also need to reset task. At this point, we don't know who
						has the task so we have to get the name from the list
					*/
					if (!ReviewerDB.hasReviewer(conn,campus,alpha,num)){
						String submittedFor = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.REVIEW_TEXT);
						if (submittedFor != null && submittedFor.length() > 0){
							CourseDB.resetOutlineToApproval(conn,campus,alpha,num);
							TaskDB.switchTaskMessage(conn,campus,alpha,num,submittedFor,Constant.REVIEW_TEXT,Constant.APPROVAL_TEXT);
						}
						progress = "APPROVAL";
					}
				} // Constant.COURSE_APPROVAL_TEXT
				else if ((Constant.COURSE_MODIFY_TEXT).equals(progress)){
					if (ApproverDB.countApprovalHistory(conn,kix)<1)
						processOutline = false;
					else
						progress = "REVISE";

					processOutline = false;

				} // COURSE_MODIFY_TEXT
				else if ((Constant.COURSE_APPROVAL_TEXT).equals(progress)){
					progress = "APPROVAL";
				} // COURSE_APPROVAL_TEXT

				if (debug) logger.info("fastTrackTest 0. kix: " + kix);

				if (processOutline){

					if (debug) logger.info("fastTrackTest 0. processOutline: " + processOutline);

					if (j++ % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					History h = HistoryDB.getLastApproverByRole(conn,kix,Constant.TASK_APPROVER);
					if (h != null)
						lastApproverSeq = h.getApproverSeq();

					if (debug) logger.info("fastTrackTest 0. lastApproverSeq: " + lastApproverSeq);

					try{
						int maxSeq = ApproverDB.maxApproverSeqID(conn,campus,route);

						if (debug) logger.info("fastTrackTest 0. maxSeq: " + maxSeq);

						rowsAffected = ApproverDB.fastTrackApprovers(conn,campus,kix,maxSeq,1,route,user);

						System.out.println("fastTrackTest : " + j + ": rowsAffected: " + rowsAffected
													 + ": kix: " + kix
													  + ": maxSeq: " + maxSeq);
					}
					catch(Exception e){
						if (debug) logger.info("0. e: " + e.toString());
					}

				} // processOutline

				found = true;
			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: fastTrackTest - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: fastTrackTest - " + ex.toString());
		}

		return "";
	} // fastTrackTest

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

