<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fixrequisite.jsp
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
	//out.println(fixRequisite(conn,"1"));
	//out.println(fixRequisite(conn,"2"));
	out.println("End<br>");

	asePool.freeConnection(conn);
%>

<%!
	public static String fixRequisite(Connection conn,String type) {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String alpha = "";
		String num = "";
		String table = "";
		String fields = "";
		String update = "";
		String historyid = "";
		int i = 1;
		int rowsAffected = 0;
		boolean debug = true;

		if ("1".equals(type)){
			table = "tblPreReq";
			fields = "PrereqAlpha AS alpha,PrereqNum AS num";
			update = "PrereqAlpha=? AND PrereqNum=?";
		}
		else{
			table = "tblCoReq";
			fields = "CoreqAlpha AS alpha,CoreqNum AS num";
			update = "CoreqAlpha=? AND CoreqNum=?";
		}

		try {

			System.out.println("START-------------------------");

			AseUtil ae = new AseUtil();

			sql = "SELECT historyid," + fields + " FROM " + table;
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				historyid = ae.nullToBlank(rs.getString("historyid"));
				alpha = ae.nullToBlank(rs.getString("alpha"));
				num = ae.nullToBlank(rs.getString("num"));

				sql = "UPDATE " + table + " SET id=? WHERE historyid=? AND " + update;
				ps = conn.prepareStatement(sql);
				ps.setInt(1,i);
				ps.setString(2,historyid);
				ps.setString(3,alpha);
				ps.setString(4,num);
				rowsAffected = ps.executeUpdate();

				System.out.println(historyid + " - " + i + " - " + rowsAffected);

				++i;
			}
			rs.close();
			ps.close();

			System.out.println("END-------------------------");

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return "";
	}

%>

