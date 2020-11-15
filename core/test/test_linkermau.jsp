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
	String kix = "o8l28i9166";
	int t = 0;

	out.println("Start<br/>");

	try{
		//out.println(getLinkedOutlineContent(conn,kix));
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
	 public static String getLinkedOutlineContent(Connection conn,String kix)throws Exception {

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
					"<li class=\"dataColumn\">"
					+ 	"<strong>" + content + "</strong>"
					+ 		"<ul>" + getLinkedOutlineSLO(conn,kix,seq) + "</ul>"
					+ 		"<ul>" + getLinkedOutlineCompentency(conn,kix,seq) + "</ul>"
					+ "</li>");

				found = true;
			}
			rs.close();
			ps.close();


		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineContent - " + e.toString());
		}

		if (found)
			temp = "<ul>" + contents.toString() + "</ul>";

		return temp;
	}

	/*
	 * getLinkedOutlineSLO
	 * <p>
	 * @param	conn			Connection
	 * @param	kix			String
	 * @param	contentid	int
	 * <p>
	 * @return String
	 */
	public static String getLinkedOutlineSLO(Connection conn,String kix,int contentid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String slo = "";
		String campus = "";
		String linkedSLO2Evaluation = "";
		String linkedSLO2GESLO = "";
		String linkedSLO2PSLO = "";

		boolean found = false;
		int seq = 0;

		StringBuffer contents = new StringBuffer();
		try {
			sql = "SELECT tc.campus,tc.Comp,tc.CompID "
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
				campus = rs.getString("campus");
				seq = rs.getInt("compid");
				slo = rs.getString("comp");

				if (seq>0){
					contents.append(
						"<li class=\"dataColumn\">"
						+ "<i>" + slo + "</i>");

					linkedSLO2Evaluation = getLinkedSLO2Evaluation(conn,kix,seq);
					linkedSLO2GESLO = getLinkedSLO2GESLO(conn,kix,seq);
					linkedSLO2PSLO = getLinked2PSLO(conn,Constant.COURSE_OBJECTIVES,kix,seq);

					contents.append("<ul>");

					// TODO - hard coding
if (!"MAU".equals(campus)){
						if (!"".equals(linkedSLO2Evaluation))
								contents.append("	<li class=\"dataColumn\">Method of Evaluation"
									+ "		<ul>" + linkedSLO2Evaluation + "</ul>"
									+ "	</li>");
					}

					if (!"".equals(linkedSLO2GESLO))
							contents.append( "	<li class=\"dataColumn\">GenED SLO"
							+ "		<ul>" + linkedSLO2GESLO + "</ul>"
							+ "	</li>");

					if (!"".equals(linkedSLO2PSLO))
							contents.append( "	<li class=\"dataColumn\">Program SLO"
							+ "		<ul>" + linkedSLO2PSLO + "</ul>"
							+ "	</li>");

					contents.append("</ul>");
					contents.append("</li>");

					found = true;
				}
			} // while
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinkedOutlineCompentency
	 * <p>
	 * @param	conn		Connection
	 * @param	kix		String
	 * @param	seq		int
	 * <p>
	 * @return String
	 */

	public static String getLinkedOutlineCompentency(Connection conn,String kix,int seq) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String dst = "";
		String temp = "";
		String campus = "";
		String linked2GESLO = "";
		String linked2MethodEval = "";
		String linked2PSLO = "";
		String linked2SLO = "";
		String competency = "";

		int keyGESLO = 0;
		int keyMethodEval = 0;

		ResultSet rsOuter = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		int keyid = 0;

		StringBuffer contents = new StringBuffer();

		try {
			sql = "SELECT DISTINCT vw.Linked2Item,tc.content,tc.campus "
				+ "FROM vw_LinkedContent2Compentency vw INNER JOIN "
				+ "tblCourseCompetency tc ON vw.historyid = tc.historyid AND "
				+ "vw.Linked2Item = tc.seq "
				+ "WHERE vw.historyid=? AND vw.contentid=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,seq);
			rsOuter = ps.executeQuery();
			while (rsOuter.next()) {
				seq = NumericUtil.nullToZero(rsOuter.getInt("linked2item"));
				competency = AseUtil.nullToBlank(rsOuter.getString("content"));
				campus = AseUtil.nullToBlank(rsOuter.getString("campus"));

				contents.append(
					"<li class=\"dataColumn\">"
					+ "<i>" + competency + "</i>");

				found = true;

				sql = "SELECT geslo,methodeval "
					+ "FROM vw_LinkedCompetency2 "
					+ "WHERE historyid=? AND seq=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,kix);
				ps.setInt(2,seq);
				rs = ps.executeQuery();
				while (rs.next()) {
					keyGESLO = rs.getInt("geslo");
					keyMethodEval = rs.getInt("methodeval");

					contents.append("<ul>");

					// TODO - hard coding
if ("KAP".equals(campus)){
						if (keyGESLO>0){
							linked2GESLO = getLinked2Competency(conn,kix,"GESLO",seq,keyGESLO);
							if (!"".equals(linked2GESLO))
									contents.append( "	<li class=\"dataColumn\">GenED SLO"
									+ "		<ul>" + linked2GESLO + "</ul>"
									+ "	</li>");
						}
					}

					if (keyMethodEval>0){
						linked2MethodEval = getLinked2Competency(conn,kix,"MethodEval",seq,keyMethodEval);
						if (!"".equals(linked2MethodEval)){
								contents.append( "	<li class=\"dataColumn\">Method of Evaluation"
								+ "		<ul>" + linked2MethodEval + "</ul>"
								+ "	</li>");
						}
					}

					// TODO - hard coding
if ("KAP".equals(campus)){
						linked2PSLO = getLinked2PSLO(conn,Constant.COURSE_COMPETENCIES,kix,seq);
						if (!"".equals(linked2PSLO)){
								contents.append( "	<li class=\"dataColumn\">Program SLO"
								+ "		<ul>" + linked2PSLO + "</ul>"
								+ "	</li>");
						}
					}

if ("MAU".equals(campus)){
						linked2SLO = getLinked2SLO(conn,Constant.COURSE_COMPETENCIES,kix,seq);
						if (!"".equals(linked2SLO)){
								contents.append( "	<li class=\"dataColumn\">Course SLO"
								+ "		<ul>" + linked2SLO + "</ul>"
								+ "	</li>");
						}
					}

					contents.append("</ul>");

				} // while
				rs.close();
			}	// rsOuter
			rsOuter.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinkedOutlineCompentency - " + e.toString());
		}

		if (found){
			contents.append("</li>");
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

		sql = "SELECT tcc.Comp, vw.content "
			+ "FROM tblCourseComp tcc, vw_LinkedSLO2MethodEval vw "
			+ "WHERE tcc.historyid=vw.historyid "
			+ "AND tcc.compid=vw.seq "
			+ "AND vw.historyid=? "
			+ "AND vw.seq=? "
			+ "ORDER BY tcc.compid,content";

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("content") + "</li>");
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
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		table = "vw_LinkedSLO2GESLO";

		try {
			sql = "SELECT content "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "seq=? "
				+ "ORDER BY content";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("content") + "</li>");
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
	 * getLinked2PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	src		String
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2PSLO(Connection conn,String src,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		table = "vw_Linked2PSLO";

		try {
			sql = "SELECT comments "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "src=? AND "
				+ "dst=? AND "
				+ "seq=? "
				+ "ORDER BY rdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setString(2,src);
			ps.setString(3,"PSLO");
			ps.setInt(4,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("comments") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2PSLO - " + e.toString());
		}

		if (found)
			temp = contents.toString();

		return temp;
	}

	/*
	 * getLinked2PSLO
	 * <p>
	 * @param	conn		Connection
	 * @param	src		String
	 * @param	kix		String
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2SLO(Connection conn,String src,String kix,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
		String indent = "";
		String table = "";
		ResultSet rs = null;
		PreparedStatement ps = null;

		boolean found = false;
		StringBuffer contents = new StringBuffer();

		table = "vw_Linked2SLO";

		try {
			sql = "SELECT comp "
				+ "FROM " + table + " "
				+ "WHERE historyid=? AND "
				+ "linkedseq=? "
				+ "ORDER BY comprdr";
			ps = conn.prepareStatement(sql);
			ps.setString(1,kix);
			ps.setInt(2,keyid);
			rs = ps.executeQuery();
			while (rs.next()) {
				contents.append("<li class=\"dataColumn\">" + rs.getString("comp") + "</li>");
				found = true;
			}
			rs.close();
			ps.close();

		} catch (Exception e) {
			logger.fatal("LinkerDB: getLinked2SLO - " + e.toString());
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
	 * @param	se			int
	 * @param	keyid		int
	 * <p>
	 * @return String
	 */
	public static String getLinked2Competency(Connection conn,String kix,String dst,int seq,int keyid) throws Exception {

		Logger logger = Logger.getLogger("test");

		String sql = "";
		String temp = "";
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
		else if ("GESLO".equals(dst))
			table = "vw_LinkedCompetency2GESLO";
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
				contents.append("<li class=\"dataColumn\">" + rs.getString("content") + "</li>");
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
