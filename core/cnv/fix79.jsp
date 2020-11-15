<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fix79.jsp
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

	out.println(fix79());
	asePool.freeConnection(conn,"fix79",user);
%>

<%!
	public static String fix79() throws Exception {

		Logger logger = Logger.getLogger("test");

		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		ResultSet rs = null;

		String sql = "";
		String alpha = "";
		String num = "";
		String kix = "";
		String x79 = "";
		String hoursperweek = "";
		String type = "";
		int rowsAffected = 0;
		int updated = 0;

      Connection conn = null;

		try {
			conn = AsePool.createLongConnection();

			AseUtil au = new AseUtil();
			System.out.println("--------------------------------fix79 START");

			sql = "SELECT coursealpha,coursenum,x79,historyid "
				+ "FROM tblCourse "
				+ "ORDER BY coursealpha,coursenum";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				alpha = au.nullToBlank(rs.getString("coursealpha"));
				num = au.nullToBlank(rs.getString("coursenum"));
				x79 = au.nullToBlank(rs.getString("x79"));
				kix = au.nullToBlank(rs.getString("historyid"));

				if (kix != null && kix.length() > 0){
					sql = "UPDATE tblCourse SET coursetitle=? WHERE historyid=?";
					ps1 = conn.prepareStatement(sql);
					ps1.setString(1,x79);
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

			System.out.println("--------------------------------fix79 END");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}

%>
