<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" type="text/javascript" src="js/textcounter.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
			<form name="aseForm">
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

	String campus = "KAP";
	String alpha = "PSY";
	String alphax = alpha;
	String num = "240B";
	String user = "THANHG"; //"CURRIVANP001";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "q3f2j9189";
	String src = "x43";
	String dst = "q3f2j9189";

	out.println("Start<br/>");
	//out.println(drawHTMLField(conn,"check","Grading","questions","",50,50,false,campus,false));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
			</form>
		</td>
	</tr>
</table>

<%!

	public String drawHTMLField(Connection conn,
											String fieldType,
											String fieldRef,
											String fieldName,
											String fieldValue,
											int fieldLen,
											int fieldMax,
											boolean lock,
											String campus,
											boolean required) {

		Logger logger = Logger.getLogger("test");

		String temp = "";
		StringBuffer buf = new StringBuffer();
		String shownValue = fieldValue;
		String hiddenValue = fieldValue;
		String fieldLabel = "";
		boolean found = false;

		try{
			if (lock){
				if ("check".equals(fieldType)){
					if ("MethodInstructions".equals(fieldRef)){
						fieldRef = "MethodInst";
					}
					else if ("MethodEvaluations".equals(fieldRef)){
						fieldRef = "MethodEval";
					}

					String sql = "SELECT kdesc FROM tblINI WHERE id IN (" + fieldValue + ") AND category=? ORDER BY kid";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, fieldRef);
					ResultSet rs = ps.executeQuery();
					shownValue = "";
					while (rs.next()) {
						found = true;
						shownValue = shownValue + "<li>"+rs.getString(1)+"</li>";
					}
					rs.close();
					ps.close();

					if (found){
						shownValue = "<ul>" + shownValue + "</ul>";
					}
				}
				else if ("radio".equals(fieldType)) {
					fieldName = "questions_0";

					if ("0".equals(fieldValue))
						shownValue = "N";
					else
						shownValue = "Y";
				}

				buf.append(shownValue.trim());
				buf.append("<input type=\'hidden\' value=\'" + hiddenValue + "\' name=\'" + fieldName.trim() + "\'>");
				temp = buf.toString();
			}
			else{
				temp = drawHTMLFieldX(conn,fieldType,fieldRef,fieldName,fieldValue.trim(),fieldLen,fieldMax,campus,required);
			}
		} catch (SQLException se) {
			temp = se.toString();
		} catch (Exception pe) {
			temp = pe.toString();
		}

		return temp;
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
		String html = "";

		// 20 was padded to the len to give space for data entry and view. subtract
		// the 20 here to control the limit properly
		int actualFieldLen = fieldLen - 20;

		if (required)
			requiredInput = "inputRequired";

		StringBuffer s1 = new StringBuffer();
		StringBuffer s2 = new StringBuffer();

