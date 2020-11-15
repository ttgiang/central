<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*,java.io.*,java.io.File"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
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
		//response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "LEE";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "100";
	String task = "Modify_outline";
	String kix = "u24a2g9188 ";
	int t = 0;

	out.println("Start<br/>");

	try{
		out.println(getContent(conn,kix));
	}
	catch(Exception e){
		out.println(e.toString());
	}

	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!

	/*
	 * STARTS HERE
	 *
	 * getLinkedOutlineContent
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * <p>
	 * @return String
	 */
	 public static String getContent(Connection conn,String kix)throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";

		ResultSet rs = null;
		PreparedStatement ps = null;

		StringBuffer contents = new StringBuffer();
		String content = "";
		boolean found = false;
		int seq = 0;

		try {
			sql = "SELECT contentid,longcontent "
				+ "FROM tblCourseContent "
				+ "WHERE historyid=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("contentid");
				content = rs.getString("longcontent");
				contents.append(
						"<ul>"
					+ 	"<li class=\"dataColumn\">"
					+ 	"<strong>" + content + "</strong>");

				String linkedSLO = getLinkedSLO(conn,kix,seq);
				if (linkedSLO != null && linkedSLO.length() > 0)
					contents.append("<ul>" + linkedSLO + "</ul>");

				String linkedCompetency = getLinkedCompentency(conn,kix,seq);
				if (linkedCompetency != null && linkedCompetency.length() > 0)
					contents.append("<ul>" + linkedCompetency + "</ul>");

				contents.append("</li>");
				contents.append("</ul>");

				found = true;
			}
			rs.close();
			ps.close();


		} catch (Exception e) {
			logger.fatal("LinkerDB: getContent - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedSLO
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	contentid	int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO(Connection conn,String kix,int contentid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String slo = "";
		String linkedSLO2Evaluation = "";
		String linkedSLO2GESLO = "";
		String linkedSLO2PSLO = "";

		boolean found = false;
		int seq = 0;

		StringBuffer contents = new StringBuffer();
		try {
			sql = "SELECT tc.Comp,tc.CompID "
				+ "FROM tblCourseContentSLO ts INNER JOIN "
				+ "tblCourseComp tc ON ts.historyid=tc.historyid AND ts.sloid = tc.CompID "
				+ "WHERE ts.historyid=? "
				+ "AND ts.contentid=? "
				+ "ORDER BY rdr";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,contentid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				seq = rs.getInt("compid");
				slo = rs.getString("comp");

				if (seq>0){
					contents.append(
						"<li class=\"dataColumn\">"
						+ "<i>" + slo + "</i>");

					contents.append("<ul>");

					linkedSLO2Evaluation = getLinkedSLO2Evaluation(conn,kix,seq);
					if (!"".equals(linkedSLO2Evaluation)){
							contents.append("	<li class=\"dataColumn\">Method of Evaluation"
								+ "		<ul>" + linkedSLO2Evaluation + "</ul>"
								+ "	</li>");
					}

					linkedSLO2GESLO = getLinkedSLO2GESLO(conn,kix,seq);
					if (!"".equals(linkedSLO2GESLO)){
							contents.append( "	<li class=\"dataColumn\">GenED SLO"
							+ "		<ul>" + linkedSLO2GESLO + "</ul>"
							+ "	</li>");
					}

					linkedSLO2PSLO = getLinkedSLO2PSLO(conn,kix,seq);
					if (!"".equals(linkedSLO2PSLO)){
							contents.append( "	<li class=\"dataColumn\">Program SLO"
							+ "		<ul>" + linkedSLO2PSLO + "</ul>"
							+ "	</li>");
						}

					contents.append("</ul>");
					contents.append("</li>");

					found = true;
				}
			} // while
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedCompentency
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	contentID	int
	 * <p>
	 * @return String
	 */
	public static String getLinkedCompentency(Connection conn,String kix,int contentID) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String dst = "";
		String temp = "";
		String linked2GESLO = "";
		String linked2MethodEval = "";
		String linked2PSLO = "";
		String competency = "";

		int keyGESLO = 0;
		int keyMethodEval = 0;

		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		int keyid = 0;
		int competencySeq = 0;
		int linkedId = 0;

		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT competencyseq, content, linkedid "
				+ "FROM vw_LinkingContent2Competency "
				+ "WHERE historyid=? "
				+ "AND contentid=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,contentID);
			rs = ps.executeQuery();
			while (rs.next()) {
				competencySeq = rs.getInt("competencyseq");
				linkedId = rs.getInt("linkedId");
				competency = rs.getString("content");

				contents.append(
					"<li class=\"dataColumn\">"
					+ "<i>" + competency + "</i>");

				contents.append("<ul>");

				linked2MethodEval = getLinked2Competency(conn,kix,"MethodEval",competencySeq);
				if (!"".equals(linked2MethodEval)){
					contents.append( "	<li class=\"dataColumn\">Method of Evaluation"
					+ "		<ul>" + linked2MethodEval + "</ul>"
					+ "	</li>");
				}

				linked2GESLO = getLinked2Competency(conn,kix,"GESLO",competencySeq);
				if (!"".equals(linked2GESLO)){
					contents.append( "	<li class=\"dataColumn\">GenED SLO"
					+ "		<ul>" + linked2GESLO + "</ul>"
					+ "	</li>");
				}

				linked2PSLO = getLinkedCompetency2PSLO(conn,Constant.COURSE_COMPETENCIES,kix,competencySeq);
				if (!"".equals(linked2PSLO)){
						contents.append( "	<li class=\"dataColumn\">Program SLO"
						+ "		<ul>" + linked2PSLO + "</ul>"
						+ "	</li>");
				}

				contents.append("</ul>");
				contents.append("</li>");

				found = true;
			}	// rs
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedCompentency - " + e.toString());
		}

		if (found){
			temp = contents.toString();
		}

		return temp;
	}

	/*
	 * getLinkedSLO2Evaluation
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO2Evaluation(Connection conn,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		sql = "SELECT kid,kdesc "
			+ "FROM vw_LinkingSLO2MethodEval "
			+ "WHERE historyid=? "
			+ "AND seq=? "
			+ "ORDER BY item";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("kid") + " - " + rs.getString("kdesc") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO2Evaluation - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedSLO2GESLO
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO2GESLO(Connection conn,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT kid, kdesc "
				+ "FROM vw_LinkingSLO2GESLO "
				+ "WHERE historyid=? "
				+ "AND seq=? "
				+ "ORDER BY item";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("kid") + " - " + rs.getString("kdesc") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO2GESLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedSLO2PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	src		String
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedSLO2PSLO(Connection conn,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT comments "
				+ "FROM vw_LinkingSLO2PSLO "
				+ "WHERE historyid=? "
				+ "AND seq=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("comments") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedSLO2PSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedCompetency2PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	src		String
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinkedCompetency2PSLO(Connection conn,String src,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT comments "
				+ "FROM vw_LinkingCompetency2PSLO "
				+ "WHERE historyid=? "
				+ "AND seq=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("comments") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedCompetency2PSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinked2Competency
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	dst		String
	 * @param	seq		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2Competency(Connection conn,String kix,String dst,int seq) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		if ("GESLO".equals(dst))
			table = "vw_LinkingCompetency2GESLO";
		else if ("MethodEval".equals(dst))
			table = "vw_LinkingCompetency2MethodEval";

		try {
			sql = "SELECT kid,content "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "seq=? "
				+ "ORDER BY content";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("kid") + " - " + rs.getString("content") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2Competency -" + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedCompKey
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	seq		int
	 * <p>
	 * @return String
	 */
	public static int getLinkedCompKey(Connection conn,String kix,int seq) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";

		StringBuffer contents = new StringBuffer();
		try {
			sql = "SELECT linked2item "
				+ "FROM vw_LinkedContent2Compentency "
				+ "WHERE historyid=? AND contentid=? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				seq = rs.getInt("linked2item");
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedCompKey - " + e.toString());
		}

		return seq;
	}

	/*
	* ENDS HERE
	*/

%>

		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
