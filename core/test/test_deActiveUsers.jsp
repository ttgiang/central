<%@ include file="ase.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,javax.servlet.*,javax.mail.internet.*"%>

<%

		boolean cron = true;
		String thisDataType = "Access";
		PreparedStatement ps;
		int days = 10;
		String campus = "LEECC";

		try {
			int rowsAffected;

			if (thisDataType == null || thisDataType.length() == 0) {
				ResourceBundle dataBundle = ResourceBundle.getBundle("ase.central.AseQueries");
				thisDataType = dataBundle.getString("databaseDriver");
				if (thisDataType == null || thisDataType.length() == 0) {
					thisDataType = "Access";
				}
				session.setAttribute("aseDataType", thisDataType);
			}

			ResourceBundle bundle = ResourceBundle.getBundle("ase.central.AseQueries" + thisDataType);
			String sql = bundle.getString("deActiveUsers");

			/*
				retrieve number of days
			*/
			Ini ini = IniDB.getIniByCategoryKid(conn,"System","DaysToDeactivate");
			if ( ini != null )
				days = Integer.parseInt(ini.getKval1());

			ps = conn.prepareStatement(sql);
			ps.setString(1, campus);
			ps.setInt(2, days);
			rowsAffected = ps.executeUpdate();
			ps.close();

			out.println("Cron: deActiveUsers completed");
		} catch (Exception e) {
			out.println("Cron: deActiveUsers\n" + e.toString());
			cron = false;
		}
%>