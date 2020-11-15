/**
 * Copyright 2007 Applied Software Engineering,LLC. All rights reserved. You may
 * not modify,use,reproduce,or distribute this software except in compliance
 * with the terms of the License made with Applied Software Engineernig
 *
 *	public static Msg authenticateUser(Connection,String,String,HttpServletRequest,HttpServletResponse,ServletContext)
 *	public static Msg authenticateUserX(Connection,String,HttpServletRequest,HttpServletResponse,ServletContext,String)
 *	public static boolean checked(Connection connection,String userid,String campus)
 *	public static int deleteUser(Connection connection, String id)
 * public static String getCampusUsersAndDistribution(Connection connection,String campus,String user)
 *	public static User getUserByID(Connection connection, int userid)
 *	public static User getUserByName(Connection connection, String userid)
 *	public static String getUserCampus(Connection connection, String user) {
 *	public static String getUserDepartment(Connection connection, String user)
 *	public static String getUserDepartment(Connection conn,String user,String dept,HttpServletRequest request) {
 *	public static String getUserDepartments(Connection conn,String user) {
 *	public static String getUserEmail(Connection connection, String user)
 *	public static boolean getSendNow(Connection connection, String user)
 *	public static String getUserFullname(Connection connection, String userid)
 *	public static int insertUser(Connection connection, User user)
 *	public static boolean isMatch(Connection connection,String userid,String campus)
 *	public static int updateProfile(Connection connection, User user,HttpServletRequest request,HttpServletResponse response)
 *	public static int updateUser(Connection connection, User user,HttpServletRequest request,HttpServletResponse response)
 *	public static int updateUserDepartment(Connection conn,String usr,String dept,HttpServletRequest request) {
 *	public static int setLastUsedDate(Connection connection,String user)
 *	public static int setUserDepartment(Connection conn,String user,String dept) {
 *	public static void updateCheck(Connection connection,String campus,String userid,String check)
 *
 * @author ttgiang
 */

//
// DBObjects.java
//
package com.ase.aseutil.db;

public class DBObjects {

	// for display
	private String TAB_KEY1 = "&nbsp;&nbsp;&nbsp;";
	private String TAB_KEY2 = TAB_KEY1 + TAB_KEY1;
	private String TAB_KEY3 = TAB_KEY2 + TAB_KEY1;
	private String TAB_KEY4 = TAB_KEY2 + TAB_KEY2;
	private String ENTER_KEY = "<br>";

	// place your class names here
	private String packageName = "com.ase.aseutil";
	private String className = "Users";
	private String tableName = "users";
	private String extendsName = "";

	private String imports = "org.apache.log4j.Logger,java.util.*,java.sql.*,com.ase.aseutil.AseUtil,com.ase.aseutil.NumericUtil";
	private String[] importList = imports.split(",");

	// database information
	private String columnName = "id,campus,userid,password,uh,firstname,lastname,auditdate";
	private String dataTypeSQL = "numeric,varchar,varchar,varchar,numeric,varchar,varchar,datetime";
	private String dataType = "int,String,String,String,int,String,String,java.util.Date";
	private String dataLength = "0,50,30,15,0,30,30,0";

	private String[] columnNames = null;
	private String[] dataTypes = null;
	private String[] dataTypesSQL = null;
	private String[] dataLengths = null;

	private String key = "";

	/**
	*
	**/
	public void setImports(String value){

		this.imports = value;

	}

	public String getImports(){

		return imports;

	}

	/**
	*
	**/
	public void setColumnName(String value){

		this.columnName = value;

		columnNames = columnName.split(",");

	}

	public String getColumnName(){

		return columnName;

	}

	/**
	*
	**/
	public void setDataTypeSQL(String value){

		this.dataTypeSQL = value;

		dataTypesSQL = dataTypeSQL.split(",");

	}

	public String getDataTypeSQL(){

		return dataTypeSQL;

	}

	/**
	*
	**/
	public void setDataType(String value){

		this.dataType = value;

		dataTypes = dataType.split(",");

	}

	public String getDataType(){

		return dataType;

	}

	/**
	*
	**/
	public void setDataLength(String value){

		this.dataLength = value;

		dataLengths = dataLength.split(",");

	}

