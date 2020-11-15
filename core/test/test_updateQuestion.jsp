<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Course Question Listing";
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
<%
	String user = "THANHG";
	String campus = "LEECC";
	String alpha = "ICS";
	String num = "241";

	int oldSeq = 30;
	int newSeq = 10;
	int questionNumber = 7;
	String question = "Articulation";
	String included = "Y";
	String auditby = user;
	String auditdate;
	String questionType = "r";

		int qNumber = 0;				// question number from database
		int qSeq = 0;					// sequence from database
		int rowsAffected = 0;
		String sql;
		String table = "";
		StringBuffer progressLog = new StringBuffer();
		PreparedStatement preparedStatement;
		Statement stmt;				// for batch update

		int total = 0;					// temp variable
		int i = 0;
		int[] batchUpdateCounts;			// array holding results of batch update

		if ("r".equals(questionType))
			table = "tblCourseQuestions";
		else
			table = "tblCampusQuestions";

		batchUpdateCounts = null;

		conn.setAutoCommit(false);

		/*
			there are 4 basic scenarios

			0) Include is N

			1) Old Seq = 0

				When old sequence is 0 and include is yes, this means that we are activating an item

			2) new seq is less than old seq
				changing the sequence number.
				1) start by putting the requested change out of the way
				2) update all sequence between the new seq and old seq
				3) update the displaced item from #1 with the correct value

				for example, assuming the old seq = 6 and we want to make it to 2

				Original order:		1 2 3 4 5 6 7 8 9 10
				#1 above:				-1 1 2 3 4 5 7 8 9 10	(6 was moved out of the way by setting to -1)
				#2 above:				-1 1 3 4 5 6 7 8 9 10	(everthing from the old seq to less than new seq is moved)
				#3	above:				1 2 3 4 5 6 7 8 9 10		(put -1 back into its correct spot)

			3) new seq is greater old seq

		*/
		try {
			if ("N".equals(included)){
				//1
				sql = "UPDATE " + table + " SET questionseq=0,include='N',auditby=?,auditdate=? WHERE campus=? AND questionnumber=?";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, auditby);
				preparedStatement.setString(2, AseUtil.getCurrentDateString());
				preparedStatement.setString(3, campus);
				preparedStatement.setInt(4, questionNumber);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM " + table + " WHERE campus=? AND include='Y' AND questionseq>? ORDER BY questionseq";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, campus);
				preparedStatement.setInt(2, oldSeq);
				ResultSet rs = preparedStatement.executeQuery();

				table = "UPDATE " + table;
				stmt = conn.createStatement();
				while (rs.next()) {
					qNumber = rs.getInt(1);
					qSeq = rs.getInt(2) - 1;
					sql = table + " SET questionseq=" + qSeq + " WHERE campus='" + campus + "' AND questionnumber=" + qNumber;
					stmt.addBatch(sql);
				}
				batchUpdateCounts = stmt.executeBatch();
				stmt.close();
				rs.close();
				preparedStatement.close();
			}
			else if (oldSeq == 0){
				//1
				sql = "SELECT questionnumber,questionseq FROM " + table + " WHERE campus=? AND include='Y' AND questionseq>=? ORDER BY questionseq DESC";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, campus);
				preparedStatement.setInt(2, newSeq);
				ResultSet rs = preparedStatement.executeQuery();

				stmt = conn.createStatement();
				while (rs.next()) {
					qNumber = rs.getInt(1);
					qSeq = rs.getInt(2) + 1;
					sql = "UPDATE " + table + " SET questionseq=" + qSeq + " WHERE campus='" + campus + "' AND questionnumber=" + qNumber;
					stmt.addBatch(sql);
				}
				batchUpdateCounts = stmt.executeBatch();
				stmt.close();
				rs.close();
				preparedStatement.close();

				//2
				sql = "UPDATE " + table + " SET questionseq=?,include='Y',auditby=?,auditdate=? WHERE campus=? AND questionnumber=?";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, newSeq);
				preparedStatement.setString(2, auditby);
				preparedStatement.setString(3, AseUtil.getCurrentDateString());
				preparedStatement.setString(4, campus);
				preparedStatement.setInt(5, questionNumber);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();
			}
			else if (newSeq > oldSeq){
				//1
				sql = "UPDATE " + table + " SET questionseq=-1,question=?,include=?,auditby=?,auditdate=? WHERE campus=? AND questionnumber=?";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, question);
				preparedStatement.setString(2, included);
				preparedStatement.setString(3, auditby);
				preparedStatement.setString(4, AseUtil.getCurrentDateString());
				preparedStatement.setString(5, campus);
				preparedStatement.setInt(6, questionNumber);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM " + table + " WHERE campus=? AND include='Y' AND (questionseq>? AND questionseq<=?) ORDER BY questionseq";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, campus);
				preparedStatement.setInt(2, oldSeq);
				preparedStatement.setInt(3, newSeq);
				ResultSet rs = preparedStatement.executeQuery();

				stmt = conn.createStatement();
				while (rs.next()) {
					qNumber = rs.getInt(1);
					qSeq = rs.getInt(2) - 1;
					sql = "UPDATE " + table + " SET questionseq=" + qSeq + " WHERE campus='" + campus + "' AND questionnumber=" + qNumber;
					stmt.addBatch(sql);
				}
				batchUpdateCounts = stmt.executeBatch();
				stmt.close();
				rs.close();
				preparedStatement.close();

				//3
				sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, newSeq);
				preparedStatement.setString(2, campus);
				preparedStatement.setInt(3, questionNumber);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();
			}
			else if (newSeq < oldSeq){
				//1
				sql = "UPDATE " + table + " SET questionseq=-1,question=?,include=?,auditby=?,auditdate=? WHERE campus=? AND questionnumber=?";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, question);
				preparedStatement.setString(2, included);
				preparedStatement.setString(3, auditby);
				preparedStatement.setString(4, AseUtil.getCurrentDateString());
				preparedStatement.setString(5, campus);
				preparedStatement.setInt(6, questionNumber);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();

				//2
				sql = "SELECT questionnumber,questionseq FROM " + table + " WHERE campus=? AND include='Y' AND (questionseq>=? AND questionseq<?) ORDER BY questionseq DESC";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1, campus);
				preparedStatement.setInt(2, newSeq);
				preparedStatement.setInt(3, oldSeq);
				ResultSet rs = preparedStatement.executeQuery();

				stmt = conn.createStatement();
				while (rs.next()) {
					qNumber = rs.getInt(1);
					qSeq = rs.getInt(2) + 1;
					sql = "UPDATE " + table + " SET questionseq=" + qSeq + " WHERE campus='" + campus + "' AND questionnumber=" + qNumber;
					stmt.addBatch(sql);
				}
				batchUpdateCounts = stmt.executeBatch();
				stmt.close();
				rs.close();
				preparedStatement.close();

				//3
				sql = "UPDATE " + table + " SET questionseq=? WHERE campus=? AND questionnumber=?";
				preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setInt(1, newSeq);
				preparedStatement.setString(2, campus);
				preparedStatement.setInt(3, questionNumber);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();
			}

			// did the batch update go through OK? If yes, total = batchUpdateCounts.length
			total = 0;
			for (i=0;i<batchUpdateCounts.length;i++){
				if (batchUpdateCounts[i]==1)
					++total;
			}

			if (total == batchUpdateCounts.length){
				QuestionDB.resequenceItems(conn,questionType,campus);
				conn.commit();
			}
			else{
				msg.setMsg("Exception");
				conn.rollback();
			}

		} catch (BatchUpdateException bu) {
			conn.rollback();
			//logger.fatal("QuestionDB - BatchUpdateException: updateQuestion\n" + bu.toString());
			out.println("QuestionDB - BatchUpdateException: updateQuestion\n" + bu.toString());
			rowsAffected = 0;
		} catch (SQLException se) {
			conn.rollback();
			//logger.fatal("QuestionDB - SQLException: updateQuestion\n" + se.toString());
			out.println("QuestionDB - SQLException: updateQuestion\n" + se.toString());
			out.println("SQLState: " + se.getSQLState() + "<br>");
			out.println("Message: " + se.getMessage() + "<br>");
			out.println("Vendor: " + se.getErrorCode() + "<br>");

			rowsAffected = 0;
		} catch (Exception e) {
			conn.rollback();
			//logger.fatal("QuestionDB - Exception: updateQuestion\n" + e.toString());
			out.println("QuestionDB - Exception: updateQuestion\n" + e.toString());
			rowsAffected = 0;
		}

		conn.setAutoCommit(true);

out.println(msg.getMsg());

%>

</body>
</html>