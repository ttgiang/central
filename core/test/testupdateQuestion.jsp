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
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "KAP";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "d17j24i101951595";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{

			CCCM6100 cccm = new CCCM6100();
			cccm.setId(1748);
			cccm.setCampus(campus);
			cccm.setType("wysiwyg");
			cccm.setQuestion_Number(49);
			cccm.setCCCM6100("question");
			cccm.setQuestion_Type("wysiwyg");
			cccm.setInclude("Y");
			cccm.setRequired("N");
			cccm.setHelpFile("helpFile");
			cccm.setAudioFile("audioFile");
			cccm.setAuditBy("auditby");
			cccm.setAuditDate(AseUtil.getCurrentDateTimeString());
			cccm.setQuestion_Friendly("questionFriendly");
			cccm.setHelp("help");
			cccm.setDefalt("defalt");
			cccm.setQuestion_Ini("question_ini");
			cccm.setQuestionSeq(2);
			cccm.setQuestion_Len(0);
			cccm.setQuestion_Max(0);
			cccm.setQuestion_Change("Y");

			updateQuestion(conn,cccm,45,"r");

		}
		catch(Exception ce){
			System.out.println(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	public static Msg updateQuestion(Connection conn,CCCM6100 cccm,int oldSeq,String tableName) throws SQLException {

Logger logger = Logger.getLogger("test");

		int junk = 0;
		int totalElements = 0;

		int lid = cccm.getId();
		int newSeq = cccm.getQuestionSeq();
		int questionNumber = cccm.getQuestion_Number();
		String questionType = cccm.getType();
		String campus = cccm.getCampus();
		String question = cccm.getCCCM6100();
		String help = cccm.getHelp();
		String included = cccm.getInclude();
		String required = cccm.getRequired();
		String change = cccm.getQuestion_Change();
		String auditby = cccm.getAuditBy();
		String auditdate = cccm.getAuditDate();
		String helpFile = cccm.getHelpFile();
		String audioFile = cccm.getAudioFile();
		String questionFriendly = cccm.getQuestion_Friendly();
		String defalt = cccm.getDefalt();

		/*
			there are possible scenarios

			0) Include is N

			1) Old Seq = 0

				When old sequence is 0 and include is yes, this means that we are activating an item

			2) new seq = old seq

				do not have to check for include = N or Y. When N, handled by #0. If yes, no change here.

			3) new seq is greater old seq

			4) new seq is less than old seq
				changing the sequence number.
				1) start by putting the requested change out of the way
				2) update all sequence between the new seq and old seq
				3) update the displaced item from #1 with the correct value

				for example, assuming the old seq = 6 and we want to make it to 2

				Original order:		1 2 3 4 5 6 7 8 9 10
				#1 above:				-1 1 2 3 4 5 7 8 9 10	(6 was moved out of the way by setting to -1)
				#2 above:				-1 1 3 4 5 6 7 8 9 10	(everthing from the old seq to less than new seq is moved)
				#3	above:				1 2 3 4 5 6 7 8 9 10		(put -1 back into its correct spot)

		*/
		int qNumber = 0;				// question number from database
		int qSeq = 0;					// sequence from database
		int rowsAffected = 0;
		String sql;
		String table = "";
		PreparedStatement ps;

		int total = 0;							// temp variable
		int i = 0;
		Msg msg = new Msg();

		int os = 0;
		int ns = 0;
		int qn = 0;

		boolean debug = true;

		String editItems = "";
		String[] aEditItems = null;

		try {
			AseUtil aseUtil = new AseUtil();

			debug = DebugDB.getDebug(conn,"QuestionDB");

			logger.info("----------------- START");

			if ("r".equals(tableName)){
				table = "tblCourseQuestions";
				editItems = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'" );
			}
			else if ("c".equals(tableName)){
				table = "tblCampusQuestions";
				editItems = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
			}
			else if ("p".equals(tableName)){
				table = "tblProgramQuestions";
				editItems = aseUtil.lookUp(conn, "tblCampus", "programitems", "campus='" + campus + "'" );
			}

			aEditItems = editItems.split(",");
			totalElements = aEditItems.length;

			logger.info("lid: " + lid);
			logger.info("newSeq: " + newSeq);
			logger.info("questionNumber: " + questionNumber);
			logger.info("questionType: " + questionType);
			logger.info("campus: " + campus);
			logger.info("question: " + question);
			logger.info("help: " + help);
			logger.info("included: " + included);
			logger.info("required: " + required);
			logger.info("change: " + change);
			logger.info("auditby: " + auditby);
			logger.info("auditdate: " + auditdate);
			logger.info("helpFile: " + helpFile);
			logger.info("audioFile: " + audioFile);
			logger.info("questionFriendly: " + questionFriendly);
			logger.info("defalt: " + defalt);
			logger.info("table: " + table);

			if ("N".equals(included)){

				logger.info("NOT included");

				aEditItems = new String[totalElements];
				for(junk=0;junk<totalElements;junk++)
					aEditItems[junk]="";

				// when removing item from use, reset the question to what is in CCCM6100
				CCCM6100 cm = CCCM6100DB.getCCCM6100ByFriendlyName(conn,questionFriendly);

				//1
				sql = "UPDATE " + table
					+ " SET questionseq=0,include='N',auditby=?,auditdate=?,question=?,help=?,defalt=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, auditby);
				ps.setString(2, AseUtil.getCurrentDateTimeString());
				ps.setString(3, cm.getCCCM6100());
				ps.setString(4, cm.getCCCM6100());
				ps.setString(5, cm.getDefalt());
				ps.setString(6, campus);
				ps.setInt(7, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM "
						+ table
						+ " WHERE campus=? "
						+ " AND include='Y' "
						+ " AND questionseq > ? "
						+ " ORDER BY questionseq";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, oldSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os - 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
				}
				rs.close();
				ps.close();

/*
	remove from list. requires removing (shrinking list)
*/
aEditItems[oldSeq] = "0";

			}
			else if (oldSeq==0){

				logger.info("oldSeq==0");

				totalElements = totalElements + 1;
				aEditItems = new String[totalElements];
				for(junk=0;junk<totalElements;junk++)
					aEditItems[junk]="";

				//1 - moving everything up by 1
				sql = "SELECT questionnumber,questionseq FROM "
					+ table
					+ " WHERE campus=? "
					+ " AND include='Y' "
					+ " AND questionseq>=? "
					+ " ORDER BY questionseq DESC";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, newSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os + 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
aEditItems[os] = os + "," + ns;
				}
				rs.close();
				ps.close();

				//2 - add new
				sql = "UPDATE "
					+ table
					+ " SET questionseq=?,include='Y',change=?,auditby=?,auditdate=?,required=?,helpfile=?,audiofile=?,help=?,defalt=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, newSeq);
				ps.setString(2, change);
				ps.setString(3, auditby);
				ps.setString(4, AseUtil.getCurrentDateTimeString());
				ps.setString(5, required);
				ps.setString(6, helpFile);
				ps.setString(7, audioFile);
				ps.setString(8, help);
				ps.setString(9, defalt);
				ps.setString(10, campus);
				ps.setInt(11, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

// new item is added and is editable
aEditItems[newSeq] = "" + newSeq;

			}
			else if (newSeq == oldSeq){

				logger.info("newSeq==oldSeq");

				aEditItems = new String[totalElements];
				for(junk=0;junk<totalElements;junk++)
					aEditItems[junk]="";

				sql = "UPDATE "
					+ table
					+ " SET change=?,question=?,help=?,auditby=?,auditdate=?,required=?,helpfile=?,audiofile=?,defalt=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, change);
				ps.setString(2, question);
				ps.setString(3, help);
				ps.setString(4, auditby);
				ps.setString(5, AseUtil.getCurrentDateTimeString());
				ps.setString(6, required);
				ps.setString(7, helpFile);
				ps.setString(8, audioFile);
				ps.setString(9, defalt);
				ps.setString(10, campus);
				ps.setInt(11, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else if (newSeq > oldSeq){

				logger.info("newSeq>oldSeq");

				aEditItems = new String[totalElements];
				for(junk=0;junk<totalElements;junk++)
					aEditItems[junk]="";

				//1
				sql = "UPDATE "
					+ table
					+ " SET questionseq=-1,question=?,help=?,include=?,change=?,auditby=?,auditdate=?,required=?,helpfile=?,audiofile=?,defalt=? "
					+ " WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, question);
				ps.setString(2, help);
				ps.setString(3, included);
				ps.setString(4, change);
				ps.setString(5, auditby);
				ps.setString(6, AseUtil.getCurrentDateTimeString());
				ps.setString(7, required);
				ps.setString(8, helpFile);
				ps.setString(9, audioFile);
				ps.setString(10, defalt);
				ps.setString(11, campus);
				ps.setInt(12, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();
//aEditItems[newSeq] = "need to do";

				//2
				sql = "SELECT questionnumber,questionseq FROM "
					+ table
					+ " WHERE campus=? AND include='Y' AND (questionseq>? AND questionseq<=?) ORDER BY questionseq";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, oldSeq);
				ps.setInt(3, newSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os - 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
aEditItems[os] = os + "," + ns;
				}
				rs.close();
				ps.close();


				//3
				sql = "UPDATE "
					+ table
					+ " SET questionseq=?,required=?,helpfile=?,audiofile=? WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, newSeq);
				ps.setString(2, required);
				ps.setString(3, helpFile);
				ps.setString(4, audioFile);
				ps.setString(5, campus);
				ps.setInt(6, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

aEditItems[newSeq] = "" + newSeq;
			}
			else if (newSeq < oldSeq){

				logger.info("newSeq < oldSeq");

				aEditItems = new String[totalElements];
				for(junk=0;junk<totalElements;junk++)
					aEditItems[junk]="";

				//1
				sql = "UPDATE "
					+ table
					+ " SET questionseq=-1,question=?,help=?,include=?,change=?,auditby=?,auditdate=?,required=?,helpfile=?,audiofile=?,defalt=? "
					+ "WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, question);
				ps.setString(2, help);
				ps.setString(3, included);
				ps.setString(4, change);
				ps.setString(5, auditby);
				ps.setString(6, AseUtil.getCurrentDateTimeString());
				ps.setString(7, required);
				ps.setString(8, helpFile);
				ps.setString(9, audioFile);
				ps.setString(10, defalt);
				ps.setString(11, campus);
				ps.setInt(12, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();
//aEditItems[newSeq] = "need to do";

				//2
				sql = "SELECT questionnumber,questionseq FROM "
					+ table
					+ " WHERE campus=? AND include='Y' AND (questionseq>=? AND questionseq<?) ORDER BY questionseq DESC";
				ps = conn.prepareStatement(sql);
				ps.setString(1, campus);
				ps.setInt(2, newSeq);
				ps.setInt(3, oldSeq);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					qn = rs.getInt(1);
					os = rs.getInt(2);
					ns = os + 1;
					qNumber = qn;
					qSeq = ns;
					sql = "UPDATE "
							+ table
							+ " SET questionseq=? WHERE campus=? AND questionnumber=?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,qSeq);
					ps.setString(2,campus);
					ps.setInt(3,qNumber);
					rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");
aEditItems[os] = os + "," + ns;
				}
				rs.close();
				ps.close();

				//3
				sql = "UPDATE "
						+ table
						+ " SET questionseq=?,change=?,required=?,helpfile=?,audiofile=? WHERE campus=? AND questionnumber=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, newSeq);
				ps.setString(2, change);
				ps.setString(3, required);
				ps.setString(4, helpFile);
				ps.setString(5, audioFile);
				ps.setString(6, campus);
				ps.setInt(7, questionNumber);
				rowsAffected = ps.executeUpdate();
				ps.close();

aEditItems[newSeq] = "" + newSeq;
			}

			logger.info("----------------- END");

System.out.println("---------------------------");
for(junk=0;junk<totalElements;junk++)
	System.out.println(junk + " - " + aEditItems[junk]);

			aseUtil = null;

		} catch (SQLException se) {
			logger.fatal("QuestionDB: updateQuestion - " + se.toString());
			msg.setMsg("Exception");
			msg.setErrorLog("QuestionDB: updateQuestion - " + se.toString());
		} catch (Exception e) {
			logger.fatal("QuestionDB: updateQuestion - " + e.toString());
			msg.setMsg("Exception");
			msg.setErrorLog("QuestionDB: updateQuestion - " + e.toString());
		}

		return msg;
	}
%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>