String fieldLabel = "";

		boolean found = false;
		boolean countThistext = false;

		int numberOfControls = 0;
		int i;
		int selectedIndex = 0;


		try {

			AseUtil au = new AseUtil();

			iniValues = new String[2];
			iniValues[0] = "";
			iniValues[1] = "";

			if ("check".equals(fieldType)) {

				i = 0;
				fieldType = "checkbox";
				java.sql.ResultSet rs;

				if (!"".equals(fieldRef)){
					sql = "SELECT kdesc,id "
						+ "FROM tblINI "
						+ "WHERE campus=? AND "
						+ "category=? "
						+ "ORDER BY kdesc";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1,campus);
					ps.setString(2,fieldRef);
					rs = ps.executeQuery();
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
					ps.close();
					selectedValue = s1.toString().split("~");
					selectedName = s2.toString().split("~");
				}
				else{
					/*
					 * get the string pointed to by fieldRef. If it contains SELECT
					 * check box data comes from some table. If not, it's a CSV.
					 * this is done to help determine the layout for check and radio
					 * buttons
					 */
					if (!"".equals(campus))
						junk = "campus=" + au.toSQL(campus, 1) + " AND kid = " + au.toSQL(fieldRef, 1);
					else
						junk = "kid = " + au.toSQL(fieldRef, 1);

					iniValues = au.lookUpX(conn, "tblINI", "kval1,kval2", junk);

					//System.out.println( "iniValues[0]: " + iniValues[0] + "<br>" );
					//System.out.println( "iniValues[1]: " + iniValues[1] + "<br>" );

					if (iniValues[0].indexOf("SELECT") >= 0) {
						java.sql.Statement stmt = conn.createStatement();
						rs = au.openRecordSet(stmt, iniValues[0]);
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
						selectedName = s1.toString().split("~");
						selectedValue = s2.toString().split("~");
					} else {
						selectedName = iniValues[0].split("~");
						selectedValue = iniValues[1].split("~");
					}
				}

				if (selectedName[0] != null && !"".equals(selectedName[0])){

					/*
					 * for radios, there's only 1 control to work with; for checks
					 * there should be as many controls as the loop above this is
					 * explained down below.
					 */
					numberOfControls = selectedValue.length;
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

					temp.append("<table width=\"100%\" border=\"0\" width=\"0\" cellpadding=\"0\" cellspacing=\"0\">");
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

						temp.append("<tr><td valign=\"top\"><input type=\'" + fieldType
								+ "\' value=\'" + selectedName[i] + "\' name=\'"
								+ tempFieldName + "\'" + " " + selected + "></td>");

						temp.append("<td class=\"datacolumn\" valign=\"top\">" + selectedValue[i]+"</td></tr>");
					} // for

					temp.append("</table>");

				}	// NODATA

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
				junk = "kid = " + au.toSQL(fieldRef, 1);
				iniValues = au.lookUpX(conn, "tblINI", "kval1,kval2", junk);

				if (iniValues[0].indexOf("SELECT") >= 0) {
					java.sql.Statement stmt = conn.createStatement();
					java.sql.ResultSet rs = au.openRecordSet(stmt, iniValues[0]);
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
} else if ("CONSENT".equals(fieldRef)) {
	fieldValue = "1,0";
	fieldLabel = "Consent: ";
	selectedValue = "Yes,No".split(",");
	selectedName = "1,0".split(",");

if (originalValue==null || "".equals(originalValue))
	originalValue = "1";

				} else if ("STATUS".equals(fieldRef)) {
					fieldValue = "1,0";
					selectedValue = "Active,Inactive".split(",");
					selectedName = "1,0".split(",");
				} else if ("UserStatus".equals(fieldRef)) {
					fieldValue = "1,0";
				} else if ("CourseStatus".equals(fieldRef)) {
					fieldValue = "1,0";
				} else if ("ReasonsforMods".equals(fieldRef)) {
					fieldValue = "1,0";
				}

				userValue = fieldValue.split(",");

				/*
				 * print the controls and their values
				 */
				inputValues = fieldValue.split(",");
temp.append(fieldLabel);

				for (i=0; i<inputValues.length; i++) {
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
				sql = au.lookUp(conn, "tblINI", "kval1", "kid = " + au.toSQL(fieldRef, 1));
				temp.append(au.createSelectionBox(conn,sql,fieldName,fieldValue,required));
			} else if ("text".equals(fieldType)) {
				countThistext = true;
				temp.append("<input size=\"" + fieldLen + "\" "
						+ " maxlength=\"" + fieldMax + "\" "
						+ " type=\"text\" class=\"" + requiredInput + "\" "
						+ " value=\"" + fieldValue + "\" "
						+ " name=\"" + fieldName + "\" ___>");
			} else if ("textarea".equals(fieldType)) {
				countThistext = true;
				temp.append("<textarea cols=\'" + fieldLen + "\' rows=\'"
						+ fieldMax + "\' class=\'" + requiredInput + "\' name=\'" + fieldName + "\' ___>"
						+ fieldValue + "</textarea>");
			} else if ("wysiwyg".equals(fieldType)) {
				temp.append("<textarea class=\"" + requiredInput + "\""
						+ " id=\"" + fieldName + "\""
						+ " name=\"" + fieldName + "\">" + fieldValue
						+ "</textarea>"
						+ "<script language=\'javascript1.2\'>"
						+ "generate_wysiwyg(\'" + fieldName + "\');"
						+ "</script>");
			}

			String countText = IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","EnableTextCounter");
			if ("1".equals(countText) && countThistext){
				String textCounter = " onKeyDown=\"textCounter(document.aseForm."+fieldName+",document.aseForm.textLen,"+actualFieldLen+")\""
					+ " onKeyUp=\"textCounter(document.aseForm."+fieldName+",document.aseForm.textLen,"+actualFieldLen+")\"";
				html = temp.toString().replace("___",textCounter);
				html = html
					+ "<p><font class=\"textblackth\"><div id=\"question-status\"></div></font>"
					+ "<input readonly class=\"input\" type=\"hidden\" name=\"textLen\" size=\"3\" maxlength=\""+fieldMax+"\" value=\""+actualFieldLen+"\"></p>";
			}
			else
				html = temp.toString().replace("___","");

		} catch (Exception pe) {
logger.fatal(pe.toString());
System.out.println(pe.toString());
		}

		return html;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
