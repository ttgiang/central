<%@ include file="ase.jsp" %>
<%@ page import="java.sql.*"%>

<jsp:useBean id="website" scope="application" class="com.ase.aseutil.WebSite" />
<jsp:useBean id="aseUtil" scope="application" class="com.ase.aseutil.AseUtil" />

<%
	String fieldName = "shorttitle,edit";
	String table = "tblCourse";
	String where = "coursealpha='ICS' AND coursenum='111'";
	int pos = 0;
	int columns = 1;

	try {
		java.sql.Statement stmt = conn.createStatement();
		java.sql.ResultSet rsLookUp = aseUtil.openRecordSet( stmt, "SELECT " + fieldName + " FROM " + table + " WHERE " + where);

		// determine number of fields being requested.
		pos = fieldName.indexOf(",",0);
		while ( pos > 0 ){
			++columns;
			pos = fieldName.indexOf(",",++pos);
		}

		// if we can't open, then we bombed.
		if (! rsLookUp.next()) {
			rsLookUp.close();
			stmt.close();
			return res;
		}

		// if we are sucessful, let's set up return values
		String[] res = new String[columns];
		for ( pos = 0; pos < columns; pos++ )
			res[pos] = rsLookUp.getString(pos+1);

		return res;

		rsLookUp.close();
		stmt.close();
	}
	catch (Exception e) {
		out.println( e.toString() );
	}
%>

