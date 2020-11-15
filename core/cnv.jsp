<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.net.URL"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.ase.aseutil.AseUtil"%>

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

	String campus = "MAN";
	System.out.println("Start<br/>");

	if (processPage){

		// 1) Restore TEST server database to CCV2
		// 2) Delete and re-add ccusr to CCV2
		// 3) Bring the database structure up to date with zz-alter.sql

		// 4) The next call
		//out.println("clearDatabaseOfOtherCampuses processed " + clearDatabaseOfOtherCampuses(conn,"MAN") + " tables" + Html.BR());

		// 5) The next call
		//out.println("clearTables processed " + clearTables(conn,"MAN") + " tables" + Html.BR());

		// 6) The next call
		//out.println("copyData processed " + countData(conn,"MAN") + " tables" + Html.BR());

		// 7) need to sync approvers with routing id
		//out.println("syncData processed " + syncData01(conn,"MAN") + " tables" + Html.BR());

		//out.println("syncData processed " + syncData02(conn,"MAN") + " tables" + Html.BR());
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

		boolean debug = false;

		int rowsAffected = 0;

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

				if(debug){
					System.out.println(sql);
				}
				else{
					rowsAffected = ps2.executeUpdate();
					++tables;
					System.out.println("" + tables + ": " + rowsAffected + " rows deleted from " + tableName);
				}

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
	 * clearTables - we know these tables are not going to be copied
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int clearTables(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int i = 0;

		try{

			/*

			DROP table tblApproval
			DROP table tblApprovalHist
			DROP table tblApprovalHist2
			DROP table tblHelpidx
			DROP table tblInfo
			DROP table tbljobs
			DROP table tblAssessedData
			DROP table tblAssessedDataARC
			DROP table tblAssessedQuestions
			DROP table tblTasks
			DROP table tblAttach
			DROP table tblCampusData
			DROP table tblSystem
			DROP table tblCampusDataCC2
			DROP table tblCampusDataMAU
			DROP table tblccowiq
			DROP table tblCoReq
			DROP table tblUserLog2
			DROP table tblCourseACCJC
			DROP table tblCourseARC
			DROP table tblCourseAssess
			DROP table tblCourseCAN
			DROP table tblCourseCC2
			DROP table tblCourseComp
			DROP table tblCourseCompAss
			DROP table tblCourseCompetency
			DROP table tblCourseContent
			DROP table tblCourseContentSLO
			DROP table tblCourseLinked
			DROP table tblCourseMAU
			DROP table tblCourseReport
			DROP table tblDiscipline
			DROP table tblCampusDataMAN
			DROP table tblDocs
			DROP table tblExtra
			DROP table tblFDCategory
			DROP table tblFDProgram
			DROP table tblCourseMAN
			DROP table tblCampusDataWIN
			DROP table tblGenericContent
			DROP table tblCourseWIN
			DROP table tblGESLO
			DROP table tblcampus
			DROP table tblCourseWIN_ARC
			DROP table tblForms
			DROP table tblCampusDataHON
			DROP table tblCourseHON
			DROP table tblJSID
			DROP table tblArchivedProgram
			DROP table tblLinkedKeys
			DROP table tblCurrentProgram
			DROP table tblLists
			DROP table tblProposedProgram
			DROP table tblauthority
			DROP table tblMail
			DROP table tblMisc
			DROP table tblMode
			DROP table tblCourseUHMC
			DROP table tblPageHelp
			DROP table tblCampusDataUHMC
			DROP table tblCourse
			DROP table tblPosition
			DROP table tblPreReq
			DROP table tblprogramdegree
			DROP table tblPrograms
			DROP table tblProps
			DROP table tblRequest
			DROP table tblReviewers
			DROP table tblReviewHist
			DROP table tblReviewHist2
			DROP table tblRpt
			DROP table tblSLO
			DROP table tblHtml
			DROP table tblSLOARC
			DROP table tblsyllabus
			DROP table tblTempAttach
			DROP table tblTempCampusData
			DROP table tblTempCoReq
			DROP table tblTempCourse
			DROP table tblTempCourseACCJC
			DROP table tblTempCourseAssess
			DROP table tblTempCourseComp
			DROP table tblTempCourseCompAss
			DROP table tblTempCourseCompetency
			DROP table tblTempCourseContent
			DROP table tblTempCourseContentSLO
			DROP table tblTempCourseLinked
			DROP table tblTempExtra
			DROP table tblTempGenericContent
			DROP table tblTempGESLO
			DROP table tblSearch
			DROP table tblTempPreReq
			DROP table tbltempPrograms
			DROP table tblTempXRef
			DROP table tblTest
			DROP table tblUploads
			DROP table tblUserLog
			DROP table tblUsersX
			DROP table tblValues
			DROP table tblValuesdata
			DROP table tblXRef
			DROP table tblCourseQuestionsMAUOLD
			DROP TABLE tblArea;
			DROP TABLE tbldebug;
			DROP TABLE tblidx;
			DROP TABLE tbljobname;
			DROP TABLE tbllevel;
			DROP TABLE tblmode2;
			DROP TABLE tblPDF;
			DROP TABLE tblReportingStatus;
			DROP TABLE tblSalutation;
			DROP TABLE tblTabs;
			DROP TABLE tblTaskMsg;
			DROP TABLE tblTempCourseLinked2;
			DROP TABLE tblText;
			DROP TABLE tblcampusoutlines;

			*/

			System.out.println("clearTables" + Html.BR());
			System.out.println("--------" + Html.BR());

			// tables not deleted must be reviewed as they are pointed or linked to another table

			String tableNames = "tblApprovalHist,"
									+ "tblApprovalHist2,"
									+ "tblAssessedQuestions,"
									+ "tblcampusdata,"
									+ "tblCourse,"
									+ "tblTasks,"
									+ "tblAttach,"
									+ "tblCoReq,"
									+ "tblUserLog2,"
									+ "tblCourseARC,"
									+ "tblCourseCAN,"
									+ "tblDiscipline,"
									+ "tblCampusDataMAN,"
									+ "tblCourseMAN,"
									+ "tblcampus,"
									+ "tblJSID,"
									+ "tblMail,"
									+ "tblMisc,"
									+ "tblPreReq,"
									+ "tblReviewHist,"
									+ "tblReviewHist2,"
									+ "tblUserLog,"
									+ "tblHtml,"
									+ "tblXRef"
									+ "tblArea"
									+ "tbldebug"
									+ "tblidx"
									+ "tbljobname"
									+ "tbllevel"
									+ "tblmode2"
									+ "tblPDF"
									+ "tblReportingStatus"
									+ "tblSalutation"
									+ "tblTabs"
									+ "tblTaskMsg"
									+ "tblTempCourseLinked2"
									+ "tblText"
									;

			String[] tables = tableNames.split(",");
			for(i = 0; i < tables.length; i++){
				String sql = "DELETE FROM " + tables[i];
				PreparedStatement ps = conn.prepareStatement(sql);
				int rowsAffected = ps.executeUpdate();
				ps.close();
				System.out.println("" + i + ": cleared " + tables[i] + " of " + rowsAffected + " rows");
			} // for
		}
		catch(SQLException e){
			logger.fatal("cnv - clearTables: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - clearTables: " + e.toString());
		}

		return i;

	}

	/*
	 * copyData - with the remaining tables, process copy
	 *	<p>
	 * @param	conn		Connection
	 * @param	campus	String
	 */
	public static int countData(Connection conn,String campus){

Logger logger = Logger.getLogger("test");

		int tables = 0;

		try{

			System.out.println("countData" + Html.BR());
			System.out.println("--------" + Html.BR());

			// select all tables where there is a campus column
			String sql = "SELECT TABLE_NAME "
							+ "FROM INFORMATION_SCHEMA.COLUMNS "
							+ "WHERE COLUMN_NAME = 'campus' "
							+ "AND TABLE_NAME like 'tbl%'";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				String tableName = rs.getString("TABLE_NAME");
				sql = "SELECT COUNT(campus) AS counter FROM " + tableName + " WHERE campus=?";
				PreparedStatement ps2 = conn.prepareStatement(sql);
				ps2.setString(1,campus);
				ResultSet rs2 = ps2.executeQuery();
				if (rs2.next()){
					++tables;
					int counter = rs2.getInt("counter");
					if (counter > 0){
						System.out.println("" + tables + ": table " + tableName + " has " + counter + " rows");
					}
					else{
						System.out.println("DROP table " + tableName);
					}
				}
				rs2.close();
				ps2.close();
			}
			rs.close();
			ps.close();
		}
		catch(SQLException e){
			logger.fatal("cnv - copyData: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - copyData: " + e.toString());
		}

		return tables;

	}

	/*
	 * syncData - sync or relink data after copy
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
				+ "FROM MAN_tblINI mti INNER JOIN "
				+ "tblINI ti ON mti.category = ti.category AND mti.campus = ti.campus AND mti.kid = ti.kid AND mti.kdesc = ti.kdesc "
				+ "WHERE (mti.category = 'ApprovalRouting') AND (mti.campus = 'MAN') "
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
			logger.fatal("cnv - syncData: " + e.toString());
		}
		catch(Exception e){
			logger.fatal("cnv - syncData: " + e.toString());
		}

		return rowsAffected;

	}

	/*
	 * syncData02 - sync or relink data after copy
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
				+ "FROM MAN_tblDivision mtd INNER JOIN "
				+ "tblDivision td ON mtd.campus = td.campus AND mtd.divisioncode = td.divisioncode AND "
				+ "mtd.divisionname = td.divisionname AND mtd.chairname = td.chairname "
				+ "WHERE mtd.campus = 'MAN' ";
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