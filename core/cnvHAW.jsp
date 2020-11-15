<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Data Conversion";
	fieldsetTitle = "Data Conversion";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="testx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "HAW";
	System.out.println("Start<br/>");

	if (processPage){

		// 1) Restore TEST server database to CCV2
		// 2) Delete and re-add ccusr to CCV2
		// 3) Bring the database structure up to date with zz-alter.sql

		// 4) The next call deletes this campus from current tables
		//out.println("clearDatabaseOfOtherCampuses processed " + clearDatabaseOfOtherCampuses(conn,campus) + " tables" + Html.BR());

		//out.println(countData(conn,campus));

		// 7) need to sync approvers with routing id

		// WE MUST DO BELOW UPDATES

		out.println("syncData processed " + syncData01(conn,campus) + " tables" + Html.BR());
		out.println("syncData processed " + syncData02(conn,campus) + " tables" + Html.BR());

	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"","");
%>

<%!

	/*
	 * clearDatabaseOfOtherCampuses - starting with the TEST database,
	 *												remove all campuses other than the one to convert
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int clearDatabaseOfOtherCampuses(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int tables = 0;

		try{

			System.out.println("clearDatabaseOfOtherCampuses" + Html.BR());
			System.out.println("----------------------------" + Html.BR());

			// select all tables where there is a campus column
			// use that data to delete all data from table where the campus is not the one what
			// coming in to this function
			String sql = "SELECT TABLE_NAME "
							+ "FROM INFORMATION_SCHEMA.COLUMNS "
							+ "WHERE COLUMN_NAME = 'campus' "
							+ "AND TABLE_NAME like 'tbl%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String tableName = rs.getString("TABLE_NAME");
				sql = "DELETE FROM " + tableName + " WHERE campus<>?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				int rowsAffected = ps2.executeUpdate();
				++tables;
				System.out.println("" + tables + ": " + rowsAffected + " rows deleted from " + tableName);
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("cnv - clearDatabaseOfOtherCampuses: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - clearDatabaseOfOtherCampuses: " + e.toString());
		}

		return tables;

	}

	/*
	 * copyData - count rows in tables where campus is this one
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static String countData(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int tables = 0;

		StringBuffer buf = new StringBuffer();

		try{

			System.out.println("countData" + Html.BR());
			System.out.println("--------" + Html.BR());

			// select all tables where there is a campus column
			String sql = "SELECT TABLE_NAME "
							+ "FROM INFORMATION_SCHEMA.COLUMNS "
							+ "WHERE COLUMN_NAME = 'campus' "
							+ "AND TABLE_NAME like 'tbl%' ORDER BY TABLE_NAME";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String tableName = rs.getString("TABLE_NAME");
				sql = "SELECT COUNT(campus) AS counter FROM " + tableName + " WHERE campus=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				ResultSet rs2 = ps2.executeQuery();
				if (rs2.next()){
					int counter = rs2.getInt("counter");
					if(counter > 0){
						buf.append(sql.replace("?","'HAW'") + Html.BR());
					}
				}
				rs2.close();
				ps2.close();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("cnv - countData: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - countData: " + e.toString());
		}

		return buf.toString();

	}

	/*
	 * syncData01 - sync or relink data after copy (approver table)
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int syncData01(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{

			System.out.println("syncData" + Html.BR());
			System.out.println("--------" + Html.BR());

			String sql = "SELECT mti.id, ti.id AS Route "
				+ "FROM tblINIHAW mti INNER JOIN "
				+ "tblINI ti ON mti.category = ti.category AND mti.campus = ti.campus AND mti.kid = ti.kid AND mti.kdesc = ti.kdesc "
				+ "WHERE (mti.category = 'ApprovalRouting') AND (mti.campus = 'HAW') "
				+ "ORDER BY mti.kid ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				int id = rs.getInt("id");
				int route = rs.getInt("route");
				sql = "UPDATE tblapprover SET route=? WHERE campus=? AND route=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,route);
				ps2.setString(2,campus);
				ps2.setInt(3,id);
				rowsAffected = ps2.executeUpdate();
				System.out.println(rowsAffected + " updated for route " + route);
				ps2.close();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("cnv - syncData01: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - syncData01: " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * syncData02 - sync or relink data after copy (chairs)
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int syncData02(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		try{

			System.out.println("syncData" + Html.BR());
			System.out.println("--------" + Html.BR());

			String sql = "SELECT mtd.divid AS oldID, td.divid AS newID "
				+ "FROM tblDivisionHAW mtd INNER JOIN "
				+ "tblDivision td ON mtd.campus = td.campus AND mtd.divisioncode = td.divisioncode AND "
				+ "mtd.divisionname = td.divisionname AND mtd.chairname = td.chairname "
				+ "WHERE mtd.campus = 'HAW' ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				int oldid = rs.getInt("oldid");
				int newid = rs.getInt("newid");
				sql = "UPDATE tblchairs SET programid=? WHERE programid=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setInt(1,newid);
				ps2.setInt(2,oldid);
				rowsAffected = ps2.executeUpdate();
				System.out.println(rowsAffected + " updated for chairs " + newid);
				ps2.close();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("cnv - syncData02: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - syncData02: " + e.toString());
		}

		return rowsAffected;

	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>