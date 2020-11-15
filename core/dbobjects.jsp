<%@ page import="com.ase.aseutil.*"%>
<%@ page import="com.ase.aseutil.db.*"%>
<%@ page import="java.util.*,java.io.*" %>

<%@ include file="ase.jsp" %>

<%

	try{
		DBObjects db = new DBObjects();
		db.setPackageName("com.ase.aseutil");
		db.setClassName("Fnd");
		db.setTableName("tblFnd");
		db.setExtendsName("");
		db.setImports("org.apache.log4j.Logger,java.util.*,java.sql.*,com.ase.aseutil.AseUtil,com.ase.aseutil.Constant");
		db.setColumnName(" id,campus,historyid,fndtype,created,coursealpha,coursenum,coursedate,coursetitle,coursedescr,proposer,coproposer,auditby,auditdate");
		db.setDataTypeSQL("int,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar");
		db.setDataType("int,String,String,String,String,String,String,String,String,String,String,String,String,String");
		db.setDataLength("0,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000");
		db.setKey("id");
		out.println(db.createClass());
	}
	catch( Exception e ){
		out.println( e.toString() );
	}

	asePool.freeConnection(conn);

%>