	public String getDataLength(){

		return dataLength;

	}

	/**
	*
	**/
	public void setClassName(String value){

		this.className = value;

	}

	public String getClassName(){

		return className;

	}

	/**
	*
	**/
	public void setTableName(String value){

		this.tableName = value;

	}

	public String getTableName(){

		return tableName;

	}

	/**
	*
	**/
	public void setExtendsName(String value){

		this.extendsName = value;

	}

	public String getExtendsName(){

		return extendsName;

	}

	/**
	*
	**/
	public void setPackageName(String value){

		this.packageName = value;

	}

	public String getPackageName(){

		return packageName;

	}

	/**
	*
	**/
	public void setKey(String value){

		this.key = value;

	}

	public String getKey(){

		return key;

	}

	/**
	*
	**/
	private String createPrint(){

		StringBuffer buf = new StringBuffer();

		int i = 0;

		buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* print" + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public String toString(){" + ENTER_KEY
					+ TAB_KEY2 +  "return " + ENTER_KEY);

		String junk = "";
		for(i=0; i<columnNames.length; i++){

			if (i>0) junk = "+";

			buf.append(TAB_KEY2 + junk +  " \"" + columnNames[i] + ": \" + "
						+" get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1)+"() "
						+ ENTER_KEY);
		} // for i

		buf.append(TAB_KEY2 + ";"
					+ ENTER_KEY
					+ TAB_KEY1 + "}"
					+ ENTER_KEY + ENTER_KEY);

