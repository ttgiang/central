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

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
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

	out.println(Testing(conn));
	asePool.freeConnection(conn);
%>

<%!

	public static String Testing(Connection conn) throws Exception {

		Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		String sql = "";
		String alpha = "";
		String num = "";
		String kix = "";
		int rowsAffected = 0;
		int compid = 0;

		try {
			System.out.println("---------------------------------");

			// clear before starting
			sql = "UPDATE tblSLO SET hid='' ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting slo kix (" + rowsAffected + ")");

			// clear before starting
			sql = "UPDATE tblCourseComp SET historyid='' ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting comp kix (" + rowsAffected + ")");

			// clear before starting
			sql = "UPDATE tblCourseACCJC SET historyid='',compid=0 ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting accjc kix (" + rowsAffected + ")");

			// clear before starting
			sql = "UPDATE tblAssessedData SET accjcid=0 ";
			ps1 = conn.prepareStatement(sql);
			rowsAffected = ps1.executeUpdate();
			ps1.close();
			System.out.println("resetting assess kix (" + rowsAffected + ")");

			sql = "SELECT * "
				+ "FROM tblSLO "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				kix = Helper.getKix(conn,"LEE",alpha,num,"CUR");

				// update tblSLO with correct kix from tblCourse with kix
				sql = "UPDATE tblSLO "
					+ "SET hid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setString(1,kix);
				ps1.setString(2,alpha);
				ps1.setString(3,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				// update tblCourseComp with correct kix from tblCourse with kix
				sql = "UPDATE tblCourseComp "
					+ "SET historyid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setString(1,kix);
				ps1.setString(2,alpha);
				ps1.setString(3,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				System.out.println(alpha + " " + num + " " + kix);

				// get compid from coursecomp
				// update accjc with compid and historyid
				// get id from accjc for use with assessdata accjc id
			}
			rs.close();
			ps.close();

			sql = "SELECT historyid,compid,coursealpha,coursenum "
				+ "FROM tblCourseComp "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				kix = rs.getString("historyid");
				compid = rs.getInt("compid");

				// update accjc with compid and historyid
				sql = "UPDATE tblCourseACCJC "
					+ "SET historyid=?, compid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setString(1,kix);
				ps1.setInt(2,compid);
				ps1.setString(3,alpha);
				ps1.setString(4,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				System.out.println(alpha + " " + num + " " + kix + " " + compid);
			}
			rs.close();
			ps.close();

			// get id from accjc for use with assessdata accjc id
			sql = "SELECT id,coursealpha,coursenum "
				+ "FROM tblCourseACCJC "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				compid = rs.getInt("id");

				// update accjc with compid and historyid
				sql = "UPDATE tblAssessedData "
					+ "SET accjcid=? "
					+ "WHERE campus='LEE' AND "
					+ "coursealpha=? AND "
					+ "coursenum=?";
				ps1 = conn.prepareStatement(sql);
				ps1.setInt(1,compid);
				ps1.setString(2,alpha);
				ps1.setString(3,num);
				rowsAffected = ps1.executeUpdate();
				ps1.close();

				System.out.println(alpha + " " + num + " " + kix + " " + compid);
			}
			rs.close();
			ps.close();

			System.out.println("---------------------------------");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}
%>
