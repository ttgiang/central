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
	out.println("Start<br/>");
	//out.println(fixList(conn,Constant.COURSE_ITEM_PREREQ));
	//out.println(fixList(conn,Constant.COURSE_ITEM_COREQ));
	//out.println(fixList(conn,Constant.COURSE_ITEM_SLO));
	//out.println(fixList(conn,Constant.COURSE_ITEM_CONTENT));
	//out.println(fixList(conn,Constant.COURSE_ITEM_COMPETENCIES));
	//out.println(fixList(conn,Constant.COURSE_ITEM_PROGRAM_SLO));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!

	public static String fixList(Connection conn,int list) throws Exception {

		Logger logger = Logger.getLogger("test");

		int row = 0;
		int id = 0;
		int i = 0;
		String key = "";
		String sql = "";
		String fields = "";
		String table = "";
		String kix = "";
		String saveKix = "";

		PreparedStatement ps = null;
		ResultSet rs = null;

		switch(list){
			case Constant.COURSE_ITEM_PREREQ:
				fields = "id,historyid ";
				key = "id";
				table = "tblPrereq";
				sql = "SELECT " + fields + " "
					+ "FROM " + table;
				break;
			case Constant.COURSE_ITEM_COREQ:
				fields = "id,historyid ";
				key = "id";
				table = "tblcoreq";
				sql = "SELECT " + fields + " "
					+ "FROM " + table;
				break;
			case Constant.COURSE_ITEM_SLO:
				fields = "compid AS id,historyid ";
				key = "compid";
				table = "tblcoursecomp";
				sql = "SELECT " + fields + " "
					+ "FROM " + table;
				break;
			case Constant.COURSE_ITEM_CONTENT:
				fields = "contentid as ID,historyid ";
				key = "contentid";
				table = "tblcoursecontent";
				sql = "SELECT " + fields + " "
					+ "FROM " + table;
				break;
			case Constant.COURSE_ITEM_COMPETENCIES:
				fields = "seq as ID,historyid ";
				key = "seq";
				table = "tblCourseCompetency";
				sql = "SELECT " + fields + " "
					+ "FROM " + table;
				break;
			case Constant.COURSE_ITEM_PROGRAM_SLO:
				fields = "id,rdr,comments";
				key = "id";
				table = "tblGenericContent";
				sql = "SELECT " + fields + " "
					+ "FROM " + table;
				break;
		}

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			i = 0;
			while (rs.next()) {
				id = rs.getInt("id");
				kix = rs.getString("historyid");
				if (!kix.equals(saveKix)){
					i = 0;
					saveKix = kix;
				}
				sql = "UPDATE " + table + " SET rdr=? WHERE historyid=? AND " + key + "=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,++i);
				ps.setString(2,kix);
				ps.setInt(3,id);
				row = ps.executeUpdate();
			}
			rs.close();
			ps.close();
		} catch (SQLException se) {
			logger.fatal("CompDB: getRequisitesForEdit\n" + se.toString());
		} catch (Exception e) {
			logger.fatal("CompDB: getRequisitesForEdit\n" + e.toString());
		}

		return "";
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
