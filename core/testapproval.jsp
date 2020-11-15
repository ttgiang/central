<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.w3c.tidy.Tidy"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.aseutil.html.Html2Text"%>

<%@ page import="com.ase.aseutil.html.HtmlSanitizer"%>

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
		<form method="post" action="testx.jsp" name="aseForm">
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

	String campus = "HIL";
	String alpha = "ENG";
	String num = "100";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "u53c30k11233";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	System.out.println("Start<br/>");
	int start = 0;
	int end = 0;

	if (processPage){

		campus = "KAU";

		out.println(approvalTest(conn,campus,user));

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	//
	// APPROVAL TESTING
	//

	public static int approvalTest(Connection conn,String campus,String user) throws Exception {

		// this routine places data into a temp table for a campus
		// then runs through the approval process.if the route exists, it uses it.
		// if not, it will use a default.

		try{
			String sql = "";
			PreparedStatement ps = null;

			// clear any pending data
			JobsDB.deleteJob("ApprovalTest");

			// put data in for testing
			sql = "INSERT INTO tblJobs(job,subjob,historyid,campus,alpha,num,type,auditby,auditdate,proposer,route) "
				+ "select 'Testing','Testing',historyid,campus,CourseAlpha,CourseNum,coursetype,proposer,auditdate,proposer,route "
				+ "from tblcourse  "
				+ "WHERE campus=? "
				+ "AND proposer=? "
				+ "AND coursetype='PRE'";
			ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ps.setString(2,user);
			ps.executeUpdate();
			ps.close();

			int i = 0;

			// for each outline found, do the following
			//
			// 1) set to approval
			// 2) put through review process
			// 3) add 3 comments per questions
			// 4) end review
			// 5) approve outline and on to next
			// 6) proposer cancels approval process

			com.ase.aseutil.CourseDB courseDB = new com.ase.aseutil.CourseDB();

			sql = "select historyid, alpha AS coursealpha,num AS coursenum,proposer,route from tbljobs order by alpha,num";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
				String num = AseUtil.nullToBlank(rs.getString("coursenum"));
				String kix = AseUtil.nullToBlank(rs.getString("historyid"));
				String proposer = AseUtil.nullToBlank(rs.getString("proposer"));
				int route = NumericUtil.getInt(rs.getInt("route"),0);

				if (route == 0){
					// make this route using THANHG for testing
					route = IniDB.getIDByCampusCategoryKid(conn,campus,"ApprovalRouting","THANHG");

					// if routing not found, create
					if (route <= 0){
						ApproverDB.addApprovalRouting(conn,campus,user,"THANHG","THANHG","");

						route = IniDB.getIDByCampusCategoryKid(conn,campus,"ApprovalRouting","THANHG");

						Approver approverDB = new Approver("0",
																		"1",
																		"THANHG",
																		"THANHG",
																		false,
																		false,
																		user,
																		AseUtil.getCurrentDateTimeString(),
																		campus,
																		route,
																		null,
																		null,
																		null);

						ApproverDB.insertApprover(conn,approverDB,0);
					}

					if (route > 0){
						ApproverDB.setApprovalRouting(conn,campus,alpha,num,route);
					}
				} // route == 0

				// do not combine as ELSE
				if (route > 0){
					// 1
					courseDB.setCourseForApproval(conn,campus,alpha,num,proposer,Constant.COURSE_APPROVAL_TEXT,route,proposer);

					// 2 - 5 (users add comments for review)
					// approved by all but last person
					approvalTest(conn,campus,proposer,kix,alpha,num,route);

					// 6 - with a rejection from last approver, we will set back to approval process before cancel
					courseDB.setCourseForApproval(conn,campus,alpha,num,proposer,Constant.COURSE_APPROVAL_TEXT,route,proposer);

					//courseDB.cancelOutlineApproval(conn,campus,alpha,num,proposer);

					++i;

				} // route > 0

			} // while
			rs.close();
			ps.close();

			courseDB = null;


		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return 0;

	}

	/*
	 *
	 * for each approver, send out so many reviews for so many questions
	 * so manies are set in this routine
	 *
	*/
	public static int approvalTest(Connection conn,String campus,String user,String kix,String alpha,String num,int route) throws Exception {

		boolean debug = true;

		if (debug) System.out.println("-----------------------");

		// get all approvers for the route to use
		Approver ap = com.ase.aseutil.ApproverDB.getApprovers(conn,campus,alpha,num,user,false,route);

		if (debug) System.out.println("Approvers: " + ap.getAllApprovers());

		// each approver adds 2 messages
		int[] qn = QuestionDB.getCourseEditableItems(conn,campus);

		// split approvers into array of users to approve
		String[] users = ap.getAllApprovers().split(",");

		int approversCount = users.length;
		int questionCount = 1;
		int loopCount = 1;
		int replyCount = 1;

		// last person rejects the outline
		boolean approval = true;

		// run through each approver and
		// create a post with X number of quetions
		// replies for each

		try{

			int getLastApproverSequence = ApproverDB.getLastApproverSequence(conn,campus,kix);
			if (getLastApproverSequence <= 0){
				getLastApproverSequence = 0;
			}

			if (getLastApproverSequence < users.length){

				int i = getLastApproverSequence;

				while(i<approversCount && approval){

					String approver = users[i];

					String comments = approver + " - " + AseUtil.getCurrentDateTimeString();

					//2
					boolean setCourseReviewers = ReviewerDB.setCourseReviewers(conn,campus,alpha,num,approver,approver,"12/01/2019",comments,kix);

					for(int y=0; y<questionCount; y++){

						int tid = 0;

						for(int x=0; x<loopCount; x++){

							int item = qn[y];

							int rowsAffected = ReviewDB.insertReview(conn,new Review(campus,
																										approver,
																										alpha,
																										num,
																										kix,
																										comments,
																										AseUtil.getCurrentDateTimeString(),
																										item,
																										true),
																										"1",
																										Constant.REVIEW_IN_APPROVAL);

							// for each forum added, let's add 20 posts/replies for testing
							int fid = ForumDB.getLastForumID(conn);

							int mid = ForumDB.getLastMessageID(conn,fid);

							if (tid == 0){
								tid = mid;
							}

							int tp = mid;

							item = QuestionDB.getCourseSequenceByNumber(conn,campus,"1",item);

							addComments(conn,user,fid,item,tid,tp,mid,replyCount);

						} // x

					} // y

					//4
					CourseDB.endReviewerTask(conn,campus,alpha,num,approver);

					if (i==users.length-1){
						approval = false;
					}

					//5
					com.ase.aseutil.CourseApproval.approveOutlineX(conn,campus,alpha,num,approver,approval,comments,i,i*i+1,i*i+2);

					System.out.println(i + " - " + approver + " - " + approval);

					++i;

				} // while
			} // if
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return 0;

	}

	//
	// add comments to board
	//
	public static int addComments(Connection conn,String user,int fid,int item,int tid,int tp,int mid,int replyCount) throws Exception {

		int rowsAffected = 0;

		try{
			for(int k=2; k<replyCount; k++){

				Messages messages = new Messages();
				messages.setTimeStamp(AseUtil.getCurrentDateTimeString());
				messages.setForumID(fid);
				messages.setItem(item);
				messages.setThreadID(tid);
				messages.setThreadParent(tp);
				messages.setThreadLevel(k);
				messages.setAuthor(user);
				messages.setNotify(true);
				messages.setSubject("Question No. " + item + " - " + mid);
				messages.setBody("Comments");
				messages.setAcktion(Constant.REVIEW_IN_APPROVAL);
				rowsAffected = ForumDB.insertMessage(conn,messages);

				mid = ForumDB.getLastMessageID(conn,fid);

				tp = mid;

			} // k
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

		return rowsAffected;
	}

	// DRIVER routines END

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>