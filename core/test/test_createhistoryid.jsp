<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%

try
{

	Calendar cal = new GregorianCalendar();

	// Get the components of the date
	int era = cal.get(Calendar.ERA);					// 0=BC, 1=AD
	int year = cal.get(Calendar.YEAR);				// 2002
	int month = cal.get(Calendar.MONTH) + 1;		// 0=Jan, 1=Feb, ...
	int day = cal.get(Calendar.DAY_OF_MONTH);		// 1...
	int hour = cal.get(Calendar.HOUR);
	int min = cal.get(Calendar.MINUTE);

	out.println( "" + year + month + day + hour + min);

}
catch (Exception e){
	out.println( e.toString() );
};


%>