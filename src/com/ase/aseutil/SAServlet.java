/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved.
 * You may not modify, use, reproduce, or distribute this software except
 * in compliance with the terms of the License made with Applied Software Engineering
 * @author ttgiang
 *
 * private int createUserTask(HttpSession session,HttpServletRequest request,String action) {
 * public static int fillCCCMCampus(Connection conn,String campus){
 * public static int fillCCCMCourse(Connection conn,String campus){
 * private int fillMissingItems(HttpSession session){
 *
 */

package com.ase.aseutil;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class SAServlet extends HttpServlet {

	private static final long serialVersionUID = 12L;
	static Logger logger = Logger.getLogger(SAServlet.class.getName());
	WebSite website;

	private AsePool connectionPool;

	/**
	 * init
	 */
	public void init() throws ServletException {
		connectionPool = AsePool.getInstance();
	}

	/**
	 * destroy
	 */
	public void destroy() {
		connectionPool.destroy();
	}

	/**
	 * doGet
	 * <p>
	 * @param	request	HttpServletRequest
	 * @param	response	HttpServletResponse
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		website = new WebSite();

		String url = "/core/index.jsp";
		int rowsAffected = -1;

		String parm1 = website.getRequestParameter(request,"c");
		String parm2 = website.getRequestParameter(request,"l");

		if (!parm1.equals(Constant.BLANK)){
			if (parm1.equals("cccm")){
				rowsAffected = resetCourseQuestionsToCCCM(session);
				rowsAffected = resetCampusQuestionsToCCCM(session);
			}
			else if (parm1.equals("ctsk")){
				rowsAffected = createUserTask(session,request,"ADD");
			}
			else if (parm1.equals("dlthst")){
				rowsAffected = deleteHistory(session,request);
			}
			else if (parm1.equals("dtsk")){
				rowsAffected = createUserTask(session,request,"REMOVE");
			}
			else if (parm1.equals("fill")){
				rowsAffected = fillMissingItems(session);
			}
			else if (parm1.equals("lgs")){
				rowsAffected = writeLogFile(session,request,response,parm2);
			}
			else if (parm1.equals("props")){
				rowsAffected = readProps(session);
			}
			else if (parm1.equals("rclhst")){
				rowsAffected = recallApproval(session,request);
			}
			else if (parm1.equals("sync")){
				rowsAffected = syncCampusINI(session);
			}

			if (rowsAffected > -1){
				url = response.encodeURL("/core/samsg.jsp?c="+parm1);
			}
		}

		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	/**
	 * fillMissingItems
	 * <p>
	 * @param	session	HttpSession
	 * <p>
	 * @return	int
	 */
	private int fillMissingItems(HttpSession session){

		String sql = "";
		String campus = "";
		int rowsAffected = 0;

		Connection conn = connectionPool.getConnection();

		StringBuffer buf = new StringBuffer();

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "SELECT campus FROM tblCampus WHERE campus>'' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				campus = rs.getString(1);
				buf.append("Course data for : " + campus + " - " + fillCCCMCourse(conn,campus) + "<br/>");
				buf.append("Campus data for: " + campus + " - " + fillCCCMCampus(conn,campus) + "<br/>");
				buf.append("Program data for: " + campus + " - " + fillCCCMPrograms(conn,campus) + "<br/><br/>");
			}
			rs.close();
			ps.close();

			IniDB.addSystemSettings(conn);

			session.setAttribute("aseApplicationMessage", buf.toString());
		}
		catch(Exception ex){
			logger.fatal("SAServlet: fillMissingItems - " + ex.toString());
			rowsAffected = -1;
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/**
	 * fillCCCMCourse
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int fillCCCMCourse(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		int rowsAffected = 0;
		boolean found = false;

		try{
			/*
				insert into course question any question from CCCM6100 that is not already there

				campus='SYS' and type='Course'
			*/
			sql = "INSERT INTO tblCourseQuestions(campus,type,questionnumber,questionseq,question,include,comments,change,help,auditby) "
				+ "SELECT '" + campus + "' AS campus,  "
				+ "'Course' AS type,  "
				+ "CCCM6100.Question_Number,  "
				+ "0 AS questionseq,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'N' AS include,  "
				+ "'Y' AS comments,  "
				+ "'N' AS change,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'"+Constant.SYSADM_NAME+"' AS auditby "
				+ "FROM CCCM6100 "
				+ "WHERE campus='SYS' "
				+ "AND type='Course' "
				+ "AND (((CCCM6100.Question_Number) Not In (SELECT questionnumber "
				+ "FROM tblCourseQuestions "
				+ "WHERE campus=?)))";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("SAServlet: fillCCCMCourse - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * fillCCCMPrograms
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int fillCCCMPrograms(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		String sql = "";
		int rowsAffected = 0;
		boolean found = false;

		try{
			/*
				insert into course question any question from CCCM6100 that is not already there

				campus='SYS' and type='Program'
			*/
			sql = "INSERT INTO tblProgramQuestions(campus,type,questionnumber,questionseq,question,include,comments,change,help,auditby) "
				+ "SELECT '" + campus + "' AS campus,  "
				+ "'Program' AS type,  "
				+ "CCCM6100.Question_Number,  "
				+ "0 AS questionseq,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'N' AS include,  "
				+ "'Y' AS comments,  "
				+ "'N' AS change,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'"+Constant.SYSADM_NAME+"' AS auditby "
				+ "FROM CCCM6100 "
				+ "WHERE campus='SYS' "
				+ "AND type='Program' "
				+ "AND (((CCCM6100.Question_Number) Not In (SELECT questionnumber "
				+ "FROM tblProgramQuestions "
				+ "WHERE campus=?)))";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("SAServlet: fillCCCMPrograms - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * fillCCCMCampus
	 * <p>
	 * @param	conn		Connection
	 * @param	campus	String
	 * <p>
	 * @return	int
	 */
	public static int fillCCCMCampus(Connection conn,String campus){

		//Logger logger = Logger.getLogger("test");

		/*
			campus questions are created by TTG campus and inserted accordingly
		*/

		String sql = "";
		int rowsAffected = 0;
		boolean found = false;

		try{
			AseUtil aseUtil = new AseUtil();
			sql = "INSERT INTO tblCampusQuestions (campus,type,questionnumber,questionseq,question,include,comments,change,help,auditby) "
				+ "SELECT '" + campus + "' AS campus,  "
				+ "'Campus' AS type,  "
				+ "CCCM6100.Question_Number,  "
				+ "0 AS questionseq,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'N' AS include,  "
				+ "'Y' AS comments,  "
				+ "'N' AS change,  "
				+ "CCCM6100.CCCM6100,  "
				+ "'"+Constant.SYSADM_NAME+"' AS auditby "
				+ "FROM CCCM6100 "
				+ "WHERE campus='TTG' AND CCCM6100.Question_Number Not In (SELECT questionnumber "
				+ "FROM tblCampusQuestions "
				+ "WHERE campus=?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();

			sql = "INSERT INTO cccm6100 (Campus,Type,Question_Number,CCCM6100,Question_Friendly,Question_Len,Question_Max,Question_Type,Question_Ini,Question_Explain) "
				+ "SELECT '" + campus + "' AS campus, "
				+ "'Campus' AS type, "
				+ "CCCM6100.Question_Number, "
				+ "CCCM6100.CCCM6100, "
				+ "CCCM6100.Question_Friendly, "
				+ "0 AS Question_Len, "
				+ "0 AS Question_Max, "
				+ "'wysiwyg' AS Question_Type, "
				+ "'' AS Question_Ini, "
				+ "'' AS Question_Explain "
				+ "FROM CCCM6100 "
				+ "WHERE campus='TTG' AND CCCM6100.Question_Number Not In (SELECT question_number "
				+ "FROM CCCM6100 "
				+ "WHERE campus=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			rowsAffected = ps.executeUpdate();
			ps.close();
		}
		catch(Exception ex){
			logger.fatal("SAServlet: fillCCCMCampus - " + ex.toString());
		}

		return rowsAffected;
	}

	/**
	 * createUserTask
	 * <p>
	 * @param	session	HttpSession
	 * @param	request	HttpServletRequest
	 * @param	action	String
	 * <p>
	 * @return	int
	 */
	private int createUserTask(HttpSession session,HttpServletRequest request,String action) {

		//Logger logger = Logger.getLogger("test");

		String alpha = "";
		String num = "";
		String type = "";
		String proposer = "";
		String campus = "";
		int rowsAffected = 0;

		Connection conn = connectionPool.getConnection();

		try{
			String usr = website.getRequestParameter(request,"usr");
			String kix = website.getRequestParameter(request,"kix");
			if (!"".equals(kix)){
				String[] info = Helper.getKixInfo(conn,kix);
				alpha = info[0];
				num = info[1];
				type = info[2];
				proposer = info[3];
				campus = info[4];
			}

			if ("ADD".equals(action))
				rowsAffected = TaskDB.logTask(conn,usr.toUpperCase(),proposer,alpha,num,"Approve outline",campus,"",action,type);
			else
				rowsAffected = TaskDB.logTask(conn,usr.toUpperCase(),usr.toUpperCase(),alpha,num,"Approve outline",campus,"",action,type);
		}
		catch(Exception ex){
			logger.fatal("SAServlet: createUserTask - " + ex.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/*
	 * resetCourseQuestionsToCCCM - reset unused course questions (include=N) to the text from CCCM6100
	 */
	public int resetCourseQuestionsToCCCM(HttpSession session) {

		int rowsAffected = 0;
		Connection conn = connectionPool.getConnection();

		try{
			int qn = 0;
			String sql = "SELECT DISTINCT questionnumber FROM tblCourseQuestions "
				+ "WHERE type='Course' AND include='N' ORDER BY questionnumber";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				qn = rs.getInt("questionnumber");
				CCCM6100 cm = CCCM6100DB.getCCCM6100ByQuestionNumber(conn,qn);
				sql = "UPDATE tblCourseQuestions SET question=?,help=? "
					+ "WHERE type='Course' AND include='N' AND questionnumber=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,cm.getCCCM6100());
				ps2.setString(2,cm.getCCCM6100());
				ps2.setInt(3,qn);
				rowsAffected = ps2.executeUpdate();
				ps2.close();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("SAServlet: resetCourseQuestionsToCCCM - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/*
	 * resetCampusQuestionsToCCCM - reset unused campus questions (include=N) to the text from CCCM6100
	 */
	public int resetCampusQuestionsToCCCM(HttpSession session) {

		int rowsAffected = 0;

		Connection conn = connectionPool.getConnection();

		try{
			int qn = 0;
			String sql = "SELECT DISTINCT questionnumber FROM tblCampusQuestions "
				+ "WHERE type='Campus' AND include='N' and question not like 'Do Not%' ORDER BY questionnumber";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				qn = rs.getInt("questionnumber");
				CCCM6100 cm = CCCM6100DB.getCCCM6100ByQuestionNumber(conn,qn);
				sql = "UPDATE tblCampusQuestions SET question=?,help=? "
					+ "WHERE type='Campus' AND include='N' AND questionnumber=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,cm.getCCCM6100());
				ps2.setString(2,cm.getCCCM6100());
				ps2.setInt(3,qn);
				rowsAffected = ps2.executeUpdate();
				ps2.close();
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("SAServlet: resetCourseQuestionsToCCCM - " + e.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/**
	 * deleteHistory
	 * <p>
	 * @param	session	HttpSession
	 * @param	request	HttpServletRequest
	 * <p>
	 * @return	int
	 */
	private int deleteHistory(HttpSession session,HttpServletRequest request) {

		int rowsAffected = 0;
		Connection conn = connectionPool.getConnection();

		try{
			String kix = website.getRequestParameter(request,"kix","");
			int id = website.getRequestParameter(request,"id",0);
			rowsAffected = HistoryDB.deleteHistory(conn,kix,id);
		}
		catch(Exception ex){
			logger.fatal("SAServlet: deleteHistory - " + ex.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/**
	 * recallHistory
	 * <p>
	 * @param	session	HttpSession
	 * @param	request	HttpServletRequest
	 * <p>
	 * @return	int
	 */
	private int recallApproval(HttpSession session,HttpServletRequest request) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int i = 0;
		int tempID = 0;

		String approver = "";
		String approvers = "";
		String comments = "";
		String user = "";
		String savedApprover = "";

		PreparedStatement ps2 = null;

		boolean debug = false;

		Connection conn = null;

		try{
			conn = connectionPool.getConnection();

			user = Encrypter.decrypter((String)session.getAttribute("aseUserName"));

			WebSite website = new WebSite();
			String kix = website.getRequestParameter(request,"kix","");
			int id = website.getRequestParameter(request,"id",0);

			String[] info = Helper.getKixInfo(conn,kix);
			String alpha = info[Constant.KIX_ALPHA];
			String num = info[Constant.KIX_NUM];
			String campus = info[Constant.KIX_CAMPUS];
			String proposer = info[Constant.KIX_PROPOSER];
			int route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

			if (debug){
				logger.info("campus: " + campus);
				logger.info("user: " + user);
				logger.info("alpha: " + alpha);
				logger.info("num: " + num);
				logger.info("proposer: " + proposer);
				logger.info("route: " + route);
				logger.info("kix: " + kix);
				logger.info("id: " + id);
			}

			// 1. loop through and update all history from the name selected to the last approver
			// 2. remove the task from the current approver and reassign to the approver with the recall
			//		send mail to those in the recall that recall took place as well as task remove/add

			// 1.

			String sql = "SELECT th.id, th.approver, th.comments "
							+ "FROM tblApprovalHist th INNER JOIN "
							+ "tblApprover ta ON th.campus = ta.campus AND th.approver = ta.approver "
							+ "WHERE th.historyid=? AND th.id >=? AND ta.route=? ORDER BY th.id ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,id);
			ps.setInt(3,route);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				comments = AseUtil.nullToBlank(rs.getString("comments"));
				approver = AseUtil.nullToBlank(rs.getString("approver"));
				tempID = rs.getInt("id");

				if (i==0){
					approvers = approver;
					savedApprover = approver;
				}
				else
					approvers += "," + approver;

				++i;

				comments = "Recalled on "
					+ AseUtil.getCurrentDateTimeString()
					+ " by "
					+ user
					+ "<br/>"
					+ comments;

				sql = "UPDATE tblApprovalHist SET approved=0,comments=?,progress=? WHERE historyid=? AND id=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,comments);
				ps2.setString(2,Constant.COURSE_RECALLED);
				ps2.setString(3,kix);
				ps2.setInt(4,tempID);
				rowsAffected = ps2.executeUpdate();
				ps2.close();

				AseUtil.logAction(conn, user, "ACTION","Approval recalled for " + approver + " ",alpha,num,campus,kix);
			}
			rs.close();
			ps.close();

			// 2.
			if (approvers != null && approvers.length() > 0){

				MailerDB mailerDB = null;

				// approver with outline approval task
				approver = TaskDB.getSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT);

				approvers += "," + approver;

				// notify approvers of recall
				mailerDB = new MailerDB(conn,
												proposer,
												approvers,
												proposer,
												"",
												alpha,
												num,
												campus,
												"emailOutlineRecalledApproval",
												kix,
												user);


				rowsAffected = TaskDB.replaceSubmittedForByTaskMessage(conn,campus,alpha,num,Constant.APPROVAL_TEXT,approver,savedApprover);
				// send mail for task addition
				mailerDB = new MailerDB(conn,
												proposer,
												user,
												"",
												"",
												alpha,
												num,
												campus,
												"emailOutlineApprovalRequest",
												kix,
												user);
			}
		}
		catch(Exception ex){
			logger.fatal("SAServlet: recallApproval - " + ex.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/**
	 * writeLogFile
	 */
	public static int writeLogFile(HttpSession session,
											HttpServletRequest request,
											HttpServletResponse response,
											String parm2) {

		//Logger logger = Logger.getLogger("test");

		int rowsAffected = -1;

		try {

			AseUtil ae = new AseUtil();

			if (ae.checkSecurityLevel(ae.SYSADM,session,response,request).equals("")){


				// log files are in form of ccv2.log, ccv2.log.1, .2, etc.
				// if we have a parm2 value, then add that to the file name
				String logFile = "";

				if (parm2 == null || parm2.length() == 0)
					logFile = "";
				else
					logFile = "." + parm2;

				// use buffering, reading one line at a time
				// FileReader always assumes default encoding is OK!
				// TODO file mapping and getting course data below (asepool as well)

				String currentDrive = AseUtil.getCurrentDrive();
				File aFile = new File(currentDrive + ":\\tomcat\\webapps\\centraldocs\\logs\\ccv2.log"+logFile);
				BufferedReader input = new BufferedReader(new FileReader(aFile));

				FileWriter fstream = new FileWriter(currentDrive + ":\\tomcat\\webapps\\centraldocs\\core\\zccv2.jsp");
				BufferedWriter output = new BufferedWriter(fstream);

				try {
					String line = null; // not declared within while loop
					/*
					 * readLine is a bit quirky : it returns the content of a line
					 * MINUS the newline. it returns null only for the END of the
					 * stream. it returns an empty String if two newlines appear in
					 * a row.
					 */

					output.write("<html>\n");
					output.write("<head>\n");
					output.write("<title>Curriculum Central</title>\n");
					output.write("</head>\n");
					output.write("<body topmargin=\"0\" leftmargin=\"0\">\n");
					output.write("<pre>\n");

					while ((line = input.readLine()) != null) {
						output.write(line+"\n");
					}

					output.write("</pre>\n");
					output.write("</body>\n");
					output.write("</html>\n");

				} finally {
					input.close();
					output.close();
				}

				rowsAffected = 1;
			}

		} catch (IOException ex) {
			logger.fatal("SAServlet IOException: writeSyllabus - " + ex.toString());
		} catch (Exception e) {
			logger.fatal("SAServlet Exception: writeSyllabus - " + e.toString());
		}

		return rowsAffected;
	}

	/**
	 * syncCampusINI
	 * <p>
	 * @param	session	HttpSession
	 * <p>
	 * @return	int
	 */
	private int syncCampusINI(HttpSession session){

		// reads through the number of campuses and create missing INI settings

		int rowsAffected = 0;

		Connection conn = connectionPool.getConnection();

		StringBuffer buf = new StringBuffer();

		try{
			String campuses = CampusDB.getCampusNames(conn);
			String[] aCampuses = campuses.split(",");

			for(int x=0; x<aCampuses.length; x++){
				rowsAffected = IniDB.createMissingSettingForCampus(conn,aCampuses[x],"SYSADM");
				buf.append("Appended " + rowsAffected + " for " + aCampuses[x] + Html.BR());
			}

			session.setAttribute("aseApplicationMessage", buf.toString());
		}
		catch(Exception ex){
			logger.fatal("SAServlet: syncCampusINI - " + ex.toString());
			rowsAffected = -1;
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/**
	 * readProps
	 * <p>
	 * @param	session	HttpSession
	 * <p>
	 * @return	String
	 */
	private int readProps(HttpSession session){

		int rowsAffected = 0;

		Connection conn = connectionPool.getConnection();

		try{
			session.setAttribute("aseApplicationMessage", PropsDB.readProps(conn));
		}
		catch(Exception ex){
			logger.fatal("SAServlet: readProps - " + ex.toString());
		} finally {
			connectionPool.freeConnection(conn);
		}

		return rowsAffected;
	}

	/**
	 * doPost
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doGet(request, response);
	}
}

