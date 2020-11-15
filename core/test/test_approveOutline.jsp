<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crttpl.jsp
	*	2007.09.01
	**/

	//javax.servlet.jsp.JspWriter out,
	//Logger logger = Logger.getLogger("test");

	String alpha = "ICS";
	String num = "212";
	String campus = "LEE";
	String user = "JITO";
	String type = "PRE";

	out.println(approveOutline(conn,campus,alpha,num,user,true,"comments"));
%>

<%!

	public static Approver getApprovers(Connection conn,String campus,String alpha,String user) throws Exception {

Logger logger = Logger.getLogger("test");

		String thisApprover = "";
		String thisDelegated = "";
		StringBuffer allApprovers = new StringBuffer();
		int thisSeq = 0;
		int currentSeq = 0;
		int firstSeq = 1;
		int nextSeq = 0;
		int prevSeq = 0;
		int lastSeq = 0;
		Approver approver = new Approver();

		try {
			user = user.toUpperCase();

			String query = "SELECT approver,delegated,approver_seq "
					+ "FROM tblApprover WHERE campus=? ORDER BY approver_seq";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, campus);
			ResultSet results = ps.executeQuery();

			while (results.next()) {
				thisApprover = AseUtil.nullToBlank(results.getString(1)).trim();

				if ("DIVISIONCHAIR".equals(thisApprover)){
					thisApprover = ApproverDB.getDivisionChairApprover(conn,campus,alpha);
				}

				thisDelegated = AseUtil.nullToBlank(results.getString(2)).trim();
				thisSeq = results.getInt(3);

				// determine the current approver
				if (user.trim().equals(thisApprover) && approver.getApprover().length() == 0) {
					currentSeq = thisSeq;
				}

				// csv representing list of approvers
				if (allApprovers.length() > 0)
					allApprovers.append(",");

				allApprovers.append(thisApprover);

				lastSeq++;
			}
			results.close();
			ps.close();

			// include the last approver
			if (thisApprover != null && thisApprover.length() > 0) {
				approver.setAllApprovers(allApprovers.toString());
			}

			if (lastSeq > 0) {
				prevSeq = currentSeq - firstSeq;

				if (prevSeq == 0)
					prevSeq = 1;

				nextSeq = currentSeq + 1;

				if (nextSeq > lastSeq)
					nextSeq = lastSeq;

				String[] approvers = new String[lastSeq];
				approvers = allApprovers.toString().split(",");

				approver.setApprover(approvers[currentSeq - 1]);
				approver.setSeq(Integer.toString(currentSeq));

				approver.setFirstApprover(approvers[firstSeq - 1]);
				approver.setFirstSequence(Integer.toString(firstSeq));

				approver.setPreviousApprover(approvers[prevSeq - 1]);
				approver.setPreviousSequence(Integer.toString(prevSeq));

				approver.setNextApprover(approvers[nextSeq - 1]);
				approver.setNextSequence(Integer.toString(nextSeq));

				approver.setLastApprover(approvers[lastSeq - 1]);
				approver.setLastSequence(Integer.toString(lastSeq));
			}
		} catch (Exception e) {
			logger.fatal("ApproverDB: getApprovers\n" + e.toString());
			approver = null;
		}

		return approver;
	}

	/*
	 * approveOutline
	 *	<p>
	 *	@return int
	 */
	public static Msg approveOutline(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												boolean approval,
												String comments) throws Exception {

Logger logger = Logger.getLogger("test");

		boolean debug = true;

		/*
		 * in case user presses refresh, we want to prevent multiple executions.
		 * Only run when there is an outline is in approval status.
		 *
		 * this is just double checking before executing. it's already checked
		 * during the outline selection.
		 *
		 * if there is an outline, is this the next approver
		 */
		Msg msg = new Msg();

		if (debug) logger.info("----------------------------------- approveOutline starts");

		if ("APPROVAL".equals(CourseDB.getCourseProgress(conn,campus,alpha,num,"PRE"))) {
			if (CourseDB.isNextApprover(conn,campus,alpha,num,user)) {
				msg = approveOutlineX(conn,campus,alpha,num,user,approval,comments);
			} else {
				msg.setMsg("NotYourTurnToApprove");
				logger.info("CourseDB: approveOutline\nAttempting to approve out of sequence.");
			}
		} else {
			msg.setMsg("NoOutlineToApprove");
			logger.info("CourseDB: approveOutline\nAttempting to approve outline that is not editable.");
		}

		if (debug) logger.info("----------------------------------- approveOutline ends");

		return msg;
	}

	public static Msg approveOutlineX(Connection conn,
												String campus,
												String alpha,
												String num,
												String user,
												boolean approval,
												String comments) throws Exception {

Logger logger = Logger.getLogger("test");
int LAST_APPROVER 	= 2;
int ERROR_CODE 		= 3;

		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps;
		String sql;

		AsePool asePool = AsePool.getInstance();
		Connection connection = asePool.getConnection();

		boolean debug = true;

		try {

			if (debug) logger.info("CourseDB - approveOutlineX - start");

			// if there is an approver, then it shouldn't be 0. Go ahead and
			// update
			Approver approver = new Approver();
//approver = ApproverDB.getApprovers(connection,campus,alpha,user);
approver = getApprovers(connection,campus,alpha,user);
			int approverSequence = Integer.parseInt(approver.getSeq());

			if (debug) logger.info("CourseDB - approveOutlineX - got approvers");

			if (approverSequence > 0) {

				String proposer = CourseDB.getCourseProposer(connection,campus,alpha,num,"CUR");
				MailerDB mailerDB;

				/*	put the outline in modify mode again if rejected
					else, if approved, and this is the last person, make sure to
					finalize approval process.
				*/
				if (!approval) {

					if (debug) logger.info("CourseDB - approveOutlineX - reject");

					AseUtil.logAction(connection, user, "crsappr.jsp","Outline disapproved", alpha, num, campus);
					String enableOutlineEdit = "UPDATE tblCourse SET edit=1,progress='MODIFY' WHERE coursealpha=? AND coursenum=? AND campus=?";
					ps = connection.prepareStatement(enableOutlineEdit);
					ps.setString(1, alpha);
					ps.setString(2, num);
					ps.setString(3, campus);
					rowsAffected = ps.executeUpdate();
					ps.close();

					// delete task for approver
					rowsAffected = TaskDB.logTask(connection,user,user,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE");
					if (debug) logger.info("CourseDB - approveOutlineX - delete approver task");

					// add task back for proposer
					rowsAffected = TaskDB.logTask(connection,proposer,proposer,alpha,num,"Modify outline",campus,"crsappr.jsp","ADD");
					if (debug) logger.info("CourseDB - approveOutlineX - insert proposer tasks");

					// notify proposer of rejection
					mailerDB = new MailerDB(connection,user,proposer,"","",alpha,num,campus,"emailOutlineReject");
					if (debug) logger.info("CourseDB - approveOutlineX - emailOutlineReject");
				} else {
					if (debug) logger.info("CourseDB - approveOutlineX - approval");

					AseUtil.logAction(connection,user,"crsappr.jsp","Outline approved",alpha,num,campus);

					// enter approval into history
					sql = "INSERT INTO tblApprovalHist(coursealpha,coursenum,dte,campus,approver,seq,approved,comments,historyid) VALUES(?,?,?,?,?,?,?,?,?)";
					String historyID = CourseDB.getHistoryID(connection,campus,alpha,num,"PRE");
					ps = conn.prepareStatement(sql);
					ps.setString(1, alpha);
					ps.setString(2, num);
					ps.setString(3, AseUtil.getCurrentDateString());
					ps.setString(4, campus);
					ps.setString(5, user);
					ps.setInt(6, approverSequence);
					ps.setBoolean(7, approval);
					ps.setString(8, comments);
					ps.setString(9, historyID);
					rowsAffected = ps.executeUpdate();
					ps.close();
					if (debug) logger.info("CourseDB - approveOutlineX - insert to history");

					/*
						if the last person, move CUR TO ARC and PRE TO CUR. However, if there are
						errors in the move, revert back.
					*/
					if (user.equalsIgnoreCase(approver.getLastApprover())) {

						if (debug) logger.info("CourseDB - approveOutlineX - last approver");

						String driverType = AseUtil.getDriverType();

						if ("Access".equals(driverType))
							msg = approveOutlineAccess(conn,campus,alpha,num,user);
						else
							msg = approveOutlineOracle(conn,campus,alpha,num,user);

						if (msg.getCode() == ERROR_CODE){
							sql = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=? AND approver=?";
							ps = connection.prepareStatement(sql);
							ps.setString(1, campus);
							ps.setString(2, alpha);
							ps.setString(3, num);
							ps.setString(4, user);
							rowsAffected = ps.executeUpdate();
							ps.close();
							if (debug) logger.info("CourseDB - approveOutlineX - clear history (error)");
						}
						else{
							msg.setCode(LAST_APPROVER);
							mailerDB = new MailerDB(connection,user,proposer,"","",alpha,num,campus,"emailApproveOutline");
							AseUtil.loggerInfo("CourseDB: approveOutlineX - send mail",campus,user,alpha,num);
							DistributionDB.notifyDistribution(connection,campus,alpha,num,"",user,"","","emailNotifiedWhenApproved","NotifiedWhenApproved");
							AseUtil.loggerInfo("CourseDB: approveOutlineX - notified distribution",campus,user,alpha,num);
							if (debug) logger.info("CourseDB - approveOutlineX - emailNotifiedWhenApproved");
						}
					} // last getLastApprover

					/*
					 * remove task for this user
					 *
					 * If the last person in line to approve, move the approved
					 * to the appropriate table and notify author of completion
					 *
					 */
					if (msg.getCode() != ERROR_CODE){
						rowsAffected = TaskDB.logTask(connection,user,user,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE");
					}
				} // else !approval

				// remove task where approve or reject since we have to start
				// over again.
				AseUtil.loggerInfo("CourseDB: approveOutlineX ",campus,user,alpha,num);
			} else {
				rowsAffected = approverSequence;
			} // approverSequence > 0
		} catch (SQLException se) {
			logger.fatal("CourseDB: approveOutlineX\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("CourseDB: approveOutlineX\n" + e.toString());
		} finally {
			asePool.freeConnection(connection);
		}

		return msg;
	}

	/*
	 * approveOutlineAccess
	 *	<p>
	 *	@return int
	 */
	public static Msg approveOutlineAccess(Connection conn,String campus,String alpha,String num,String user) throws Exception {

		int tableCounter = 0;
		int stepCounter = 0;
		int rowsAffected = 0;
		int i = 0;

Logger logger = Logger.getLogger("test");
int LAST_APPROVER 	= 2;
int ERROR_CODE 		= 3;

		boolean debug = true;

		Msg msg = new Msg();
		PreparedStatement ps;
		String[] sql = new String[20];
		String thisSQL = "";
		String currentDate = AseUtil.getCurrentDateString();

		/*
			 to make a proposed course to current, do the following
			 1) make sure the course doesn't already exist in the temp table (deleteFromTemp)
			 2) make a copy of the CUR course in temp table (insertToTemp)
			 3) update key fields and prep for archive (updateTemp)
			 4) put the temp record in courseARC table for use (insertToCourseARC)
			 5) delete the current course from tblCourse
			 6) change the PRE course in current course to CUR
			 7) clean up the temp table (deleteFromTemp)
			 8) move current approval history to log table
			 9) clear current approval history
		*/

		stepCounter = 0;

		conn.setAutoCommit(false);

		try {
			// delete temp data
			tableCounter = 7;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			sql[6] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i] + " WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - delete1 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// delete into temp what is currently in the main tables
			tableCounter = 7;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			sql[6] = "tblTempCourseCompAss";

			sql[10] = "tblCourse";
			sql[11] = "tblCampusData";
			sql[12] = "tblCoreq";
			sql[13] = "tblPreReq";
			sql[14] = "tblCourseComp";
			sql[15] = "tblCourseContent";
			sql[16] = "tblCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ sql[i + 10]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - insert2 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// update temp data prior to inserting into archived tables
			thisSQL = "UPDATE tblTempCourse SET coursetype='ARC',progress='ARCHIVED',proposer=?,coursedate=? WHERE coursealpha=? AND coursenum=? AND campus=?";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, user);
			ps.setString(2, currentDate);
			ps.setString(3, alpha);
			ps.setString(4, num);
			ps.setString(5, campus);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("CourseDB - approveOutlineAccess - update3 - " + rowsAffected + " row");

			tableCounter = 6;
			sql[0] = "tblTempCoreq";
			sql[1] = "tblTempPreReq";
			sql[2] = "tblTempCourseComp";
			sql[3] = "tblTempCourseContent";
			sql[4] = "tblTempCampusData";
			sql[5] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='ARC',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, currentDate);
				ps.setString(2, campus);
				ps.setString(3, alpha);
				ps.setString(4, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - update4 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// insert data from temp into archived tables
			tableCounter = 7;
			sql[0] = "tblCourseARC";
			sql[1] = "tblCampusData";
			sql[2] = "tblCoReq";
			sql[3] = "tblPreReq";
			sql[4] = "tblCourseComp";
			sql[5] = "tblCourseContent";
			sql[6] = "tblCourseCompAss";

			sql[10] = "tblTempCourse";
			sql[11] = "tblTempCampusData";
			sql[12] = "tblTempCoreq";
			sql[13] = "tblTempPreReq";
			sql[14] = "tblTempCourseComp";
			sql[15] = "tblTempCourseContent";
			sql[16] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "INSERT INTO "
						+ sql[i]
						+ " SELECT * FROM "
						+ sql[i + 10]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='ARC'";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - insert5 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// delete the current table data before moving from temp back to it
			tableCounter = 7;
			sql[0] = "tblCourse";
			sql[1] = "tblCampusData";
			sql[2] = "tblCoReq";
			sql[3] = "tblPreReq";
			sql[4] = "tblCourseComp";
			sql[5] = "tblCourseContent";
			sql[6] = "tblCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM "
						+ sql[i]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='CUR'";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - delete6 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// set the modified data to current
			thisSQL = "UPDATE tblCourse " +
				"SET coursetype='CUR',progress='APPROVED',edit1='',edit2='',coursedate=?,auditdate=?,proposer=? " +
				"WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
			ps = conn.prepareStatement(thisSQL);
			ps.setString(1, currentDate);
			ps.setString(2, currentDate);
			ps.setString(3, user);
			ps.setString(4, campus);
			ps.setString(5, alpha);
			ps.setString(6, num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info("CourseDB - approveOutlineAccess - update7 - " + rowsAffected + " row");
			ps.clearParameters();

			tableCounter = 6;
			sql[0] = "tblCampusData";
			sql[1] = "tblCoReq";
			sql[2] = "tblPreReq";
			sql[3] = "tblCourseComp";
			sql[4] = "tblCourseContent";
			sql[5] = "tblCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "UPDATE "
						+ sql[i]
						+ " SET coursetype='CUR',auditdate=? WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype='PRE'";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, currentDate);
				ps.setString(2, campus);
				ps.setString(3, alpha);
				ps.setString(4, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - update8 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// clean up temp tables
			tableCounter = 7;
			sql[0] = "tblTempCourse";
			sql[1] = "tblTempCampusData";
			sql[2] = "tblTempCoreq";
			sql[3] = "tblTempPreReq";
			sql[4] = "tblTempCourseComp";
			sql[5] = "tblTempCourseContent";
			sql[6] = "tblTempCourseCompAss";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = "DELETE FROM " + sql[i]
						+ " WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - delete9 " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			// update history table
			tableCounter = 2;
			sql[0] = "INSERT INTO tblApprovalHist2 ( id, historyid, approvaldate, coursealpha, coursenum, "
					+ "dte, campus, seq, approver, approved, comments ) "
					+ "SELECT tba.id, tba.historyid, '"
					+ currentDate
					+ "', tba.coursealpha, tba.coursenum, tba.dte, tba.campus, tba.seq,  "
					+ "tba.approver, tba.approved, tba.comments "
					+ "FROM tblApprovalHist tba "
					+ "WHERE campus=? AND "
					+ "CourseAlpha=? AND " + "CourseNum=?";
			sql[1] = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=?";
			for (i = 0; i < tableCounter; i++) {
				thisSQL = sql[i];
				ps = conn.prepareStatement(thisSQL);
				ps.setString(1, campus);
				ps.setString(2, alpha);
				ps.setString(3, num);
				rowsAffected = ps.executeUpdate();
				if (debug) logger.info("CourseDB - approveOutlineAccess - mix " + (i+1) + " of " + tableCounter + " - " + rowsAffected + " row");
				ps.clearParameters();
			}

			conn.commit();

			ps.close();
		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("CourseDB: approveOutlineAccess\n" + ex.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);
			msg.setErrorLog("Exception");
			conn.rollback();
			logger.info("CourseDB: approveOutlineAccess\nRolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("CourseDB: approveOutlineAccess\n" + e.toString());
			msg.setMsg("Exception");
			msg.setCode(ERROR_CODE);

			try {
				conn.rollback();
				logger.info("CourseDB: approveOutlineAccess\nRolling back transaction");
			} catch (SQLException exp) {
				msg.setCode(ERROR_CODE);
				logger.fatal("CourseDB: approveOutlineAccess\n" + exp.toString());
				msg.setMsg("Exception");
				msg.setErrorLog("Exception");
			}
		}

		conn.setAutoCommit(true);

		return msg;
	}

	/*
	 * approveOutlineOracle
	 *	<p>
	 *	@return Msg
	 */
	public static Msg approveOutlineOracle(Connection conn, String campus,
			String alpha, String num, String user) throws Exception {

Logger logger = Logger.getLogger("test");

		String query = "{ call sp_ApproveOutline(?,?,?,?,?) }";
		Msg msg = new Msg();
		conn.setAutoCommit(false);

		try {
			msg.setMsg("");

			CallableStatement stmt = conn.prepareCall(query);
			stmt.setString(1, alpha);
			stmt.setString(2, num);
			stmt.setString(3, campus);
			stmt.setString(4, user);
			stmt.setString(5, AseUtil.getCurrentDateString());
			stmt.executeQuery();
			stmt.close();
			conn.commit();
		} catch (Exception e) {
			logger.fatal("CourseDB: approveOutlineOracle\n" + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog(e.toString());
		}

		conn.setAutoCommit(true);
		return msg;
	}

%>