<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = "LEE";
	String alpha = "ICS";
	String alphax = "ICS";
	String num = "100";
	String user = "THANHG";
	String proposer = user;
	String type = "PRE";
	int rowsAffected = 0;
	String reqType = "1";

	out.println(fix27());
	out.println(fix29());

	out.println(createModifyProgramTask());

	//int start = 3700;

	//out.println(updateHistoryID("tblArchivedProgram",start));
	//out.println(updateHistoryID("tblCurrentProgram",start));
	//out.println(updateHistoryID("tblProposedProgram",start));

	asePool.freeConnection(conn,"fix27",user);
%>

<%!
	public static String fix27() throws Exception {

		Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		String sql = "";
		String alpha = "";
		String num = "";
		String kix = "";
		String x27 = "";
		String hoursperweek = "";
		String type = "";
		int rowsAffected = 0;
		int updated = 0;

      Connection conn = null;

		try {
			conn = AsePool.createLongConnection();

			AseUtil au = new AseUtil();
			System.out.println("--------------------------------fix27 START");

			sql = "SELECT coursealpha,coursenum,x27,historyid "
				+ "FROM tblCourse "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = au.nullToBlank(rs.getString("coursealpha"));
				num = au.nullToBlank(rs.getString("coursenum"));
				x27 = au.nullToBlank(rs.getString("x27"));
				kix = au.nullToBlank(rs.getString("historyid"));

				if (kix != null && kix.length() > 0){
					sql = "UPDATE tblCampusdata SET c32=? WHERE historyid=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setString(1,x27);
					ps1.setString(2,kix);
					rowsAffected = ps1.executeUpdate();
					ps1.close();

					if (rowsAffected != 1)
						System.out.println("Kix updated for (" + alpha + " - " + num + "): " + rowsAffected + " row");

					++updated;
				}
				else{
					System.out.println("*** Kix not found: " + kix);
				}
			}
			rs.close();
			ps.close();

			System.out.println("updated " + updated + " rows");

			System.out.println("--------------------------------fix27 END");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}

	public static String fix29() throws Exception {

		Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		String sql = "";
		String alpha = "";
		String num = "";
		String kix = "";
		String x29 = "";
		String hoursperweek = "";
		String type = "";
		int rowsAffected = 0;
		int updated = 0;

      Connection conn = null;

		try {
			conn = AsePool.createLongConnection();

			AseUtil au = new AseUtil();
			System.out.println("--------------------------------fix29 START");

			sql = "SELECT coursealpha,coursenum,x29,historyid "
				+ "FROM tblCourse "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = au.nullToBlank(rs.getString("coursealpha"));
				num = au.nullToBlank(rs.getString("coursenum"));
				x29 = au.nullToBlank(rs.getString("x29"));
				kix = au.nullToBlank(rs.getString("historyid"));

				if (kix != null && kix.length() > 0){
					sql = "UPDATE tblCampusdata SET c33=? WHERE historyid=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setString(1,x29);
					ps1.setString(2,kix);
					rowsAffected = ps1.executeUpdate();
					ps1.close();

					if (rowsAffected != 1)
						System.out.println("Kix updated for (" + alpha + " - " + num + "): " + rowsAffected + " row");

					++updated;
				}
				else{
					System.out.println("*** Kix not found: " + kix);
				}
			}
			rs.close();
			ps.close();

			System.out.println("updated " + updated + " rows");

			System.out.println("--------------------------------fix29 END");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}

	public static String updateHistoryID(String table,int start) throws Exception {

		Logger logger = Logger.getLogger("test");

		int historyid = 0;
		int rowsAffected = 0;

		String sql = "";

      Connection conn = null;

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;

		ResultSet rs = null;

		try {
			conn = AsePool.createLongConnection();

			AseUtil au = new AseUtil();
			System.out.println("--------------------------------- START");

			if (!"tblProposedProgram".equals(table)){
				System.out.println("starting id: " + start);

				sql = "SELECT historyid FROM " + table + " ORDER BY historyid";
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while (rs.next()) {
					historyid = rs.getInt("historyid");

					++start;
					sql = "UPDATE  " + table + "  SET historyid=? WHERE historyid=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setInt(1,start);
					ps1.setInt(2,historyid);
					rowsAffected = ps1.executeUpdate();
					ps1.close();

					sql = "UPDATE tblApprovalHistX SET id=? WHERE id=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setInt(1,start);
					ps1.setInt(2,historyid);
					rowsAffected = ps1.executeUpdate();
					ps1.close();

				}
				rs.close();
				ps.close();

				System.out.println("end id: " + start);
			}

			System.out.println("starting id: " + start);

			sql = "SELECT id FROM  " + table + "  ORDER BY id";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				historyid = rs.getInt("id");

				++start;
				sql = "UPDATE  " + table + "  SET id=? WHERE id=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setInt(1,start);
				ps1.setInt(2,historyid);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				sql = "UPDATE tblApprovalHistX SET id=? WHERE id=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setInt(1,start);
				ps1.setInt(2,historyid);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

			}
			rs.close();
			ps.close();

			System.out.println("ending id: " + start);

			System.out.println("--------------------------------- END");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}

	public static String createModifyProgramTask() throws Exception {

		Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "";
		String historyid = "";
		String program = "";
		String divisionname = "";
		String title = "";
		String proposer = "";
		int rowsAffected = 0;

		String campus = "LEE";

      Connection conn = null;

      String message = "";
      int degree = 0;
      int division = 0;

		try {
			conn = AsePool.createLongConnection();

			AseUtil au = new AseUtil();
			System.out.println("---------------------------------createModifyProgramTask START");

			sql = "SELECT historyid, Program, divisionname, title, proposer, degreeid, divisionid "
				+ "FROM vw_ProgramForViewing "
				+ "WHERE campus='LEE' "
				+ "AND progress='MODIFY' ";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				historyid = au.nullToBlank(rs.getString("historyid"));
				program = au.nullToBlank(rs.getString("program"));
				divisionname = au.nullToBlank(rs.getString("divisionname"));
				title = au.nullToBlank(rs.getString("title"));
				proposer = au.nullToBlank(rs.getString("proposer"));
				degree = rs.getInt("degreeid");
				division = rs.getInt("divisionid");

				if (!"".equals(proposer)){
					System.out.println("Task: " + program + " - " + divisionname + " - " + title + " - " + proposer);

					boolean isNewProgram = ProgramsDB.isNewProgram(conn,campus,title,degree,division);
					if (isNewProgram)
						message = Constant.PROGRAM_CREATE_TEXT;
					else
						message = Constant.PROGRAM_MODIFY_TEXT;

					rowsAffected += TaskDB.logTask(conn,
															proposer,
															proposer,
															title,
															"",
															message,
															"LEE",
															"",
															"ADD",
															"PRE",
															Constant.TASK_PROPOSER,
															Constant.TASK_PROPOSER,
															historyid,
															Constant.PROGRAM);
				}

			}
			rs.close();
			ps.close();

			System.out.println("---------------------------------createModifyProgramTask END");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}
%>
