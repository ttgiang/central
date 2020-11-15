<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "218";
	String user = "THANHG";
	String campus = "LEECC";
	//(new SimpleDateFormat("MM/dd/yyyy  hh:mm:ss a")).format(new java.util.Date())

	String reviewDate = website.getRequestParameter(request,"reviewDate","02/29/2008");
	String setCourseToReview = "UPDATE tblCourse SET edit=0,progress='REVIEW',edit0='',edit1='2',edit2='2',reviewdate=? WHERE coursealpha=? AND coursenum=? AND campus=? AND progress='MODIFY' AND coursetype='PRE'";
	PreparedStatement preparedStatement = conn.prepareStatement(setCourseToReview);
	preparedStatement.setString (1, reviewDate);
	preparedStatement.setString (2, alpha);
	preparedStatement.setString (3, num);
	preparedStatement.setString (4, campus);
	int rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();
	//((CourseDB)session.getAttribute("aseCourseDB")).setCourseReviewers(conn,campus,alpha,num,user,"THANHG,LEECC",reviewDate);

}
catch (Exception e){
	out.println( e.toString() );
};


%>