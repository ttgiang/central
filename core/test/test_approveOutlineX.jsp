<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = "ICS";
	String num = "100";
	String user = "GOODMANJ"; //"CURRIVANP001";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";

	msg = courseDB.approveOutline(conn,campus,alpha,num,user,true,"",0,0,0);
	out.println(msg);
	if ( "Exception".equals(msg.getMsg()) ){
		message = "Outline approval failed.<br><br>" + msg.getErrorLog();
	}
	else if ("forwardURL".equals(msg.getMsg()) ){
		sURL = "lstappr.jsp?kix="+msg.getMsg()+"&s="+msg.getCode();
	}
	else if (!"".equals(msg.getMsg()) ){
		message = "Unable to approve outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
	}
	else{
		if (msg.getCode() == 2)
			message = "Outline was approved and finalized.";
		else
			message = "Outline was approved.";
	}

	if ( sURL != null && sURL.length() > 0 )
		response.sendRedirect(sURL);

	asePool.freeConnection(conn);
%>

<%!

	public static Msg approveOutlineX(Connection connection,
												String campus,
												String alpha,
												String num,
												String user,
												boolean approval,
												String comments,
												int voteFor,int voteAgainst,int voteAbstain,
												HttpServletResponse response) throws Exception {

	final int LAST_APPROVER 	= 2;
	final int ERROR_CODE 		= 3;

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps;
		String sql;
		String type = "PRE";
		String delegated = "";
		String nextApprover = "";
		int approverSequence = 0;

		ResourceBundle bundle = ResourceBundle.getBundle(Constant.ASE_PROPERTIES);
		String domain = "@" + bundle.getString("domain");
		String toNames = "";
		String sender = "";
		String temp = "";
		String[] tasks = new String[20];
		User udb = new User();
		String DeanLevelApproval = "";
		int z = 0;
		boolean forwardURL = true;

		String kix = Helper.getKix(connection,campus,alpha,num,type);
		logger.info(kix + " - " + user + " - CourseApproval: approveOutlineX - STARTS");

		try {
			logger.info("CourseApproval - approveOutlineX - start");

			// if there is an approver, then it shouldn't be 0. Go ahead and update
			Approver approver = new Approver();
			approver = ApproverDB.getApprovers(connection,campus,alpha,user);
			approverSequence = Integer.parseInt(approver.getSeq());
			if (approverSequence > 0) {

				String historyID = CourseDB.getHistoryID(connection,campus,alpha,num,type);
				String proposer = CourseDB.getCourseProposer(connection,campus,alpha,num,type);
				MailerDB mailerDB;

				// save approval into history
				sql = "INSERT INTO tblApprovalHist(coursealpha,coursenum,dte,campus,approver,seq,approved,comments,historyid) VALUES(?,?,?,?,?,?,?,?,?)";
				ps = connection.prepareStatement(sql);
				ps.setString(1, alpha);
				ps.setString(2, num);
				ps.setString(3, AseUtil.getCurrentDateString());
				ps.setString(4, campus);
				ps.setString(5, user);
				ps.setInt(6, CourseApproval.getNextSequenceNumber(connection));
				ps.setBoolean(7, approval);
				ps.setString(8, comments);
				ps.setString(9, historyID);
				rowsAffected = ps.executeUpdate();
				ps.close();
				logger.info("CourseApproval - approveOutlineX - insert to history");

				/*
					if division chair and votes were casted, update
				*/
				int totalVotes = voteFor + voteAgainst + voteAbstain;
				if (user.equals(ApproverDB.getDivisionChairApprover(connection,campus,alpha)) && totalVotes > 0){
					sql = "UPDATE tblCourse SET votesfor=?,votesagainst=?,votesabstain=? "
						+ "WHERE historyid=?";
					ps = connection.prepareStatement(sql);
					ps.setInt(1,voteFor);
					ps.setInt(2,voteAgainst);
					ps.setInt(3,voteAbstain);
					ps.setString(4,kix);
					rowsAffected = ps.executeUpdate();
					ps.close();
					logger.info(kix + " - CourseApproval - approveOutlineX - update votes");
				}

				/*	put the outline in modify mode again if rejected
					else, if approved, and this is the last person, make sure to
					finalize approval process.
				*/
				if (!approval) {
					String enableOutlineEdit = "UPDATE tblCourse SET edit=1,progress='MODIFY' WHERE coursealpha=? AND coursenum=? AND campus=?";
					ps = connection.prepareStatement(enableOutlineEdit);
					ps.setString(1, alpha);
					ps.setString(2, num);
					ps.setString(3, campus);
					rowsAffected = ps.executeUpdate();
					ps.close();
					AseUtil.logAction(connection, user, "crsappr.jsp","Outline disapproved", alpha, num, campus);

					// delete task for approver & delegate
					rowsAffected = TaskDB.logTask(connection,proposer,user,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
					logger.info("CourseApproval - approveOutlineX - delete approver task (" + user + ") - rowsAffected " + rowsAffected);

					delegated = ApproverDB.getDelegateByApproverName(connection,campus,user);
					if (!"".equals(delegated)){
						rowsAffected = TaskDB.logTask(connection,proposer,delegated,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
						logger.info("CourseApproval - approveOutlineX - delete approver task (" + delegated + ") rowsAffected " + rowsAffected);
					}
					else{
						delegated = ApproverDB.getApproverByDelegateName(connection,campus,user);
						if (!"".equals(delegated)){
							rowsAffected = TaskDB.logTask(connection,proposer,delegated,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
							logger.info("CourseApproval - approveOutlineX - delete approver task (" + delegated + ") rowsAffected " + rowsAffected);
						}
					}

					// add task back for proposer
					rowsAffected = TaskDB.logTask(connection,proposer,proposer,alpha,num,"Modify outline",campus,"crsappr.jsp","ADD",type);
					logger.info("CourseApproval - approveOutlineX - insert proposer tasks - rowsAffected " + rowsAffected);

					// notify proposer of rejection
					mailerDB = new MailerDB(connection,user,proposer,"","",alpha,num,campus,"emailOutlineReject");
					logger.info("CourseApproval - approveOutlineX - emailOutlineReject");
				}
				else {
					logger.info("CourseApproval - approveOutlineX - approval");

					/*
						if the last person, move CUR TO ARC and PRE TO CUR. However, if there are
						errors in the move, revert back.
					*/

					if ("1THANHG".equals(user) && "YES".equals(AseUtil.getDebugMode())) {
						approver.setLastApprover(user);
					}

					if (user.equalsIgnoreCase(approver.getLastApprover()) || user.equalsIgnoreCase(approver.getLastDelegate())) {
						logger.info("CourseApproval - approveOutlineX - last approver");

						switch(AseUtil.getDriverType(0)){
							case Constant.DATABASE_DRIVER_ACCESS:
							case Constant.DATABASE_DRIVER_ACCESSSQL:
								msg = CourseApproval.approveOutlineAccess(connection,campus,alpha,num,user);
								break;
							case Constant.DATABASE_DRIVER_ORACLE:
								msg = CourseApproval.approveOutlineAccess(connection,campus,alpha,num,user);
								break;
							case Constant.DATABASE_DRIVER_SQL:
								msg = CourseApproval.approveOutlineAccess(connection,campus,alpha,num,user);
								break;
						}

						if (msg.getCode()==ERROR_CODE){
							sql = "DELETE FROM tblApprovalHist WHERE campus=? AND coursealpha=? AND coursenum=? AND approver=?";
							ps = connection.prepareStatement(sql);
							ps.setString(1, campus);
							ps.setString(2, alpha);
							ps.setString(3, num);
							ps.setString(4, user);
							rowsAffected = ps.executeUpdate();
							ps.close();
							logger.info("CourseApproval - approveOutlineX - clear history (error)");
						}
						else{
							msg.setCode(LAST_APPROVER);
							mailerDB = new MailerDB(connection,user,proposer,"","",alpha,num,campus,"emailApproveOutline");
							AseUtil.loggerInfo("CourseApproval: approveOutlineX - send mail",campus,user,alpha,num);
							DistributionDB.notifyDistribution(connection,campus,alpha,num,"",user,"","","emailNotifiedWhenApproved","NotifiedWhenApproved");
							AseUtil.loggerInfo("CourseApproval: approveOutlineX - notified distribution",campus,user,alpha,num);
							logger.info("CourseApproval - approveOutlineX - emailNotifiedWhenApproved");
						}
					}
					else{
						/*
							at some point in time, it will be hard to determine who gets mail based on division,
							department. Also, when delegates are involved for some senior folks, it gets messy
							because of who has to do the approval.

							Here, we combine the next approver and delegate to send mail in normal flow.
							However, for instances where we can't determine (DEANs), we have to collect
							all of them and their delegates, combine them and send them out.
						*/

						approver = ApproverDB.getNextPersonToApprove(connection,campus,alpha,num);
						nextApprover = approver.getApprover();
						delegated = approver.getDelegated();

						approverSequence = ApproverDB.getApproverSequence(connection,nextApprover);

						// when more than one person at this level, present list for selection
						if (ApproverDB.getApproverCount(connection,campus,approverSequence)>1){
							forwardURL = true;
							msg.setCode(4);
							msg.setMsg("forwardURL");
						}
						else{
							forwardURL = false;

							if (!"".equals(delegated))
								nextApprover = nextApprover + "," + delegated;

							tasks = nextApprover.split(",");
							for (z=0;z<tasks.length;z++){
								rowsAffected = TaskDB.logTask(connection,tasks[z],tasks[z],alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
								logger.info("CourseApproval - approveOutlineX - delete approver task - rowsAffected " + rowsAffected);

								rowsAffected = TaskDB.logTask(connection,tasks[z],proposer,alpha,num,"Approve outline",campus,"crsedt.jsp","ADD",type);
								logger.info("CourseDB - setCourseForApproval - approval task created - rowsAffected " + rowsAffected);

								if (toNames.length()==0)
									toNames = tasks[z];
								else
									toNames = toNames + "," + tasks[z];
							}

							sender = proposer + domain;
							mailerDB = new MailerDB(connection,sender,toNames,"","",alpha,num,campus,"emailOutlineApprovalRequest");
							logger.info("CourseDB - setCourseForApproval - mail sent - " + nextApprover);
						}
					} // last getLastApprover

					/*
					 * remove task for this user
					 *
					 * If the last person in line to approve, move the approved
					 * to the appropriate table and notify author of completion
					 *
					 */
					if (msg.getCode() != ERROR_CODE && (forwardURL==false)){
						rowsAffected = TaskDB.logTask(connection,user,user,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
						logger.info("CourseApproval - approveOutlineX - tasked remove (" + user + ") - rowsAffected " + rowsAffected);

						// remove/add tasks depending on approver or delegate; either way, must remove
						// approver or delegate
						delegated = ApproverDB.getDelegateByApproverName(connection,campus,user);
						if (!"".equals(delegated)){
							rowsAffected = TaskDB.logTask(connection,proposer,delegated,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
							logger.info("CourseApproval - approveOutlineX - delete approver task (" + delegated + ") rowsAffected " + rowsAffected);
						}
						else{
							delegated = ApproverDB.getApproverByDelegateName(connection,campus,user);
							if (!"".equals(delegated)){
								rowsAffected = TaskDB.logTask(connection,proposer,delegated,alpha,num,"Approve outline",campus,"crsappr.jsp","REMOVE",type);
								logger.info("CourseApproval - approveOutlineX - delete approver task (" + delegated + ") rowsAffected " + rowsAffected);
							}
						}
					}

				} // else !approval

				// remove task where approve or reject since we have to start
				// over again.
				logger.info(kix + " - CourseApproval: approveOutlineX - " + campus + " - " + user);
			} else {
				rowsAffected = approverSequence;
			} // approverSequence > 0
		} catch (SQLException se) {
			msg.setMsg("Exception");
			logger.fatal("CourseApproval: approveOutlineX\n" + se.toString());
		} catch (Exception e) {
			msg.setMsg("Exception");
			logger.fatal("CourseApproval: approveOutlineX\n" + e.toString());
		}

		logger.info(kix + " - " + user + " - CourseApproval: approveOutlineX - ENDS");

		return msg;
	}

	public String drawHTMLFieldX(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											String campus,
											boolean required) {

Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String[] selectedValue;
		String[] selectedName;
		String[] iniValues;
		String[] inputValues;
		String[] userValue;
		String selected = "";
		String sql;
		String HTMLType = "";
		String tempFieldName = "";
		String junk = "";
		String thisValue = "";
		String originalValue = fieldValue;
		String requiredInput = "input";

		if (required)
			requiredInput = "inputRequired";

		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();

		boolean found = false;

		int numberOfControls = 0;
		int i;
		int selectedIndex = 0;

		try {
		AseUtil aseUtil = new AseUtil();

			if ("check".equals(fieldType)) {

				fieldType = "checkbox";

				/*
				 * get the string pointed to by fieldRef. If it contains SELECT
				 * check box data comes from some table. If not, it's a CSV.
				 * this is done to help determine the layout for check and radio
				 * buttons
				 */

				if (!"".equals(campus))
					junk = 	"campus = " + aseUtil.toSQL(campus, 1) +
								"AND kid = " + aseUtil.toSQL(fieldRef, 1);
				else
					junk = "kid = " + aseUtil.toSQL(fieldRef, 1);

				iniValues = aseUtil.lookUpX(conn, "tblINI", "kval1,kval2", junk);

System.out.println("iniValues[0]: " + iniValues[0]);
System.out.println("iniValues[1]: " + iniValues[1]);

				if (iniValues[0].indexOf("SELECT") >= 0) {
					java.sql.Statement stmt = conn.createStatement();
					java.sql.ResultSet rs = aseUtil.openRecordSet(stmt, iniValues[0]);
					i = 0;
					while (rs.next()) {
						if (i > 0) {
							s1.append("~");
							s2.append("~");
						}
						s1.append(rs.getString(1));
						s2.append(rs.getString(2));
						i = 1;
					}
					rs.close();
					stmt.close();
					selectedValue = s1.toString().split("~");
					selectedName = s2.toString().split("~");
				} else {
					selectedValue = iniValues[0].split("~");
					selectedName = iniValues[1].split("~");
				}

				/*
				 * for radios, there's only 1 control to work with; for checks
				 * there should be as many controls as the loop above this is
				 * explained down below.
				 */
				numberOfControls = selectedName.length;
				inputValues = fieldValue.split(",");

				/*
					make the list of available items and list of user selected items
					the same in length.
				*/
				if (inputValues.length < numberOfControls) {
					for (i=inputValues.length; i<numberOfControls; i++) {
						fieldValue += ",0";
					}
				}

				userValue = fieldValue.split(",");

				/*
				 * print the controls and their values
				 * checkboxes can have different names for controls, but
				 * radios must all share 1 single name.
				 */

				temp.append("");

				for (i=0; i<numberOfControls; i++) {
					selected = "";
					selectedIndex = 0;
					found = false;
					while (!found && selectedIndex < numberOfControls){
						if (selectedName[i].equals(userValue[selectedIndex++])){
							selected = "checked";
							found = true;
						}
					}

					tempFieldName = fieldName + "_" + i;

					temp.append("<input type=\'" + fieldType
							+ "\' value=\'" + selectedName[i] + "\' name=\'"
							+ tempFieldName + "\'" + " " + selected + ">&nbsp;" + selectedValue[i]);

					temp.append("<br>");
				} // for

				/*
				 * form data collection expects at least a field call
				 * 'questions'. when dealing with radios and checks, questions
				 * does not exists since the field are either named with similar
				 * names or created as multiple selections (must be unique).
				 * this hidden field makes it easy to ignore the calendar or
				 * form error
				 */
				temp.append("<input type=\'hidden\' value=\'\' name=\'questions\'>");
				temp.append("<input type=\'hidden\' value=\'" + numberOfControls + "\' name=\'numberOfControls\'>");
			} else if ("radio".equals(fieldType)) {

				/*
					see check box logic for explanation on what's happening here
				*/
				junk = "kid = " + aseUtil.toSQL(fieldRef, 1);
				iniValues = aseUtil.lookUpX(conn, "tblINI", "kval1,kval2", junk);

				if (iniValues[0].indexOf("SELECT") >= 0) {
					java.sql.Statement stmt = conn.createStatement();
					java.sql.ResultSet rs = aseUtil.openRecordSet(stmt, iniValues[0]);
					i = 0;
					while (rs.next()) {
						if (i > 0) {
							s1.append(",");
							s2.append(",");
						}
						s1.append(rs.getString(1));
						s2.append(rs.getString(2));
						i = 1;
					}
					rs.close();
					stmt.close();
					selectedValue = s1.toString().split(",");
					selectedName = s2.toString().split(",");
				} else {
					selectedValue = iniValues[0].split(",");
					selectedName = iniValues[1].split(",");
				}

				/*
				 * some known values for CC
				 */
				if ("YESNO".equals(fieldRef)) {
					fieldValue = "1,0";
				} else if ("YN".equals(fieldRef)) {
					fieldValue = "Y,N";
				} else if ("UserStatus".equals(fieldRef)) {
					fieldValue = "1,0";
				} else if ("CourseStatus".equals(fieldRef)) {
					fieldValue = "1,0";
				}

				userValue = fieldValue.split(",");

				/*
				 * print the controls and their values
				 */
				inputValues = fieldValue.split(",");
				temp.append("");

				for (i = 0; i < inputValues.length; i++) {
					selected = "";

					if (userValue[i].equals(originalValue)){
						selected = "checked";
					}

					tempFieldName = fieldName + "_0";
					thisValue = inputValues[i];

					temp.append("<input type=\'" + fieldType
							+ "\' value=\'" + selectedName[i] + "\' name=\'"
							+ tempFieldName + "\'" + " " + selected + ">&nbsp;" + selectedValue[i]);

					temp.append("&nbsp;&nbsp;");

				} // for

				numberOfControls = 1;

				temp.append("<input type=\'hidden\' value=\'\' name=\'questions\'>");
				temp.append("<input type=\'hidden\' value=\'" + numberOfControls + "\' name=\'numberOfControls\'>");
			} else if ("date".equals(fieldType)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				java.util.Date date = sdf.parse(fieldValue);
				java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
				SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy",Locale.getDefault());
				fieldValue = formatter.format(ts);
				temp.append("<input type=\'Text\' size=\'10\' maxlength=\'10\' class=\'" + requiredInput + "\' name=\'questions\' value=\'" + fieldValue + "\'>");
				temp.append("&nbsp;<a href=\"javascript:calendar.popup();\"><img src=\'img/cal.gif\' width=\'16\' height=\'16\' border=\'0\' alt=\'Click Here to Pick up the date\'></a>");

			} else if ("listbox".equals(fieldType)) {
				sql = aseUtil.lookUp(conn, "tblINI", "kval1", "kid = " + aseUtil.toSQL(fieldRef, 1));
				temp.append(aseUtil.createSelectionBox(conn,sql,fieldName,fieldValue,required));
			} else if ("text".equals(fieldType)) {
				temp.append("<input size=\'" + fieldLen + "\' maxlength=\'"
						+ fieldMax
						+ "\' type=\'text\' class=\'" + requiredInput + "\' value=\'"
						+ fieldValue + "\' name=\'" + fieldName + "\'>");
			} else if ("textarea".equals(fieldType)) {
				temp.append("<textarea cols=\'" + fieldLen + "\' rows=\'"
						+ fieldMax + "\' class=\'" + requiredInput + "\' name=\'" + fieldName
						+ "\'>" + fieldValue + "</textarea>");
			} else if ("wysiwyg".equals(fieldType)) {
				temp.append("<textarea class=\'" + requiredInput + "\' id=\'" + fieldName
						+ "\' name=\'" + fieldName + "\'>" + fieldValue
						+ "</textarea>" + "<script language=\'javascript1.2\'>"
						+ "generate_wysiwyg(\'" + fieldName + "\');"
						+ "</script>");
			}

		} catch (Exception pe) {
			temp.append(pe.toString());
		}

		return temp.toString();
	}

	public static String showAssessmentsToCancel(Connection conn,
																String campus,
																String user,
																String caller){

Logger logger = Logger.getLogger("test");

		StringBuffer listing = new StringBuffer();
		String alpha = "";
		String num = "";
		String title = "";
		String progress = "";
		String kix = "";
		String link = "";
		boolean found = false;

		try{
			/*
				get all outlines in proposed status. for each found, make sure there isn't a matching
				outline under slo review.
			*/
			AseUtil aseUtil = new AseUtil();
			String sql = "SELECT historyid,CourseAlpha,CourseNum,coursetitle,progress " +
				"FROM vw_SLOByProgress_2 " +
				"WHERE Campus=? AND " +
				"progress=? AND " +
				"proposer=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,"ASSESSED");
			ResultSet rs = ps.executeQuery();
			while ( rs.next() ){
				alpha = aseUtil.nullToBlank(rs.getString("coursealpha")).trim();
				num = aseUtil.nullToBlank(rs.getString("coursenum")).trim();
				title = aseUtil.nullToBlank(rs.getString("coursetitle")).trim();
				progress = aseUtil.nullToBlank(rs.getString("progress")).trim();
				kix = aseUtil.nullToBlank(rs.getString("historyid")).trim();
				link = caller + ".jsp?kix=" + kix;
				listing.append("<li><a href=\"" + link + "\" class=\"linkcolumn\">" + alpha + " " + num + " - " + title + "</a></li>");
				found = true;
			}
			rs.close();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("Helper: showAssessmentsToCancel\n" + ex.toString());
			listing.setLength(0);
		}

		if (found)
			return "<ul>" + listing.toString() + "</ul>";
		else
			return "Outline does not exist for this request";
	}

	public static String Testing(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		String sql = "";
		String alpha = "";
		String num = "";
		String kix = "";
		int rowsAffected = 0;
		int compid = 0;

		try {
			System.out.println("---------------------------------");

			// clear before starting
			sql = "UPDATE tblSLO SET hid='' ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting slo kix (" + rowsAffected + ")");

			// clear before starting
			sql = "UPDATE tblCourseComp SET historyid='' ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting comp kix (" + rowsAffected + ")");

			// clear before starting
			sql = "UPDATE tblCourseACCJC SET historyid='',compid=0 ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting accjc kix (" + rowsAffected + ")");

			// clear before starting
			sql = "UPDATE tblAssessedData SET accjcid=0 ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting assess kix (" + rowsAffected + ")");

			sql = "SELECT * "
				+ "FROM tblSLO "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				kix = Helper.getKix(conn,"LEE",alpha,num,"CUR");

				// update tblSLO with correct kix from tblCourse with kix
				sql = "UPDATE tblSLO "
					+ "SET hid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setString(1,kix);
				ps1.setString(2,alpha);
				ps1.setString(3,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				// update tblCourseComp with correct kix from tblCourse with kix
				sql = "UPDATE tblCourseComp "
					+ "SET historyid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setString(1,kix);
				ps1.setString(2,alpha);
				ps1.setString(3,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				System.out.println(alpha + " " + num + " " + kix);

				// get compid from coursecomp
				// update accjc with compid and historyid
				// get id from accjc for use with assessdata accjc id
			}
			rs.close();
			ps.close();

			sql = "SELECT historyid,compid,coursealpha,coursenum "
				+ "FROM tblCourseComp "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				kix = rs.getString("historyid");
				compid = rs.getInt("compid");

				// update accjc with compid and historyid
				sql = "UPDATE tblCourseACCJC "
					+ "SET historyid=?, compid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setString(1,kix);
				ps1.setInt(2,compid);
				ps1.setString(3,alpha);
				ps1.setString(4,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				System.out.println(alpha + " " + num + " " + kix + " " + compid);
			}
			rs.close();
			ps.close();

			// get id from accjc for use with assessdata accjc id
			sql = "SELECT id,coursealpha,coursenum "
				+ "FROM tblCourseACCJC "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				compid = rs.getInt("id");

				// update accjc with compid and historyid
				sql = "UPDATE tblAssessedData "
					+ "SET accjcid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setInt(1,compid);
				ps1.setString(2,alpha);
				ps1.setString(3,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				System.out.println(alpha + " " + num + " " + kix + " " + compid);
			}
			rs.close();
			ps.close();

			System.out.println("---------------------------------");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}

	/*
	 * getContentAsHTMLList - Identical to getComps except returning string with
	 * HTML table for display
	 *	<p>
	 * @param	Connection	connection
	 * @param	String		alpha
	 * @param	String		num
	 * @param	String		campus
	 * @param	String		type
	 * @param	String		hid
	 * @param	boolean		detail
	 * @param	boolean		includeAssessment
	 *	<p>
	 * @return String
	 */
	public static String getContentAsHTMLList(Connection connection,
															String alpha,
															String num,
															String campus,
															String type,
															String hid,
															boolean detail,
															boolean includeAssessment) throws Exception {

Logger logger = Logger.getLogger("test");

		/*
			run through all content and get slo. get all slo with assessments.
			resulting structure is

			<ul>
				<li>content
					<ul>
						<li>slo 1
							<ul>
								<li>assessment 1<li>
								<li>assessment 2<li>
								<li>assessment <li>
							</ul>
						</li>
						<li>slo 2
							<ul>
								<li>assessment 1<li>
								<li>assessment 2<li>
								<li>assessment <li>
							</ul>
						</li>
					</ul>
				</li>
			<ul>
		*/

		String sqlContent = "";
		String sqlSLO = "";
		String sqlAssess = "";

		StringBuffer contents = new StringBuffer();
		StringBuffer SLO = new StringBuffer();
		StringBuffer assess = new StringBuffer();

		boolean found = false;
		boolean foundDetail = false;
		boolean foundAssess = false;

		PreparedStatement ps = null;
		PreparedStatement stmtSLO = null;
		PreparedStatement stmtAssess = null;

		ResultSet rsSLO = null;
		ResultSet rsAssess = null;

		String temp = "";

		sqlAssess = "SELECT assessment "
			+ "FROM vw_slo2assessment "
			+ "WHERE historyid=? AND compid=?";

		sqlSLO = "SELECT tc.Comp,tc.CompID "
			+ "FROM tblCourseContentSLO ts, tblCourseComp tc "
			+ "WHERE ts.historyid=tc.historyid AND "
			+ "ts.historyid=? AND "
			+ "ts.sloid=tc.CompID AND "
			+ "ts.contentid=?";

		sqlContent = "SELECT ContentID, LongContent "
			+ "FROM tblCourseContent "
			+ "WHERE historyid=?";

		try {
			ps = connection.prepareStatement(sqlContent);
			ps.setString(1,hid);
			ResultSet resultSet = ps.executeQuery();
			while (resultSet.next()) {
				found = true;
				contents.append("<li class=\"dataColumn\">" + resultSet.getString(2));

				if (detail){
					SLO.setLength(0);
					foundDetail = false;

					stmtSLO = connection.prepareStatement(sqlSLO);
					stmtSLO.setString(1,hid);
					stmtSLO.setInt(2,resultSet.getInt(1));
					rsSLO = stmtSLO.executeQuery();
					while (rsSLO.next()){
						foundDetail = true;
						SLO.append("<li class=\"dataColumn\">" + rsSLO.getString(1));

						if (includeAssessment){
							assess.setLength(0);
							foundAssess = false;

							stmtAssess = connection.prepareStatement(sqlAssess);
							stmtAssess.setString(1,hid);
							stmtAssess.setInt(2,rsSLO.getInt(2));
							rsAssess = stmtAssess.executeQuery();
							while (rsAssess.next()){
								foundAssess = true;
								assess.append("<li class=\"dataColumn\">" + rsAssess.getString(1) + "</li>");
							}

							rsAssess.close();
							stmtAssess.close();

							if (foundAssess){
								SLO.append("<ul>");
								SLO.append(assess.toString());
								SLO.append("</ul>");
							}
						} // includeAssessment

						SLO.append("</li>");
					}	// while rsSLO

					rsSLO.close();
					stmtSLO.close();

					if (foundDetail){
						contents.append("<ul>");
						contents.append(SLO.toString());
						contents.append("</ul>");
					}

					contents.append("</li>");

				} // detail
			} // while

			resultSet.close();
			ps.close();

			if (found){
				temp = "<table border=\"0\" width=\"98%\">" +
					"<tr><td>&nbsp;</td></tr>" +
					"<tr><td><ul>" +
					contents.toString() +
					"</ul></td></tr></table>";
			}

		} catch (Exception e) {
			logger.fatal("ContentDB: getContentAsHTMLList\n" + e.toString());
		}

		return temp;
	}

%>
