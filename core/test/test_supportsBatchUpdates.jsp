<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

 try {
	  DatabaseMetaData dmd = conn.getMetaData();
	  if (dmd.supportsBatchUpdates()) {
			out.println( "batch support available" );
	  } else {
			out.println( "batch support not available" );
	  }
 } catch (SQLException e) {
	 out.println( "processing error" );
 }


%>