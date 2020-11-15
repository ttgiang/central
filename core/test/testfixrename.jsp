<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.owasp.validator.html.*"%>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*,java.naming.*,javax.mail.*,javax.servlet.*,javax.mail.*,javax.mail.internet.*,java.sql.*,java.util.*,javax.activation.*,javax.naming.NamingException,javax.naming.Context,javax.naming.InitialContext"%>
<%@ include file="ase.jsp" %>

<%
	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script language="JavaScript" src="js/test.js"></script>
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
	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM,session,response,request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = "KAP";
	String user = "THANHG";
	out.println("Start<br/>");
	//out.println(rename(conn,campus,"LING","113","LING","103"));
	//out.println(CourseRename.renameOutline(conn,campus,"LING","103","LING","113",user));
	out.println("<br/>End");

	asePool.freeConnection(conn);
%>

<%!

	public static String rename(Connection conn,String campus,String fra,String frn,String toa,String ton){

		// array of table and fields
		String[] tab;
		String[] alpha;
		String[] num;

		// buffers
		StringBuffer output = new StringBuffer();
		StringBuffer bufTab = new StringBuffer();
		StringBuffer bufAlpha = new StringBuffer();
		StringBuffer bufNum = new StringBuffer();

		int i = 0;
		int rowsAffected = 0;

		try{
			// get the tables and fields in
			String sql = "SELECT tab,alpha,num FROM tblTabs";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (rowsAffected==0){
					bufTab.append(rs.getString("tab"));
					bufAlpha.append(rs.getString("alpha"));
					bufNum.append(rs.getString("num"));
				}
				else{
					bufTab.append(","+rs.getString("tab"));
					bufAlpha.append(","+rs.getString("alpha"));
					bufNum.append(","+rs.getString("num"));
				}

				++rowsAffected;
			}
			rs.close();
			ps.close();

			// formulate SQL statement for update
			tab = bufTab.toString().split(",");
			alpha = bufAlpha.toString().split(",");
			num = bufNum.toString().split(",");

			// update
			conn.setAutoCommit(false);
			for (i=0;i<tab.length;i++){
				sql = "UPDATE " + tab[i]
					+ " SET " + alpha[i] + "=?," + num[i] + "=?"
					+ " WHERE campus=? AND " + alpha[i] + "=? AND " + num[i] + "=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,toa);
				ps.setString(2,ton);
				ps.setString(3,campus);
				ps.setString(4,fra);
				ps.setString(5,frn);
				rowsAffected = ps.executeUpdate();

				if (rowsAffected>0)
					output.append(i + ": " + tab[i] + " (<strong>" + rowsAffected + " rows</strong>)<br/>");
				else
					output.append(i + ": " + tab[i] + " (" + rowsAffected + " rows)<br/>");
			}
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch(SQLException e){
			try{
				conn.rollback();
			}
			catch(SQLException se){
			}
		}
		catch(Exception ex){
			try{
				conn.rollback();
			}
			catch(SQLException exx){
			}
		}

		return output.toString();
	}

	public static String renameY(Connection conn,String campus,String fra,String frn){

		// show sql statement

		String table = "tblApproval,tblApprovalHist,tblApprovalHist2,tblAssessedData,tblAssessedDataARC,tblCampusData,"
			+ "tblCourse,tblCourseACCJC,tblCourseARC,tblCourseCAN,tblCourseComp,tblCourseCompAss,"
			+ "tblCourseCompetency,tblCourseContent,tblCourseContentSLO,tblExtra,tblGenericContent,"
			+ "tblMisc,tblReviewHist,tblReviewHist2,tblReviewers,tblSLO,tblSLOARC,"
			+ "tblTasks,tblsyllabus,tblXRef";

		StringBuffer buf = new StringBuffer();
		String[] t = table.split(",");
		String sql = "";
		int i = 0;
		int rowsAffected = 0;

		try{
			for (i=0;i<t.length;i++){
				sql = "SELECT COUNT(*) FROM " + t[i] + " WHERE campus='KAP' AND coursealpha='VIET' AND coursenum='297F'";
				buf.append(sql+"</br>");
			}

			sql = "SELECT count(*) FROM tblCoReq"
				+ " WHERE campus='KAP' AND coreqalpha='VIET' AND coreqnum='297F'";
			buf.append(sql+"</br>");

			sql = "SELECT count(*) FROM  tblPreReq"
				+ " WHERE campus='KAP' prereqalpha='VIET' AND prereqnum='297F'";
			buf.append(sql+"</br>");

			sql = "SELECT count(*) FROM  tblXRef"
				+ " WHERE campus='KAP' coursealphax='VIET' AND coursenumx='297F'";
			buf.append(sql+"</br>");

			sql = "SELECT count(*) FROM  tblMail"
				+ " WHERE campus='KAP' alpha='VIET' AND num='297F'";
			buf.append(sql+"</br>");

			sql = "SELECT count(*) FROM  tblUserLog"
				+ " WHERE campus='KAP' alpha='VIET' AND num='297F'";
			buf.append(sql+"</br>");
		}
		catch(Exception ex){
			System.out.println(ex.toString());
		}

		return buf.toString();
	}

	public static String renameX(Connection conn,String campus,String fra,String frn,String toa,String ton){

		// actual rename

		String table = "tblApproval,tblApprovalHist,tblApprovalHist2,tblAssessedData,tblAssessedDataARC,tblCampusData,"
			+ "tblCourse,tblCourseACCJC,tblCourseARC,tblCourseCAN,tblCourseComp,tblCourseCompAss,"
			+ "tblCourseCompetency,tblCourseContent,tblCourseContentSLO,tblExtra,tblGenericContent,"
			+ "tblMisc,tblReviewHist,tblReviewHist2,tblReviewers,tblSLO,tblSLOARC,"
			+ "tblTasks,tblsyllabus,tblXRef";

		StringBuffer buf = new StringBuffer();
		String[] tab = table.split(",");
		String sql = "";
		int i = 0;
		int rowsAffected = 0;

		try{
			conn.setAutoCommit(false);

			PreparedStatement ps = null;
			for (i=0;i<tab.length;i++){
				sql = "UPDATE " + tab[i]
					+ " SET coursealpha=?,coursenum=?"
					+ " WHERE campus=? AND coursealpha=? AND coursenum=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1,toa);
				ps.setString(2,ton);
				ps.setString(3,campus);
				ps.setString(4,fra);
				ps.setString(5,frn);
				rowsAffected = ps.executeUpdate();
				buf.append(i + ": " + tab[i] + " (" + rowsAffected + " rows)<br/>");
			}

			sql = "UPDATE tblCoReq"
				+ " SET coreqalpha=?,coreqnum=?"
				+ " WHERE campus=? AND coreqalpha=? AND coreqnum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toa);
			ps.setString(2,ton);
			ps.setString(3,campus);
			ps.setString(4,fra);
			ps.setString(5,frn);
			rowsAffected = ps.executeUpdate();
			buf.append(i + ": tblCoReq (" + rowsAffected + " rows)<br/>");

			sql = "UPDATE tblPreReq"
				+ " SET prereqalpha=?,prereqnum=?"
				+ " WHERE campus=? AND prereqalpha=? AND prereqnum=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toa);
			ps.setString(2,ton);
			ps.setString(3,campus);
			ps.setString(4,fra);
			ps.setString(5,frn);
			rowsAffected = ps.executeUpdate();
			buf.append((i++) + ": tblPreReq (" + rowsAffected + " rows)<br/>");

			sql = "UPDATE tblXRef"
				+ " SET coursealphax=?,coursenumx=?"
				+ " WHERE campus=? AND coursealphax=? AND coursenumx=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toa);
			ps.setString(2,ton);
			ps.setString(3,campus);
			ps.setString(4,fra);
			ps.setString(5,frn);
			rowsAffected = ps.executeUpdate();
			buf.append((i++) + ": tblXRef (" + rowsAffected + " rows)<br/>");

			sql = "UPDATE tblMail"
				+ " SET alpha=?,num=?"
				+ " WHERE campus=? AND alpha=? AND num=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toa);
			ps.setString(2,ton);
			ps.setString(3,campus);
			ps.setString(4,fra);
			ps.setString(5,frn);
			rowsAffected = ps.executeUpdate();
			buf.append((i++) + ": tblMail (" + rowsAffected + " rows)<br/>");

			sql = "UPDATE tblUserLog"
				+ " SET alpha=?,num=?"
				+ " WHERE campus=? AND alpha=? AND num=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1,toa);
			ps.setString(2,ton);
			ps.setString(3,campus);
			ps.setString(4,fra);
			ps.setString(5,frn);
			rowsAffected = ps.executeUpdate();
			buf.append((i++) + ": tblUserLog (" + rowsAffected + " rows)<br/>");

			conn.commit();

			conn.setAutoCommit(true);
		}
		catch(SQLException e){
			try{
				conn.rollback();
			}
			catch(SQLException se){
			}
		}
		catch(Exception ex){
			try{
				conn.rollback();
			}
			catch(SQLException exx){
			}
		}

		return buf.toString();
	}

%>


		</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

