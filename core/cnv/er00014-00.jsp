<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "ER00014";
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
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	crsedtx.jsp
	* 	Logger logger = Logger.getLogger("test");
	**/

	//---------------------------------------------------------
	//
	// 1) log in as ZENZ and see why she can't do what she needs to do
	// 2) fast track left task on screen
	// 3) in HIL, approvals not going to WHEAT
	//
	//---------------------------------------------------------

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String thisPage = "ER00014";

	String campus = "KAP";
	String alpha = "MGT";
	String num = "125";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "255i7d119";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;
	String temp = "";

	if (processPage){
		/*

select campus,submittedfor,coursealpha,coursenum,progress,message
from tblTasks
where progress is null
AND not message like 'SLO%'
AND not message like '%SLO'
AND not message like '%program'
AND not message like 'Program%'
		*/

		int idx = website.getRequestParameter(request,"idx",0);

		switch(idx){
			case 1:
				temp = conversion01(conn); // convert NEW outlines in modify progress
				break;
			case 2:
				temp = conversion02(conn); // convert NEW outlines in approval progress
				break;
			case 3:
				temp = conversion03(conn); // convert OLD outlines in approval progress
				break;
			case 4:
				temp = conversion04(conn); // convert OLD outlines in modify progress
				break;
			case 5:
				temp = conversion05(conn); // convert NEW review outlines
				break;
			case 6:
				temp = conversion06(conn); // convert OLD review outlines
				break;
			case 7:
				temp = conversion07(conn); // convert NEW outlines in modify progress
				break;
			case 8:
				temp = conversion08(conn); // convert NEW outlines in modify progress
				break;
			case 9:
				temp = conversion09(conn); // convert NEW outlines in modify progress
				break;
			case 10:
				temp = conversion10(conn); // convert NEW outlines in modify progress
				break;
			case 11:
				temp = conversion11(conn); 	// remove stray task driver
				break;
			case 12:
				temp = removeStrayTasksDriver(conn); 	// remove stray task driver
				break;
			case 13:
				temp = approval01(conn); 		// approve all outlines
				break;
			case 20:
				temp = reassign(conn,user);	// reassign for testing
				break;
			case 21:
				temp = approval02(conn,user); 		// run all through approval
				break;
			case 22:
				temp = approval03(conn,user); 		// run all through approval
				break;
			case 23:
				temp = modify(conn,"KAP","BIOL",user); 		// set to modify
				break;
			case 99:
				temp = conversion99(conn); // run all conversions
				break;
		}

	}

%>

	<ul>
		<li><a href="?idx=1" class="linkcolumn">Conversion 1</a></li>
		<li><a href="?idx=2" class="linkcolumn">Conversion 2</a></li>
		<li><a href="?idx=3" class="linkcolumn">Conversion 3</a></li>
		<li><a href="?idx=4" class="linkcolumn">Conversion 4</a></li>
		<li><a href="?idx=5" class="linkcolumn">Conversion 5</a></li>
		<li><a href="?idx=6" class="linkcolumn">Conversion 6</a></li>
		<li><a href="?idx=7" class="linkcolumn">Conversion 7</a></li>
		<li><a href="?idx=8" class="linkcolumn">Conversion 8</a></li>
		<li><a href="?idx=9" class="linkcolumn">Conversion 9</a></li>
		<li><a href="?idx=10" class="linkcolumn">Conversion 10</a></li>
		<li><a href="?idx=11" class="linkcolumn">Conversion 11</a></li>
		<li><a href="?idx=99" class="linkcolumn">Conversion ALL</a></li>
	</ul>

	<ul>
		<li><a href="?idx=13" class="linkcolumn">Approval 1 for tasks = "Approve Outline Proposal")</a></li>
		<li><a href="?idx=21" class="linkcolumn">Approval 2 (pushed approvals through fast track)</a></li>
		<li><a href="?idx=22" class="linkcolumn">Approval 3 (from modify to approval to fast track)</a></li>
	</ul>

	<ul>
		<li><a href="?idx=23" class="linkcolumn">Modify (test)</a></li>
	</ul>

	<ul>
		<li><a href="?idx=12" class="linkcolumn">removeStrayTasksDriver (test)</a></li>
		<li><a href="?idx=20" class="linkcolumn">Reassign (test)</a></li>
	</ul>

