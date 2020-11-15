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

	String campus = "WIN";
	String user = "THANHG";
	String alpha = "ICS";
	String num = "101";
	String task = "Modify_outline";
	String kix = "c53a8c9822937";

	// BE SURE to create IDX column in table to work on

	out.println("Start<br/>");
	out.println("fill data..." + fixKIX(conn,campus) + " <br/>");
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>
		</td>
	</tr>
</table>

<%!
	/*
	**
	**
	*/
	public static int fixKIX(Connection conn,String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		int inserted = 0;
		int idx = 0;
		String historyid = "";

		try{
			String sql = "SELECT idx FROM tblCourseWIN WHERE historyid is null OR historyid=''";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				historyid = createHistoryID(1);

				idx = rs.getInt("idx");

				sql = "UPDATE tblCourseWIN SET id=?,historyid=? WHERE idx=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,historyid);
				ps.setString(2,historyid);
				ps.setInt(3,idx);
				ps.executeUpdate();
				++rowsAffected;

			}
			rs.close();
			ps.close();
		}
		catch(SQLException sx){
			logger.fatal("fixKIX - " + sx.toString());
		} catch(Exception ex){
			logger.fatal("fixKIX - " + ex.toString());
		}

		return rowsAffected;
	}
%>

<%!

	public static boolean isMatch(Connection conn,String kix) throws SQLException {

		String sql = "SELECT historyid FROM tblCourseWIN WHERE historyid=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,kix);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();

		return exists;
	}

	/*
	 * createHistoryID
	 * <p>
	 * @param	type	int
	 * <p>
	 * @return String
	 */
	public static synchronized String createHistoryID(int type) throws Exception {

		Logger logger = Logger.getLogger("test");

		/*
			effort to create id without a duplicate. Duplicates happen when requests
			come through so quick that the timer doesn't change fast enough.

			if a connection was not available, we'll create one the old fashion way.
		*/

		boolean duplicate = false;

		String kix = "";

		AsePool connectionPool = AsePool.getInstance();

		Connection conn = null;

		try{
			conn = connectionPool.getConnection();

			if (conn != null){
				kix = SQLUtil.createHistoryID(type,0);

				duplicate = isMatch(conn,kix);

				while(duplicate){
					kix = SQLUtil.createHistoryID(type,0);
					duplicate = isMatch(conn,kix);
				}
			}
			else
				kix = SQLUtil.createHistoryID(type,0);
		}
		catch(Exception e){
			logger.fatal("SQLUtil - createHistoryID: " + e.toString());
		} finally {
			connectionPool.freeConnection(conn,"SQLUtil","");
		}

		return kix;
	}

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

