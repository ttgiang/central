<%@ page import="java.util.*, java.io.*" %>

<%@ include file="ase.jsp" %>

<%

	PreparedStatement preparedStatement;
	ResultSet resultSet;
	boolean renamed = false;

	try{
		String fromAlpha = "ICS";
		String fromNum = "218";
		String toAlpha = "ICS";
		String toNum = "219";
		String campus = "LEECC";
		String user = "THANHG";
		ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AseMessages");

		/*
			1) does toNum course exist campus wide?
			2) If not, is fromNum course being modified?
			3) If not, rename
		*/
		String sql = "SELECT historyid FROM tblCourse WHERE coursealpha=? AND coursenum=?";
		preparedStatement = conn.prepareStatement(sql);
		preparedStatement.setString(1,toAlpha);
		preparedStatement.setString(2,toNum);
		resultSet = preparedStatement.executeQuery();
		boolean exists = resultSet.next();
		if ( exists ){
			out.println( bundle.getString("CourseExistInSystem") );
		}
		else{
			resultSet.close();
			sql = "SELECT historyid FROM tblCourse WHERE coursealpha=? AND coursenum=? AND coursetype='PRE'";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1,fromAlpha);
			preparedStatement.setString(2,fromNum);
			resultSet = preparedStatement.executeQuery();
			exists = resultSet.next();
			if ( exists ){
				out.println( bundle.getString("CourseModificationInProgress") );
			}
			else{
				renamed = courseDB.renameCourseOutlineX(conn,campus,fromAlpha,fromNum,toAlpha,toNum,user);
			}

			resultSet.close();
			preparedStatement.close();
		}
	}
	catch( Exception e ){
		out.println( e.toString() );
		renamed = false;
	}

	asePool.freeConnection(conn);
%>