<%
	out.println("<h3 class=\"subheader\">" + temp + Html.BR() + "</h3>");

	System.out.println("<br/>End");

	asePool.freeConnection(conn,thisPage,"");
%>

</table>

<%!

	/*
	 * reassign - convert task description for new outlines
	 *	<p>
	 * new is having 'Modify outline' in task table and only PRE in course
	 *	<p>
	 * @return String
	 */
	public static String reassign(Connection conn,String user){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT submittedfor,coursealpha,coursenum,campus,coursetype FROM tblTasks";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				String submittedfor = AseUtil.nullToBlank(rs.getString("submittedfor"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				if (type != null && type.length() > 0){
					Outlines.reassignOwnership(conn,campus,user,submittedfor,user,alpha,num);
					++totalFound;
				}


			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "reassign - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // reassign

	/*
	 * approval01 - simulate testing of approval for everyone
	 *	<p>
	 * @return String
	 */
	public static String approval01(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;

		try{
			String sql = "select t.submittedfor,t.coursealpha,t.coursenum,t.coursetype, c.historyid, c.campus "
							+ "from tbltasks t, tblCourse c "
							+ "where t.coursealpha = c.coursealpha "
							+ "AND t.coursenum = c.coursenum "
							+ "AND t.coursetype = c.coursetype "
							+ "AND message=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,Constant.APPROVAL_TEXT_EXISTING);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String user = AseUtil.nullToBlank(rs.getString("submittedfor"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));

				CourseDB.approveOutline(conn,campus,alpha,num,user,true,"comments",totalRead,totalRead*2,totalRead*3);

				++totalFound;

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "approvalTest - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // approvalTest

	/*
	 * approval02 - push through as fast tracked
	 *	<p>
	 * @return String
	 */
	public static String approval02(Connection conn,String user){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";
		String campus = "";

		try{

			String sql = "SELECT campus,historyid,coursealpha,coursenum,coursetype,proposer,route "
							+ "FROM tblCourse "
							+ "WHERE campus='KAP' AND progress='APPROVAL' AND coursetype='PRE' AND proposer='SPOPE' "
							+ "ORDER BY campus,coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++totalRead;

				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));

				int route = rs.getInt("route");

				int maxSeq = ApproverDB.getMaxApproverSeq(conn,campus,route);

				fastTrackApprovers(conn,campus,kix,maxSeq,0,route,user);

				++totalFound;

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "approval - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // reassign

	/*
	 * approval03 - send modified to approval
	 *	<p>
	 * @return String
	 */
	public static String approval03(Connection conn,String user){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";
		String campus = "";

		try{

			String sql = "SELECT campus,historyid,coursealpha,coursenum,coursetype,proposer "
							+ "FROM tblCourse "
							+ "WHERE campus='KAP' AND progress='MODIFY' AND coursetype='PRE' AND proposer='SPOPE' "
							+ "ORDER BY campus,coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++totalRead;

				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				campus = AseUtil.nullToBlank(rs.getString("campus"));

				int route = 1316;

				CourseDB.setCourseForApproval(conn,campus,alpha,num,proposer,Constant.COURSE_APPROVAL_TEXT,route,proposer);

				++totalFound;

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "approval - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // reassign

	/*
	 * modify - send modified to approval
	 *	<p>
	 * @return String
	 */
	public static String modify(Connection conn,String campus,String alpha,String user){

		Logger logger = Logger.getLogger("test");

		try{
			int route = 1316;

			String sql = "SELECT coursenum FROM tblCourse "
				+ "WHERE campus=? "
				+ "AND CourseAlpha=? "
				+ "AND CourseType='CUR'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));

				modify01(conn,campus,alpha,num,user);

				CourseDB.setCourseForApproval(conn,campus,alpha,num,user,Constant.COURSE_APPROVAL_TEXT,route,user);

				int maxSeq = ApproverDB.getMaxApproverSeq(conn,campus,route);

				String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

				fastTrackApprovers(conn,campus,kix,maxSeq,0,route,user);

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "";

	} // reassign

	/*
	 * modify - send modified to approval
	 *	<p>
	 * @return String
	 */
	public static String modify01(Connection conn,String campus,String alpha,String num,String user){

		Logger logger = Logger.getLogger("test");

		try{

			CourseModify.modifyOutline(conn,campus,alpha,num,user,Constant.COURSE_MODIFY_TEXT);

			String sql = "UPDATE tblCourse "
				+ "SET edit1=?,edit2=? "
				+ "WHERE campus=? AND "
				+ "CourseAlpha=? AND "
				+ "coursenum=? AND "
				+ "CourseType='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "1");
			ps.setString(2, "1");
			ps.setString(3, campus);
			ps.setString(4, alpha);
			ps.setString(5, num);
			int rowsAffected = ps.executeUpdate();
			ps.close();
			ps = null;

			String kix = Helper.getKix(conn,campus,alpha,num,"PRE");

			MiscDB.insertMisc(conn,campus,kix,alpha,num,"PRE",Constant.OUTLINE_MODIFICATION,"1",user);

		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "";

	} // reassign

	public static int fastTrackApprovers(Connection conn,
														String campus,
														String kix,
														int seq,
														int lastSeq,
														int route,
														String user){

Logger logger = Logger.getLogger("test");

		String temp = "";
		String alpha = "";
		String num = "";
		String approver = "";
		String proposer = "";
		String delegated = "";
		boolean lastApprover = false;
		Msg msg = new Msg();

		int rowsAffected = -1;
		int approver_seq = 0;

		boolean fastTrack = true;
		boolean debug = true;

		String junk = "";

		if (!kix.equals(Constant.BLANK)){
			String[] info = Helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
			proposer = info[3];
		}

		try{
			debug = DebugDB.getDebug(conn,"ApproverDB");

debug = true;

			if (debug) logger.info("---------------------- FAST TRACK APPROVAL - STARTS");

			if (debug){
				logger.info("kix: " + kix);
				logger.info("seq: " + seq);
				logger.info("lastSeq: " + lastSeq);
				logger.info("route: " + route);
				logger.info("user: " + user);
			}

			// is this the last approver?
			if (seq == ApproverDB.getMaxApproverSeq(conn,campus,route)){
				lastApprover = true;
			}

			String approverAtSequence1 = ApproverDB.approverAtSequenceOne(conn,campus,alpha,num);
			if (debug) logger.info("approverAtSequence1: " + approverAtSequence1);

			// get all approvers before this seq and fast track their approvals
			// this is where we simply by pass everyone who was not needed
			String sql = "SELECT approver,delegated,approver_seq "
				+ "FROM tblApprover "
				+ "WHERE campus=? AND "
				+ "route=? AND "
				+ "(approver_seq>? AND approver_seq<=?) "
				+ "ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setInt(2,route);
			ps.setInt(3,lastSeq);
			ps.setInt(4,seq);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				// get the approver's ID
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				delegated = AseUtil.nullToBlank(rs.getString("delegated"));
				approver_seq = rs.getInt("approver_seq");

				boolean isDistributionList = DistributionDB.isDistributionList(conn,campus,approver);
				if (isDistributionList){
					junk = DistributionDB.expandNameList(conn,campus,approver);
				}
				else{
					junk = approver;
				}

				String[] names = junk.split(",");

				for (int iJunk = 0; iJunk < names.length; iJunk++){

					approver = names[iJunk];

					rowsAffected = -1;

					// if it's the first approver and the name does not match the name found as approverAtSequence1,
					// or the person is not part of a distribution, don't log
					fastTrack = true;
					if (approver_seq == 1 && !isDistributionList){
						if (!approverAtSequence1.equals(approver) || junk.indexOf(approverAtSequence1) < 0){
							fastTrack = false;
						}
					}

					if (fastTrack){
						// if last approver, move to archive and make this for real
						if (lastApprover){
							try{
								msg = CourseApproval.approveOutline(conn,
																				campus,
																				alpha,
																				num,
																				approver,
																				true,
																				Constant.FAST_TRACK_TEXT,
																				0,
																				0,
																				0);
								if (msg.getCode() > 0)
									rowsAffected = 0;
							}
							catch(Exception e){
								logger.fatal(kix + " - ApproverDB: fastTrackApprovers - " + e.toString());
								msg.setMsg("Exception");
								rowsAffected = -1;
							}
						}
						else{
							// add to history
							HistoryDB.addHistory(conn,
														alpha,
														num,
														campus,
														approver,
														CourseApproval.getNextSequenceNumber(conn),
														true,
														"Fast track approval",
														kix,
														approver_seq,
														0,
														0,
														0,
														Constant.BLANK,
														Constant.TASK_APPROVER,
														Constant.COURSE_FAST_TRACKED);

							// remove any approval task assigned
							rowsAffected = TaskDB.logTask(conn,
																	approver,
																	approver,
																	alpha,
																	num,
																	Constant.APPROVAL_TEXT,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	Constant.BLANK,
																	Constant.BLANK,
																	Constant.TASK_APPROVER);

							// remove any approval task assigned to delegate
							if (!delegated.equals(Constant.BLANK) && !approver.equals(delegated)){
								rowsAffected = TaskDB.logTask(conn,
																		delegated,
																		delegated,
																		alpha,
																		num,
																		Constant.APPROVAL_TEXT,
																		campus,
																		Constant.BLANK,
																		Constant.TASK_REMOVE,
																		Constant.BLANK,
																		Constant.BLANK,
																		Constant.TASK_APPROVER);
							}
						}	// lastApprover

						AseUtil.logAction(conn,approver,"ACTION","Outline fast tracked for "+ approver,alpha,num,campus,kix);

					}	// if fast track

				} // for

			} // while
			rs.close();

			String sApprovers = "";
			String sDelegates = "";
			boolean found = false;

			// send request for approval to next person in line
			if (!lastApprover){
				seq = seq + 1;
				sql = "SELECT approver,delegated "
					+ "FROM tblApprover "
					+ "WHERE campus=? AND "
					+ "route=? AND "
					+ "approver_seq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,campus);
				ps.setInt(2,route);
				ps.setInt(3,seq);
				rs = ps.executeQuery();
				while (rs.next()) {
					approver = AseUtil.nullToBlank(rs.getString("approver"));

					rowsAffected = TaskDB.logTask(conn,
															approver,
															proposer,
															alpha,
															num,
															Constant.APPROVAL_TEXT,
															campus,
															Constant.BLANK,
															Constant.TASK_ADD,
															Constant.PRE,
															Constant.BLANK,
															Constant.TASK_APPROVER);

					if (debug) logger.info("fast track outline approval task created - rowsAffected " + rowsAffected);

					delegated = AseUtil.nullToBlank(rs.getString("delegated"));
					if (!delegated.equals(Constant.BLANK) && !approver.equals(delegated)){

						rowsAffected = TaskDB.logTask(conn,
																delegated,
																proposer,
																alpha,
																num,
																Constant.APPROVAL_TEXT,
																campus,
																Constant.BLANK,
																Constant.TASK_ADD,
																Constant.PRE,
																Constant.BLANK,
																Constant.TASK_APPROVER);

						if (debug) logger.info("fast track outline approval task created - rowsAffected " + rowsAffected);
					}

					found = true;

					if (sApprovers.equals(Constant.BLANK))
						sApprovers = approver;
					else
						sApprovers = sApprovers + "," + approver;

					if (sDelegates.equals(Constant.BLANK))
						sDelegates = delegated;
					else
						sDelegates = sDelegates + "," + delegated;
				}
				rs.close();
				ps.close();

				// send mail if found
				if (found){
					MailerDB mailerDB = new MailerDB(conn,
													proposer,
													sApprovers,sDelegates,"",
													alpha,
													num,
													campus,
													"emailOutlineApprovalRequest",
													kix,
													user);
					if (debug) logger.info("fast track outline mail sent to " + sApprovers);
				}
			}	// !lastApprover

			if (debug) logger.info("---------------------- FAST TRACK APPROVAL - ENDS");
		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: fastTrackApprovers - " + sx.toString());
			rowsAffected = -1;
		} catch(Exception ex){
			logger.fatal("ApproverDB: fastTrackApprovers - " + ex.toString());
			rowsAffected = -1;
		}

		return rowsAffected;
	}

	/*
	 * conversion01 - convert task description for new outlines
	 *	<p>
	 * new is having 'Modify outline' in task table and only PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion01(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Modify outline'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
				if (kix == null || kix.length() == 0){
					++totalFound;

					// if we find data in approval history, it means that the approval process is in progress
					// and this modification is a revision to the outline
					message = Constant.MODIFY_TEXT_NEW; // "Work on New Course Outline";
					long approvalHistory = ApproverDB.countApprovalHistory(conn,kix);
					if (approvalHistory > 0){
						message = Constant.REVISE_TEXT_NEW; // "Revise New Outline";
					}

					sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();
				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "Conversion01 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion01

	/*
	 * conversion02 - convert task description for new outlines
	 *	<p>
	 * new is having 'Approve outline' in task table and only PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion02(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Approve outline'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
				if (kix == null || kix.length() == 0){
					++totalFound;

					sql = "UPDATE tblTasks SET message='"+Constant.APPROVAL_TEXT_NEW+"',progress='NEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,id);
					ps2.executeUpdate();
					ps2.close();
				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "Conversion02 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion02

	/*
	 * conversion03 - convert task description for old outlines
	 *	<p>
	 * old is having 'Approve outline' in task table and CUR and PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion03(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Approve outline'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
				if (kix != null || kix.length() > 0){
					++totalFound;

					sql = "UPDATE tblTasks SET message='"+Constant.APPROVAL_TEXT_EXISTING+"',progress='APPROVE' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,id);
					ps2.executeUpdate();
					ps2.close();
				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "Conversion03 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion03

	/*
	 * conversion04 - convert task description for old outlines
	 *	<p>
	 * old is having 'Modify outline' in task table and CUR and PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion04(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";
		String progress = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Modify outline'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
				if (kix != null || kix.length() > 0){
					++totalFound;

					// if we find data in approval history, it means that the approval process is in progress
					// and this modification is a revision to the outline
					message = Constant.MODIFY_TEXT_EXISTING;	// "Modify Outline Proposal";
					progress = "MODIFY";
					long approvalHistory = ApproverDB.countApprovalHistory(conn,kix);
					if (approvalHistory > 0){
						message = Constant.REVISE_TEXT_EXISTING; // "Revise Outline Proposal";
						progress = "REVISE";
					}

					sql = "UPDATE tblTasks SET message=?,progress=? WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setString(2,progress);
					ps2.setInt(3,id);
					ps2.executeUpdate();
					ps2.close();
				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion04 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion04

	/*
	 * conversion05 - convert task description for Review outline
	 *	<p>
	 * new is having 'Review outline' in task table and only PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion05(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Review outline'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
				if (kix == null || kix.length() == 0){
					++totalFound;
					message = Constant.REVIEW_TEXT_NEW;	// "Review New Outline";
					sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();
				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion05 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion05

	/*
	 * conversion06 - convert task description for Review outline
	 *	<p>
	 * old is having 'Modify outline' in task table and CUR and PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion06(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Review outline'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				String kix = Helper.getKix(conn,campus,alpha,num,"CUR");
				if (kix != null || kix.length() > 0){
					++totalFound;

					message = Constant.REVIEW_TEXT_EXISTING;	// "Review Outline Proposal";

					sql = "UPDATE tblTasks SET message=?,progress='REVIEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();
				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion06 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion06

	/*
	 * conversion07 - convert task description for new programs
	 *	<p>
	 * new is having 'Modify program' in task table and only PRE in program
	 *	<p>
	 * @return String
	 */
	public static String conversion07(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype,historyid FROM tblTasks WHERE message = 'Modify program'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (kix != null && kix.length() > 0){

					// found the program but cannot exist in system
					if (!ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR")){

						++totalFound;

						// if we find data in approval history, it means that the approval process is in progress
						// and this modification is a revision to the outline
						message = Constant.PROGRAM_MODIFY_TEXT_NEW; 	// "Work on New Program";
						long approvalHistory = ApproverDB.countApprovalHistory(conn,kix);
						if (approvalHistory > 0){
							message = Constant.PROGRAM_REVISE_TEXT_NEW;	// "Revise New Program";
						}

						sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setString(1,message);
						ps2.setInt(2,id);
						ps2.executeUpdate();
						ps2.close();

					} //

				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion07 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion07

	/*
	 * conversion08 - convert task description for Create Program
	 *	<p>
	 * new is having 'Modify outline' in task table and only PRE in course
	 *	<p>
	 * @return String
	 */
	public static String conversion08(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype,historyid FROM tblTasks WHERE message = 'Create program'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (kix != null && kix.length() > 0){

					++totalFound;

					message = Constant.PROGRAM_MODIFY_TEXT_NEW; // "Work on New Program";

					sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();

				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion08 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion08

	/*
	 * conversion09 - convert task description for Approve programs
	 *	<p>
	 * @return String
	 */
	public static String conversion09(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype,historyid FROM tblTasks WHERE message = 'Approve program'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (kix != null && kix.length() > 0){

					if (!ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR"))
						message = Constant.PROGRAM_APPROVAL_TEXT_NEW; // "Approve New Program";
					else
						message = Constant.PROGRAM_APPROVAL_TEXT_EXISTING; // "Approve Program Proposal";

					++totalFound;

					sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();


				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion09 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion09

	/*
	 * conversion10 - convert task description for Approve programs
	 *	<p>
	 * @return String
	 */
	public static String conversion10(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype,historyid FROM tblTasks WHERE message = 'Program approved'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				if (kix != null && kix.length() > 0){

					if (!ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR"))
						message = Constant.PROGRAM_APPROVED_TEXT_NEW; 		// "New Program Approved";
					else
						message = Constant.PROGRAM_APPROVED_TEXT_EXISTING; 	//"Approved Program Proposal";

					++totalFound;

					sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,message);
					ps2.setInt(2,id);
					ps2.executeUpdate();
					ps2.close();


				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion10 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion10

	/*
	 * conversion11 - convert task description for Approve programs
	 *	<p>
	 * @return String
	 */
	public static String conversion11(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;
		String message = "";

		try{
			String sql = "SELECT id, campus,coursealpha,coursenum,coursetype FROM tblTasks WHERE message = 'Outline approved'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				int id = rs.getInt("id");
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String type = AseUtil.nullToBlank(rs.getString("coursetype"));

				if (!CampusDB.courseExistByCampus(conn,campus,alpha,num,"CUR"))
					message = Constant.APPROVED_TEXT_NEW; 		// "New Outline Approved";
				else
					message = Constant.APPROVED_TEXT_EXISTING; // "Proposed Outline Approved";

				++totalFound;

				sql = "UPDATE tblTasks SET message=?,progress='NEW' WHERE id=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,message);
				ps2.setInt(2,id);
				ps2.executeUpdate();
				ps2.close();

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "conversion11 - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // conversion11

	/*
	 * conversion99 - approve all outlines for LR24
	 *	<p>
	 * @return String
	 */
	public static String conversion99(Connection conn){

		Logger logger = Logger.getLogger("test");

		StringBuffer sb = new StringBuffer();

		try{
			sb.append(conversion01(conn) + Html.BR());
			sb.append(conversion02(conn) + Html.BR());
			sb.append(conversion03(conn) + Html.BR());
			sb.append(conversion04(conn) + Html.BR());
			sb.append(conversion05(conn) + Html.BR());
			sb.append(conversion06(conn) + Html.BR());
			sb.append(conversion07(conn) + Html.BR());
			sb.append(conversion08(conn) + Html.BR());
			sb.append(conversion09(conn) + Html.BR());
			sb.append(conversion10(conn) + Html.BR());
			sb.append(conversion11(conn) + Html.BR());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		sb.append("conversion99 completed" + Html.BR());

		return sb.toString();

	} // conversion99

	/*
	 * removeStrayTasksDriver - remove stray task driver
	 *	<p>
	 * @return String
	 */
	public static String removeStrayTasksDriver(Connection conn){

		Logger logger = Logger.getLogger("test");

		int totalRead = 0;
		int totalFound = 0;

		try{
			String sql = "SELECT campus,userid FROM tblusers WHERE userid='FISHERE' ORDER BY campus,userid";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){

				++totalRead;

				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String userid = AseUtil.nullToBlank(rs.getString("userid"));

				removeStrayTasks(conn,campus,userid);

				++totalFound;

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("conversion - " + e.toString());
		}
		catch(Exception e){
			logger.fatal("conversion - " + e.toString());
		}

		return "removeStrayTasksDriver - Read: " + totalRead + "; Processed: " + totalFound + Html.BR();

	} // removeStrayTasksDriver

	/*
	 * removeStrayTasks
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * @param	user		String
	 * <p>
	 * @return	void
	 */
	public static void removeStrayTasks(Connection conn,String campus,String user) throws SQLException {

Logger logger = Logger.getLogger("test");

		String message = "";
		String alpha = "";
		String num = "";
		String type = "";
		String kix = "";
		String outlineProgress = "";
		String taskProgress = "";
		String taskMessage = "";
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

		boolean programExistByTypeCampus = false;
		boolean courseExistByTypeCampus = false;

		PreparedStatement ps = null;

		String today = (new SimpleDateFormat("MM/dd/yyyy")).format(new java.util.Date());
		String reviewDate = "";
		String subprogress = "";

		// stray tasks are tasks not found with corresponding coures work
		try{
			logger.info("------------------- removeStrayTasks START");

			test = false;

			if (test){
				sql = "SELECT id,coursealpha,coursenum,coursetype,message,historyid,category "
					+ "FROM tblTasks "
					+ "WHERE campus=? "
					+ "AND submittedfor=? "
					+ "AND coursealpha='KES' "
					+ "AND coursenum='143' "
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
				if (kix == null || kix.length() == 0){
					kix = Helper.getKix(conn,campus,alpha,num,type);
				}

				isAProgram = ProgramsDB.isAProgram(conn,kix);

				programExistByTypeCampus = ProgramsDB.programExistByTypeCampus(conn,campus,kix,"CUR");

				courseExistByTypeCampus = CourseDB.courseExistByTypeCampus(conn,campus,alpha,num,"CUR");

				subprogress = Outlines.getSubProgress(conn,kix);

				// set to proper type for task progress
				type = "PRE";
				String[] taskText = TaskDB.getTaskMenuText(conn,message,campus,alpha,num,type,kix);
				taskProgress = taskText[Constant.TASK_PROGRESS];
				taskMessage = taskText[Constant.TASK_MESSAGE];

				// review date
				if (!category.equals(Constant.PROGRAM) && message.toLowerCase().indexOf("review") > -1){
					reviewDate = CourseDB.getCourseItem(conn,kix,"reviewdate");
				}

				// get current progress from outline/program
				if (category.equals(Constant.PROGRAM)){
					outlineProgress = ProgramsDB.getProgramProgress(conn,campus,kix);
				}
				else{
					outlineProgress = CourseDB.getCourseProgress(conn,campus,alpha,num,type);

					if (subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL))
						reviewDuringApprovalAllowed = true;
				}

				reason = "";
				delete = false;

				// if the task is there but the user is not the proposer of the item in modify progress, delete
				// if review task exists but not in review, delete only if not a review within approval
				// if approval task exists but not in approval, delete
				if(	taskMessage.equals(Constant.APPROVED_TEXT_NEW) ||
						taskMessage.equals(Constant.APPROVED_TEXT_EXISTING) ||
						taskMessage.equals(Constant.PROGRAM_APPROVED_TEXT_NEW) ||
						taskMessage.equals(Constant.PROGRAM_APPROVED_TEXT_EXISTING) ||
						taskMessage.equals(Constant.APPROVAL_PENDING_TEXT)){

						// ignore because these are notification only
						reason = "notification only";
						outlineProgressStep = "step: 000";
				}
				else{
					if (isAProgram){
						if (	(taskProgress.toLowerCase().indexOf("approv") > -1 || outlineProgress.equals(Constant.COURSE_CREATE_TEXT)) &&
								!ProgramsDB.programExistByTitleCampus(conn,campus,kix,type)){

							// a task exists but the program does not so delete
							delete = true;
							reason = "not allowed to approve";
							outlineProgressStep = "step: 100";
						}
						else if (taskProgress.toLowerCase().indexOf("delete") > -1 && !outlineProgress.equals(Constant.COURSE_DELETE_TEXT)){
							delete = true;
							reason = "not allowed to delete";
							outlineProgressStep = "step: 110";
						}
						else if (taskProgress.toLowerCase().indexOf("modify") > -1 && !outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)){
							delete = true;
							reason = "not allowed to modify";
							outlineProgressStep = "step: 120";
						}
						else if (taskProgress.toLowerCase().indexOf("work") > -1 && !outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)){
							delete = true;
							reason = "not allowed to modify";
							outlineProgressStep = "step: 120";
						}
						else if (category.equals(Constant.PROGRAM) && outlineProgress.equals(Constant.BLANK)){
							delete = true;
							reason = "invalid progress or task";
							outlineProgressStep = "step: 130";
						}
					}
					else{
						if (outlineProgress.equals(Constant.BLANK)){
							delete = true;
							reason = "outline does not exist to delete";
							outlineProgressStep = "step: 135";
						}
						else if (taskProgress.equals(Constant.APPROVE_REQUISITE_TEXT) &&
									!RequisiteDB.isPendingApproval(conn,Constant.REQUISITES_PREREQ,campus,alpha,num,type)){
							delete = true;
							reason = "no pending pre requisite to approve";
							outlineProgressStep = "step: 136";
						}
						else if (taskProgress.equals(Constant.APPROVE_REQUISITE_TEXT) &&
									!RequisiteDB.isPendingApproval(conn,Constant.REQUISITES_COREQ,campus,alpha,num,type)){
							delete = true;
							reason = "no pending co requisite to approve";
							outlineProgressStep = "step: 137";
						}
						else if (taskProgress.equals(Constant.APPROVE_CROSS_LISTING_TEXT) &&
									!XRefDB.isPendingApproval(conn,campus,alpha,num,type)){
							delete = true;
							reason = "no pending xref to approve";
							outlineProgressStep = "step: 138";
						}
						else if (taskProgress.toLowerCase().indexOf("approv") > -1 && (!(outlineProgress.equals(Constant.COURSE_APPROVAL_TEXT)) &&
										!(outlineProgress.equals("DELETE")))){
							delete = true;
							reason = "not allowed to approve";
							outlineProgressStep = "step: 140";
						}
						else if ((taskProgress.toLowerCase().indexOf("modify") > -1 && outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)) &&
								!CourseDB.courseExistByProposer(conn,campus,user,alpha,num,type)){
							delete = true;
							reason = "modify text but not proposer";
							outlineProgressStep = "step: 150";
						}
						else if ((taskProgress.toLowerCase().indexOf("work") > -1 && outlineProgress.equals(Constant.COURSE_MODIFY_TEXT)) &&
								!CourseDB.courseExistByProposer(conn,campus,user,alpha,num,type)){
							delete = true;
							reason = "modify text but not proposer";
							outlineProgressStep = "step: 150";
						}
						else if ((taskProgress.toLowerCase().indexOf("review") > -1 || subprogress.equals(Constant.COURSE_REVIEW_IN_APPROVAL)) &&
									DateUtility.compare2Dates(reviewDate,today) < 0 ){
							delete = true;
							reason = "In review but review date has expired";
							outlineProgressStep = "step: 160";
						}
						else if (taskProgress.toLowerCase().indexOf("review") > -1 &&
									((!reviewDuringApprovalAllowed	&& !(outlineProgress.equals("REVIEW")))
										&& !outlineProgress.equals("APPROVAL"))){
							delete = true;
							reason = "not allowed to review";
							outlineProgressStep = "step: 170";
						}
						else if (taskProgress.toLowerCase().indexOf("review") > -1 && !ReviewerDB.isReviewer(conn,kix,user)){
							delete = true;
							reason = "not a reviewer";
							outlineProgressStep = "step: 180";
						}
					} // isAProgram
				} // notification

				if (delete){

debug = true;

					if (debug){
						logger.fatal("-----------------------------------");
						logger.fatal("user: " + user);
						logger.fatal("isAProgram: " + isAProgram);
						logger.fatal("taskProgress: " + taskProgress);
						logger.fatal("outlineProgress: " + outlineProgress);
						logger.fatal("outlineProgressStep: " + outlineProgressStep);
						logger.fatal("taskMessage: " + taskMessage);
						logger.fatal("kix: " + kix);
						logger.fatal("alpha: " + alpha);
						logger.fatal("num: " + num);
						logger.fatal("reason: " + reason);
					}

					++cleaned;

					boolean run = true;

					if (run){

						if (category.equals(Constant.COURSE)){
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	alpha,
																	num,
																	message,
																	campus,
																	"stray",
																	Constant.TASK_REMOVE,
																	type);
						}
						else{
							rowsAffected = TaskDB.logTask(conn,
																	user,
																	user,
																	Constant.BLANK,
																	Constant.BLANK,
																	message,
																	campus,
																	Constant.BLANK,
																	Constant.TASK_REMOVE,
																	type,
																	Constant.BLANK,
																	Constant.BLANK,
																	kix,
																	Constant.PROGRAM);
						}

						// if we were unable to remove the task, use ID instead
						if (rowsAffected == 0){
							rowsAffected = TaskDB.deleteTaskByID(conn,id);
						}

						logger.info("Stray task removed for " + user + ": " + alpha + " " + num + " (" + rowsAffected + ")");
					} // run
				} // delete

			}	// while
			rs.close();
			ps.close();

			if (cleaned > 0){
				logger.info("Stray task(s) cleaned up for " + user + " (" + cleaned + " rows)");
			}

			logger.info("------------------- removeStrayTasks END");
		}
		catch( Exception ex ){
			logger.fatal("TaskDB: removeStrayTasks - " + ex.toString());
		}
	} // removeStrayTasks

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>