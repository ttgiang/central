<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.textdiff.*"%>
<%@ page import="com.ase.exception.*"%>
<%@ page import="com.ase.aseutil.html.*"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "DF00001";
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
		<form name="aseForm" action="testz.jsp" method="post">
<%
	/**
	*	ASE
	*	df00001.jsp
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
	String user = "THANHG";

	String alpha = "ACC";
	String num = "124";
	String type = "PRE";
	String comments = "";
	String title = "";
	String divisionCode = "";
	String sloCode = "";

	int i = 0;
	int j = 0;
	int seq = 0;
	int route = 0;

	String sql = "";
	String kix = "";
	String message = "";
	String[] arr = null;

	boolean cancelApproval = false;
	boolean cancelProposal = false;
	boolean cancelReview = false;

	boolean createOutlines = false;

	boolean requestApproval = false;
	boolean approveOutline = false;

	boolean requestReviewWithInApproval = false;
boolean reviewOutlinesInApproval = true;

	boolean sendToReviewOutlines = false;
boolean reviewOutlines = true;

	String reviewDate = "11/29/2010";
	String formSelect = "SPOPE,JRAND";
	String[] aFormSelect = formSelect.split(",");

	out.println("Start<br/>");

	if (processPage){
		try{

			//------------------------------------------------
			// cancelReview
			//------------------------------------------------
			if (cancelReview){

user = "THANHG";

				alpha = "ACC";
				//arr = "102,103,104,105".split(",");
				arr = "106,107,108,109".split(",");
				//arr = "102,103,104,105,106,107,108,109".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					msg = courseDB.cancelOutlineReview(conn,campus,alpha,num,user);
					out.println("review cancelled " + comments + Html.BR());
				}

				alpha = "ENG";
				//arr = "250,251,252,253".split(",");
				arr = "254,256,257B,257C".split(",");
				//arr = "250,251,252,253,254,256,257B,257C".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					msg = courseDB.cancelOutlineReview(conn,campus,alpha,num,user);
					out.println("review cancelled " + comments + Html.BR());
				}

			} // cancelReview

			//------------------------------------------------
			// approveOutline
			//------------------------------------------------
			if (approveOutline){

seq = 2;

route = 1396;
				alpha = "ACC";
				arr = "102,103,104,105".split(",");
				user = ApproverDB.getApproverBySeq(conn,campus,seq,route);
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					user = ApproverDB.getApproverBySeq(conn,campus,seq,route);
					msg = courseDB.approveOutline(conn,campus,alpha,num,user,true,comments,0,0,0);
					out.println("approved " + comments + Html.BR());
				}

route = 1219;

				alpha = "ENG";
				arr = "250,251,252,253".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					user = ApproverDB.getApproverBySeq(conn,campus,seq,route);
					msg = courseDB.approveOutline(conn,campus,alpha,num,user,true,comments,0,0,0);
					out.println("approved " + comments + Html.BR());
				}

			} // approveOutline

			//------------------------------------------------
			// cancelProposal
			//------------------------------------------------
			if (cancelProposal){

				alpha = "ACC";
				arr = "102,103,104,105,106,107,108,109".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					user = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");;
					CourseCancel.cancelOutline(conn,campus,alpha,num,user);
				}

				alpha = "ENG";
				arr = "250,251,252,253,254,256,257B,257C".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					user = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");;
					CourseCancel.cancelOutline(conn,campus,alpha,num,user);
				}

			} // cancelProposal


			//------------------------------------------------
			// cancelApproval
			//------------------------------------------------
			if (cancelApproval){

user = "THANHG";

				alpha = "ACC";
				//arr = "102,103,104,105".split(",");
				//arr = "106,107,108,109".split(",");
				arr = "102,103,104,105,106,107,108,109".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					courseDB.cancelOutlineApproval(conn,campus,alpha,num,user);
				}

				alpha = "ENG";
				//arr = "250,251,252,253".split(",");
				//arr = "254,256,257B,257C".split(",");
				arr = "250,251,252,253,254,256,257B,257C".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					courseDB.cancelOutlineApproval(conn,campus,alpha,num,user);
				}

			} // cancelApproval

			//------------------------------------------------
			// createOutlines
			//------------------------------------------------
			if (createOutlines){

user = "THANHG";

				arr = "102,103,104,105,106,107,108,109".split(",");
				for (i = 0; i < arr.length; i++){
					alpha = "ACC";
					num = arr[i];
					comments = alpha + " " + num;
					title = comments;
					divisionCode = "";
					sloCode = "";

					if (CourseCreate.createOutline(conn,alpha,num,title,comments,user,campus,divisionCode,sloCode,""))
						out.println("created " + comments + Html.BR());
					else
						out.println("unable to creat " + comments + Html.BR());
				} // for

				alpha = "ENG";
				arr = "250,251,252,253,254,256,257B,257C".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					msg = CourseModify.modifyOutlineX(conn,campus,alpha,num,user,Constant.COURSE_MODIFY_TEXT);
					if ("Exception".equals(msg.getMsg())){
						message = "Outline modification failed.";
					}
					else if (!"".equals(msg.getMsg())){
						message = "Unable to modify outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						sql = "UPDATE tblCourse "
							+ "SET edit1='1',edit2='1' "
							+ "WHERE campus=? AND "
							+ "CourseAlpha=? AND "
							+ "coursenum=? AND "
							+ "CourseType='PRE'";
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setString(1,campus);
						ps.setString(2,alpha);
						ps.setString(3,num);
						int rowsAffected = ps.executeUpdate();
						ps.close();
						ps = null;

						message = "outline modification " + alpha + " " + num;
					} // course modify

					out.println(message + Html.BR());
				} // for
			} // createOutlines

			//------------------------------------------------
			// sendToReviewOutlines
			//------------------------------------------------
			if (sendToReviewOutlines){

user = "THANHG";
reviewDate = "11/29/2010";

				alpha = "ACC";
				//arr = "102,103,104,105".split(",");
				arr = "106,107,108,109".split(",");
				//arr = "102,103,104,105,106,107,108,109".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					kix = helper.getKix(conn,campus,alpha,num,"PRE");

					if (ReviewerDB.setCourseReviewers(conn,campus,alpha,num,user,formSelect,reviewDate,comments,kix))
						out.println("review sent for " + comments + Html.BR());
					else
						out.println("review not sent for " + comments + Html.BR());
				}

				alpha = "ENG";
				//arr = "250,251,252,253".split(",");
				arr = "254,256,257B,257C".split(",");
				//arr = "250,251,252,253,254,256,257B,257C".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					kix = helper.getKix(conn,campus,alpha,num,"PRE");

					if (ReviewerDB.setCourseReviewers(conn,campus,alpha,num,user,formSelect,reviewDate,comments,kix))
						out.println("review sent for " + comments + Html.BR());
					else
						out.println("review not sent for " + comments + Html.BR());
				}

			} // sendToReviewOutlines

			//------------------------------------------------
			// reviewOutlines
			//------------------------------------------------
			if (reviewOutlines){

				alpha = "ACC";
				//arr = "102,103,104,105".split(",");
				//arr = "106,107,108,109".split(",");
				//arr = "102,103,104,105,106,107,108,109".split(",");
				arr = "101".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					kix = helper.getKix(conn,campus,alpha,num,"PRE");

					for (j = 0; j < aFormSelect.length; j++){
						runReviewMode(conn,campus,kix,alpha,num,aFormSelect[j],"REVIEW");
						CourseDB.endReviewerTask(conn,campus,alpha,num,aFormSelect[j]);
						out.println("reviewing " + comments + Html.BR());
					}

				}
			} // reviewOutlines

			//------------------------------------------------
			// requestApproval
			//------------------------------------------------
			if (requestApproval){

user = "THANHG";

route = 1396;
				alpha = "ACC";
				arr = "102,103,104,105".split(",");
				//arr = "106,107,108,109".split(",");
				//arr = "102,103,104,105,106,107,108,109".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					msg = CourseDB.setCourseForApproval(conn,
																	campus,
																	alpha,
																	num,
																	user,
																	Constant.COURSE_APPROVAL_TEXT,
																	route,
																	user);
					out.println("approving " + comments + Html.BR());
				}

route = 1219;
				alpha = "ENG";
				arr = "250,251,252,253".split(",");
				//arr = "254,256,257B,257C".split(",");
				//arr = "250,251,252,253,254,256,257B,257C".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					msg = CourseDB.setCourseForApproval(conn,
																	campus,
																	alpha,
																	num,
																	user,
																	Constant.COURSE_APPROVAL_TEXT,
																	route,
																	user);
					out.println("approving " + comments + Html.BR());
				}

			} // requestApproval

			//------------------------------------------------
			// requestReviewWithInApproval
			//------------------------------------------------
			if (requestReviewWithInApproval){

reviewDate = "11/29/2010";
seq = 1;

route = 1396;
				user = ApproverDB.getApproverBySeq(conn,campus,seq,route);
				alpha = "ACC";
				arr = "102,103,104,105".split(",");

				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					kix = helper.getKix(conn,campus,alpha,num,"PRE");

					for (j = 0; j < aFormSelect.length; j++){
						if (ReviewerDB.setCourseReviewers(conn,campus,alpha,num,user,formSelect,reviewDate,comments,kix))
							out.println("review sent for " + comments + Html.BR());
						else
							out.println("review not sent for " + comments + Html.BR());
					}
				}

route = 1219;

				user = ApproverDB.getApproverBySeq(conn,campus,seq,route);
				alpha = "ENG";
				arr = "250,251,252,253".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					kix = helper.getKix(conn,campus,alpha,num,"PRE");

					for (j = 0; j < aFormSelect.length; j++){
						if (ReviewerDB.setCourseReviewers(conn,campus,alpha,num,user,formSelect,reviewDate,comments,kix))
							out.println("review sent for " + comments + Html.BR());
						else
							out.println("review not sent for " + comments + Html.BR());
					}
				}

			} // requestReviewWithInApproval

			//------------------------------------------------
			// reviewOutlinesInApproval
			//------------------------------------------------
			if (reviewOutlinesInApproval){

				alpha = "ACC";
				arr = "102".split(",");
				for (i = 0; i < arr.length; i++){
					num = arr[i];
					comments = alpha + " " + num;
					kix = helper.getKix(conn,campus,alpha,num,"PRE");

					for (j = 0; j < aFormSelect.length; j++){
						runReviewMode(conn,campus,kix,alpha,num,aFormSelect[j],Constant.COURSE_REVIEW_IN_APPROVAL);
						CourseDB.endReviewerTask(conn,campus,alpha,num,aFormSelect[j]);
						out.println("review in approval " + comments + Html.BR());
					}
				}

			} // reviewOutlinesInApproval


		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"df00001",user);
%>

</table>

<%!

	public static String runReviewMode(Connection conn,
												String campus,
												String kix,
												String alpha,
												String num,
												String user,
												String modeText){

		Logger logger = Logger.getLogger("test");

		int item = 0;
		int mode = 0;
		int counter = 0;
		int runs = 3;
		int rowsAffected = 0;

		Review reviewDB = null;

		try{
			if (("APPROVAL").equals(modeText))
				mode = Constant.APPROVAL;
			else if (("MODIFY").equals(modeText))
				mode = Constant.MODIFY;
			else if (("REVIEW").equals(modeText))
				mode = Constant.REVIEW;
			else if (("REVIEW_IN_APPROVAL").equals(modeText))
				mode = Constant.REVIEW_IN_APPROVAL;

			while(++counter < runs){
				reviewDB = new Review();
				reviewDB.setId(0);
				reviewDB.setUser(user);
				reviewDB.setAlpha(alpha);
				reviewDB.setNum(num);
				reviewDB.setHistory(kix);
				reviewDB.setComments(user + "-" + modeText + "<br/>" + AseUtil.getCurrentDateTimeString());
				reviewDB.setItem(QuestionDB.getQuestionNumber(conn,campus,1,++item));
				reviewDB.setCampus(campus);
				reviewDB.setEnable(false);
				reviewDB.setAuditDate(AseUtil.getCurrentDateTimeString());
				rowsAffected = ReviewDB.insertReview(conn,reviewDB,"1",mode);
			} // while

		}
		catch(Exception ex){
			logger.fatal("runReviewMode - " + ex.toString());
		}

		return "";
	} // runReviewMode

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>