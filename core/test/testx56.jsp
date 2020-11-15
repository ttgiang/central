<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";

	out.println("Start<br>");
	out.println(fixX56(conn,campus));
	out.println("End<br>");

	asePool.freeConnection(conn);
%>

<%!

	public static String fixX56(Connection conn,String campus) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String junk = "";
		String historyid = "";
		int rowsAffected = 0;
		StringBuffer buf = new StringBuffer();

		 //HomeworkAssignment 125,40
		 //ResearchProject 126,43
		 //ComputerProject 127,38
		 //TermPapers 128,44
		 //RehearsalTime 129,42
		 //PracticeLabTime 131,41

		try {
			AseUtil ae = new AseUtil();

			sql = "SELECT historyid,x56 FROM tblCourse WHERE campus=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,campus);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				temp = ae.nullToBlank(rs.getString("x56"));
				historyid = ae.nullToBlank(rs.getString("historyid"));
				if (!"".equals(temp)){
					junk = temp.replace("125","40");
					junk = junk.replace("126","43");
					junk = junk.replace("127","38");
					junk = junk.replace("128","44");
					junk = junk.replace("129","42");
					junk = junk.replace("131","41");

					sql = "UPDATE tblCourse "
						+ "SET x56=? "
						+ "WHERE historyid=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1,junk);
					ps.setString(2,historyid);
					rowsAffected = ps.executeUpdate();
					ps.close();

					buf.append(temp + " ---- " + junk + " ---- " + rowsAffected + "<br/>");
				}
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			buf.append(e.toString() + "<br/>");
		}

		return buf.toString();
	}

%>

