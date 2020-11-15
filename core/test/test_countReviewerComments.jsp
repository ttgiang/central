<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crstpl.jsp
	*	2007.09.01
	**/

	String alpha = "ICS";
	String num = "241";
	String type = "CUR";
	String campus = "KAP";
	int item = 1;
	String status = "reviewing";

		long lRecords = 0;
		String table = "tblReviewHist2";

		/*
			in review mode, data is saved to tblReviewHist. After the reviewing process ends,
			all comments are moved to tblReviewHist2.

			Depending on when this is called (status), the appropriate table is used.

			For example, when modifying, we want to count from tblReviewHist2. During
			review, we count from tblReviewHist;
		*/

		try {
			if ("reviewing".equals(status))
				table = "tblReviewHist";

			int parms = 0;
			String sql = "";
			String historyID = CourseDB.getHistoryID(conn,campus,alpha,num,"PRE");

			if (historyID==null || historyID.length()==0){
				sql = "SELECT Count(id) AS CountOfid " +
					"FROM " + table + " " +
					"GROUP BY item " +
					"HAVING item=? ";

				parms = 1;
			}
			else{
				sql = "SELECT Count(historyid) AS CountOfhistoryid " +
					"FROM " + table + " " +
					"GROUP BY historyid, item " +
					"HAVING historyid=? AND item=? ";

				parms = 2;
			}

			PreparedStatement ps = conn.prepareStatement(sql);

			if (parms==1){
				ps.setInt(1,item);
			}
			else{
				ps.setString(1,historyID);
				ps.setInt(2,item);
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				lRecords = rs.getLong(1);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			out.println("ReviewerDB: countReviewerComments\n" + e.toString());
		}

		out.println(lRecords);
%>