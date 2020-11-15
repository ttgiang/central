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
	String thisApprover = "";
	int thisSeq = 0;
	int currentSeq = 0;
	int firstSeq = 1;
	int nextSeq = 0;
	int prevSeq = 0;
	int lastSeq = 0;
	String alpha = "ICS";
	String num = "241";

	String thisDelegated = "";
	StringBuffer allApprovers = new StringBuffer();
	Approver approver = new Approver();

		int lid = 0;
		String hid = "";
		String cid = "";
		String type = "PRE";
		int section = 4;

		String sql = "";
		String historyID = null;

		int columnCount = 0;
		int j = 0;

		String table = "tblCampusData";
		StringBuffer outline = new StringBuffer();

		try{
			String questionData[] = new String[2];
			PreparedStatement preparedStatement;

			// these are questions to display
			ArrayList list = QuestionDB.getCampusQuestionsByInclude(conn,campus,"Y");
			columnCount = list.size();

			// these are the fields we need to get back from the db
			String temp = aseUtil.lookUp(conn,"tblCampus","campusitems","campus='" + campus + "'") + ",historyid";
			columnCount++;

			if (temp.length() > 0) {
				outline.append("");

				String[] aFieldNames = new String[columnCount];
				aFieldNames = temp.split(",");

				switch (section) {
				case 1:
					sql = "SELECT " + temp + " FROM " + table + " WHERE id=?";
					break;
				case 2:
					table = "tblCourseARC";
					type = "ARC";

					/*
					 * with only the historyid, we have to get the alpha and
					 * number to make it work for archived outlines.
					 */
					sql = "historyid=" + aseUtil.toSQL(hid, 1);
					questionData = aseUtil.lookUpX(conn,table,"coursealpha,coursenum",sql);
					alpha = questionData[0];
					num = questionData[1];

					sql = "SELECT " + temp + " FROM " + table + " WHERE historyid=?";
					break;
				case 3:
					table = "tblCourseCAN";
					sql = "SELECT " + temp + " FROM " + table + " WHERE historyid=?";
					break;
				case 4:
				case 5:
					sql = "SELECT " + temp + " FROM " + table
							+ " WHERE coursealpha=? AND coursenum=? AND campus=? AND coursetype=?";
					break;
				} // switch

				preparedStatement = conn.prepareStatement(sql);
				if (section == 1)
					preparedStatement.setInt(1, lid);
				else if (section == 2)
					preparedStatement.setString(1, hid);
				else if (section == 3)
					preparedStatement.setString(1, cid);
				else if (section >= 4) {
					preparedStatement.setString(1, alpha);
					preparedStatement.setString(2, num);
					preparedStatement.setString(3, campus);
					preparedStatement.setString(4, type);
				}


out.println(sql);
				ResultSet rs = preparedStatement.executeQuery();
				java.util.Hashtable rsHash = new java.util.Hashtable();
				if (rs.next()) {
					Question question;
					aseUtil.getRecordToHash(rs, rsHash, aFieldNames);
					for (j = 0; j < list.size(); j++) {
						question = (Question) list.get(j);
						temp = rsHash.get(aFieldNames[j]).toString();
						outline.append("<br><b><font class=textblackTH>"
								+ question.getQuestion()
								+ "</font></b><br><br><font class=dataColumn>"
								+ temp + "</font><br>");
					} // for
				} // if rs.next
				else {
					outline.append("Campus outline not found.");
				}
				rs.close();
				rs = null;

				preparedStatement.close();

				msg.setErrorLog(outline.toString());
			} // if temp
		}
		catch(SQLException ex) {
			//logger.fatal("CourseDB: viewOutline\n" + ex.toString());
			out.println(ex.toString()+"<br>");
		}
		catch (Exception e){
			//logger.fatal("CourseDB: viewOutline\n" + e.toString());
			out.println(e.toString()+"<br>");
		}

out.println(msg.getErrorLog());

%>

</body>
</html>