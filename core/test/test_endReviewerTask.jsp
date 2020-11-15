<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

try
{
	String alpha = "ICS";
	String num = "218";
	String user = "THANHG";
	String campus = "LEECC";
	boolean	endTask = false;

	// end user's review task
	String sql = "DELETE FROM tblReviewers WHERE courseAlpha=? AND coursenum=? AND userid=? AND campus=?";
	PreparedStatement preparedStatement = conn.prepareStatement(sql);
	preparedStatement.setString (1, alpha);
	preparedStatement.setString (2, num);
	preparedStatement.setString (3, user);
	preparedStatement.setString (4, campus);
	int rowsAffected = preparedStatement.executeUpdate();
	preparedStatement.close ();

	if ( rowsAffected > 0 ){
		endTask = true;
		// if all reviewers have completed their task, let's reset the course and get back
		// to modify mode. also, backup history
		sql = "WHERE courseAlpha = '" + SQLUtil.encode(alpha) + "' AND " +
			"coursenum = '" + SQLUtil.encode(num) + "' AND " +
			"campus = '" + SQLUtil.encode(campus) + "'";
		if ( (int)AseUtil.countRecords(conn, "tblReviewers", sql ) == 0 ){

			// reset course from review to modify
			sql = "UPDATE tblCourse SET edit=1,edit0='',edit1='1',edit2='1',progress='MODIFY' WHERE coursetype='PRE' AND coursealpha=? AND coursenum=? AND campus=?";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString (1, alpha);
			preparedStatement.setString (2, num);
			preparedStatement.setString (3, campus);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close ();
			//out.println( sql + "<br>" );

			// move review history to backup table then clear the active table
			sql = "INSERT INTO tblReviewHist2 SELECT * FROM tblReviewHist WHERE coursealpha=? AND coursenum=? AND campus=?";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString (1, alpha);
			preparedStatement.setString (2, num);
			preparedStatement.setString (3, campus);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close ();
			//out.println( sql + "<br>" );

			sql = "DELETE FROM tblReviewHist WHERE coursealpha=? AND coursenum=? AND campus=?";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString (1, alpha);
			preparedStatement.setString (2, num);
			preparedStatement.setString (3, campus);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close ();
			//out.println( sql + "<br>" );
		}	// endTask

		// log the action and remove the task
		AseUtil.logAction(conn,user,"crsrvwer.jsp","Reviewer Task Ended",alpha,num,campus);
		rowsAffected = TaskDB.logTask(conn,user,user,alpha,num,"Reviewer Task Ended",campus,"crsrvwer.jsp","REMOVE");
	}	// rowsAffected
}
catch (Exception e){
	out.println( e.toString() );
};


%>