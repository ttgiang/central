<%@ page import="java.util.*, java.io.*" %>

<%@ include file="ase.jsp" %>

<%

	/*
		1) Constructor needs to be corrected
		2) datetime does not exist
		3) case is a problem but can be ignored
	*/

	try{

		String table = "tblCampusOutlines ";
		String where = "id=?";
		String sql = "SELECT * FROM " + table + " WHERE " + where;
		String sets = "";
		String gets = "";
		PreparedStatement preparedStatement = conn.prepareStatement(sql);
		preparedStatement.setInt(1,1);
		ResultSet resultSet = preparedStatement.executeQuery();
		if (resultSet.next()) {
			ResultSetMetaData rsmd = resultSet.getMetaData();

			String strFieldName;
			String strFieldNameL;
			String strTypeName;
			String variables = "";
			String classes = "";
			String arg = "";
			String constructors = "";
			String toStrings = "";
			int count = rsmd.getColumnCount();

			for ( int i=1; i<=count;i++){
				strFieldName = rsmd.getColumnLabel(i);
				strFieldNameL = strFieldName;
				strFieldName = strFieldName.substring(0,1).toUpperCase() + strFieldName.substring(1);
				strTypeName = rsmd.getColumnTypeName(i);

				if (arg.equals(Constant.BLANK))
					arg = strFieldNameL;
				else
					arg += "," + strFieldNameL;

				constructors += "this." + strFieldNameL + " = " + strFieldNameL + ";<br/>";

				toStrings += "\"" + strFieldName + ": \" + get" +  strFieldName + "() + <br>\n";

				variables += "<br>/**<br>* " + strFieldName + " " + strTypeName + "<br>**/<br>";
				classes += "<br>/**<br>** " + strFieldName + " " + strTypeName + "<br>**/<br>";

				if ( 	"TEXT".equalsIgnoreCase(strTypeName) ||
						"CHAR".equalsIgnoreCase(strTypeName) ||
						"VARCHAR".equalsIgnoreCase(strTypeName) ||
						"NVARCHAR".equalsIgnoreCase(strTypeName) ||
						"LONGCHAR".equalsIgnoreCase(strTypeName) ){
					variables += "private String " + strFieldName + " = null;<br>";
					classes += "public String get" + strFieldName + "(){ return this." + strFieldNameL + "; }<br>";
					classes += "public void set" + strFieldName + "(String value){ this." + strFieldNameL + " = value; }<br>";
				}
				else if ( 	"identity".indexOf(strTypeName) > 0 ||
								"int".indexOf(strTypeName) >= 0 ||
								"numeric".equalsIgnoreCase(strTypeName) ||
								"int identity".equalsIgnoreCase(strTypeName) ||
								"integer".equalsIgnoreCase(strTypeName) ||
								"COUNTER".equalsIgnoreCase(strTypeName) ){
					variables += "private int " + strFieldName + " = 0;<br>";
					classes += "public int get" + strFieldName + "(){ return this." + strFieldNameL + "; }<br>";
					classes += "public void set" + strFieldName + "(int value){ this." + strFieldNameL + " = value; }<br>";
				}
				else if ( "BIT".equalsIgnoreCase(strTypeName) ){
					variables += "private boolean " + strFieldName + " = false;<br>";
					classes += "public boolean get" + strFieldName + "(){ return this." + strFieldNameL + "; }<br>";
					classes += "public void set" + strFieldName + "(boolean value){ this." + strFieldNameL + " = value; }<br>";
				}
				else if ( 	"DATETIME".equalsIgnoreCase(strTypeName) ||
								"SMALLDATETIME".equalsIgnoreCase(strTypeName) ){
					variables += "private String " + strFieldName + " = null;<br>";
					classes += "public String get" + strFieldName + "(){ return this." + strFieldNameL + "; }<br>";
					classes += "public void set" + strFieldName + "(String value){ this." + strFieldName + " = value; }<br>";
				}
				else if ( "DOUBLE".equalsIgnoreCase(strTypeName) ){
					variables += "private int " + strFieldName + " = 0;<br>";
					classes += "public double get" + strFieldName + "(){ return this." + strFieldNameL + "; }<br>";
					classes += "public void set" + strFieldName + "(double value){ this." + strFieldNameL + " = value; }<br>";
				}
				else{
					variables += strFieldName + " " + strTypeName + "<br>";
				}

				sets += table + ".set" + strFieldName + "(rs.getString(i++));<br>";
				gets += table + ".get" + strFieldName + "();<br>";
			}

			out.println( variables );
			out.println( "<br>" );

			// constructor
			classes = "public " + table.substring(0,1).toUpperCase() + table.substring(1) + "("+arg+"){<br>"
				+ constructors
				+ "}<br><br>" + classes + "<br>";

			out.println( classes );
			out.println( "<br>" );

			// what else?
			toStrings = "public String toString(){<br>return " + toStrings + "\"\";<br>}";
			out.println( toStrings );

			// helper functions
			out.println( "<br>/************************************************/<br>" );
			out.println( sets );

			// helper functions
			out.println( "<br>/************************************************/<br>" );
			out.println( gets );

		}
		resultSet.close();
		preparedStatement.close ();

	}
	catch( Exception e ){
		out.println( e.toString() );
	}

	asePool.freeConnection(conn);

%>