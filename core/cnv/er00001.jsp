<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "ER00001";
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

	String campus = "KAP";
	String alpha = "ACC";
	String num = "124";
	String type = "PRE";
	String user = "ERICD";
	String kix = "g17k15l10183";
	String message = "";

	out.println("Start<br/>");

	if (processPage){
		try{
			int route = 1221;
			String seq = "1";
			String id = "685";

			String oldUser = "AKOSEKI";
			String newUser = "THANHG";

			Approver approverDB = new Approver(id,
															seq,
															newUser,
															newUser,
															false,
															false,
															user,
															AseUtil.getCurrentDateTimeString(),
															campus,
															route,
															AseUtil.getCurrentDateTimeString(),
															AseUtil.getCurrentDateTimeString(),
															AseUtil.getCurrentDateTimeString());

			int rowsAffected = ApproverDB.updateApprover(conn,approverDB,1);

System.out.println(rowsAffected);

		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!

	public static int updateApprover(Connection connection,Approver appr,int applyDate) {

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		String sql = "";

		PreparedStatement ps = null;

		String approver = "";
		String delegated = "";
		String campus = "";
		int route = 0;
		int seq = 0;

		try {
			approver = appr.getApprover();
			delegated = appr.getDelegated();
			campus = appr.getCampus();
			route = appr.getRoute();
			seq = Integer.parseInt(appr.getSeq());

			// set dates appropriately
			if (appr.getEndDate() == null || appr.getEndDate().length() == 0)
				appr.setEndDate(null);

			if (appr.getStartDate() == null || appr.getStartDate().length() == 0)
				appr.setStartDate(null);

			// who is the current approver at this sequence. if there is a name change,
			// let's make notifications
String currentApprover = ApproverDB.getApproversBySeq(connection,campus,seq,route);

			sql = "UPDATE tblApprover "
				+ "SET approver_seq=?,approver=?,delegated=?,multilevel=?,experimental=?,addedby=?,addeddate=?,route=?, "
				+ "availabledate=?,startdate=?,enddate=? "
				+ "WHERE approverid=?";

			ps = connection.prepareStatement(sql);
			ps.setString(1, appr.getSeq());
			ps.setString(2, approver);
			ps.setString(3, delegated);
			ps.setBoolean(4, appr.getMultiLevel());
			ps.setBoolean(5, appr.getExcludeFromExperimental());
			ps.setString(6, appr.getLanid());
			ps.setString(7, appr.getDte());
			ps.setInt(8, route);
			ps.setString(9,appr.getAvailableDate());
			ps.setString(10,appr.getStartDate());
			ps.setString(11,appr.getEndDate());
			ps.setString(12, appr.getId());
			rowsAffected = ps.executeUpdate();
			ps.close();

			/*
				coming from appr.jsp, this flag tells CC to apply this endDate to all approvals
				by this user
			*/
			if (applyDate == 1){
				sql = "UPDATE tblApprover SET enddate=? WHERE campus=? AND approver=?";
				ps = connection.prepareStatement(sql);
				ps.setString(1,appr.getEndDate());
				ps.setString(2,campus);
				ps.setString(3,approver);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}

			if (!currentApprover.equals(approver)){
				rowsAffected = renameApprover(connection,campus,currentApprover,approver,route);
			}

		} catch (SQLException e) {
			logger.fatal("ApproverDB: updateApprover - " + e.toString());
			return 0;
		}

		return rowsAffected;
	}

	/*
	 * renameApprover (ER00001)
	 * <p>
	 * @param	conn
	 * @param	campus
	 * @param	oldNser
	 * @param	newUser
	 * @param	route
	 * <p>
	 * @return int
	 */
	public static int renameApprover(Connection conn,String campus,String oldUser,String newUser,int route){

Logger logger = Logger.getLogger("test");

		String kix = null;
		String alpha = null;
		String num = null;
		String submittedby = null;
		String title = null;
		String proposer = null;
		String taskMsg = Constant.APPROVAL_TEXT;

		String alphas = null;

		int rowsAffected = 0;
		int rowsRenamed = 0;

		try{
			// select all outlines where the task for approval is created for person in question (olduser)
			// qualifying outlines are PRE types and progress may be APPROVAL or DELETE.
			// this impact is by route that is being changed only
			String sql = "SELECT c.historyid,c.CourseAlpha,c.CourseNum,c.coursetitle,c.proposer,t.submittedby "
							+ "FROM tblTasks t INNER JOIN tblCourse c ON t.campus = c.campus "
							+ "AND t.coursealpha = c.CourseAlpha "
							+ "AND t.coursenum = c.CourseNum "
							+ "WHERE c.campus=? "
							+ "AND t.message=? "
							+ "AND c.CourseType='PRE' "
							+ "AND c.route=? "
							+ "AND t.submittedfor=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,taskMsg);
			ps.setInt(3,route);
			ps.setString(4,oldUser);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				// get all tasks for current user
				kix = AseUtil.nullToBlank(rs.getString("historyid"));
				alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				num = AseUtil.nullToBlank(rs.getString("coursenum"));
				title = AseUtil.nullToBlank(rs.getString("coursetitle"));
				submittedby = AseUtil.nullToBlank(rs.getString("submittedby"));
				proposer = AseUtil.nullToBlank(rs.getString("proposer"));

				// collect to make this additiona alphas
				if (alphas == null){
					alphas = alpha;
				}
				else{
					alphas = alphas + "," + alpha;
				}

				// remove from current user
				rowsAffected = TaskDB.logTask(conn,
														oldUser,
														oldUser,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_REMOVE,
														Constant.PRE);

				AseUtil.logAction(conn,
										oldUser,
										"REMOVE",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// add for new user
				rowsAffected = TaskDB.logTask(conn,
														newUser,
														submittedby,
														alpha,
														num,
														taskMsg,
														campus,
														Constant.BLANK,
														Constant.TASK_ADD,
														Constant.PRE,
														Constant.BLANK,
														Constant.TASK_APPROVER,
														kix,
														Constant.COURSE);

				AseUtil.logAction(conn,
										newUser,
										"ADD",
										"Outline approval ("+ alpha + " " + num  + " - " + title + ")",
										alpha,
										num,
										campus,
										kix);

				// send notification
				MailerDB mailerDB = new MailerDB(conn,
															proposer,
															newUser,
															"nextDelegate",
															Constant.BLANK,
															alpha,
															num,
															campus,
															"emailOutlineApprovalRequest",
															kix,
															newUser);

				++rowsRenamed;

			} // while
			rs.close();
			ps.close();

			// add these alphas to the user's profile
			if (alphas != null){
				int profiles = UserDB.updateUserAlphas(conn,newUser,alphas);

				AseUtil.logAction(conn,
										newUser,
										"ADD",
										"Added to user list of alphas",
										Util.removeDuplicateFromString(alphas),
										"",
										campus,
										kix);
			}

		}
		catch(SQLException sx){
			logger.fatal("ApproverDB: renameApprover01 - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("ApproverDB: renameApprover01 - " + ex.toString());
		}

		return rowsRenamed;

	} // renameApprover

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>