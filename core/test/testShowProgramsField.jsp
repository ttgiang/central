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

	String campus = "HIL";
	String alpha = "ENG";
	String num = "999";
	String type = "PRE";
	String user = "THANHG";
	String task = "Modify_outline";
	String kix = "r36f18i10230";	//H3d4j9196
	String message = "";
	String url = "";
	String dst = "dst";

	out.println("Start<br/>");

	if (processPage){
		try{

			showProgramFields(conn,campus,kix,"rtn",1,false);

		}
		catch(Exception ce){
			logger.info(ce.toString());
		}
	}

	out.println("<br/>End");

	asePool.freeConnection(conn,campus,user);
%>

<%!

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
		String thisEdit = null;
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

					edit1-2 contains a single value of '1' indiciating that all fields are editable.
					however, during the modification/approval process, edit1-2 may contain CSV
					due to rejection or reasons for why editing is needed

					when the value is a single '1', we set up for all check marks ON.

					when there are multiple values (more than a '1' or a comma is there), we
					set up for ON/OFF.

					enabling is when approvers wishes to enable items for edits by proposer.
				*/
				if (editing==1 || enabling){
					edits = ProgramsDB.getProgramEdits(conn,campus,kix);

					if (edits != null && !(Constant.BLANK).equals(edits[1])){
						thisEdit = edits[1];

						if (thisEdit == null)
							thisEdit = "";

						if (debug) logger.info("thisEdit: " + thisEdit);

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

							if (debug) logger.info("editsCount: " + editsCount);

							for (i=0; i<editsCount; i++){
								if ((Constant.ON).equals(checkMarks[i]))
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

					temp = "<tr bgcolor=\"" + rowColor + "\"><td valign=top align=\"right\" class=\"textblackth\">" + cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top class=\"datacolumn\">" + cQuestion + "</td></tr>";

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