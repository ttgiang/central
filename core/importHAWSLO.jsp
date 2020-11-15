<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%@ page import="com.ase.aseutil.AseUtil"%>
<%@ page import="com.ase.exception.CentralException"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.jar.*"%>
<%@ page import="com.itextpdf.text.BaseColor"%>

<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Testing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="fckeditor.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table border="0" width="100%" id="table1" cellspacing="3" cellpadding="3">
	<tr>
		<td>
		<form method="post" action="shwfldx.jsp" name="aseForm">
<%
	/**
	*	ASE
	*	cnv - convert date from test to production for a single campus
	**/

	boolean processPage = true;

	// authorized to edit?
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	/*

	SELECT     historyid, Campus, CourseAlpha, CourseNum, CourseType, CompID, Comp, comments, Approved, ApprovedDate, ApprovedBy, AuditDate, AuditBy, rdr, reviewed,
								 revieweddate, reviewedby
	FROM         tblCourseComp
	WHERE     (Campus = 'HAW') AND (AuditBy = 'SYSADM-HAW-SLO')
	ORDER BY Campus, CourseAlpha, CourseNum


	*/


	String campus = "HAW";
	String user = "SYSADM-HAW-SLO";
	String alpha = "";
	String num = "";
	String type = "";
	String kix = "";
	String comp = "";
	String message = "";

	System.out.println("Start<br/>");

	if (processPage){
		out.println(process(conn));
		out.println(createHTML(campus));
	}

	System.out.println("<br/>End");

	asePool.freeConnection(conn," ","");
%>

