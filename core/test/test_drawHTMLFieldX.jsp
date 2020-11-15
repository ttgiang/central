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

	String campus = "KAP";
	String alpha = "ICS";
	String alphax = alpha;
	String num = "100";
	String user = "THANHG"; //"CURRIVANP001";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String message = "";
	String sURL = "";
	String kix = "m55g17d9203";
	String src = "x43";
	String dst = "m55g17d9203";

	out.println("Start<br/>");
	out.println(drawHTMLFieldX(conn,"check","FunctionDesignation","FunctionDesignation","FALL",10,10,campus,false));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

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
