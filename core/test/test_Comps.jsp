<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try{
	Vector vector = new Vector();
	vector = com.ase.aseutil.CompDB.getComps(conn,"ICS","218","LEECC");
		if ( vector != null ){
			for (Enumeration e = vector.elements(); e.hasMoreElements();){
			String myString = (String) e.nextElement();
			out.println(myString);
		}
	}
}
catch (Exception e){
	out.println( e.toString() );
}
finally {
	if (conn != null) {
		try {
			conn.close();
		} catch (SQLException e) {
			out.println( e.toString() );
		}
	}
}

%>