<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>

<%@ include file="ase.jsp" %>

<%

  try
  {
		String getSQL = "SELECT coursealpha,coursenum,semester,yeer,userid,textbooks,objectives,grading,auditdate FROM tblSyllabus WHERE id=?";
		PreparedStatement preparedStatement = conn.prepareStatement(getSQL);
		preparedStatement.setString(1,String.valueOf(9));
		ResultSet resultSet = preparedStatement.executeQuery();
		if (resultSet.next()) {
			Syllabus syllabus = new Syllabus();
			syllabus.setAlpha( resultSet.getString(1) );
			syllabus.setNum( resultSet.getString(2) );
			syllabus.setSemester( resultSet.getString(3) );
			syllabus.setYear( resultSet.getString(4) );
			syllabus.setUserID( resultSet.getString(5) );
			syllabus.setTextBooks( resultSet.getString(6) );
			syllabus.setObjectives( resultSet.getString(7) );
			syllabus.setGrading( resultSet.getString(8) );
			syllabus.setAuditDate( resultSet.getString(9) );
			out.println( syllabus );
		}
		resultSet.close();
		preparedStatement.close ();
  }
	catch( Exception e ){
		out.println( e.toString() );
	}

%>