<%@ page import="java.util.*, java.io.*" %>

<%@ include file="ase.jsp" %>

<%
	try{
		ResultSet rs = null;
		String table;

		DatabaseMetaData meta = conn.getMetaData();
		ResultSet res = meta.getTables(null,null,null,new String[] {"TABLE"});
		while (res.next()) {
			table = 	res.getString("TABLE_NAME");

			// ignore temp tables
			if ( table.indexOf("~") == -1 ){
				out.println(
						 "  " + res.getString("TABLE_CAT")
					  + ", " + res.getString("TABLE_SCHEM")
					  + ", " + table
					  + ", " + res.getString("TABLE_TYPE")
					  + ", " + res.getString("REMARKS")
					  + "<br>");

				/*
					NOT WITH ACCESS

					rs = meta.getPrimaryKeys(null, null, table);
					while (rs.next()) {
						String name = rs.getString("TABLE_NAME");
						String columnName = rs.getString("COLUMN_NAME");
						String keySeq = rs.getString("KEY_SEQ");
						String pkName = rs.getString("PK_NAME");
						out.println("column name:  " + columnName);
						out.println("sequence in key:  " + keySeq);
						out.println("primary key name:  " + pkName);
						out.println("<br>");
					}	// while rs
					rs.close();
				*/
			}	// if table
		}	// while res

		res.close();
	}
	catch( Exception e ){
		out.println( e.toString() );
	}

	asePool.freeConnection(conn);
%>