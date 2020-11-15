<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
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
	String alpha = "ACC";
	String num = "101";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "V31j29l10106";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		out.println(notYourTurn());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

</table>

<%!

	public static String notYourTurn(){

Logger logger = Logger.getLogger("test");

		// approvers are assigned out of sequence and is receiving not your turn to approve
		// this routine runs through current approvals to identify where it is that
		// a person should not be but has a test on his/her list to approve.

		// if it's there incorrectly, it should be deleted or left there since a message
		// is made available for user to delete the incorrect task

		// for now, we only display the outlines for references. no actual fix implemented
		Connection conn = null;

		try{
			logger.info("------------------- START");

			conn = AsePool.createLongConnection();
			if (conn != null){
				String sql = "SELECT historyid,coursealpha,coursenum,proposer,route,coursetype,campus "
							+ "FROM tblCourse "
							+ "WHERE progress='APPROVAL' "
							+ "ORDER BY coursealpha,coursenum";

				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while ( rs.next() ){
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
					String type = AseUtil.nullToBlank(rs.getString("coursetype"));
					String campus = AseUtil.nullToBlank(rs.getString("campus"));
					int route = rs.getInt("route");

					if (route > 0){

						String approver = ApproverDB.getApproverNames(conn,campus,alpha,route);

						if (approver != null && approver.length() > 0){
							String[] approvers = approver.split(",");

							int lastApproverSequence = ApproverDB.getLastApproverSequence(conn,campus,kix);

							if (lastApproverSequence < approvers.length){

								if (!CourseDB.isNextApprover(conn,campus,alpha,num,approvers[lastApproverSequence])){
									logger.info("------------------------------------------");
									logger.info("kix: " + kix);
									logger.info("alhpa: " + alpha);
									logger.info("num: " + num);
									logger.info("proposer: " + proposer);
									logger.info("route: " + route);
									logger.info("current Approver: " + (lastApproverSequence-1) + " - " + approvers[lastApproverSequence-1]);
									logger.info("next Approver: " + (lastApproverSequence) + " - " + approvers[lastApproverSequence]);

									int rowsAffected = TaskDB.logTask(conn,
																			approvers[lastApproverSequence],
																			approvers[lastApproverSequence],
																			alpha,
																			num,
																			Constant.APPROVAL_TEXT,
																			campus,
																			Constant.BLANK,
																			Constant.TASK_REMOVE,
																			type);
									if (rowsAffected > 0){
										logger.info("task removed");
									}

								}
							} // lastApproverSequence

						} // approver

					} // route

				} // while
				rs.close();
				ps.close();
			} // conn

			logger.info("------------------- END");

		}
		catch(SQLException sx){
			logger.info("notYourTurn - " + sx.toString());
		}
		catch(Exception ex){
			logger.info("notYourTurn - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("Cron: notYourTurn - " + e.toString());
			}
		}

		return "";
	} // updateDefect

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>