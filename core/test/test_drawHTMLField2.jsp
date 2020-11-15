<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String user = "THANHG";
	String questionData[] = new String[2];
	String[] selectedValue;
	String[] selectedName;
	String[] iniValues;
	String[] inputValues;
	String selected = "";
	String sql;
	String HTMLType = "";
	String tempFieldName = "";
	String junk = "";
	int i;
	StringBuffer s1 = new StringBuffer();
	StringBuffer s2 = new StringBuffer();

	// check box data comes from some table. If not, it's a CSV
	junk = "kid = 'MethodInstructions'";
	iniValues = aseUtil.lookUpX(conn,"tblINI", "kval1,kval2", junk );

out.println( iniValues[0] + "<br>" );
out.println( iniValues[1] + "<br>" );

	if ( iniValues[0].indexOf("SELECT") >= 0 ){
		java.sql.Statement stmt = conn.createStatement();
		java.sql.ResultSet rs = aseUtil.openRecordSet( stmt, iniValues[0] );
		i = 0;
		while ( rs.next() ) {
			if ( i > 0 ){
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
	}
	else{
		selectedValue = iniValues[0].split(",");
		selectedName = iniValues[1].split(",");
	}

	out.println("<br>" + s1.toString());
	out.println("<br>" + s2.toString());


String fieldType = "radio";
String fieldValue = "1";
String fieldRef = "YESNO";
String fieldName = "repeatable";
int fieldLen = 0;
int fieldMax = 0;
StringBuffer temp = new StringBuffer();

	HTMLType = "radio";
	if ( "check".equals(fieldType) )
		HTMLType = "checkbox";

	// for multi option fields, fieldValue is CSV of valid values
	// selected. Works great for checkboxes. For radios, there's only
	// 1 value selected and many options. When that happens,
	// fieldValue does not have a comma. This part forces commas
	// so that the split function and subsequent for loop can use
	// inputValues correctly. Basically, match number of selection
	// with number of possible answers.
	// at the end, fieldValue contains as many entries as necessary
	// to match selectedName, but all items are the same name
	// IE: fieldValue starts as PRE and selectedName has 3 elements
	// resulting string would be PRE,PRE,PRE
	// also, at the start when there's no data, fill up with '0,'
	// for padding.
	if ( fieldValue.indexOf(",") < 0 || fieldValue.length() == 0 ){
		if ( fieldValue.length() == 0 )
			fieldValue = "0";

		junk = fieldValue;
		for ( i = 1; i < selectedValue.length; i++ ){
			fieldValue += "," + junk;
		}
	}

	inputValues = fieldValue.split(",");

out.println("<br>"+fieldValue);
out.println("<br>"+selectedValue.length);

	temp.append("");
	for ( i = 0; i < selectedValue.length; i++ ){
		selected = "";
		if ( selectedName[i].equals( inputValues[i] ) || "1".equals( inputValues[i] ) )
			selected = "checked";

		// checkboxes can have different names for controls, but radios
		// must all share 1 single name.
		if ( "check".equals(fieldType) )
			tempFieldName = fieldName + "_" + i;
		else
			tempFieldName = fieldName + "_0";

		temp.append("<input " + selected + " type=\'" + HTMLType + "\' value=\'" + selectedName[i] + "\' name=\'" + tempFieldName + "\'>&nbsp;" + selectedValue[i] + "<br>");
	}

	// for radios, there's only 1 control to work with;
	// for checks there should be as many controls as the loop above
	// this is explained down below.
	if ( !"check".equals(fieldType) )
		i = 1;

	// form data collection expects at least a field call 'questions'. when dealing with
	// radios and checks, questions does not exists since the field are either named
	// with similar names or created as multiple selections (must be unique). this
	// hidden field makes it easy to ignore the calendar or form error
	temp.append("<input type=\'hidden\' value=\'\' name=\'questions\'>");
	temp.append("<input type=\'hidden\' value=\'" + i + "\' name=\'numberOfControls\'>");

out.println("<br>"+temp.toString());


%>