<%!

	public static String process(Connection conn){

		Logger logger = Logger.getLogger("test");

		String campus = "HAW";
		String user = "SYSADM-HAW-SLO";
		String alpha = "";
		String num = "";
		String type = "";
		String kix = "";
		String comp = "";
		String message = "";

		int pre = 0;
		int cur = 0;
		int read = 0;
		int processed = 0;
		int error = 0;

		try{
			String sql = "select * from hawslo";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){

				++read;

				alpha = AseUtil.nullToBlank(rs.getString("alpha"));
				num = AseUtil.nullToBlank(rs.getString("num"));
				comp = AseUtil.nullToBlank(rs.getString("slo"));
				type = AseUtil.nullToBlank(rs.getString("type"));
				kix = AseUtil.nullToBlank(rs.getString("kix"));

				if(!kix.equals("")){

					Msg msg = addRemoveCourseComp(conn,"a",campus,alpha,num,comp,0,user,kix);

					if (!"Exception".equals(msg.getMsg())){
						++processed;
					}
					else{
						++error;
					}

					if(type.equals("CUR")){
						++cur;
					}
					else if(type.equals("PRE")){
						++pre;
					}

				}
				else{
					System.out.println("missing kix: " + alpha + " " + num + " " + type + Html.BR());
				}
				// valid kix
			}
			rs.close();
			ps.close();

		} catch (Exception e){
			System.err.println (e.toString());
		}

		return
					"Read: " + read + "<br/>" +
					"CUR: " + cur + "<br/>" +
					"PRE: " + pre + "<br/>" +
					"Processed: " + processed + "<br/>" +
					"Error: " + error + "<br/>";
	}

	/**
	*
	*	createHTML
	*
	**/
	public static String createHTML(String campus){

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;

		Connection conn = null;

		try{
			conn = AsePool.createLongConnection();

			if (conn != null){

				String sql = "select distinct CourseAlpha, CourseNum, historyid from tblcoursecomp where campus='HAW' and AuditBy = 'SYSADM-HAW-SLO'";
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while (rs.next()){
					String alpha = AseUtil.nullToBlank(rs.getString("coursealpha"));
					String num = AseUtil.nullToBlank(rs.getString("coursenum"));
					String kix = AseUtil.nullToBlank(rs.getString("historyid"));

					Tables.createOutlines(conn,campus,kix,alpha,num,"html","","",false,false,true);

					++rowsAffected;
				} // while
				rs.close();
				ps.close();

			}	// if conn

		}
		catch(SQLException sx){
			logger.fatal("extract: createHTML - " + sx.toString());
		}
		catch(Exception ex){
			logger.fatal("extract: createHTML - " + ex.toString());
		}
		finally{
			try{
				if (conn != null){
					conn.close();
					conn = null;
				}
			}
			catch(Exception e){
				logger.fatal("extract: createHTML - " + e.toString());
			}
		}


		return "createHTML: " + rowsAffected;

	} // createHTML

	/*
	 * addRemoveCourseComp
	 * <p>
	 * @param	connection	Connection
	 * @param	action		String
	 * @param	campus		String
	 * @param	alpha			String
	 * @param	num			String
	 * @param	comp			String
	 * @param	compID		int
	 * @param	user			String
	 * @param	kix			String
	 * <p>
	 * @return Msg
	 */
	public static Msg addRemoveCourseComp(Connection conn,
														String action,
														String campus,
														String alpha,
														String num,
														String comp,
														int compID,
														String user,
														String kix) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int rowsAffected = 0;
		Msg msg = new Msg();
		PreparedStatement ps;
		int accjcID = 0;
		String type = "";
		int compNextID = 0;
		int rdrNextID = 0;
		type = "CUR";

		try {
			String sql = "INSERT INTO tblCourseComp(campus,coursealpha,coursenum,coursetype,comp,AuditBy,historyid,compid,rdr) VALUES(?,?,?,?,?,?,?,?,?)";;
			ps = conn.prepareStatement(sql);
			compNextID = getNextCompID(conn);
			rdrNextID = getNextRDR(conn,kix);
			ps.setString(1, campus);
			ps.setString(2, alpha);
			ps.setString(3, num);
			ps.setString(4, type);
			ps.setString(5, comp);
			ps.setString(6, user);
			ps.setString(7, kix);
			ps.setInt(8, compNextID);
			ps.setInt(9, rdrNextID);
			rowsAffected = ps.executeUpdate();
			ps.close();
			msg.setMsg("Successful");
			msg.setCode(compNextID);
		} catch (SQLException e) {
			msg.setMsg("Exception");
			logger.fatal("CompDB: addRemoveCourseComp - " + e.toString());
		} catch (Exception ex) {
			msg.setMsg("Exception");
			logger.fatal("CompDB: addRemoveCourseComp\n" + ex.toString());
		}

		return msg;
	}

	/**
	 * isMatch
	 * <p>
	 * @param connection	Connection
	 * @param userid		String
	 * @param campus		String
	 * <p>
	 * @return boolean
	 */
	public static boolean isMatch(Connection conn,String campus,String alpha,String num,String slo) throws SQLException {

		String sql = "SELECT compid FROM tblCourseComp WHERE campus=? AND coursealpha=? AND coursenum=? AND coursetype=? AND comp=?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1,campus);
		ps.setString(2,alpha);
		ps.setString(3,num);
		ps.setString(4,"CUR");
		ps.setString(5,slo);
		ResultSet rs = ps.executeQuery();
		boolean exists = rs.next();
		rs.close();
		ps.close();
		return exists;
	}

	/*
	 * getNextCompID
	 *	<p>
	 *	@return int
	 */
	public static int getNextCompID(Connection connection) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int id = 0;
		String table = "tblCourseComp";

		try {
			String sql = "SELECT MAX(CompID) + 1 AS maxid FROM " + table;
			PreparedStatement ps = connection.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: getNextCompID - " + e.toString());
		}

		return id;
	}

	/*
	 * getNextRDR
	 *	<p>
	 *	@param	connection	Connection
	 * @param	kix			String
	 *	<p>
	 *	@return int
	 */
	public static int getNextRDR(Connection connection,String kix) throws SQLException {

		Logger logger = Logger.getLogger("test");

		int id = 0;
		String table = "tblCourseComp";

		try {
			String sql = "SELECT MAX(rdr) + 1 AS maxid FROM "
				+ table
				+ " WHERE historyid=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1,kix);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				id = rs.getInt("maxid");

			if (id==0)
				id = 1;

			rs.close();
			ps.close();
		} catch (SQLException e) {
			logger.fatal("CompDB: getNextRDR - " + e.toString());
		}

		return id;
	}

%>

</form>
		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html

