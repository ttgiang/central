<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
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
<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "y17h9e9228";
	String src = "x43";
	String dst = "y17h9e9228";

	out.println("Start<br/>");

	String[] blackList = {"--",";--",";","/*","*/","@@",
								 "char","nchar","varchar","nvarchar",
								 "alter","begin","cast","create","cursor","declare","delete","drop","end","exec","execute",
								 "fetch","insert","kill","open","xp_",
								 "information_schema","information_","_schema",
								 "schema.tables","table_name","union select",
								 "select", "sys","sysobjects","syscolumns",
								 "table","update",
								 "' or 1=1--",
								 "\" or 1=1--",
								 "or 1=1--",
								 "' or 'a'='a",
								 "\" or \"a\"=\"a",
								 ") or ('a'='a",
								 ".js"
								 };

	String[] blackList1 = {"--",";--",";","/*","*/","@@","xp_","information_schema","information_","_schema",
								 "schema.tables","table_name","union select","sysobjects","syscolumns",
								 "' or 1=1--",
								 "\" or 1=1--",
								 "or 1=1--",
								 "' or 'a'='a",
								 "\" or \"a\"=\"a",
								 ") or ('a'='a",
								 ".js"
								 };

	int len = blackList1.length;

	for(int i=0;i<len;i++)
		out.println(cleanSQL(blackList1[i] + " ~~~ " + blackList1[i] + "<br/>"));

	out.println(cleanSQL(website.getRequestParameter(request,"login","c0mp1ex")));

	kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
	}
	else{
		kix = helper.getKix(conn,campus,alpha,num,type);
	}

	System.out.println("alpha: " + alpha);
	System.out.println("num: " + num);

	if ((alpha==null || alpha.length()==0) || (num==null || num.length()==0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsedt&viewOption=PRE");
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public static String cleanSQL(String str){

		Logger logger = Logger.getLogger("test");
		String temp = "";

		if (str != null) {

			temp = str;

			// double dashes are bad
			// comments type characters are bad
			if (str.indexOf("--") > -1 ){
				temp = str.replaceAll("--","-");
				logger.info("WebSite: cleanSQL - double dashes");
			}
			else if (str.indexOf("/*") > -1 ){
				temp = str.replaceAll("/*","");
				logger.info("WebSite: cleanSQL - comment characters");
			}

			try{
				String policy = "antisamy.xml";
				String realPath = "";

				CleanResults cr = null;
				//ServletContext sc = null;
				//sc = session.getServletContext();
				realPath = "/tomcat/webapps/central/WEB-INF/resources/" + policy;
				AntiSamy as = new AntiSamy();
				cr = as.scan(temp,realPath);
				temp = cr.getCleanHTML();
System.out.println(temp);
				//temp = cleanSQLXY(temp);
			}catch(ScanException se){
				logger.fatal(se.toString());
			}catch(PolicyException pe){
				logger.fatal(pe.toString());
			}
		}

		return temp;
	}

	public static String blackListed(String str){

		Logger logger = Logger.getLogger("test");

		String[] blackList = {"--",";--",";","/*","*/","@@","xp_","information_schema","information_","_schema",
									 "schema.tables","table_name","union select","sysobjects","syscolumns","' or 1=1--",
									 "\" or 1=1--","or 1=1--","' or 'a'='a","\" or \"a\"=\"a",") or ('a'='a",".js"};

		String temp = str;
		String tempCopy = str;
		String front = "";
		String back = "";
		int pos = 0;
		int i = 0;

		try{
			if (temp != null && temp.length() > 0){
				for(i=0;i<blackList.length;i++){
					temp = temp.replace(blackList[i],"");
				}
			}
		}
		catch(Exception ex){
			System.out.println(i + ": " + blackList[i] + " - WebSite: cleanSQLX - black listed - " + ex.toString());
		}

		return temp;
	}

	public static String blackListed2(String str,int spin){

		Logger logger = Logger.getLogger("test");

		String[] blackList = {"--",";--",";","/*","*/","@@","xp_","information_schema","information_","_schema",
									 "schema.tables","table_name","union select","sysobjects","syscolumns","' or 1=1--",
									 "\" or 1=1--","or 1=1--","' or 'a'='a","\" or \"a\"=\"a",") or ('a'='a",".js"};

		String temp = str;
		String tempCopy = str;
		String front = "";
		String back = "";
		int pos = 0;
		int i = 0;

		/*
			Cannot use replace because we want to keep the original
			text in it's case sensitive format. remove the bad words and
			leave the text alone.

			front is the text up to the point of our word
			back is from the end of the word to the end of the text
			temp is reassembled from the split without bad word

			when a blacklisted word is found, check to see that a space does not
			follow it. in a single word check, it shouldn't have a space.

			however, in a sentence, a space is usually followed by other words that
			my not be good.
		*/

		try{
			if (temp != null && temp.length() > 0){
				for(i=0;i<blackList.length;i++){
					pos = tempCopy.indexOf(blackList[i]);
					if (pos > -1){
						if (spin==1)
							pos = tempCopy.indexOf(" ",pos);

						if (pos > -1){
							front = temp.substring(0,pos);
							back = temp.substring(pos+blackList[i].length());
							temp = front + back;
							tempCopy = temp;
							logger.info("WebSite: cleanSQLX - black listed - " + blackList[i]);
						}	// pos = " "
					}	// pos in black list
				}	// for loop
			}	// temp is valid
		}
		catch(Exception ex){
			System.out.println(i + ": " + blackList[i] + " - WebSite: cleanSQLX - black listed - " + ex.toString());
		}

		return temp;
	}

	public static boolean isEditable(Connection connection,
												String campus,
												String alpha,
												String num,
												String user,
												String jsid) {

		Logger logger = Logger.getLogger("test");

		boolean editable = false;
		String proposer = "";
		String progress = "";

		String kix = Helper.getKix(connection,campus,alpha,num,"PRE");

		try {
			String sql = "SELECT edit,proposer,progress " +
				"FROM tblCourse " +
				"WHERE campus=? AND " +
				"alpha=? AND " +
				"num=? AND " +
				"coursetype='PRE'";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ResultSet results = ps.executeQuery();
			if (results.next()) {
				editable = results.getBoolean(1);
				proposer = results.getString(2);
				progress = results.getString(3);
			}
			results.close();

			//if (editable && user.equals(proposer) && "MODIFY".equals(progress) & countApprovalHistory == 0)
			long countApprovalHistory = ApproverDB.countApprovalHistory(connection,kix);

			if (editable && user.equals(proposer) && "MODIFY".equals(progress))
				editable = true;
			else
				editable = false;

			ps.close();

			AseUtil.loggerInfo(kix + " - CourseDB: isEditable ",campus,user,alpha,num);
		} catch (SQLException e) {
			logger.fatal(kix + " - CourseDB: isEditable\n" + e.toString());
		} catch (Exception ex) {
			logger.fatal(kix + " - CourseDB: isEditable\n" + ex.toString());
		}

		return editable;
	}

	public static String showFields(Connection conn,
												String campus,
												String alpha,
												String num,
												String rtn,
												int editing) throws SQLException {

		Logger logger = Logger.getLogger("test");

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
		String thisEdit = null;

		try{
			buf.append("<table width=\"100%\" cellspacing='1' cellpadding='4' border=\"0\">" );
			buf.append("<tr bgcolor=\"#e1e1e1\"><td colspan=\"3\"><input type=\"checkbox\" name=\"checkAll\" onclick=\"toggleAll(this);\"/>&nbsp;&nbsp;<font class=\"textblackTH\">Select/deselect all items</font></td></tr>");

			ArrayList list = QuestionDB.getCourseQuestionsInclude(conn,campus,"Y");
			if (list != null){

				totalItems = list.size();

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
				*/
				if (editing==1){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");
					if (!"".equals(edits[1])){
						thisEdit = edits[1];
						if ("1".equals(thisEdit)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thisEdit.split(",");
							for (i=0; i<totalItems; i++){
								if (!"0".equals(checkMarks[i])) // <====
									checked[i] = "checked";
							}	// for
						} // if equals 1
					}
				}	// if editing

				savedCounter = list.size();

				for (i=0; i<savedCounter; i++){
					question = (Question)list.get(i);
					// field names are SYS_xxx or CAMPUS_xxx to indicate
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

					temp = "<tr><td valign=top align=\"right\">" + cQuestionSeq + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top>" + cQuestion + "</td></tr>";

					buf.append( temp );
				}	// for
			}	// if

			buf.append("<tr><td valign=middle height=30 colspan=\"3\"><hr size=\"1\"></td></tr>");

			list = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			if (list != null){
				totalItems = list.size();

				checked = new String[totalItems];
				for (i=0; i<list.size(); i++){
					checked[i] = "";
				}

				if (editing==1){
					edits = CourseDB.getCourseEdits(conn,campus,alpha,num,"PRE");
					if (!"".equals(edits[2])){
						thisEdit = edits[2];
						if ("1".equals(thisEdit)){
							for (i=0; i<totalItems; i++){
								checked[i] = "checked";
							}
						}
						else{
							checkMarks = thisEdit.split(",");
							for (i=0; i<totalItems; i++){
								if (!"0".equals(checkMarks[i])) // <====
									checked[i] = "checked";
							}
						}
					}
				}

				for (i=0; i<list.size(); i++){
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

					temp = "<tr><td valign=top align=\"right\">" + (savedCounter+i+1) + ".&nbsp;</td><td valign=\"top\" height=\"30\"><input type=\"checkbox\" name=\"" + fieldName + "\" value=\"1\" " + checked[i] + "></td><td valign=top>" +  cQuestion + "</td></tr>";

					buf.append( temp );
				}	// for
			}	// if

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
			buf.append("<input type=\"hidden\" name=\"fieldCountSystem\" value=\"" + fieldCountSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"fieldCountCampus\" value=\"" + fieldCountCampus + "\">" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldSystem\" value=\"" + hiddenFieldSystem + "\">" );
			buf.append("<input type=\"hidden\" name=\"hiddenFieldCampus\" value=\"" + hiddenFieldCampus + "\">" );
			buf.append("<input type=\"hidden\" name=\"totalEnabledFields\" value=\"0\">" );
			buf.append("</td>" );
			buf.append("</tr>" );
			buf.append( "</table>" );
		}
		catch( SQLException e ){
			logger.fatal("QuestionDB: showFields\n" + e.toString());
		}
		catch( Exception ex ){
			logger.fatal("QuestionDB: showFields\n" + ex.toString());
		}

		return buf.toString();
	}

	public String drawHTMLFieldX(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											String campus,
											boolean required) {

		Logger logger = Logger.getLogger("test");

		StringBuffer temp = new StringBuffer();
		String[] selectedValue;
		String[] selectedName;
		String[] iniValues;
		String[] inputValues;
		String[] userValue;
		String selected = "";
		String sql;
		String HTMLType = "";
		String tempFieldName = "";
		String junk = "";
		String thisValue = "";
		String originalValue = fieldValue;
		String requiredInput = "input";

		if (required)
			requiredInput = "inputRequired";

		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();

		boolean found = false;

		int numberOfControls = 0;
		int i;
		int selectedIndex = 0;

		try {
			AseUtil ae = new AseUtil();

			if ("check".equals(fieldType)) {

				fieldType = "checkbox";

				/*
				 * get the string pointed to by fieldRef. If it contains SELECT
				 * check box data comes from some table. If not, it's a CSV.
				 * this is done to help determine the layout for check and radio
				 * buttons
				 */
				if (!"".equals(campus))
					junk = "campus = " + ae.toSQL(campus, 1) + "AND kid = " + ae.toSQL(fieldRef, 1);
				else
					junk = "kid = " + ae.toSQL(fieldRef, 1);

				iniValues = ae.lookUpX(conn, "tblINI", "kval1,kval2", junk);

				//System.out.println( "iniValues[0]: " + iniValues[0] + "<br>" );
				//System.out.println( "iniValues[1]: " + iniValues[1] + "<br>" );

				if (iniValues[0].indexOf("SELECT") >= 0) {
					java.sql.Statement stmt = conn.createStatement();
					java.sql.ResultSet rs = ae.openRecordSet(stmt, iniValues[0]);
					i = 0;
					while (rs.next()) {
						if (i > 0) {
							s1.append("~");
							s2.append("~");
						}
						s1.append(rs.getString(1));
						s2.append(rs.getString(2));
						i = 1;
					}
					rs.close();
					stmt.close();
					selectedValue = s1.toString().split("~");
					selectedName = s2.toString().split("~");
				} else {
					selectedValue = iniValues[0].split("~");
					selectedName = iniValues[1].split("~");
				}

System.out.println( "------------------------------------------" );
System.out.println( "iniValues[0]: " + iniValues[0] + "<br>" );
System.out.println( "iniValues[1]: " + iniValues[1] + "<br>" );
System.out.println( "selectedValue[0]: " + selectedName[0] + "<br>" );
System.out.println( "selectedName[1]: " + selectedName[1] + "<br>" );
System.out.println( "s1: " + s1 + "<br>" );
System.out.println( "s2: " + s2 + "<br>" );

				/*
				 * for radios, there's only 1 control to work with; for checks
				 * there should be as many controls as the loop above this is
				 * explained down below.
				 */
				numberOfControls = selectedName.length;
				inputValues = fieldValue.split(",");

				/*
					make the list of available items and list of user selected items
					the same in length.
				*/
				if (inputValues.length < numberOfControls) {
					for (i=inputValues.length; i<numberOfControls; i++) {
						fieldValue += ",0";
					}
				}

				userValue = fieldValue.split(",");

				/*
				 * print the controls and their values
				 * checkboxes can have different names for controls, but
				 * radios must all share 1 single name.
				 */

				temp.append("");

				for (i=0; i<numberOfControls; i++) {
					selected = "";
					selectedIndex = 0;
					found = false;
					while (!found && selectedIndex < numberOfControls){
						if (selectedName[i].equals(userValue[selectedIndex++])){
							selected = "checked";
							found = true;
						}
					}

					tempFieldName = fieldName + "_" + i;

					temp.append("<input type=\'" + fieldType
							+ "\' value=\'" + selectedValue[i] + "\' name=\'"
							+ tempFieldName + "\'" + " " + selected + ">&nbsp;" + selectedName[i]);

					temp.append("<br>");
				} // for

				/*
				 * form data collection expects at least a field call
				 * 'questions'. when dealing with radios and checks, questions
				 * does not exists since the field are either named with similar
				 * names or created as multiple selections (must be unique).
				 * this hidden field makes it easy to ignore the calendar or
				 * form error
				 */
				temp.append("<input type=\'hidden\' value=\'\' name=\'questions\'>");
				temp.append("<input type=\'hidden\' value=\'" + numberOfControls + "\' name=\'numberOfControls\'>");
			} else if ("radio".equals(fieldType)) {

				/*
					see check box logic for explanation on what's happening here
				*/
				junk = "kid = " + ae.toSQL(fieldRef, 1);
				iniValues = ae.lookUpX(conn, "tblINI", "kval1,kval2", junk);

				if (iniValues[0].indexOf("SELECT") >= 0) {
					java.sql.Statement stmt = conn.createStatement();
					java.sql.ResultSet rs = ae.openRecordSet(stmt, iniValues[0]);
					i = 0;
					while (rs.next()) {
						if (i > 0) {
							s1.append(",");
							s2.append(",");
						}
						s1.append(rs.getString(1));
						s2.append(rs.getString(2));
						i = 1;
					}
					rs.close();
					stmt.close();
					selectedValue = s1.toString().split(",");
					selectedName = s2.toString().split(",");
				} else {
					selectedValue = iniValues[0].split(",");
					selectedName = iniValues[1].split(",");
				}

				/*
				 * some known values for CC
				 */
				if ("YESNO".equals(fieldRef)) {
					fieldValue = "1,0";
				} else if ("YN".equals(fieldRef)) {
					fieldValue = "Y,N";
				} else if ("UserStatus".equals(fieldRef)) {
					fieldValue = "1,0";
				} else if ("CourseStatus".equals(fieldRef)) {
					fieldValue = "1,0";
				}

				userValue = fieldValue.split(",");

				/*
				 * print the controls and their values
				 */
				inputValues = fieldValue.split(",");
				temp.append("");

				for (i = 0; i < inputValues.length; i++) {
					selected = "";

					if (userValue[i].equals(originalValue)){
						selected = "checked";
					}

					tempFieldName = fieldName + "_0";
					thisValue = inputValues[i];

					temp.append("<input type=\'" + fieldType
							+ "\' value=\'" + selectedName[i] + "\' name=\'"
							+ tempFieldName + "\'" + " " + selected + ">&nbsp;" + selectedValue[i]);

					temp.append("&nbsp;&nbsp;");

				} // for

				numberOfControls = 1;

				temp.append("<input type=\'hidden\' value=\'\' name=\'questions\'>");
				temp.append("<input type=\'hidden\' value=\'" + numberOfControls + "\' name=\'numberOfControls\'>");
			} else if ("date".equals(fieldType)) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				java.util.Date date = sdf.parse(fieldValue);
				java.sql.Timestamp ts = new java.sql.Timestamp(date.getTime());
				SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy",Locale.getDefault());
				fieldValue = formatter.format(ts);
				temp.append("<input type=\'Text\' size=\'10\' maxlength=\'10\' class=\'" + requiredInput + "\' name=\'questions\' value=\'" + fieldValue + "\'>");
				temp.append("&nbsp;<a href=\"javascript:calendar.popup();\"><img src=\'img/cal.gif\' width=\'16\' height=\'16\' border=\'0\' alt=\'Click Here to Pick up the date\'></a>");

			} else if ("listbox".equals(fieldType)) {
				sql = ae.lookUp(conn, "tblINI", "kval1", "kid = " + ae.toSQL(fieldRef, 1));
				temp.append(ae.createSelectionBox(conn,sql,fieldName,fieldValue,required));
			} else if ("text".equals(fieldType)) {
				temp.append("<input size=\'" + fieldLen + "\' maxlength=\'"
						+ fieldMax
						+ "\' type=\'text\' class=\'" + requiredInput + "\' value=\'"
						+ fieldValue + "\' name=\'" + fieldName + "\'>");
			} else if ("textarea".equals(fieldType)) {
				temp.append("<textarea cols=\'" + fieldLen + "\' rows=\'"
						+ fieldMax + "\' class=\'" + requiredInput + "\' name=\'" + fieldName
						+ "\'>" + fieldValue + "</textarea>");
			} else if ("wysiwyg".equals(fieldType)) {
				temp.append("<textarea class=\'" + requiredInput + "\' id=\'" + fieldName
						+ "\' name=\'" + fieldName + "\'>" + fieldValue
						+ "</textarea>" + "<script language=\'javascript1.2\'>"
						+ "generate_wysiwyg(\'" + fieldName + "\');"
						+ "</script>");
			}

		} catch (Exception pe) {
			temp.append(pe.toString());
		}

		return temp.toString();
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
