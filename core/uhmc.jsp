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
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campus = website.getRequestParameter(request,"cps","");
	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");

	out.println("Start<br/><br/>This page counts number of records in tables for a course outline.<br><br>");

	if (processPage){

		try{
			if(campus != "" && alpha != "" && num != ""){
				out.println(com.ase.aseutil.db.TSql.countRowsOfData(conn,campus,"",alpha,num) + "<br>");
				out.println("<br>click <a href=\"../tsql.txt\" class=\"linkcolumn\" target=\"_blank\">here</a> to view result");
			}
			else{
				out.println("Invalid course outline to count. Provide cps, alpha, and num to process page.");
			}

		} catch (Exception e){
			System.err.println (e.toString());
		}
	}

	out.println("<br><br>return to <a href=\"ccutil.jsp\" class=\"linkcolumn\">CC</a>");

	out.println("<br><br/>End");

	asePool.freeConnection(conn,"lee",user);
%>

<%!

	/*
	 * reassignOwnership
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	user		String
	 *	@param	fromName	String
	 *	@param	toName	String
	 *	@param	alpha		String
	 *	@param	num		String
	 * <p>
	 *	@return Msg
	 */
	public static Msg reassignOwnership(Connection conn,
													String campus,
													String user,
													String fromName,
													String toName,
													String alpha,
													String num) throws Exception {


Logger logger = Logger.getLogger("test");

		Msg msg = new Msg();

		int rowsAffected = 0;
		String kix = "";

		// we never would reassign once approved
		String type = "PRE";

		boolean debug = false;

		conn.setAutoCommit(false);

		try {
			debug = DebugDB.getDebug(conn,"Outlines");

			kix = Helper.getKix(conn,campus,alpha,num,type);

			if (debug) logger.info(kix + " - " + user + " - REASSIGNOWNERSHIP - STARTS");

			// change names for courses pending
			String sql = "UPDATE tblCourse SET proposer=? WHERE campus=? AND historyid=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,campus);
			ps.setString(3,kix);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership course - " + rowsAffected + " row(s).");

			// change names for tasks pending
			sql = "UPDATE tblTasks SET submittedfor=?,submittedby=? "
				+ "WHERE campus=? AND coursealpha=? AND coursenum=? AND submittedfor=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,toName);
			ps.setString(3,campus);
			ps.setString(4,alpha);
			ps.setString(5,num);
			ps.setString(6,fromName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership task created - " + rowsAffected + " row(s).");

			// change names for reviews pending
			sql = "UPDATE tblReviewers SET userid=? WHERE campus=? AND userid=? AND coursealpha=? AND coursenum=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,campus);
			ps.setString(3,fromName);
			ps.setString(4,alpha);
			ps.setString(5,num);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership reviewer notes transferred - " + rowsAffected + " row(s).");
			ps.close();

			// change names for forum
			sql = "UPDATE forums SET creator=? WHERE historyid=? AND (status<>'Closed' AND status<>'Completed')";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,kix);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forums - " + rowsAffected + " row(s).");
			ps.close();

			// forum members
			sql = "UPDATE forumsx SET userid=? WHERE userid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,fromName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forum members - " + rowsAffected + " row(s).");
			ps.close();

			// update forum messagse
			sql = "UPDATE messages SET message_author=? WHERE message_author=? AND closed=0";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			ps.setString(2,fromName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forum messages - " + rowsAffected + " row(s).");
			ps.close();

			// delete from message notification to force new owner to read
			sql = "DELETE FROM messagesX WHERE author=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toName);
			rowsAffected = ps.executeUpdate();
			if (debug) logger.info(kix + " - reassignOwnership forum notification - " + rowsAffected + " row(s).");
			ps.close();

			conn.commit();

			MailerDB mailerDB = new MailerDB(conn,
														fromName,
														toName,
														"",
														"",
														alpha,
														num,
														campus,
														"emailOutlineReassigned",
														kix,
														user);

			AseUtil.logAction(conn, user, "ACTION","Outline Reassigned ("+ fromName + " to " + toName + ")",alpha,num,campus,kix);

		} catch (SQLException ex) {
			/*
			 * this is caught before exception. However, there are instances
			 * where it may be valid and still executes.
			 */
			logger.fatal("Outlines: reassignOwnership - " + ex.toString());
			msg.setMsg("Exception");
			conn.rollback();
			logger.info("Outlines: reassignOwnership - Rolling back transaction");
		} catch (Exception e) {
			/*
			 * must do since for any exception, a rollback is a must.
			 */
			logger.fatal("Outlines: reassignOwnership - " + e.toString());

			try {
				conn.rollback();
				logger.info("Outlines: reassignOwnership - Rolling back transaction\n");
			} catch (SQLException exp) {
				logger.fatal("Outlines: reassignOwnership - " + exp.toString());
			}
		}

		conn.setAutoCommit(true);

		return msg;
	}

%>

</form>
		</td>
	</tr>
</table>

</body>
</html
