<%@ page import="org.apache.log4j.Logger"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedtx.jsp
	*	2007.09.01	course edit
	**/

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAU";
	String alpha = "ICS";
	String num = "241";
	String user = "THANHG";

	out.println(getLinkedOutlineContent(conn,"m55g17d9203"));
	asePool.freeConnection(conn);
%>

<%!

	/*
	 * getLinkedOutlineContent
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	 public static String getLinkedOutlineContent(Connection connection,String kix)throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;

		String temp = "";
		StringBuffer contents = new StringBuffer();
		String content = "";
		int seq = 0;

		try {
			sql = "SELECT contentid,longcontent FROM tblCourseContent WHERE historyid=?";
			ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("contentid");
				content = rs.getString("longcontent");
				contents.append("<li class=\"dataColumn\">"
					+ "<b>" + content + "<br/><br/></b>"
					+ getLinkedOutlineSLO(connection,kix,seq)
					+ "</li>");
				found = true;
			} // while
			rs.close();
			ps.close();

			if (found){
				temp = "<ul>" + contents.toString() + "</ul>";
			}

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineContent\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getLinkedOutlineCompentency
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String getLinkedOutlineCompentency(Connection conn,String kix) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String dst = "";
		String temp = "";
		String linked2Content = "";
		String linked2MethodEval = "";
		String linked2Assessment = "";
		String competency = "";

		int keyAssess = 0;
		int keyContent = 0;
		int keyMethodEval = 0;

		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		int seq = 0;
		int keyid = 0;

		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT seq,assess,content,methodeval,competency FROM vw_LinkedCompetency2 WHERE historyid=? ORDER BY seq";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("seq");
				keyAssess = rs.getInt("assess");
				keyContent = rs.getInt("content");
				keyMethodEval = rs.getInt("methodeval");
				competency = rs.getString("competency");

				//linked2Content = getLinked2Competency(conn,kix,"Content",seq,keyContent);
				//if (!"".equals(linked2Content))
				//	linked2Content = "<li>Content" + linked2Content + "</li>";

				linked2MethodEval = getLinked2Competency(conn,kix,"MethodEval",seq,keyMethodEval);
				if (!"".equals(linked2MethodEval))
					linked2MethodEval = "<li>Method Evaluation" + linked2MethodEval + "</li>";

				linked2Assessment = getLinked2Competency(conn,kix,"Assess",seq,keyAssess);
				if (!"".equals(linked2Assessment))
					linked2Assessment = "<li>Assessment" + linked2Assessment + "</li>";

				contents.append("<li class=\"dataColumn\">"
					+ competency
					+ "<ul>"
					+ linked2Content
					+ linked2MethodEval
					+ linked2Assessment
					+ "</ul>"
					+ "</li>");

				found = true;
			} // while
			rs.close();
			ps.close();

			if (found){
				temp = "<ul>" + contents.toString() + "</ul>";
			}

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineCompentency\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getLinkedOutlineSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	public static String getLinkedOutlineSLO(Connection conn,String kix,int contentid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String slo = "";

		boolean found = false;
		int seq = 0;

		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT tc.Comp,tc.CompID "
				+ "FROM tblCourseContentSLO ts INNER JOIN "
				+ "tblCourseComp tc ON ts.historyid=tc.historyid AND ts.sloid = tc.CompID "
				+ "WHERE ts.historyid=? "
				+ "AND ts.contentid=? "
				+ "ORDER BY tc.Comp";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,contentid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("compid");
				slo = rs.getString("comp");

				contents.append("<li class=\"dataColumn\">"
					+ "<i>" + slo + "</i>"
					+ getLinkedSLO2Assessment(conn,kix,seq)
					+ "</li>");

				found = true;
			} // while
			rs.close();
			ps.close();

			if (found){
				temp = "<ul>" + contents.toString() + "</ul>";
			}

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineSLO\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getLinkedSLO2Assessment
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	dst		String
	 * @param	se			int
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO2Assessment(Connection conn,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String data = "";

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		sql = "SELECT assessment "
			+ "FROM vw_slo2assessment "
			+ "WHERE historyid=? AND "
			+ "compid=?";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				data = rs.getString("assessment");
				contents.append("<li class=\"dataColumn\">" + data + "</li>");
				found = true;
			} // while
			rs.close();
			ps.close();

			if (found){
				temp = "<ul>" + contents.toString() + "</ul>";
			}

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO2Assessment\n" + e.toString());
		}

		return temp;
	}

	/*
	 * getLinked2Competency
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	dst		String
	 * @param	se			int
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2Competency(Connection conn,String kix,String dst,int seq,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String data = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		if ("Assess".equals(dst))
			table = "vw_LinkedCompetency2Assessment";
		else if ("Content".equals(dst))
			table = "vw_LinkedCompetency2Content";
		else if ("MethodEval".equals(dst))
			table = "vw_LinkedCompetency2MethodEval";

		try {
			sql = "SELECT content "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "keyid=? AND "
				+ "seq=? "
				+ "ORDER BY content";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			ps.setInt(3,seq);
			rs = ps.executeQuery();
			while (rs.next()) {
				data = rs.getString("content");
				contents.append("<li class=\"dataColumn\">" + data + indent + "</li>");
				found = true;
			} // while
			rs.close();
			ps.close();

			if (found){
				temp = "<ul>" + contents.toString() + "</ul>";
			}

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2Competency\n" + e.toString());
		}

		return temp;
	}

%>
