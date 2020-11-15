<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fix46.jsp
	*	2007.09.01	course edit
	*
	* 	Logger logger = Logger.getLogger("test");
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		processPage = false;
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

	System.out.println("Start<br/>");

	if (processPage){
		out.println(fix46());
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn,"fix46",user);
%>

<%!
	public static String fix46() throws Exception {

		Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		String sql = "";
		String alpha = "";
		String campus = "";
		String num = "";
		String kix = "";
		String x46 = "";
		int rowsAffected = 0;
		int updated = 0;

      Connection conn = null;

		try {
			conn = AsePool.createLongConnection();

			AseUtil au = new AseUtil();
			System.out.println("--------------------------------fix46 START");

			sql = "SELECT campus,coursealpha,coursenum,x46,historyid "
				+ "FROM tblCourse "
				+ "WHERE NOT x46 IS NULL "
				+ "ORDER BY campus,coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				campus = au.nullToBlank(rs.getString("campus"));
				alpha = au.nullToBlank(rs.getString("coursealpha"));
				num = au.nullToBlank(rs.getString("coursenum"));
				x46 = au.nullToBlank(rs.getString("x46"));
				kix = au.nullToBlank(rs.getString("historyid"));

				if (kix != null && kix.length() > 0){
					sql = "UPDATE tblCourse SET x76=?,x46=null WHERE historyid=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setString(1,x46);
					ps1.setString(2,kix);
					rowsAffected = ps1.executeUpdate();
					ps1.close();

					if (rowsAffected == 1)
						System.out.println("Kix updated for (" + campus + " - " + alpha + " - " + num + "): " + rowsAffected + " row");

					++updated;
				}
				else{
					System.out.println("*** Kix not found: " + kix);
				}
			}
			rs.close();
			ps.close();

			System.out.println("updated " + updated + " rows");

			System.out.println("--------------------------------fix46 END");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "updated " + updated + " rows";
	}

%>
