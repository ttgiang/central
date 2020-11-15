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
		String x51 = "";
		String hoursperweek = "";
		String type = "";
		int rowsAffected = 0;

		try {
			AseUtil au = new AseUtil();
			System.out.println("---------------------------------");

			sql = "SELECT coursealpha,coursenum,coursetype,x51,hoursperweek,historyid "
				+ "FROM tblCourse "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = rs.getString("coursealpha");
				num = rs.getString("coursenum");
				type = rs.getString("coursetype");
				x51 = au.nullToBlank(rs.getString("x51")).trim();
				hoursperweek = au.nullToBlank(rs.getString("hoursperweek")).trim();
				kix = au.nullToBlank(rs.getString("historyid")).trim();

				if ("".equals(x51) || x51.length()==0){
					sql = "UPDATE tblCourse "
						+ "SET x51=? "
						+ "WHERE historyid=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setString(1,hoursperweek);
					ps1.setString(2,kix);
					rowsAffected = ps1.executeUpdate();
					ps1.close();
					System.out.println(alpha + " " + num  + " " + type   + " " + kix + " - "  + rowsAffected);
				}

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
