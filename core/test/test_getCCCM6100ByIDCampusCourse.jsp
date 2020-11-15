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

		int id = 879;
		String questionType = "r";

		String table = "";

		if ("r".equals(questionType))
			table = "vw_CCCM6100ByIDCampusCourse";
		else
			table = "vw_CCCM6100ByIDCampusItems";

		String sql = "SELECT id,questionnumber,questionseq,question,include,question_friendly,"
				+ "question_type,question_len,question_max,question_ini,auditby,auditdate "
				+ "FROM " + table + " WHERE campus=? AND id=?";

out.println(sql);

		CCCM6100 cccm6100 = new CCCM6100();

		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, campus);
			preparedStatement.setInt(2, id);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				cccm6100.setId(resultSet.getInt(1));
				cccm6100.setQuestion_Number(resultSet.getInt(2));
				cccm6100.setQuestionSeq(resultSet.getInt(3));
				cccm6100.setCCCM6100(aseUtil.nullToBlank(resultSet.getString(4)).trim());
				cccm6100.setInclude(aseUtil.nullToBlank(resultSet.getString(5)).trim());
				cccm6100.setQuestion_Friendly(aseUtil.nullToBlank(resultSet.getString(6)).trim());
				cccm6100.setQuestion_Type(aseUtil.nullToBlank(resultSet.getString(7)).trim());
				cccm6100.setQuestion_Len(resultSet.getInt(8));
				cccm6100.setQuestion_Max(resultSet.getInt(9));
				cccm6100.setQuestion_Ini(aseUtil.nullToBlank(resultSet.getString(10)).trim());
				cccm6100.setAuditBy(resultSet.getString(11).trim());
				cccm6100.setAuditDate(aseUtil.nullToBlank(resultSet.getString(12)).trim());
			}
			resultSet.close();
			preparedStatement.close();
		} catch (Exception e) {
			//logger.fatal("CCCM6100DB: getCCCM6100ByIDCampusCourse\n" + e.toString());
			cccm6100 = null;
		}

//return cccm6100;

out.println(cccm6100);

%>

</body>
</html>