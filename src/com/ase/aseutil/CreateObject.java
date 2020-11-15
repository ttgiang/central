/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineernig
 * 
 * @author ttgiang
 */

//
// CreateObject.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;

public class CreateObject {

	public CreateObject() {
	}

	public String printObject(Connection conn, String table, String key,
			String field) {

		String where = field + "=?";
		String sql = "SELECT * FROM " + table + " WHERE " + where;
		String sets = "";
		String gets = "";
		String strFieldName;
		String strTypeName;
		String variables = "";
		String classes = "";
		String toStrings = "";
		String columnType = "";

		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, key);
			ResultSet resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				ResultSetMetaData rsmd = resultSet.getMetaData();
				int count = rsmd.getColumnCount();

				for (int i = 1; i <= count; i++) {
					strFieldName = rsmd.getColumnLabel(i);
					strFieldName = strFieldName.substring(0, 1).toUpperCase()
							+ strFieldName.substring(1);
					strTypeName = rsmd.getColumnTypeName(i);
					columnType = getColumnType(rsmd.getColumnType(i));

					toStrings += "\"" + strFieldName + ": \" + get"
							+ strFieldName + "() + <br>\n";

					variables += "<br>/**<br>* " + strFieldName + " "
							+ strTypeName + "<br>**/<br>";

					classes += "<br>/**<br>* get/set" + strFieldName
							+ "<br>* <p>" + "* @param " + columnType
							+ "<br>* <p>" + "* @return " + columnType
							+ "<br>**/<br>";

					variables += "String " + strFieldName + " = null;<br>";
					classes += "public " + columnType + " get" + strFieldName
							+ "(){ return this." + strFieldName + "; }<br>";
					classes += "public void set" + strFieldName + "("
							+ columnType + " value){ this." + strFieldName
							+ " = value; }<br>";

					sets += table + ".set" + strFieldName
							+ "(rs.getString(i++));<br>";
					gets += table + ".get" + strFieldName + "();<br>";
				}
			}

			resultSet.close();
			preparedStatement.close();

			variables = variables + "<br>" + "public " + table + "(){}<br><br>"
					+ classes + "<br>" + "<br>"
					+ "public String toString(){<br>return " + toStrings
					+ "\"\";<br>}" + "<br>/*<br>" + sets + "<br><br>" + gets
					+ "<br>*/<br>";
		} catch (Exception e) {
		}

		return variables;
	}

	/**
	 * returns column type
	 * <p>
	 * 
	 * @param type
	 *            int
	 *            <p>
	 * @return java.sql.String
	 */
	public String getColumnType(int type) {
		String cname;

		switch (type) {
		case Types.BIT: {
			cname = "java.lang.Boolean";
			break;
		}
		case Types.TINYINT: {
			cname = "java.lang.Byte";
			break;
		}
		case Types.SMALLINT: {
			cname = "java.lang.Short";
			break;
		}
		case Types.INTEGER: {
			cname = "java.lang.Integer";
			break;
		}
		case Types.BIGINT: {
			cname = "java.lang.Long";
			break;
		}
		case Types.FLOAT:
		case Types.REAL: {
			cname = "java.lang.Float";
			break;
		}
		case Types.DOUBLE: {
			cname = "java.lang.Double";
			break;
		}
		case Types.NUMERIC: {
			cname = "java.lang.Number";
			break;
		}
		case Types.DECIMAL: {
			cname = "java.math.BigDecimal";
			break;
		}
		case Types.CHAR:
		case Types.VARCHAR:
		case Types.LONGVARCHAR: {
			cname = "java.lang.String";
			break;
		}
		case Types.DATE: {
			cname = "java.sql.Date";
			break;
		}
		case Types.TIME: {
			cname = "java.sql.Time";
			break;
		}
		case Types.TIMESTAMP: {
			cname = "java.sql.Timestamp";
			break;
		}
		case Types.BINARY:
		case Types.VARBINARY:
		case Types.LONGVARBINARY: {
			cname = "byte[]";
			break;
		}
		case Types.OTHER:
		case Types.JAVA_OBJECT: {
			cname = "java.lang.Object";
			break;
		}
		case Types.CLOB: {
			cname = "java.sql.Clob";
			break;
		}
		case Types.BLOB: {
			cname = "java.ssql.Blob";
			break;
		}
		case Types.REF: {
			cname = "java.sql.Ref";
			break;
		}
		case Types.STRUCT: {
			cname = "java.sql.Struct";
			break;
		}
		default: {
			cname = "";
		}
		}

		return cname;
	}
}
