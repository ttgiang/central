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

		int aid = 61;
		int counter = 30;
		int i = 0;
		String[] assess = new String[counter];
		String sql = "SELECT question,approvedby,approveddate FROM tblAssessedData WHERE accjcid=? ORDER BY qid";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, aid);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				assess[i++] = AseUtil.nullToBlank(results.getString("question"));
				assess[i++] = AseUtil.nullToBlank(results.getString("approvedby"));
				assess[i++] = aseUtil.ASE_FormatDateTime(results.getString("approveddate"),6);
			}

			// nothing found
			if (i==0)
				out.println("none");

			results.close();
			ps.close();
		} catch (SQLException e) {
			out.println("AssessedDataDB: getAssessedData\n" + e.toString());
		} catch (Exception ex) {
			out.println("AssessedDataDB: getAssessedData\n" + ex.toString());
		}

%>

</body>
</html>