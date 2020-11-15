<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.io.IOException"%>
<%@ page import="com.snowtide.pdf.OutputTarget"%>
<%@ page import="com.snowtide.pdf.PDFTextStream"%>

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
<%@ include file="../inc/header.jsp" %>

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

	String campus = "KAP";
	String alpha = "ACC";
	String num = "101";
	String type = "CUR";
	String user = "SPOPE";
	String task = "Modify_outline";
	String kix = "y24i27b1114";
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		try{

			createMessageBoard(session,conn,campus,user);

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	/*
	 * createMessageBoard
	 *	<p>
	 * @param	session	HttpSession
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int createMessageBoard(HttpSession session,Connection conn,String campus,String user){

		Logger logger = Logger.getLogger("ER00018");

		int conversion = 0;

		try{

			// before we create the board, clean up first
			cleanMessageBoard(conn,campus);

			// now create
			conversion = createMessageBoardX(conn,campus,user);

			if (conversion > 0){
				IniDB.setScript(conn,campus,"System","EnableMessageBoard");

				String kid = "EnableMessageBoard";
				String kval1 = "1";

				AseUtil.logAction(conn,user,"ACTION","System setting change ("+ kid + " is " + kval1 + ")","","",campus,"");

				HashMap sessionMap = (HashMap)session.getAttribute("aseSessionMap");

				if (sessionMap == null){
					sessionMap = new HashMap();
				}

				sessionMap.put(kid,new String(Encrypter.encrypter(kval1)));

				cleanHistory(conn,campus);

			}

		}
		catch(Exception e){
			logger.fatal("ER00018 - createMessageBoard: " + e.toString());
		}

		return conversion;

	}
	/*
	 * cleanHistory
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static void cleanHistory(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		// with a successful conversion, delete data from review and
		// approvals based on converted historyid

		try{
			String sql = "SELECT historyid FROM forums WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));

				sql = "DELETE FROM tblApprovalHist WHERE historyid=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.executeUpdate();
				ps2.close();

				sql = "DELETE FROM tblApprovalHist2 WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.executeUpdate();
				ps2.close();

				sql = "DELETE FROM tblReviewHist WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.executeUpdate();
				ps2.close();

				sql = "DELETE FROM tblReviewHist2 WHERE historyid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setString(1,kix);
				ps2.executeUpdate();
				ps2.close();

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ER00018 - cleanHistory: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ER00018 - cleanHistory: " + e.toString());
		}

	}

	/*
	 * cleanMessageBoard
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static void cleanMessageBoard(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int messages = 0;
		int messagesX = 0;
		int forumsx = 0;
		int forums = 0;

		try{
			String sql = "SELECT forum_id FROM forums WHERE campus=? AND (src='course' OR src='program')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				int id = rs.getInt("forum_id");

				sql = "DELETE FROM messages WHERE forum_id=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,id);
				messages += ps2.executeUpdate();
				ps2.close();

				sql = "DELETE FROM messagesX WHERE fid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,id);
				messagesX += ps2.executeUpdate();
				ps2.close();

				sql = "DELETE FROM forumsx WHERE fid=?";
				ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,id);
				forumsx += ps2.executeUpdate();
				ps2.close();
			}
			rs.close();
			ps.close();

			sql = "DELETE FROM forums WHERE campus=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			forums += ps.executeUpdate();
			ps.close();

		}
		catch(SQLException e){
			logger.fatal("ER00018 - cleanMessageBoard: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ER00018 - cleanMessageBoard: " + e.toString());
		}

	}

	/*
	 * createMessageBoardX
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static int createMessageBoardX(Connection conn,String campus,String user){

		Logger logger = Logger.getLogger("ER00018");

		int conversion = 0;
		int counter = 0;

		try{

			//
			// only process anything in review at this time.
			// we include tblReviewers in case no reviews completed yet
			//
			String sql = "SELECT DISTINCT historyid FROM tblReviewHist WHERE campus=? "
					+ "UNION "
					+ "SELECT DISTINCT historyid FROM tblReviewers WHERE campus=? "
					+ "UNION "
					+ "SELECT DISTINCT historyid FROM tblcourse WHERE campus=? AND (progress='REVIEW' OR subprogress='REVIEW_IN_APPROVAL')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,campus);
			ps.setString(3,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String historyid = rs.getString("historyid");
				//System.out.println((++counter) + ". " + historyid);
				createMessageBoardY(conn,historyid,campus,user);
			}
			rs.close();
			ps.close();

			conversion = 1;
		}
		catch(SQLException e){
			logger.fatal("ER00018 - createMessageBoardX: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ER00018 - createMessageBoardX: " + e.toString());
		}

		return conversion;

	}

	/*
	 * createMessageBoardY
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createMessageBoardY(Connection conn,String kix,String campus,String user){

		Logger logger = Logger.getLogger("ER00018");

		String fileName = null;

		try{

			String sql = "SELECT proposer,coursealpha,coursenum,coursetitle,dateproposed "
							+ "FROM tblCourse WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int forumID = ForumDB.getNextForumID(conn);
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String auditdate = AseUtil.nullToBlank(rs.getString("dateproposed"));

				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));

				PreparedStatement ps2 = null;

				int rowsAffected = 0;

				if (!ForumDB.isMatch(conn,campus,kix)){
					sql = "INSERT INTO forums(forum_id,campus, historyid, creator, requestor, forum_name, forum_description, forum_start_date, forum_grouping, src, counter, status, priority, auditdate, createddate, auditby) "
						+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,forumID);
					ps2.setString(2,campus);
					ps2.setString(3,kix);
					ps2.setString(4,proposer);
					ps2.setString(5,AseUtil.nullToBlank(rs.getString("proposer")));
					ps2.setString(6,alpha + " " + num);
					ps2.setString(7,AseUtil.nullToBlank(rs.getString("coursetitle")));
					ps2.setString(8,AseUtil.getCurrentDateTimeString());
					ps2.setString(9,"course");
					ps2.setString(10,"course");
					ps2.setInt(11,1);
					ps2.setString(12,"Requirements");
					ps2.setInt(13,0);
					ps2.setString(14,AseUtil.getCurrentDateTimeString());
					ps2.setString(15,AseUtil.getCurrentDateTimeString());
					ps2.setString(16,AseUtil.nullToBlank(rs.getString("proposer")));
					rowsAffected = ps2.executeUpdate();
					ps2.close();
				} // match

				int messages = createRootPost(conn,campus,kix,forumID,auditdate);

				// set views to number of messages created
				if (messages > 0){
					sql = "UPDATE forums SET views=? WHERE forum_id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,messages);
					ps2.setInt(2,forumID);
					rowsAffected = ps2.executeUpdate();
					ps2.close();
				}

				AseUtil.logAction(conn,user,"ACTION","Reformat for message board ("+messages+")",alpha,num,campus,"");

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ER00018 - createMessageBoardY: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ER00018 - createMessageBoardY: " + e.toString());
		}

		return fileName;

	}

	/*
	 * createRootPost
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static int createRootPost(Connection conn,String campus,String kix,int forumID,String auditdate){

		Logger logger = Logger.getLogger("ER00018");

		int messages = 0;

		try{

			String[] info = Helper.getKixInfo(conn,kix);
			String proposer = info[Constant.KIX_PROPOSER];

			int forumItem = 0;
			int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			int processed = 0;

			String sql = "select distinct item, source from tblReviewHist where historyid=? order by item";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int item = rs.getInt("item");
				String src = AseUtil.nullToBlank(rs.getString("source"));

				if (item > 0){

					forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item);

					if (src.equals("2")){
						forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item)  + courseTabCount;;
					}

					int message_id = ForumDB.getNextMessageID(conn);
					sql = "INSERT INTO messages (message_id, forum_id, item, thread_id, thread_parent, thread_level, message_author, message_author_notify, message_timestamp, message_subject,message_body,acktion,closed,notified,processed,processeddate) "
						+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,message_id);
					ps2.setInt(2,forumID);
					ps2.setInt(3,forumItem);
					ps2.setInt(4,message_id);
					ps2.setInt(5,0);
					ps2.setInt(6,1);
					ps2.setString(7,proposer);
					ps2.setInt(8,0);
					ps2.setString(9,auditdate);
					ps2.setString(10,"Item No. " + forumItem);
					ps2.setString(11,"");
					ps2.setInt(12,1); // root post acktion is 1
					ps2.setInt(13,0);
					ps2.setInt(14,1);
					ps2.setInt(15,processed);
					ps2.setString(16,AseUtil.getCurrentDateTimeString());
					int rowsAffected = ps2.executeUpdate();
					ps2.close();

					messages += createMessageBoardZ(conn,campus,kix,forumID,message_id,item);

				} // item

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ER00018 - createRootPost: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ER00018 - createRootPost: " + e.toString());
		}

		return messages;

	}

	/*
	 * createMessageBoardZ
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static int createMessageBoardZ(Connection conn,String campus,String kix,int forumID,int mid,int item){

		Logger logger = Logger.getLogger("ER00018");

		int messages = 0;

		try{

			int forumItem = 0;
			int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			//
			// if still part of reviewer listing, then not processed or notified
			//
			String courseReviewers = ReviewerDB.getCourseReviewers(conn,campus,kix);

			String sql = "select dte, reviewer, comments, acktion,source from tblReviewHist where historyid=? and item=? ORDER BY dte";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,item);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				int processed = 1;
				int notified = 1;

				String reviewer = rs.getString("reviewer");

				if(courseReviewers.toLowerCase().contains(reviewer.toLowerCase())){
					processed = 0;
					notified = 0;
				}

				String comments = rs.getString("comments");
				String dte = rs.getString("dte");
				String src = AseUtil.nullToBlank(rs.getString("source"));
				int acktion = rs.getInt("acktion");
				int message_id = ForumDB.getNextMessageID(conn);

				forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item);

				if (src.equals("2")){
					forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item) + courseTabCount;
				}

				sql = "INSERT INTO messages (message_id, forum_id, item, thread_id, thread_parent, thread_level, message_author, message_author_notify, message_timestamp, message_subject,message_body,acktion,closed,notified,processed,processeddate) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,message_id);
				ps2.setInt(2,forumID);
				ps2.setInt(3,forumItem);
				ps2.setInt(4,mid);
				ps2.setInt(5,mid);
				ps2.setInt(6,2);
				ps2.setString(7,reviewer);
				ps2.setInt(8,0);
				ps2.setString(9,dte);
				ps2.setString(10,"");
				ps2.setString(11,comments);
				ps2.setInt(12,acktion);
				ps2.setInt(13,0);
				ps2.setInt(14,notified);
				ps2.setInt(15,processed);
				ps2.setString(16,AseUtil.getCurrentDateTimeString());
				int rowsAffected = ps2.executeUpdate();
				ps2.close();

				++messages;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("ER00018 - createMessageBoardZ: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("ER00018 - createMessageBoardZ: " + e.toString());
		}

		return messages;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html
