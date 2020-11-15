<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%
		String alpha = "ICS";
		String num = "241";
		String campus = "LEECC";
		String user = "THANHG";
		int l1 = 21;
		int l2 = 40;
		int l3 = 2;
		String action = "a";

		int rowsAffected = 0;
		String insertSQL = "INSERT INTO tblCourseACCJC(campus,coursealpha,coursenum,coursetype,ContentID,CompID,Assessmentid,auditby) VALUES(?,?,?,?,?,?,?,?)";
		String removeSQL = "DELETE FROM tblCourseACCJC WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND ContentID=? AND CompID=? AND Assessmentid=?";

		try {
			String sql = "";
			boolean nextStep = true;

			/*
			 * for add mode, don't add if already there. for remove, just
			 * proceed
			 */
			if ("a".equals(action)) {
				sql = insertSQL;
				if (courseDB.isACCJCAdded(conn, campus, alpha, num, l1, l2, l3)) {
					msg.setMsg("DuplicateEntry");
					msg.setCode(-1);
					nextStep = false;
				}
			}
			else
				sql = removeSQL;

			if (nextStep) {
				PreparedStatement preparedStatement = conn.prepareStatement(sql);
				preparedStatement.setString(1,campus);
				preparedStatement.setString(2,alpha);
				preparedStatement.setString(3,num);
				preparedStatement.setString(4,"PRE");
				preparedStatement.setInt(5,l1);
				preparedStatement.setInt(6,l2);
				preparedStatement.setInt(7,l3);
				preparedStatement.setString(8,user);
				rowsAffected = preparedStatement.executeUpdate();
				preparedStatement.close();
				AseUtil.loggerInfo("CourseDB: courseACCJC ",campus,action,alpha + " " + num,"");
				msg.setCode(rowsAffected);
				msg.setMsg("Successful");
			}
		} catch (SQLException e) {
			out.println("CourseDB: courseACCJC\n" + e.toString());
		} catch (Exception ex) {
			out.println("CourseDB: courseACCJC\n" + ex.toString());
		}

		if (!"".equals(msg.getMsg())){
			String message = MsgDB.getMsgDetail(msg.getMsg());
			if (msg.getCode()<0)
				message = "<font color=red>" + message + "</font>";
			out.println(message);
		}

		out.println("getMsg: " + msg.getMsg() + "<br>");
		out.println("getCode: " + msg.getCode() + "<br>");

		String sql = aseUtil.getPropertySQL( session, "slo" );
		sql = aseUtil.replace(sql, "_camp_", campus);
		sql = aseUtil.replace(sql, "_alpha_", alpha);
		sql = aseUtil.replace(sql, "_num_", num);
		sql = aseUtil.replace(sql, "_type_", "PRE");

		paging = new com.ase.paging.Paging();
		paging.setRecordsPerPage(99);
		paging.setNavigation( false );
		paging.setSorting( false );
		paging.setSQL(sql);
		out.print( paging.showRecords( conn, request, response ) );
		paging = null;

%>