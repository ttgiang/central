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

		out.println("" + Html.BR());

		out.println("fix01: " + fix01(conn) + Html.BR());
		out.println("fix02: " + fix02(conn) + Html.BR());
		out.println("fix03: " + fix03(conn) + Html.BR());

		//out.println("<strong>createNotifications</strong>" + Html.BR());
		//out.println(createNotifications(conn) + " rows in email property data" + Html.BR());

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	public static int fix01(Connection conn) {

		Logger logger = Logger.getLogger("test");

		// set comments to question_friendly for easy reading

		int i = 0;

		int rowsAffected = 0;

		try{
			String sql = "select id, question_number, question_friendly,campus,type "
							+ "from cccm6100 where comments is null or comments = ''";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				int id = rs.getInt("id");
				int question_number = rs.getInt("question_number");

				String question_friendly = AseUtil.nullToBlank(rs.getString("question_friendly"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String type = AseUtil.nullToBlank(rs.getString("type"));

				sql = "UPDATE cccm6100 SET comments=? WHERE id=? AND campus=? AND type=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,question_friendly);
				ps2.setInt(2,id);
				ps2.setString(3,campus);
				ps2.setString(4,type);
				rowsAffected = ps2.executeUpdate();
				ps2.close();

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return rowsAffected;

	}

	public static int fix02(Connection conn) {

		Logger logger = Logger.getLogger("test");

		// set specific columns to reserved for future use

		int rowsAffected = 0;

		try{

			String[] column = "C27,C28,C29,C30".split(",");

			for(int i = 0; i < column.length; i++){

				String text = "Do Not Use - reserved for CC";

				String sql = "SELECT COUNT(*) AS counter "
								+ "FROM (SELECT id "
								+ "FROM tblCampusData "
								+ "WHERE (NOT (" + column[i] + " IS NULL)) AND (CAST(" + column[i] + " AS varchar(1000)) <> '')) AS derived";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				if(rs.next()){
					int counter = rs.getInt("counter");

					if(counter == 0){
						sql = "UPDATE cccm6100 SET CCCM6100=?,comments=? WHERE campus='TTG' AND type='Campus' AND Question_Friendly=?";
						PreparedStatement ps2 = conn.prepareStatement(sql);
						ps2.setString(1,text);
						ps2.setString(2,text);
						ps2.setString(3,column[i]);
						rowsAffected = ps2.executeUpdate();
						ps2.close();

						// get the corresponding question number to update campus question
						// we made sure the column is not in used
						sql = "SELECT tc.questionnumber "
							+ "FROM tblCampusQuestions tc INNER JOIN "
							+ "CCCM6100 cm ON tc.questionnumber = cm.Question_Number AND tc.type = cm.type AND  "
							+ "tc.campus = cm.campus "
							+ "WHERE (cm.campus = 'KAP') AND (cm.type = 'Campus') AND (tc.include <> 'Y') AND (cm.Question_Friendly = '" + column[i] + "') ";
						ps2 = conn.prepareStatement(sql);
						ResultSet rs2 = ps2.executeQuery();
						if(rs2.next()){
							int questionnumber = rs2.getInt("questionnumber");

							ps2.close();

							sql = "UPDATE tblCampusQuestions SET question=?,help=?,headertext=? WHERE questionnumber=?";
							ps2 = conn.prepareStatement(sql);
							ps2.setString(1,text);
							ps2.setString(2,text);
							ps2.setString(3,text);
							ps2.setInt(4,questionnumber);
							rowsAffected = ps2.executeUpdate();

						}
						rs2.close();
						ps2.close();


						System.out.println("fix02 - column - " + column[i] + " " + counter);
					}

				}
				rs.close();
				ps.close();

			} // for i


		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return rowsAffected;

	}

	public static int fix03(Connection conn) {

		Logger logger = Logger.getLogger("test");

		// reset do not use columns

		int rowsAffected = 0;

		try{

			String sql = "SELECT Question_Number, CCCM6100, Question_Friendly "
							+ "FROM CCCM6100 "
							+ "WHERE (campus = 'TTG') AND (type = 'Campus') AND (CCCM6100 LIKE 'Do Not%')";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				int qn = rs.getInt("Question_Number");
				String CCCM6100 = AseUtil.nullToBlank(rs.getString("CCCM6100"));

				sql = "UPDATE tblCampusQuestions SET question=?,help=?,headertext=? WHERE questionnumber=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,CCCM6100);
				ps2.setString(2,CCCM6100);
				ps2.setString(3,CCCM6100);
				ps2.setInt(4,qn);
				rowsAffected = ps2.executeUpdate();

			}
			rs.close();
			ps.close();

		} catch (SQLException e) {
			logger.fatal("fix - " + e.toString());
		} catch (Exception e) {
			logger.fatal("fix - " + e.toString());
		}

		return rowsAffected;

	}

	//
	// create notification emails from property files
	//
	public static int createNotifications(Connection conn) throws Exception {

Logger logger = Logger.getLogger("test");

		int i = 0;
		int j = 0;

		int rowsAffected = 0;

		String campus = SQLUtil.resultSetToCSV(conn,"SELECT campus FROM tblCampus WHERE campus<>''","");

		String prop = "emailApproveOutline,"
						+ "emailCancelOutlineApproval,"
						+ "emailCoreqAdded,"
						+ "emailCrossListAdded,"
						+ "emailNotifiedWhenApproved,"
						+ "emailNotifiedWhenCopy,"
						+ "emailNotifiedWhenDelete,"
						+ "emailNotifiedWhenRename,"
						+ "emailOutlineCancelReview,"
						+ "emailOutlineReassigned,"
						+ "emailOutlineRecalledApproval,"
						+ "emailOutlineReject,"
						+ "emailOutlineReviewCompleted,"
						+ "emailPrereqAdded,"
						+ "emailReviewerComment,"
						+ "emailReviewerInvite,"
						+ "emailOutlineApprovalRequest,"
						+ "emailOutlineCancelApproval,"
						+ "emailApproveProgram,"
						+ "emailCrossListingApproved,"
						+ "emailMessagePosted,"
						+ "emailNotifiedWhenProgramApproved,"
						+ "emailOutlineApprovalPacketRequest,"
						+ "emailOutlineTerminationNotice,"
						+ "emailProgramAdded,"
						+ "emailProgramApproval,"
						+ "emailProgramApprovalRequest,"
						+ "emailProgramApproved,"
						+ "emailProgramReject,"
						+ "emailProgramReviewCompleted,"
						+ "emailProperties,"
						+ "emailRejectOutline,"
						+ "emailRequiredElectiveAdded,"
						+ "emailRequiredOrElectiveApproval,"
						+ "emailRequisiteApproval,"
						+ "emailRequisiteApproved,"
						+ "emailRequisiteNotApproved,"
						+ "emailSendOnce,"
						+ "emailSLOApprovalCancelled,"
						+ "emailSLOApprovalCompleted,"
						+ "emailSLOApprovalRequest,"
						+ "emailSLOReviewCancelled,"
						+ "emailSLOReviewCompleted,"
						+ "emailSLOReviewRequest,"
						+ "emailTest,"
						+ "emailCrossListingNotApproved,"
						+ "emailProgramNotApproved,"
						+ "emailApproveOutlineToApprovers"
						+ "emailMessageBoardMember"
						;

		String descr = "Notify proposer of approved outline.,"
						+ "Notification sent when outline approval has been cancelled,"
						+ "Notification sent after co-requisite has been added to an outline,"
						+ "Notification sent after cross-listed has been added to an outline,"
						+ "Notify registrar of approved outline,"
						+ "Notify campus user when and outline is being copied to another campus,"
						+ "Notify campus user when and outline is deleted,"
						+ "Notify campus user when and outline is renamed or renumbered,"
						+ "Notification sent when outline approval review has been cancelled,"
						+ "Sent when CC task is assigned from one user to another,"
						+ "Sent when outline approval is recalled,"
						+ "Sent when outline requires revision,"
						+ "Notification to proposer after review has been completed,"
						+ "Notification sent after pre-requisite has been added to an outline,"
						+ "Notification after comments are added by reviewer,"
						+ "Notification to review an outline,"
						+ "Send request for outline approval,"
						+ "Send notification to approvers that outline has approval has been cancelled,"
						+ "Notify proposer of approved program,"
						+ "Notify proposer when cross listed outline has been approved,"
						+ "Notification when a message has been posted to the message board,"
						+ "Notify proposer of approved program,"
						+ "Notify Division/Department chair when packet approval is ready,"
						+ "Notification sent when and outline is ready for termination,"
						+ "Notification sent when a program is linked to a course outline.,"
						+ "Sent when a linked program requires approval,"
						+ "Notification sent when a program is ready for approval,"
						+ "Notification sent after program linking has been approved,"
						+ "Notification sent when a program requires revision,"
						+ "Notification sent to inform proposer that reviews are completed,"
						+ "emailProperties,"
						+ "Sent when outline requires revision,"
						+ "Course outline linked to other division/department,"
						+ "Linking to other division/department requires approval.,"
						+ "Requested course outline - Pre/Co requisite approval,"
						+ "Course Outline - Pre/Co Requisite Approved,"
						+ "Course Outline - Pre/Co Requisite Not Approved,"
						+ "Daily Notification,"
						+ "Course outline SLO approval notification,"
						+ "Course outline SLO approval completed notification,"
						+ "Course outline SLO approval request notification,"
						+ "Course outline SLO review notification,"
						+ "Course outline SLO review completed,"
						+ "Course Outline SLO review notification,"
						+ "emailTest,"
						+ "Notify proposer when cross listed outline has not been approved,"
						+ "Notification sent after program linking has not been approved,"
						+ "Notification sent to approvers after outline/program has been approved,"
						+ "Notification sent to message board member,"
						;

		String subject = "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Co-Requisite Added,"
						+ "Course outline ([ALPHA] [NUM]) Cross List Added,"
						+ "Course outline ([ALPHA] [NUM]) Approved,"
						+ "Course outline ([ALPHA] [NUM]) Copied,"
						+ "Course outline ([ALPHA] [NUM]) Deleted,"
						+ "Course outline ([ALPHA] [NUM]) Renamed or Renumbered,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Review Completed,"
						+ "Course outline ([ALPHA] [NUM]) Pre-Requisite Added,"
						+ "Course outline ([ALPHA] [NUM]) Review Notification,"
						+ "Course outline ([ALPHA] [NUM]) Review Request,"
						+ "Course outline ([ALPHA] [NUM]) Approval Request,"
						+ "Course outline ([ALPHA] [NUM]) Approval Cancelled,"
						+ "Program Notification,"
						+ "Course outline ([ALPHA] [NUM]) - Cross Listing Approved,"
						+ "Course outline ([ALPHA] [NUM]) Message Board Notification,"
						+ "Program Approval Notification,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) Termination,"
						+ "Course outline ([ALPHA] [NUM]) - Program Linked,"
						+ "Course outline ([ALPHA] [NUM]) - Program link Approval Requested,"
						+ "Program is ready for your approval,"
						+ "Course outline ([ALPHA] [NUM]) - Program linked Approved,"
						+ "Your program requires revision,"
						+ "Program review completed,"
						+ "emailProperties,"
						+ "Course outline ([ALPHA] [NUM]) Notification,"
						+ "Course outline ([ALPHA] [NUM]) - Link to Other Division/Department,"
						+ "Linking to other division/department requires approval.,"
						+ "Course outline ([ALPHA] [NUM]) - Pre/Co Requisite Approval Requested,"
						+ "Course outline ([ALPHA] [NUM]) - Pre/Co Requisite Approved,"
						+ "Course outline ([ALPHA] [NUM]) - Pre/Co Requisite Not Approved,"
						+ "Daily Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Approval Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Approval Completed Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Approval Request Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Review Notification,"
						+ "Course outline ([ALPHA] [NUM]) SLO Review Completed,"
						+ "Course outline ([ALPHA] [NUM]) SLO Review Notification,"
						+ "emailTest,"
						+ "Course outline ([ALPHA] [NUM]) - Cross Listing Not Approved,"
						+ "Course outline ([ALPHA] [NUM]) - Program linked Not Approved,"
						+ "Course outline ([ALPHA] [NUM]) - Approved"
						+ "Course outline ([ALPHA] [NUM]) - Mesasge Board Notification"
						;

		String content = "Your outline [ALPHA] [NUM] was approved.,"
						+ "Request for approval of outline [ALPHA] [NUM] has been cancelled.,"
						+ "Co Requisite added to Outline.,"
						+ "Cross Listing added to Outline.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was recently approved.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was copied.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was deleted.,"
						+ "This is to inform you that outline [ALPHA] [NUM] was renamed or renumbered.,"
						+ "Request for review of outline [ALPHA] [NUM] has been cancelled.,"
						+ "Outline was reassigned to you.,"
						+ "Request for approval of outline [ALPHA] [NUM] has been recalled.,"
						+ "Your outline requires revision.,"
						+ "Outline review has been completed.,"
						+ "Pre Requisite added to Outline.,"
						+ "Reviewer comments are availble for your outline.,"
						+ "Please review requested outline.,"
						+ "Outline is ready for your approval.,"
						+ "Request for approval of outline [ALPHA] [NUM] has been cancelled.,"
						+ "Your program was approved.,"
						+ "Cross listed outline was approved.,"
						+ "A message was posted to the message board for which you'd asked to be notified.,"
						+ "This is to inform you that your program was recently approved.,"
						+ "Outline is ready for packet approval,"
						+ "This is to inform you that outline [ALPHA] [NUM] is scheduled for termination.,"
						+ "Program linked to outline.,"
						+ "A program linked to a course outline requires approval.,"
						+ "Program is ready for your approval.,"
						+ "Program linking has been approved.,"
						+ "Your program requires revision.,"
						+ "Program review has been completed.,"
						+ "emailProperties,"
						+ "Your outline requires revision.,"
						+ "Other division/department linked to program or outline.,"
						+ "Other division/department linking requires approval.,"
						+ "Pre/Co requisite added to outline and requires approval.,"
						+ "Pre/Co requisite has been approved.,"
						+ "Pre/Co requisite were not approved.,"
						+ "This is an automatated daily notificaiton from Curriculum Central.,"
						+ "Request for approval of outline has been cancelled.,"
						+ "Outline SLO has been approved.,"
						+ "Outline SLO is ready for your approval.,"
						+ "Request for review of outline has been cancelled.,"
						+ "Outline SLO review has been completed.,"
						+ "Outline SLO is ready for your review.,"
						+ "emailTest,"
						+ "Cross listed outline was not approved.,"
						+ "Program linking was not approved.,"
						+ "Outline was approved."
						+ "You\'ve been invited to contribute to course outline _alpha_ _num_ message board."
						;

		String[] props = prop.split(",");
		String[] descrs = descr.split(",");
		String[] subjects = subject.split(",");
		String[] contents = content.split(",");
		String[] campuses = campus.split(",");

		System.out.println(props.length);
		System.out.println(descrs.length);
		System.out.println(subjects.length);
		System.out.println(contents.length);

		try {
			// remove current
			String sql = "DELETE FROM tblProps";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();

			// add new
			sql = "INSERT INTO tblprops(campus,propname,propdescr,subject,content,cc,auditby,auditdate) "
					+ "VALUES(?,?,?,?,?,'','SYSTEM',getdate())";

			for(j=0; j<campuses.length; j++){
				for(i=0; i<props.length; i++){
					ps = conn.prepareStatement(sql);
					ps.setString(1,campuses[j]);
					ps.setString(2,props[i]);
					ps.setString(3,descrs[i]);
					ps.setString(4,subjects[i]);
					ps.setString(5,contents[i]);
					rowsAffected += ps.executeUpdate();
					ps.close();
				}
			}
		} catch (SQLException e) {
			logger.fatal("CNV: createNotifications - " + e.toString() + " - " + props[i]);
		} catch (Exception e) {
			logger.fatal("CNV: createNotifications - " + e.toString() + " - " + props[i]);
		}

		return rowsAffected;
	}

	/*
	 * process
	 *	<p>
	 * @param	conn	Connection
	 */
	public static int process01(Connection conn,String table){

		Logger logger = Logger.getLogger("test");

		// add to tblmisc any editing that requires only a set number of items for modification
		// edit1 == 1 means all items. a comma within means selected item only
		int rowsAffected = 0;
		int counter = 0;

		try{
			String sql = "SELECT question,questionseq,questionnumber,campus,type FROM " + table;
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String question = AseUtil.nullToBlank(rs.getString("question"));
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String type = AseUtil.nullToBlank(rs.getString("type"));
				int questionnumber = NumericUtil.getInt(rs.getString("questionnumber"),0);
				int questionseq = NumericUtil.getInt(rs.getString("questionseq"),0);

				sql = "UPDATE " + table + " SET headertext=? WHERE campus=? AND questionseq=? AND questionnumber=? AND type=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,question);
				ps2.setString(2,campus);
				ps2.setInt(3,questionseq);
				ps2.setInt(4,questionnumber);
				ps2.setString(5,type);
				ps2.executeUpdate();
				ps2.close();

				++rowsAffected;

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - process01: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - process01: " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * process
	 *	<p>
	 * @param	conn	Connection
	 */
	public static int process02(Connection conn){

		Logger logger = Logger.getLogger("test");

		// add to tblmisc any editing that requires only a set number of items for modification
		// edit1 == 1 means all items. a comma within means selected item only
		int rowsAffected = 0;
		int counter = 0;

		try{
			String sql = "SELECT campus,coursealpha,coursenum,historyid,edit1,edit2 FROM tblcourse WHERE route=0 AND progress='MODIFY' and coursetype='PRE' ORDER BY campus,coursealpha,coursenum";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				String campus = AseUtil.nullToBlank(rs.getString("campus"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String edit1 = AseUtil.nullToBlank(rs.getString("edit1"));
				String edit2 = AseUtil.nullToBlank(rs.getString("edit2"));

				if (edit1.indexOf(",") > -1 || edit2.indexOf(",") > -1){
					//System.out.println((++counter) + ": " + campus + ":" + kix);

					edit1 = CCCM6100DB.getSequenceFromQuestionNumbers(conn,
																						campus,
																						Constant.TAB_COURSE,
																						edit1,
																						true);

					edit2 = CCCM6100DB.getSequenceFromQuestionNumbers(conn,
																						campus,
																						Constant.TAB_CAMPUS,
																						edit2,
																						true);

					sql = "UPDATE tblMISC SET edit1=?,edit2=? WHERE historyid=?";
					PreparedStatement ps2 = conn.prepareStatement(sql);
					ps2.setString(1,edit1);
					ps2.setString(2,edit2);
					ps2.setString(3,kix);
					ps2.executeUpdate();
					ps2.close();

					++rowsAffected;

				}

			} // while
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("Test - process02: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("Test - process02: " + e.toString());
		}

		return rowsAffected;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>