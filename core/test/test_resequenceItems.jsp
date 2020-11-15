<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String user = "THANHG";
	String questionType = "r";
	int rowsAffected = 0;
	int i = 0;

	try{
		PreparedStatement preparedStatement;
		String resequenceSQL;
		String resetExcludedItemsSQL;
		String table = "";
		String view = "";
		String resequence = "";
		String campusField = "";

		if ("c".equals(questionType)){
			table = "tblCourseQuestions";
			view = "vw_CourseQuestions";
			resequence = "vw_ResequenceCourseItems";
			campusField = "courseitems";
		}
		else{
			table = "tblCampusQuestions";
			view = "vw_CampusQuestions";
			resequence = "vw_ResequenceCampusItems";
			campusField = "campusitems";
		}

out.println( "table: " + table + "<br>" );
out.println( "view: " + view + "<br>" );
out.println( "resequence: " + resequence + "<br>" );
out.println( "campusField: " + campusField + "<br>" );

		resequenceSQL = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND type='Course' AND questionseq=?";
		resetExcludedItemsSQL = "UPDATE " + table + " SET questionseq=0 WHERE campus=? AND type='Course' AND include='N'";

		/*
			loop through and renumber questions sequence
		*/
		preparedStatement = conn.prepareStatement("SELECT questionseq FROM " + view + " WHERE campus=?");
		preparedStatement.setString(1, campus);
		ResultSet rs = preparedStatement.executeQuery();

out.println( "Resequencing<br>" );
out.println( "------------<br>" );

		preparedStatement = conn.prepareStatement(resequenceSQL);
		while (rs.next()) {
			int oldSeq = rs.getInt(1);
			int newSeq = ++i;

out.println( "newSeq: " + newSeq + "<br>" );

			preparedStatement.setInt (1, newSeq);
			preparedStatement.setString (2, campus);
			preparedStatement.setInt (3, oldSeq);
			rowsAffected = preparedStatement.executeUpdate();
		}
		rs.close();
		preparedStatement.close ();

		// reset excluded items
		preparedStatement = conn.prepareStatement(resetExcludedItemsSQL);
		preparedStatement.setString (1, campus);
		rowsAffected = preparedStatement.executeUpdate();
		preparedStatement.close ();

		/*
			save field names
			get course field names that are included by campus
		*/
out.println( "Save Fields<br>" );
out.println( "-----------<br>" );
		String temp = "";
		preparedStatement = conn.prepareStatement("SELECT question_friendly FROM " + resequence + " WHERE campus=?");
		preparedStatement.setString(1, campus);
		rs = preparedStatement.executeQuery();
		while ( rs.next() ) {
			if ( temp.length() == 0 )
				temp = (String)rs.getString("question_friendly");
			else
				temp = temp + "," + (String)rs.getString("question_friendly");
out.println( "temp: " + temp + "<br>" );
		}
		rs.close();
		rs = null;

		if ( temp.length() > 0 ){
			preparedStatement = conn.prepareStatement("UPDATE tblCampus SET " + campusField + "=? WHERE campus=?");
			preparedStatement.setString (1, temp);
			preparedStatement.setString (2, campus);
			rowsAffected = preparedStatement.executeUpdate();
			preparedStatement.close ();
		}
	}
	catch (SQLException e){
		out.println("QuestionDB: resequenceItems\n" + e.toString());
		rowsAffected = 0;
	}


%>