<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="com.ase.aseutil.AseUtil"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
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
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		//createBoard(conn);

		// ----------------------------------------------------

		//cleanMessageBoard(conn,110);

NO LONGER USED.

replaced with inicon.jsp

//out.println(createMessageBoard(conn));

		//out.println(QuestionDB.getCourseSequenceByNumber(conn,"KAP","2",1) + Html.BR());
		//out.println(QuestionDB.getCourseSequenceByNumber(conn,"KAP","2",6) + Html.BR());
		//out.println(QuestionDB.getCourseSequenceByNumber(conn,"KAP","2",43) + Html.BR());

		// should this be done? only active and only reviews are brought over
		// FOR NOW, DON"T DO THIS LINE
		//out.println(closePost(conn));

		//cleanMessageBoard(conn,17);

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!
	// ---------------------------------------------------------------------

	/*
	 * createMessageBoard
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createMessageBoard(Connection conn){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{

			createMessageBoardX(conn,"tblReviewHist","Requirements");

			// closed or completed forums stay where they are.
			//createMessageBoardX(conn,"tblReviewHist2","Closed");

			//createMessageBoardY(conn,"tblReviewHist","648d30k1130","Requirements");
			//createMessageBoardY(conn,"tblReviewHist2","o33j14l1125","Closed");
		}
		catch(Exception e){
			logger.fatal("Test - createMessageBoardX: " + e.toString());
		}

		return fileName;

	}

	/*
	 * cleanMessageBoard
	 *	<p>
	 * @param	conn	Connection
	 */
	public static String cleanMessageBoard(Connection conn,int id){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{
			String sql = "DELETE FROM messages WHERE forum_id > ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			System.out.println("deleted " + ps.executeUpdate() + " rows from messages");
			ps.close();

			sql = "DELETE FROM messagesX WHERE fid > ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			System.out.println("deleted " + ps.executeUpdate() + " rows from messages");
			ps.close();

			sql = "DELETE FROM forumsx WHERE fid > ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			System.out.println("deleted " + ps.executeUpdate() + " rows from forum");
			ps.close();

			sql = "DELETE FROM forums WHERE forum_id > ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			System.out.println("deleted " + ps.executeUpdate() + " rows from forum");
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - cleanMessageBoard: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - cleanMessageBoard: " + e.toString());
		}

		return fileName;

	}

	/*
	 * createMessageBoardX
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createMessageBoardX(Connection conn,String table,String active){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{

			// collect only courses that are still in PRE

			String sql = "SELECT DISTINCT r.historyid "
							+ "FROM "+table+" AS r INNER JOIN "
							+ "tblCourse AS c ON r.historyid = c.historyid "
							+ "WHERE c.CourseType='PRE'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String historyid = rs.getString("historyid");
				createMessageBoardY(conn,table,historyid,active);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - createMessageBoardX: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createMessageBoardX: " + e.toString());
		}

		return fileName;

	}

	/*
	 * createMessageBoardY
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createMessageBoardY(Connection conn,String table,String kix,String active){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{

			String sql = "SELECT campus,proposer,coursealpha,coursenum,coursetitle,dateproposed "
							+ "FROM tblCourse "
							+ "WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int forumID = ForumDB.getNextForumID(conn);
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String auditdate = AseUtil.nullToBlank(rs.getString("dateproposed"));

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
					ps2.setString(6,AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum")));
					ps2.setString(7,AseUtil.nullToBlank(rs.getString("coursetitle")));
					ps2.setString(8,AseUtil.getCurrentDateTimeString());
					ps2.setString(9,"course");
					ps2.setString(10,"course");
					ps2.setInt(11,1);
					ps2.setString(12,active);
					ps2.setInt(13,0);
					ps2.setString(14,AseUtil.getCurrentDateTimeString());
					ps2.setString(15,AseUtil.getCurrentDateTimeString());
					ps2.setString(16,AseUtil.nullToBlank(rs.getString("proposer")));
					rowsAffected = ps2.executeUpdate();
					ps2.close();
				} // match

				int messages = createRootPost(conn,table,campus,kix,forumID,active,auditdate);

				// set views to number of messages created
				if (messages > 0){
					sql = "UPDATE forums SET views=? WHERE forum_id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,messages);
					ps2.setInt(2,forumID);
					rowsAffected = ps2.executeUpdate();
					ps2.close();
				}

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - createMessageBoardY: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createMessageBoardY: " + e.toString());
		}

		return fileName;

	}

	/*
	 * createRootPost
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static int createRootPost(Connection conn,String table,String campus,String kix,int forumID,String active,String auditdate){

Logger logger = Logger.getLogger("test");

		int messages = 0;

		try{

			if (active.equals("Closed")){
				active = "1";
			}
			else{
				active = "0";
			}

			String[] info = Helper.getKixInfo(conn,kix);
			String proposer = info[Constant.KIX_PROPOSER];

			int forumItem = 0;
			int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			String sql = "select distinct item, source from " + table + " where historyid=? order by item";
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
					sql = "INSERT INTO messages (message_id, forum_id, item, thread_id, thread_parent, thread_level, message_author, message_author_notify, message_timestamp, message_subject,message_body,acktion,closed,notified) "
						+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
					//ps2.setString(11,QuestionDB.getCourseItemData(conn,proposer,kix,src,forumItem));
					ps2.setString(11,"");
					ps2.setInt(12,1); // root post acktion is 1
					ps2.setInt(13,Integer.parseInt(active));
					ps2.setInt(14,1);
					int rowsAffected = ps2.executeUpdate();
					ps2.close();

					messages += createMessageBoardZ(conn,table,campus,kix,forumID,message_id,item,active);

				} // item

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - createRootPost: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createRootPost: " + e.toString());
		}

		return messages;

	}

	/*
	 * createMessageBoardZ
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static int createMessageBoardZ(Connection conn,String table,String campus,String kix,int forumID,int mid,int item,String active){

Logger logger = Logger.getLogger("test");

		int messages = 0;

		try{

			int forumItem = 0;
			int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			String sql = "select dte, reviewer, comments, acktion,source from "+table+" where historyid=? and item=? ORDER BY dte";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,item);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {

				String reviewer = rs.getString("reviewer");
				String comments = rs.getString("comments");
				String dte = rs.getString("dte");
				String src = AseUtil.nullToBlank(rs.getString("source"));
				int acktion = rs.getInt("acktion");
				int message_id = ForumDB.getNextMessageID(conn);

				forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item);

				if (src.equals("2")){
					forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item) + courseTabCount;
				}

				sql = "INSERT INTO messages (message_id, forum_id, item, thread_id, thread_parent, thread_level, message_author, message_author_notify, message_timestamp, message_subject,message_body,acktion,closed) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
				ps2.setInt(13,Integer.parseInt(active));
				int rowsAffected = ps2.executeUpdate();
				ps2.close();

				++messages;
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - createMessageBoardZ: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createMessageBoardZ: " + e.toString());
		}

		return messages;

	}


	/*
	 * createPrimaryDocument
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createPrimaryDocument(Connection conn,String campus,String documents,String kix){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{
			// after adding the attached document, include the HTML for program or outline as well
			String documentFolder = "";
			boolean isAProgram = ProgramsDB.isAProgram(conn,kix);
			if (isAProgram){
				documentFolder = "programs";
			}
			else{
				documentFolder = "outlines";
			}

			// there is a chance that the file already exist but we want
			// to create from the most recent content
			String[] info = null;
			if (isAProgram){
				info = Helper.getKixInfo(conn,kix);
				String degree = info[Constant.KIX_PROGRAM_TITLE];
				String division = info[Constant.KIX_PROGRAM_DIVISION];
				Tables.createPrograms(campus,kix,degree,division);
			}
			else{
				info = Helper.getKixInfo(conn,kix);
				String alpha = info[Constant.KIX_ALPHA];
				String num = info[Constant.KIX_NUM];
				String type = info[Constant.KIX_TYPE];
				Tables.createOutlines(conn,campus,kix,alpha,num,"html","",type,false,true);
			}

			fileName = AseUtil.getCurrentDrive()
									+ ":"
									+ documents
									+ documentFolder + "\\"
									+ campus + "\\"
									+ kix
									+ ".html";
		}
		catch(SQLException e){
			logger.fatal("Test - createPrimaryDocument: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createPrimaryDocument: " + e.toString());
		}

		return fileName;

	}

	/*
	 * closePost - turn off ability to edit posts for outlines sent back for modification
	 *	<p>
	 * @param	conn	Connection
	 */
	public static int closePost(Connection conn){

		int rowsAffected = 0;

Logger logger = Logger.getLogger("test");

		try{
			String sql = "SELECT DISTINCT forums.campus, forums.historyid "
					+ "FROM tblReviewHist INNER JOIN "
					+ "tblCourse ON tblReviewHist.historyid = tblCourse.historyid INNER JOIN "
					+ "forums ON tblReviewHist.historyid = forums.historyid "
					+ "WHERE (tblCourse.Progress = 'MODIFY')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));

				System.out.println(kix);

				rowsAffected += Board.endReviewProcess(conn,campus,kix);

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - closePost: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - closePost: " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * createMessageBoardX
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createBoard(Connection conn){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{

			// collect only courses that are still in PRE

			String sql = "SELECT DISTINCT historyid FROM tblReviewHist";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				String kix = rs.getString("historyid");

				// for each id found, add to forum
				createForum(conn,kix);

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - createMessageBoardX: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createMessageBoardX: " + e.toString());
		}

		return fileName;

	}

	/*
	 * createForum
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static String createForum(Connection conn,String kix){

Logger logger = Logger.getLogger("test");

		String fileName = null;

		try{

			String sql = "SELECT campus,proposer,coursealpha,coursenum,coursetitle,dateproposed "
							+ "FROM tblCourse WHERE historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				int forumID = ForumDB.getNextForumID(conn);
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				String auditdate = AseUtil.nullToBlank(rs.getString("dateproposed"));

				PreparedStatement ps2 = null;

				int rowsAffected = 0;

				sql = "INSERT INTO forums(forum_id,campus, historyid, creator, requestor, forum_name, forum_description, forum_start_date, forum_grouping, src, counter, status, priority, auditdate, createddate, auditby) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,forumID);
				ps2.setString(2,campus);
				ps2.setString(3,kix);
				ps2.setString(4,proposer);
				ps2.setString(5,AseUtil.nullToBlank(rs.getString("proposer")));
				ps2.setString(6,AseUtil.nullToBlank(rs.getString("coursealpha")) + " " + AseUtil.nullToBlank(rs.getString("coursenum")));
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

				int messages = createMessages(conn,campus,kix,forumID);

				// set views to number of messages created
				if (messages > 0){
					sql = "UPDATE forums SET views=? WHERE forum_id=?";
					ps2 = conn.prepareStatement(sql);
					ps2.setInt(1,messages);
					ps2.setInt(2,forumID);
					rowsAffected = ps2.executeUpdate();
					ps2.close();
				}

			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - createForum: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createForum: " + e.toString());
		}

		return fileName;

	}

	/*
	 * createMessages
	 *	<p>
	 * @param	conn	Connection
	 * @param	kix	String
	 */
	public static int createMessages(Connection conn,String campus,String kix,int forumID){

Logger logger = Logger.getLogger("test");

		int messages = 0;

		try{
			AseUtil aseUtil = new AseUtil();

			int courseTabCount = CourseDB.countCourseQuestions(conn,campus,"Y","",1);

			String sql = "select * from tblReviewHist where historyid=? order by item";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int item = rs.getInt("item");
				String src = AseUtil.nullToBlank(rs.getString("source"));
				String reviewer = AseUtil.nullToBlank(rs.getString("reviewer"));
				String comments = AseUtil.nullToBlank(rs.getString("comments"));

				int forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item);

				if (src.equals("2")){
					forumItem = QuestionDB.getCourseSequenceByNumber(conn,campus,src,item)  + courseTabCount;;
				}

				String dte = aseUtil.ASE_FormatDateTime(rs.getString("dte"),Constant.DATE_DATETIME);

				int message_id = ForumDB.getNextMessageID(conn);
				sql = "INSERT INTO messages (message_id, forum_id, item, thread_id, thread_parent, thread_level, message_author, message_author_notify, message_timestamp, message_subject,message_body,acktion,closed,notified) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,message_id);
				ps2.setInt(2,forumID);
				ps2.setInt(3,forumItem);
				ps2.setInt(4,message_id);
				ps2.setInt(5,0);
				ps2.setInt(6,1);
				ps2.setString(7,reviewer);
				ps2.setInt(8,0);
				ps2.setString(9,dte);
				ps2.setString(10,"Item No. " + forumItem);
				ps2.setString(11,comments);
				ps2.setInt(12,1);
				ps2.setInt(13,0);
				ps2.setInt(14,1);
				int rowsAffected = ps2.executeUpdate();
				ps2.close();

				++messages;

			} // while

			rs.close();
			ps.close();

			aseUtil = null;
		}
		catch(SQLException e){
			logger.fatal("Test - createMessages: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - createMessages: " + e.toString());
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
</html>