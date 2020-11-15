<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.htmlcleaner.*"%>
<%@ page import="java.awt.Color"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.ase.aseutil.report.*"%>
<%@ page import="com.ase.exception.*"%>

<%@ page import="org.joda.time.DateTime"%>
<%@ page import="org.joda.time.Months"%>

<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.io.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.USER,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ACC";
	String num = "101";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "p5i26k10175";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{
			runReviewMode(conn,"ARISB");
		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static String runReviewMode(Connection conn,String user){

Logger logger = Logger.getLogger("test");

		String campus = "UHMC";
		String alpha = "ACC";
		String num = "124";
		String kix = "I46c12l10207";
		String modeText = "";

		//user = "CADLER";

		int item = 0;
		int mode = 0;
		int counter = 0;
		int runs = 10;
		int rowsAffected = 0;

		Review reviewDB = null;

		boolean debug = true;

		try{

			if (debug) System.out.println("------------------- START");

			mode = Constant.APPROVAL;
			//mode = Constant.MODIFY;
			//mode = Constant.REVIEW;
			//mode = Constant.REVIEW_IN_APPROVAL;

			modeText = "APPROVAL";
			//modeText = "MODIFY";
			//modeText = "REVIEW";
			//modeText = "REVIEW_IN_APPROVAL";

			boolean endReviewerTask = false;

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
				reviewDB.setAuditDate((new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date()));
				rowsAffected = ReviewDB.insertReview(conn,reviewDB,"1",mode);
			} // while

			if (endReviewerTask){

				rowsAffected = CourseDB.approveOutlineReview(conn,
																			campus,
																			kix,
																			alpha,
																			num,
																			user,
																			user + "- comments",
																			1,
																			2,
																			3);

				CourseDB.endReviewerTask(conn,campus,alpha,num,user);
			}

			if (debug) System.out.println("------------------- END");

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