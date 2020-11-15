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

	String campus = "LEE";
	String alpha = "MATH";
	String num = "206";
	String type = "PRE";
	String user = "MLANE";
	String task = "Modify_outline";
	String kix = "I52a8c91582648";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{

/*
			CCCM6100 cccm = new CCCM6100();
			cccm.setId(2322);
			cccm.setCampus(campus);
			cccm.setType("wysiwyg");
			cccm.setQuestion_Number(12);
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
			cccm.setQuestionSeq(20);
			cccm.setQuestion_Len(0);
			cccm.setQuestion_Max(0);
			cccm.setQuestion_Change("Y");

			updateQuestion(conn,cccm,4,"r");
*/
final int NEW_GREATER_OLD = 0;
final int OLD_GREATER_NEW = 1;
final int NO_CHANGE = 2;
final int INSERT_QUESTION = 3;
final int REMOVE_QUESTION = 4;

			// out.println(resetQuestionFlags(conn,campus,4,4,REMOVE_QUESTION));

			// out.println(showFields(conn,campus,alpha,num,"rtn",1,true));
			System.out.println(setProgramEnabledItems(conn,campus,kix,1,true,"1"));

		}
		catch(Exception ce){
			//logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/*
	 * setProgramEnabledItems - sets individual enabled items
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	q			int
	 *	@param	enabled	boolean
	 *	@param	tb			String
	 *	<p>
	 *	@return int
	 */
	public static int setProgramEnabledItems(Connection conn,
															String campus,
															String kix,
															int q,
															boolean enabled,
															String tb) throws Exception {

Logger logger = Logger.getLogger("test");

		int i = 0;
		int rowsAffected = 0;

		boolean debug = false;

		try{
			debug = DebugDB.getDebug(conn,"QuestionDB");

			if (debug) System.out.println("---------------------- START");

			// get the questions in use. Must be ordered by questions seq
			int[] qnProgram = QuestionDB.getProgramEditableItems(conn,campus);

			if (debug) System.out.println("campus: " + campus);
			if (debug) System.out.println("kix: " + kix);
			if (debug) System.out.println("q: " + q);
			if (debug) System.out.println("enabled: " + enabled);
			if (debug) System.out.println("tb: " + tb);

			if (qnProgram != null){

				if (debug) System.out.println("qnProgram.length: " + qnProgram.length);

				// get current editable items (if any)
				int programEdits = 1;
				String[] aProgramEdits = null;
				String[] edits = ProgramsDB.getProgramEdits(conn,campus,kix);
				if (edits != null){

					if (debug) System.out.println("edits not null");

					// since we are here to enable items for edit, if a comma was not found,
					// that means we currently permit edits on all items.
					// for this to work, we remove edits on all items and set all to off
					// and permit following code below to enable the appropriate ones.

					// edits are either 1 to indicate editable for all items in outline,
					// or CSV of question numbers allowed to edit
					// check for comma to ensure that it's enabled or not

					if (edits[programEdits].indexOf(",") == -1){
						aProgramEdits = new String[qnProgram.length];
						for(i=0; i<qnProgram.length; i++){
							aProgramEdits[i] = "0";
						}
					}
					else{
						aProgramEdits = edits[programEdits].split(",");
					}

					// if the question matches the one needing enablement, set it
					// qnProgram contains actual question numbers
					// q is the question to enable
					// qnProgram and aProgramEdits should be in order
					boolean found = false;
					String junk = "";

					// tb = 1 for course tab
					if ((Constant.ON).equals(tb)){

						found = false;
						i=0;
						while(i<qnProgram.length && !found){

							if (qnProgram[i]>0){

								if (qnProgram[i]==q){

									if (enabled)
										aProgramEdits[i] = ""+q;
									else
										aProgramEdits[i] = "0";

									found = true;
								}
							} // question number > 0

							i++;
						} // while

					} // if tb ON

					// reassemble as string to save back to table
					junk = "";
					for(i=0; i<aProgramEdits.length; i++){
						if (i==0 || (Constant.BLANK).equals(junk))
							junk = aProgramEdits[i];
						else
							junk = junk + "," + aProgramEdits[i];
					}
					rowsAffected = ProgramsDB.setProgramEdit(conn,campus,kix,junk);

				} // edits != null

			} // qnProgram != null

			if (debug) System.out.println("---------------------- END");

		}
		catch(SQLException e){
			logger.fatal(e.toString());
		}
		catch(Exception e){
			logger.fatal(e.toString());
		}

		return rowsAffected;
	}

	/*
	 * showFields
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	alpha		String
	 *	@param	num		String
	 *	@param	rtn		String
	 *	@param	editing	int
	 *	@param	enabling	boolean
	 * <p>
	 *	@return String
	 */
	public static String showFields(Connection conn,
												String campus,
												String alpha,
												String num,
												String rtn,
												int editing,
												boolean enabling) throws SQLException {

		//Logger logger = Logger.getLogger("test");

		int j;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		String table = "";
		String fieldName = "";
		String hiddenFieldSystem = "";
		String hiddenFieldCampus = "";
		String cQuestionSeq = "";
		String cQuestionNumber = "";
		String cQuestion = "";
		String cQuestionFriendly = "";
		int fieldCountSystem = 0;
		int fieldCountCampus = 0;
		Question question;

		int i = 0;
		int savedCounter = 0;
		int totalItems = 0;

		String checked[] = null;
		String checkMarks[] = null;
		String[] edits = null;
		int editsCount = 0;
		String thisEdit = null;
		String rowColor = "";

		boolean debug = false;

		try{

			debug = DebugDB.getDebug(conn,"QuestionDB");

			if (debug) System.out.println("---------------- QuestionDB - showFields - START");

			if (debug) System.out.println("campus: " + campus);
			if (debug) System.out.println("alpha: " + alpha);
			if (debug) System.out.println("num: " + num);
			if (debug) System.out.println("editing: " + editing);
			if (debug) System.out.println("enabling: " + enabling);

			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
			buf.append("<tr bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>");

			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			if (list != null){

				totalItems = list.size();

				if (debug) System.out.println("course items: " + totalItems);

				// initialize
				checked = new String[totalItems];
				for (i=0; i<list.size(); i++){
					checked[i] = "";
				}

				/*
					editing is available when we are coming back in to enable additional fields

					edit1-2 contains a single value of '1' indiciating that all fields are editable.
					however, during the modification/approval process, edit1-2 may contain CSV
					due to rejection or reasons for why editing is needed

					when the value is a single '1', we set up for all check marks ON.

					when there are multiple values (more than a '1' or a comma is there), we
					set up for ON/OFF.

					enabling is when approvers wishes to enable items for edits by proposer.
				*/
				if (editing==1 || enabling){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");

					if (!"".equals(edits[1])){
						thisEdit = edits[1];

						if ((Constant.ON).equals(thisEdit)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thisEdit.split(",");

							// cannot base loops on number of questions since questions
							// may be added removed from an outline at will. Base on number
							// of edit flags.
							if (checkMarks!=null)
								editsCount = checkMarks.length;

							for (i=0; i<editsCount; i++){
								if (!(Constant.OFF).equals(checkMarks[i]))
									checked[i] = "checked";
							}	// for
						} // if equals 1
					}
				}	// if editing || enabling

				savedCounter = list.size();

				for (i=0; i<savedCounter; i++){
					question = (Question)list.get(i);
					// field names are Course_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();

					fieldName = "Course_" + cQuestionNumber;

					if ( hiddenFieldSystem.length() == 0 )
						hiddenFieldSystem = cQuestionNumber;
					else
						hiddenFieldSystem = hiddenFieldSystem +"," + cQuestionNumber;

					++fieldCountSystem;

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					temp = "<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">" + cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top class=\"datacolumn\">" + cQuestion + "</td></tr>";

					buf.append( temp );
				}	// for
			}	// if list for campus

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><hr size=\"1\"></td></tr>");

			list = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			if (list != null){
				totalItems = list.size();

				if (debug) System.out.println("campus items: " + totalItems);

				checked = new String[totalItems];
				for (i=0; i<totalItems; i++){
					checked[i] = "";
				}

				if (editing==1 || enabling){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");

					if (debug) System.out.println("edits[0]: " + edits[0]);
					if (debug) System.out.println("edits[1]: " + edits[1]);
					if (debug) System.out.println("edits[2]: " + edits[2]);

					if (edits != null){
						if (!(Constant.BLANK).equals(edits[2])){
							thisEdit = edits[2];
							if ((Constant.ON).equals(thisEdit)){
								for (i=0; i<totalItems; i++){
									checked[i] = "checked";
								}
							}
							else{
								checkMarks = thisEdit.split(",");
								for (i=0; i<totalItems && i<checkMarks.length; i++){
									if (!(Constant.OFF).equals(checkMarks[i]))
										checked[i] = "checked";
								}
							}
						}
					} // edits != null

				} // editing==1 || enabling

				for (i=0; i<totalItems; i++){
					question = (Question)list.get(i);
					// field names are SYS_xxx or CAMPUS_xxx to indicate
					// the type of question and the number that's editable
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();

					fieldName = "Campus_" + cQuestionNumber;

					if ( hiddenFieldCampus.length() == 0 )
						hiddenFieldCampus = cQuestionNumber;
					else
						hiddenFieldCampus = hiddenFieldCampus +"," + cQuestionNumber;

					++fieldCountCampus;

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					temp = "<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">" + (savedCounter+i+1) + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top class=\"datacolumn\">" +  cQuestion + "</td></tr>";

					buf.append( temp );
				}	// for
			}	// if campus

			buf.append("<tr>" );
			buf.append("<td class=\"textblackTHRight\" colspan=\"3\"><hr size=\"1\">" );
			buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\" onClick=\"return checkForm(\'s\')\">&nbsp;");
			buf.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return checkForm(\'c\')\">" );
			buf.append("<input type=\"hidden\" name=\"formAction\" value=\"c\">" );
			buf.append("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">" );
			buf.append("<input type=\"hidden\" name=\"alpha\" value=\"" + alpha + "\">" );
			buf.append("<input type=\"hidden\" name=\"num\" value=\"" + num + "\">" );
			buf.append("<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">" );
			buf.append("<input type=\"hidden\" name=\"rtn\" value=\"" + rtn + "\">" );
			buf.append("<input type=\"hidden\" name=\"edit\" value=\"" + editing + "\">" );
			buf.append("<input type=\"hidden\" name=\"enabling\" value=\"" + enabling + "\">" );
			buf.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"fieldCountCampus\" value=\"" + fieldCountCampus + "\">" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldCampus\" value=\"" + hiddenFieldCampus + "\">" );
			buf.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">" );
			buf.append("</td>" );
			buf.append("</tr>" );
			buf.append( "</table>" );

			if (debug) System.out.println("---------------- QuestionDB - showFields - END");

		}
		catch( SQLException e ){
			System.out.println("QuestionDB: showFields - " + e.toString());
		}
		catch( Exception ex ){
			System.out.println("QuestionDB: showFields - " + ex.toString());
		}

		return buf.toString();

	}

	public static int resetQuestionFlags(Connection conn,String campus,int oldSeq,int newSeq,int direction) throws SQLException {

Logger logger = Logger.getLogger("test");

		String alpha = "";
		String num = "";
		String type = "PRE";

		String edit = "";
		String oldValue = "";
		String[] aEdit = null;

		int i = 0;
		int length = 0;

		boolean debug = true;

		final int NEW_GREATER_OLD = 0;
		final int OLD_GREATER_NEW = 1;
		final int NO_CHANGE = 2;
		final int INSERT_QUESTION = 3;
		final int REMOVE_QUESTION = 4;

		try{
			if (debug) System.out.println("-------------------- resetQuestionFlags - START");
			if (debug) System.out.println("direction: " + direction);
			if (debug) System.out.println("campus: " + campus);
			if (debug) System.out.println("oldSeq: " + oldSeq);
			if (debug) System.out.println("newSeq: " + newSeq);

			// decrement for work with array
			--oldSeq;
			--newSeq;

			String sql = "SELECT coursealpha,coursenum,edit1 "
					+ "FROM tblcourse "
					+ "where campus=? "
					+ "AND coursetype='PRE' "
					+ "AND edit1 like '%,%' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();

			if (direction == NEW_GREATER_OLD){
				while (rs.next()){
					alpha = rs.getString("coursealpha");
					num = rs.getString("coursenum");
					edit = rs.getString("edit1");

					if (edit != null){
						if (debug) System.out.println("-----------------------");
						if (debug) System.out.println(alpha + " " + num);
						if (debug) System.out.println(edit);

						aEdit = edit.split(",");

						length = aEdit.length;

						oldValue = aEdit[oldSeq];

						for(i=oldSeq; i<newSeq; i++)
							aEdit[i] = aEdit[i+1];

						aEdit[newSeq] = oldValue;

						edit = "";
						for(i=0; i<length; i++){
							if (i==0)
								edit = aEdit[i];
							else
								edit = edit + "," + aEdit[i];
						}

						if (debug) System.out.println(edit);
					} // if
				} // while
			} // NEW_GREATER_OLD
			else if (direction == OLD_GREATER_NEW){
				while (rs.next()){
					alpha = rs.getString("coursealpha");
					num = rs.getString("coursenum");
					edit = rs.getString("edit1");

					if (edit != null){
						if (debug) System.out.println("-----------------------");
						if (debug) System.out.println(alpha + " " + num);
						if (debug) System.out.println(edit);

						aEdit = edit.split(",");

						length = aEdit.length;

						oldValue = aEdit[oldSeq];

						for(i=oldSeq; i>newSeq; i--)
							aEdit[i] = aEdit[i-1];

						aEdit[newSeq] = oldValue;

						edit = "";
						for(i=0; i<length; i++){
							if (i==0)
								edit = aEdit[i];
							else
								edit = edit + "," + aEdit[i];
						}

						if (debug) System.out.println(edit);
					} // if
				} // while
			} // OLD_GREATER_NEW
			else if (direction == INSERT_QUESTION){
				while (rs.next()){
					alpha = rs.getString("coursealpha");
					num = rs.getString("coursenum");
					edit = rs.getString("edit1");

					if (edit != null){
						if (debug) System.out.println("-----------------------");
						if (debug) System.out.println(alpha + " " + num);
						if (debug) System.out.println(edit);

						// since we are inserting a new element, we must grow the array by 1 before split
						// we also have to add the new question number to the list
						edit = edit + ",0";
						aEdit = edit.split(",");

						length = aEdit.length;

oldValue = "*"; // what is the question number from CCCM6100

						for(i=length-1; i>newSeq; i--)
							aEdit[i] = aEdit[i-1];

						aEdit[newSeq] = oldValue;

						edit = "";
						for(i=0; i<length; i++){
							if (i==0)
								edit = aEdit[i];
							else
								edit = edit + "," + aEdit[i];
						}

						if (debug) System.out.println(edit);
					} // if
				} // while
			} // INSERT_QUESTION
			else if (direction == REMOVE_QUESTION){
				while (rs.next()){
					alpha = rs.getString("coursealpha");
					num = rs.getString("coursenum");
					edit = rs.getString("edit1");

					if (edit != null){

						if (debug) System.out.println("-----------------------");
						if (debug) System.out.println(alpha + " " + num);
						if (debug) System.out.println(edit);

						aEdit = edit.split(",");

						length = aEdit.length;

						for(i=oldSeq; i<length-1; i++)
							aEdit[i] = aEdit[i+1];

						// recombine without the last item that is now removed
						edit = "";
						for(i=0; i<length-1; i++){
							if (i==0)
								edit = aEdit[i];
							else
								edit = edit + "," + aEdit[i];
						}

						if (debug) System.out.println(edit);
					} // if
				} // while
				//
			} // REMOVE_QUESTION

			rs.close();
			ps.close();

			rs = null;
			ps = null;

			if (debug) System.out.println("-------------------- resetQuestionFlags - END");
		}
		catch( SQLException e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}

		return 0;

	} // resetQuestionFlags

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

			if ((Constant.TABLE_COURSE).equals(tableName)){
				table = "tblCourseQuestions";
				editItems = aseUtil.lookUp(conn, "tblCampus", "courseitems", "campus='" + campus + "'" );
			}
			else if ((Constant.TABLE_CAMPUS).equals(tableName)){
				table = "tblCampusQuestions";
				editItems = aseUtil.lookUp(conn, "tblCampus", "campusItems", "campus='" + campus + "'" );
			}
			else if ((Constant.TABLE_PROGRAM).equals(tableName)){
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

				// ---------------------------------->> 1 - not included

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
				if (!debug) rowsAffected = ps.executeUpdate();
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
					if (!debug) rowsAffected = ps.executeUpdate();
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

				// ---------------------------------->> 2 - oldSeq==0

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
					if (!debug) rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");

					aEditItems[os] = os + Constant.SEPARATOR + ns;
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
				if (!debug) rowsAffected = ps.executeUpdate();
				ps.close();

// new is added and is editable
aEditItems[newSeq] = Constant.ON;

			}
			else if (newSeq == oldSeq){

				// ---------------------------------->> 3 - new = old

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
				if (!debug) rowsAffected = ps.executeUpdate();
				ps.close();
			}
			else if (newSeq > oldSeq){

				// ---------------------------------->> 4 - new > old

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
				if (!debug)  rowsAffected = ps.executeUpdate();
				ps.close();

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
					if (!debug) rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");

					aEditItems[os] = os + Constant.SEPARATOR + ns;
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
				if (!debug) rowsAffected = ps.executeUpdate();
				ps.close();

aEditItems[newSeq] = aEditItems[oldSeq];
			}
			else if (newSeq < oldSeq){

				// ---------------------------------->> 5 - new < old

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
				if (!debug) rowsAffected = ps.executeUpdate();
				ps.close();

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
					if (!debug) rowsAffected = ps.executeUpdate();
					logger.info("2 - UPDATED " + os + " TO " + ns + " - " + rowsAffected + " row");

					aEditItems[os] = os + Constant.SEPARATOR + ns;
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
				if (!debug) rowsAffected = ps.executeUpdate();
				ps.close();

aEditItems[newSeq] = aEditItems[oldSeq];
			}

			logger.info("----------------- END");

			aseUtil = null;

			// need to rearrange edit flags for changes to question order
			try{
				String edits = "";
				for(junk=0;junk<totalElements;junk++){

					if (aEditItems[junk] == null || aEditItems[junk].length() == 0)
						aEditItems[junk] = "-";

					if (junk==0)
						edits = aEditItems[junk];
					else
						edits = edits + "," + aEditItems[junk];
				}

				resetQuestionFlags2(conn,campus,edits,oldSeq,newSeq);
			}
			catch(Exception e){
				System.out.println(e.toString());
			}

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
	} // updateQuestion

	public static int resetQuestionFlags2(Connection conn,
														String campus,
														String edits,
														int oldSeq,
														int newSeq) throws SQLException {

Logger logger = Logger.getLogger("test");

//edits = "-,-,-,-,-,5~~4,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-";
//oldSeq = 3;
//newSeq = 4;

		String alpha = "";
		String num = "";
		String type = "PRE";

		String edit = "";

		String[] aEdit = null;
		String[] aEdits = null;

		String[] cell = null;

		int i = 0;
		int length = 0;

		boolean debug = true;

		String oldValue = "";

		try{
			logger.info("-------------------- resetQuestionFlags - START");
			logger.info("New > Old - moving front to back");
			logger.info("campus: " + campus);
			logger.info("edits: " + edits);
			logger.info("oldSeq: " + oldSeq);
			logger.info("newSeq: " + newSeq);

			if (edits != null)
				aEdits = edits.split(",");

			length = aEdits.length;

			String sql = "SELECT coursealpha,coursenum,edit1 "
					+ "FROM tblcourse "
					+ "where campus=? AND coursetype='PRE' AND edit1 like '%,%' AND coursealpha='IS' AND coursenum='205'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				edit = rs.getString("edit1");

				if (edit != null && aEdits != null){
					aEdit = edit.split(",");

					oldValue = aEdit[oldSeq];

					// loop to the smaller of 2 arrays
					if (aEdit.length < aEdits.length)
						length = aEdit.length;
					else
						length = aEdits.length;

					/*
						move items around. in this scenario, we check from the front and moving back
						to avoid overlaying data items

						aEdits are adjusted cells in from,to format. each element has a CSV or a dash
						to mean no change.

						aEdit is the orignal flags.

						We go through and see if the cell contains valid data. If yes, break into
						2 element array. First is from and second is to. Use from/to to move edit items
						around

						When done, the new location is set to the old value.

						assemble back before returning.
					*/

System.out.println("-------------------------------");
System.out.println("oldSeq: " + oldSeq);
System.out.println("newSeq: " + newSeq);
System.out.println("oldValue: " + oldValue);
System.out.println(edit);

					for(i=0; i<length; i++){

						if (aEdits[i] != null && aEdits[i].length() > 1){
							cell = aEdits[i].split(Constant.SEPARATOR);

							int from = Integer.parseInt(cell[0]) - 1;
							int to = Integer.parseInt(cell[1]) - 1;

							if (from > 0 && to > 0){
								System.out.println("aEdits[i]: " + aEdits[i]);
								System.out.println("aEdit["+from+"]: " + aEdit[from]);
								System.out.println("aEdit["+to+"]: " + aEdit[to]);
								aEdit[to] = aEdit[from];
							}

						} // if

					} // for

					// place moved item in its place
					aEdit[newSeq] = oldValue;

					// reassemble items into a string for saving back to course
					edits = "";
					for(i=0; i<length; i++){
						if (i==0)
							edits = aEdit[i];
						else
							edits = edits + "," + aEdit[i];
					}

System.out.println("outline: " + alpha + " " + num + " - " + edits);

				} // if edit

			}
			rs.close();
			ps.close();

			logger.info("-------------------- resetQuestionFlags - END");
		}
		catch( SQLException e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}
		catch( Exception e ){
			logger.fatal("QuestionDB: resetQuestionFlags - " + e.toString());
		}

		return 0;

	} // resetQuestionFlags

	/*
	 * showProgramFields
	 * <p>
	 *	@param	conn		Connection
	 *	@param	campus	String
	 *	@param	kix		String
	 *	@param	rtn		String
	 *	@param	editing	int
	 *	@param	enabling	boolean
	 * <p>
	 *	@return String
	 */
	public static String showProgramFields(Connection conn,
														String campus,
														String kix,
														String rtn,
														int editing,
														boolean enabling) throws SQLException {

Logger logger = Logger.getLogger("test");

		int j;
		StringBuffer buf = new StringBuffer();
		String temp = "";
		String table = "";
		String fieldName = "";
		String hiddenFieldSystem = "";
		String cQuestionSeq = "";
		String cQuestionNumber = "";
		String cQuestion = "";
		String cQuestionFriendly = "";
		int fieldCountSystem = 0;
		Question question;

		int i = 0;
		int savedCounter = 0;
		int totalItems = 0;

		String checked[] = null;
		String checkMarks[] = null;
		String[] edits = null;
		int editsCount = 0;
		String thiaEdit = null;
		String rowColor = "";

		boolean debug = true;

		try{
			if (debug) logger.info("QuestionDB - showProgramFields - START");
			if (debug) logger.info("campus: " + campus);
			if (debug) logger.info("kix: " + kix);
			if (debug) logger.info("rtn: " + rtn);
			if (debug) logger.info("editing: " + editing);
			if (debug) logger.info("enabling: " + enabling);

			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
			buf.append("<tr bgcolor=\""+Constant.HEADER_ROW_BGCOLOR+"\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>");

			ArrayList list = QuestionDB.getProgramQuestionsInclude(conn,campus,"Y");
			if (list != null){

				totalItems = list.size();

				if (debug) logger.info("totalItems: " + totalItems);

				// initialize
				checked = new String[totalItems];
				for (i=0; i<list.size(); i++){
					checked[i] = "";
				}

				/*
					editing is available when we are coming back in to enable additional fields

					edit-2 contains a single value of '1' indiciating that all fields are editable.
					however, during the modification/approval process, edit-2 may contain CSV
					due to rejection or reasons for why editing is needed

					when the value is a single '1', we set up for all check marks ON.

					when there are multiple values (more than a '1' or a comma is there), we
					set up for ON/OFF.

					enabling is when approvers wishes to enable items for edits by proposer.
				*/
				if (editing==1 || enabling){
					edits = ProgramsDB.getProgramEdits(conn,campus,kix);

					if (edits != null && !(Constant.BLANK).equals(edits[1])){
						thiaEdit = edits[1];

						if (thiaEdit == null)
							thiaEdit = "";

						if (debug) logger.info("thiaEdit: " + thiaEdit);

						if ((Constant.ON).equals(thiaEdit)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thiaEdit.split(",");

							// cannot base loops on number of questions since questions
							// may be added removed from an outline at will. Base on number
							// of edit flags.
							if (checkMarks!=null)
								editsCount = checkMarks.length;

							if (debug) logger.info("editsCount: " + editsCount);

							for (i=0; i<editsCount; i++){
								if (!(Constant.OFF).equals(checkMarks[i]))
									checked[i] = "checked";
							}	// for
						} // if equals 1
					}
				}	// if editing || enabling

				savedCounter = list.size();

				if (debug) logger.info("savedCounter: " + savedCounter);

				for (i=0; i<savedCounter; i++){
					question = (Question)list.get(i);
					cQuestionNumber = question.getNum().trim();
					cQuestionSeq = question.getSeq().trim();
					cQuestion = question.getQuestion().trim();
					fieldName = "Program_" + cQuestionNumber;

					if ( hiddenFieldSystem.length() == 0 )
						hiddenFieldSystem = cQuestionNumber;
					else
						hiddenFieldSystem = hiddenFieldSystem +"," + cQuestionNumber;

					++fieldCountSystem;

					if (i % 2 == 0)
						rowColor = Constant.EVEN_ROW_BGCOLOR;
					else
						rowColor = Constant.ODD_ROW_BGCOLOR;

					temp = "<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">"
							+ cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\""
							+ fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top class=\"datacolumn\">"
							+ cQuestion + "</td></tr>";

					buf.append( temp );
				}	// for
			}	// if

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><hr size=\"1\"></td></tr>");

			buf.append("<tr>" );
			buf.append("<td class=\"textblackTHRight\" colspan=\"3\"><hr size=\"1\">" );
			buf.append("<input type=\"submit\" name=\"aseSubmit\" value=\"Submit\" class=\"inputsmallgray\" onClick=\"return checkForm(\'s\')\">&nbsp;");
			buf.append("<input type=\"submit\" name=\"aseCancel\" value=\"Cancel\" class=\"inputsmallgray\" onClick=\"return checkForm(\'c\')\">" );
			buf.append("<input type=\"hidden\" name=\"formAction\" value=\"c\">" );
			buf.append("<input type=\"hidden\" name=\"formName\" value=\"aseForm\">" );
			buf.append("<input type=\"hidden\" name=\"kix\" value=\"" + kix + "\">" );
			buf.append("<input type=\"hidden\" name=\"campus\" value=\"" + campus + "\">" );
			buf.append("<input type=\"hidden\" name=\"rtn\" value=\"" + rtn + "\">" );
			buf.append("<input type=\"hidden\" name=\"edit\" value=\"" + editing + "\">" );
			buf.append("<input type=\"hidden\" name=\"enabling\" value=\"" + enabling + "\">" );
			buf.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">" );
			buf.append("</td>" );
			buf.append("</tr>" );
			buf.append( "</table>" );

			if (debug) logger.info("QuestionDB - showProgramFields - END");
		}
		catch( SQLException e ){
			logger.info("QuestionDB: showProgramFields - " + e.toString());
		}
		catch( Exception ex ){
			logger.info("QuestionDB: showProgramFields - " + ex.toString());
		}

		return buf.toString();

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>