		return buf.toString();

	}

	/**
	*
	**/
	private String createGetData(){

		StringBuffer buf = new StringBuffer();

		int i = 0;

		String temp = className.substring(0,1).toLowerCase() + className.substring(1).toLowerCase();

		buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* get"+ className+ ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @param conn connection" + ENTER_KEY
					+ TAB_KEY1 +  "* @param id int" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @return " + className + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public "+className+" get"+className+"(Connection conn,int id){" + ENTER_KEY
					+ TAB_KEY2 + className + " " + temp + " = null ;" + ENTER_KEY + ENTER_KEY
					+ TAB_KEY2 +  "try{" + ENTER_KEY
					+ TAB_KEY3 +  "AseUtil ae = new AseUtil();" + ENTER_KEY
					+ TAB_KEY3 +  "String sql = \"SELECT * FROM " + tableName + " WHERE "+key+"=?\";");

		buf.append(ENTER_KEY);

		buf.append(TAB_KEY3 + "PreparedStatement ps = conn.prepareStatement(sql);" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ps.setInt(1,id);" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ResultSet rs = ps.executeQuery();" + ENTER_KEY);
		buf.append(TAB_KEY3 + "if(rs.next()){" + ENTER_KEY);

		buf.append(TAB_KEY4 + temp +" = new " + className + "();" + ENTER_KEY);

		for(i=0; i<columnNames.length; i++){
			if (dataTypesSQL[i].equals("numeric") || dataTypesSQL[i].equals("smallint")){
				buf.append(TAB_KEY4 + temp + ".set"+columnNames[i].substring(0,1).toUpperCase()+ columnNames[i].substring(1)
						+"(NumericUtil.getInt(rs.getInt(\""+columnNames[i]+"\"),0));" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("varchar") || dataTypesSQL[i].equals("text")){
				buf.append(TAB_KEY4 + temp + ".set"+columnNames[i].substring(0,1).toUpperCase()+ columnNames[i].substring(1)
						+"(AseUtil.nullToBlank(rs.getString(\""+columnNames[i]+"\")));" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("datetime") || dataTypesSQL[i].equals("smalldatetime")){
				buf.append(TAB_KEY4 + temp + ".set"+columnNames[i].substring(0,1).toUpperCase()+ columnNames[i].substring(1)
						+"(ae.ASE_FormatDateTime(rs.getString(\""+columnNames[i]+"\"),Constant.DATE_DATETIME));" + ENTER_KEY);
			}
		} // for i

		buf.append(TAB_KEY3 + "}" + ENTER_KEY);
		buf.append(TAB_KEY3 + "rs.close();" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ps.close();" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ae = null;" + ENTER_KEY);

		buf.append(TAB_KEY2 + "}" + ENTER_KEY);
		buf.append(TAB_KEY2 + "catch(Exception e){" + ENTER_KEY);
		buf.append(TAB_KEY3 + "logger.fatal(\""+className+".delete: \" + e.toString());" + ENTER_KEY);
		buf.append(TAB_KEY2 + "}" + ENTER_KEY
					+ ENTER_KEY + TAB_KEY2 + "return " + temp + ";" + ENTER_KEY
					+ ENTER_KEY + TAB_KEY1 + "}"
					+ ENTER_KEY
					+ ENTER_KEY);

		return buf.toString();

	}

	/**
	*
	**/
	private String createGetColumn(){

		StringBuffer buf = new StringBuffer();

		int i = 0;

		String temp = className.substring(0,1).toLowerCase() + className.substring(1).toLowerCase();

		buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* getColumn - returns a column from the object/table"+ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @param conn 		connection" + ENTER_KEY
					+ TAB_KEY1 +  "* @param column	String" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @return String"+ ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public String getColumn(Connection conn,String column){" + ENTER_KEY
					+ TAB_KEY2 + "String column = \"\";" + ENTER_KEY + ENTER_KEY
					+ TAB_KEY2 +  "try{" + ENTER_KEY
					+ TAB_KEY3 +  "String sql = \"SELECT \"+column+\" FROM " + tableName + " WHERE "+key+"=?\";"  + ENTER_KEY
		         + TAB_KEY3 +  "PreparedStatement ps = conn.prepareStatement(sql);" + ENTER_KEY
         		+ TAB_KEY3 +  "ps.setString(1,campus);" + ENTER_KEY
		         + TAB_KEY3 +  "ps.setString(2,kix);" + ENTER_KEY
         		+ TAB_KEY3 +  "ResultSet rs = ps.executeQuery();" + ENTER_KEY
		         + TAB_KEY3 +  "if(rs.next()){" + ENTER_KEY
            	+ TAB_KEY4 +  "column = AseUtil.nullToBlank(rs.getString(\"+column+\"));" + ENTER_KEY
         		+ TAB_KEY3 +  "}" + ENTER_KEY
         		+ TAB_KEY3 +  "rs.close();" + ENTER_KEY
         		+ TAB_KEY3 +  "ps.close();" + ENTER_KEY
      			+ TAB_KEY2 +  "}" + ENTER_KEY
					+ TAB_KEY2 +  "catch(Exception e){" + ENTER_KEY
					+ TAB_KEY3 +  "logger.fatal(\"getColumn \" + e.toString());" + ENTER_KEY
					+ TAB_KEY2 +  "}" + ENTER_KEY
      			+ TAB_KEY2 +  "return column;" + ENTER_KEY
					+ ENTER_KEY + TAB_KEY1 + "}"
					+ ENTER_KEY
					+ ENTER_KEY);

		return buf.toString();

	}

	/**
	*
	**/
	private String createDelete(){

		StringBuffer buf = new StringBuffer();

		buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* delete" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @param conn connection" + ENTER_KEY
					+ TAB_KEY1 +  "* @param id int" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @return int" + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public int delete(Connection conn,int id){" + ENTER_KEY
					+ TAB_KEY2 +  "int rowsAffected = 0;" + ENTER_KEY + ENTER_KEY
					+ TAB_KEY2 +  "try{" + ENTER_KEY
					+ TAB_KEY3 +  "String sql = \"DELETE FROM " + tableName + " WHERE "+key+"=?\";");

		buf.append(ENTER_KEY);

		buf.append(TAB_KEY3 + "PreparedStatement ps = conn.prepareStatement(sql);" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ps.setInt(1,id);" + ENTER_KEY);
		buf.append(TAB_KEY3 + "rowsAffected = ps.executeUpdate();" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ps.close();" + ENTER_KEY);

		buf.append(TAB_KEY2 + "}" + ENTER_KEY);
		buf.append(TAB_KEY2 + "catch(Exception e){" + ENTER_KEY);
		buf.append(TAB_KEY3 + "logger.fatal(\""+className+".delete: \" + e.toString());" + ENTER_KEY);
		buf.append(TAB_KEY2 + "}" + ENTER_KEY);

		buf.append(ENTER_KEY + TAB_KEY2 + "return rowsAffected;" + ENTER_KEY
					+ ENTER_KEY + TAB_KEY1 + "}"
					+ ENTER_KEY
					+ ENTER_KEY);

		return buf.toString();

	}

	/**
	*
	**/
	private String createUpdate(){

		StringBuffer buf = new StringBuffer();

		int i = 0;

		buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* update" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @param conn connection" + ENTER_KEY
					+ TAB_KEY1 +  "* @param "+className+" "+className.toLowerCase() + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @return int" + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public int update(Connection conn,"+className+" "+className.toLowerCase()+"){" + ENTER_KEY
					+ TAB_KEY2 +  "int rowsAffected = 0;" + ENTER_KEY + ENTER_KEY
					+ TAB_KEY2 +  "try{" + ENTER_KEY
					+ TAB_KEY3 +  "String sql = \"UPDATE " + tableName + " SET ");

		String junk = ",";
		for(i=0; i<columnNames.length; i++){
			if (i == (columnNames.length-1)) junk = "";
			buf.append(columnNames[i] + "=?" + junk);

		} // for i
		buf.append(" WHERE "+key+"=?\";");

		buf.append(ENTER_KEY);

		buf.append(TAB_KEY3 + "PreparedStatement ps = conn.prepareStatement(sql);" + ENTER_KEY);

		for(i=0; i<columnNames.length; i++){
			if (dataTypesSQL[i].equals("numeric") || dataTypesSQL[i].equals("smallint")){
				buf.append(TAB_KEY3 + "ps.setInt(" + (i+1) + ","+className.toLowerCase()+".get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + "());" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("varchar") || dataTypesSQL[i].equals("text")){
				buf.append(TAB_KEY3 + "ps.setString(" + (i+1) + ","+className.toLowerCase()+".get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + "());" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("datetime") || dataTypesSQL[i].equals("smalldatetime")){
				buf.append(TAB_KEY3 + "ps.setString(" + (i+1) + ","+className.toLowerCase()+".get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + "());" + ENTER_KEY);
			}
		} // for i

		buf.append(TAB_KEY3 + "ps.setInt(" + (i+1) +",[KEY_VALUE_HERE]);" + ENTER_KEY);

		buf.append(TAB_KEY3 + "rowsAffected = ps.executeUpdate();" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ps.close();" + ENTER_KEY);

		buf.append(TAB_KEY2 + "}" + ENTER_KEY);
		buf.append(TAB_KEY2 + "catch(Exception e){" + ENTER_KEY);
		buf.append(TAB_KEY3 + "logger.fatal(\""+className+".update: \" + e.toString());" + ENTER_KEY);
		buf.append(TAB_KEY2 + "}" + ENTER_KEY);

		buf.append(ENTER_KEY + TAB_KEY2 + "return rowsAffected;"
					+ ENTER_KEY
					+ ENTER_KEY + TAB_KEY1 + "}"
					+ ENTER_KEY
					+ ENTER_KEY);

		return buf.toString();
	}

	/**
	*
	**/
	private String createInsert(){

		int i = 0;

		StringBuffer buf = new StringBuffer();

		buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* insert" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @param conn connection" + ENTER_KEY
					+ TAB_KEY1 +  "* @param "+className+" "+className.toLowerCase() + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @return int" + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public int insert(Connection conn,"+className+" "+className.toLowerCase()+"){" + ENTER_KEY
					+ TAB_KEY2 +  "int rowsAffected = 0;" + ENTER_KEY + ENTER_KEY
					+ TAB_KEY2 +  "try{" + ENTER_KEY
					+ TAB_KEY3 +  "String sql = \"INSERT INTO " + tableName + "(");

		String junk = ",";

		for(i=0; i<columnNames.length; i++){
			if (i == (columnNames.length-1)) junk = "";
			buf.append(columnNames[i] + junk);

		} // for i
		buf.append(")");

		buf.append(" VALUES(");
		junk = ",";
		for(i=0; i<columnNames.length; i++){
			if (i == (columnNames.length-1)) junk = "";
			buf.append("?" + junk);

		} // for i
		buf.append(")\";");

		buf.append(ENTER_KEY);

		buf.append(TAB_KEY3 + "PreparedStatement ps = conn.prepareStatement(sql);" + ENTER_KEY);

		for(i=0; i<columnNames.length; i++){
			if (dataTypesSQL[i].equals("numeric") || dataTypesSQL[i].equals("smallint")){
				buf.append(TAB_KEY3 + "ps.setInt(" + (i+1) + ","+className.toLowerCase()+".get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + "());" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("varchar") || dataTypesSQL[i].equals("text")){
				buf.append(TAB_KEY3 + "ps.setString(" + (i+1) + ","+className.toLowerCase()+".get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + "());" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("datetime") || dataTypesSQL[i].equals("smalldatetime")){
				buf.append(TAB_KEY3 + "ps.setString(" + (i+1) + ","+className.toLowerCase()+".get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + "());" + ENTER_KEY);
			}

		} // for i

		buf.append(TAB_KEY3 + "rowsAffected = ps.executeUpdate();" + ENTER_KEY);
		buf.append(TAB_KEY3 + "ps.close();" + ENTER_KEY);

		buf.append(TAB_KEY2 + "}" + ENTER_KEY);
		buf.append(TAB_KEY2 + "catch(Exception e){" + ENTER_KEY);
		buf.append(TAB_KEY3 + "logger.fatal(\""+className+".insert: \" + e.toString());" + ENTER_KEY);
		buf.append(TAB_KEY2 + "}" + ENTER_KEY);

		buf.append(ENTER_KEY + TAB_KEY2 + "return rowsAffected;" + ENTER_KEY);

		buf.append(ENTER_KEY + TAB_KEY1 + "}");
		buf.append(ENTER_KEY);
		buf.append(ENTER_KEY);

		return buf.toString();

	}

	/**
	*
	**/
	private String createSettersGetters(){

		StringBuffer buf = new StringBuffer();

		for(int i=0; i<columnNames.length; i++){
			buf.append(
					TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* set" + columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) +  ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @param " + dataTypes[i] + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public void set" + columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1)+"("+dataTypes[i]+" value){" + ENTER_KEY
					+ TAB_KEY1 + "" + ENTER_KEY
					+ TAB_KEY2 + "this."+columnNames[i]+" = value;" + ENTER_KEY
					+ TAB_KEY1 + "" + ENTER_KEY
					+ TAB_KEY1 + "}" + ENTER_KEY
					+ TAB_KEY1 + "" + ENTER_KEY
					+ TAB_KEY1 + "/**" + ENTER_KEY
					+ TAB_KEY1 +  "* get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1) + ENTER_KEY
					+ TAB_KEY1 +  "*" + ENTER_KEY
					+ TAB_KEY1 +  "* @return " + dataTypes[i] + ENTER_KEY
					+ TAB_KEY1 + "*/" + ENTER_KEY
					+ TAB_KEY1 + "public "+dataTypes[i]+" get"+ columnNames[i].substring(0,1).toUpperCase() + columnNames[i].substring(1)+"(){" + ENTER_KEY
					+ TAB_KEY1 + "" + ENTER_KEY
					+ TAB_KEY2 + "return "+columnNames[i]+";" + ENTER_KEY
					+ TAB_KEY1 + "" + ENTER_KEY
					+ TAB_KEY1 + "}" + ENTER_KEY
					+ TAB_KEY1 + "" + ENTER_KEY
				);

		}

		return buf.toString();

	}

	/**
	*
	**/
	private String createInitialization(){

		StringBuffer buf = new StringBuffer();

		for(int i=0; i<columnNames.length; i++){

			if (dataTypesSQL[i].equals("numeric") || dataTypesSQL[i].equals("smallint")){
				buf.append(TAB_KEY2 + "this." + columnNames[i] + " = 0;" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("varchar") || dataTypesSQL[i].equals("text")){
				buf.append(TAB_KEY2 + "this." + columnNames[i] + " = null;" + ENTER_KEY);
			}
			else if (dataTypesSQL[i].equals("datetime") || dataTypesSQL[i].equals("smalldatetime")){
				buf.append(TAB_KEY2 + "this." + columnNames[i] + " = null;" + ENTER_KEY);
			}

		} // for i


		buf.append(ENTER_KEY + TAB_KEY1 + "}" + ENTER_KEY + ENTER_KEY);

		return buf.toString();

	}

	/**
	*
	**/
	private String createConstructor(){

		return ENTER_KEY
				+ TAB_KEY1 + "public " + className + "(){" + ENTER_KEY
				+ TAB_KEY1 + "" + ENTER_KEY
				+ TAB_KEY2 + "//super();" + ENTER_KEY
				+ TAB_KEY1 + "" + ENTER_KEY
				+ TAB_KEY2 + "//created = new java.sql.Date(Calendar.getInstance().getTime().getTime());" + ENTER_KEY
				+ TAB_KEY1 + "" + ENTER_KEY;

	}

	/**
	*
	**/
	private String createMemberVariables(){

		String buf = "";

		for(int i=0; i<columnNames.length; i++){
			buf += TAB_KEY1 + "private " + dataTypes[i] + " " + columnNames[i] + ";" + ENTER_KEY;
		}

		return buf;

	}

	/**
	*
	**/
	private String createLogging(){

		return TAB_KEY1
				+ "static Logger logger = Logger.getLogger("+className+".class.getName());"
				+ ENTER_KEY
				+ ENTER_KEY;

	}

	/**
	*
	**/
	private String createVersionID(){

		//com.ase.guid.RandomGUID guid = new com.ase.guid.RandomGUID(false);
		//buf.append(TAB_KEY1 + "private static final long serialVersionUID = "+guid.toString()+";" + ENTER_KEY);
		//buf.append(ENTER_KEY);

		return "";


	}

	/**
	*
	**/
	private String createClassDeclaration(){

		return "public class " + className + " " + extendsName + "{" + ENTER_KEY + ENTER_KEY;

	}

	/**
	*
	**/
	private String closeClassDeclaration(){

		return "}" + ENTER_KEY + ENTER_KEY;

	}

	/**
	*
	**/
	private String createImports(){

		String buf = "";

		for(int i=0; i<importList.length; i++){
			buf += "import " + importList[i] + ";" + ENTER_KEY;
		}

		buf += ENTER_KEY;

		return buf;

	}

	/**
	*
	**/
	private String createPackage(){

		return "package " + packageName + ";" + ENTER_KEY + ENTER_KEY;
	}

	/**
	*
	**/
	private String createDisclaimer(){

		return "/**" + ENTER_KEY
			 + "* Copyright 2007- Applied Software Engineering, LLC. All rights reserved. You" + ENTER_KEY
			 + "* may not modify, use, reproduce, or distribute this software except in" + ENTER_KEY
			 + "* compliance with the terms of the License made with Applied Software" + ENTER_KEY
			 + "* Engineering" + ENTER_KEY
			 + "*" + ENTER_KEY
			 + "* @author ttgiang" + ENTER_KEY
			 + "*/"
			 + ENTER_KEY
			 + ENTER_KEY;

	}

	/**
	*
	**/
	public String createClass(){

		/*
		System.out.println("package name: " + getPackageName());
		System.out.println("class name: " + getClassName());
		System.out.println("table name: " + getTableName());
		System.out.println("imports: " + getImports());
		System.out.println("extends: " + getExtendsName());
		System.out.println("key: " + getKey());
		System.out.println("column name: " + getColumnName());
		System.out.println("sql type: " + getDataTypeSQL());
		System.out.println("data type: " + getDataType());
		System.out.println("data length: " + getDataLength());
		*/

		return
			createDisclaimer()
			+ createPackage()
			+ createImports()
			+ createClassDeclaration()
			+ createVersionID()
			+ createLogging()
			+ createMemberVariables()
			+ createConstructor()
			+ createInitialization()
			+ createSettersGetters()
			+ createInsert()
			+ createUpdate()
			+ createDelete()
			+ createGetData()
			+ createGetColumn()
			+ createPrint();
	}

	/**
	*
	**/
	public void DBOjects(){}

	public static void main(String[] args) {

	} // main

} // DBOjects

