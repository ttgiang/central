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
			StringBuffer buf = new StringBuffer();
			String resequenceSQL = "";
			String field = "";
			String campusField = "";
			String table = "";
			String sql;
			String view = "";
			int id = 0;
			String[] seq = new String[100];
			String sequences = "1,2,3,4,5,6,7,8,9,10";

			if ("c".equals(questionType)){
				table = "tblCourseQuestions";
				view = "vw_CourseItems";
				campusField = "courseitems";
			}
			else{
				table = "tblCampusQuestions";
				view = "vw_CampusItems";
				campusField = "campusitems";
			}

			/*
				1) select all Y questions in order of seq then update the seq by the record ID
				starting from 1 till end of the recordset.

				2) when done, update all the N with seq = 0

				3) create a string of field names and save to the campus table for later use (CSV)
			*/

			//1
			sql = "SELECT id,field_name FROM " + view + " WHERE include='Y' AND campus=? ORDER BY seq";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			ResultSet rs = preparedStatement.executeQuery();

			seq = sequences.split(",");
			i = 0;

			resequenceSQL = "UPDATE " + table + " SET questionseq=? WHERE id=?";
			preparedStatement = conn.prepareStatement(resequenceSQL);
			while (rs.next()) {
				id = rs.getInt(1);
				field = rs.getString(2);

				if (i==0)
					buf.append(field);
				else
					buf.append(","+field);

				preparedStatement.setInt(1, Integer.valueOf(seq[i++]));
				preparedStatement.setInt(2, id);
				rowsAffected = preparedStatement.executeUpdate();
			}
			rs.close();

			//2
			preparedStatement.clearParameters();
			sql = "UPDATE " + table + " SET questionseq=0 WHERE include='N' AND campus=?";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			rowsAffected = preparedStatement.executeUpdate();

			//3
			preparedStatement.clearParameters();
			sql = "UPDATE tblCampus SET " + campusField + "=? WHERE campus=?";
			preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, buf.toString());
			preparedStatement.setString(2, campus);
			rowsAffected = preparedStatement.executeUpdate();

		preparedStatement.close ();
	}
	catch (SQLException e){
		out.println(e.toString());
	}
	catch (Exception ex){
		out.println(ex.toString());
	}

%>